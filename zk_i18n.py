"""
Zero-K 汉化工具模块 — 处理 .sdz 的解包、打包、备份、恢复
.sdz 文件本质上是 ZIP 格式
"""
import zipfile
import os
import shutil
import json
import re
from datetime import datetime
from pathlib import Path

GAMES_DIR = Path(r"D:\SteamLibrary\steamapps\common\Zero-K\games")
WORK_DIR = Path(r"D:\SteamLibrary\steamapps\common\Zero-K\zh_cn_translation\work")
BACKUP_DIR = Path(r"D:\SteamLibrary\steamapps\common\Zero-K\zh_cn_translation\backup")

SDZ_FILES = ["zk-stable.sdz", "zkmenu-stable.sdz"]


def backup():
    """备份原始 .sdz 文件（带时间戳）"""
    ts = datetime.now().strftime("%Y%m%d_%H%M%S")
    bak = BACKUP_DIR / ts
    bak.mkdir(parents=True, exist_ok=True)
    for name in SDZ_FILES:
        src = GAMES_DIR / name
        dst = bak / name
        if src.exists():
            shutil.copy2(src, dst)
            print(f"  backup: {name} -> {bak / name}")
        else:
            print(f"  WARNING: {src} not found")
    print(f"备份完成: {bak}")
    return bak


def list_backups():
    """列出所有备份"""
    backups = sorted(BACKUP_DIR.glob("*"), reverse=True)
    for b in backups:
        if b.is_dir():
            size = sum(f.stat().st_size for f in b.glob("*.sdz"))
            print(f"  {b.name}  ({size / 1024 / 1024:.0f} MB)")
    return backups


def restore(backup_name=None):
    """恢复备份。不指定名称则恢复最新的"""
    backups = sorted(BACKUP_DIR.glob("*"))
    if not backups:
        print("没有找到备份")
        return False
    if backup_name:
        bak = BACKUP_DIR / backup_name
    else:
        bak = backups[-1]
    if not bak.exists():
        print(f"备份不存在: {bak}")
        return False
    for name in SDZ_FILES:
        src = bak / name
        dst = GAMES_DIR / name
        if src.exists():
            shutil.copy2(src, dst)
            print(f"  restore: {src} -> {dst}")
    print(f"已恢复备份: {bak.name}")
    return True


def unpack(sdz_name, dest_dir):
    """解压 .sdz 到目标目录"""
    src = GAMES_DIR / sdz_name
    if not src.exists():
        raise FileNotFoundError(f"找不到 {src}")
    dest = Path(dest_dir)
    dest.mkdir(parents=True, exist_ok=True)
    with zipfile.ZipFile(src, 'r', zipfile.ZIP_DEFLATED) as zf:
        zf.extractall(dest)
    file_count = sum(1 for _ in dest.rglob("*") if _.is_file())
    print(f"解压: {sdz_name} -> {dest_dir} ({file_count} 个文件)")


def pack(sdz_name, src_dir):
    """将目录打包为 .sdz"""
    dest = GAMES_DIR / sdz_name
    src = Path(src_dir)

    with zipfile.ZipFile(dest, 'w', zipfile.ZIP_DEFLATED) as zf:
        for f in sorted(src.rglob("*")):
            if f.is_file():
                arcname = str(f.relative_to(src)).replace("\\", "/")
                zf.write(f, arcname)

    size_mb = dest.stat().st_size / 1024 / 1024
    print(f"打包: {src_dir} -> {sdz_name} ({size_mb:.0f} MB)")


def read_file_from_sdz(sdz_name, internal_path):
    """从 .sdz 中读取单个文件内容（返回文本）"""
    src = GAMES_DIR / sdz_name
    with zipfile.ZipFile(src, 'r') as zf:
        return zf.read(internal_path).decode("utf-8")


def read_json_from_sdz(sdz_name, internal_path):
    """从 .sdz 中读取 JSON 文件"""
    return json.loads(read_file_from_sdz(sdz_name, internal_path))


def parse_lua_table(text, key="en"):
    """解析 chililobby.lua 风格的语言表。
    返回 {key: value} 字典。处理 Lua 字符串 concatenation。
    """
    # 找到指定语言段: key = { ... }
    pattern = rf'\t{key}\s*=\s*\{{'
    match = re.search(pattern, text)
    if not match:
        return {}

    # 从 { 之后开始解析
    start = match.end()
    depth = 0
    entries = {}
    in_section = False
    current_key = None
    current_val = None

    for line in text[start:].split("\n"):
        # 跟踪大括号深度
        depth += line.count("{") - line.count("}")

        # 匹配键值对: key = "value",
        m = re.match(r'^\t\t(\w+)\s*=\s*(.+?)(?:,\s*)?$', line)
        if m and depth <= 1:
            k = m.group(1)
            v = m.group(2).strip().rstrip(",")

            # 尝试解析字符串值
            if v.startswith("[[") and v.endswith("]]"):
                v = v[2:-2]
            elif (v.startswith('"') and v.endswith('"')) or \
                 (v.startswith("'") and v.endswith("'")):
                v = v[1:-1]
            elif v.startswith("[["):
                # 多行字符串，在后续行中收集
                current_key = k
                current_val = v[2:]
                continue
            entries[k] = v
            continue

        # 继续多行字符串
        if current_key:
            if "]]" in line:
                end_idx = line.index("]]")
                current_val += "\n" + line[:end_idx]
                entries[current_key] = current_val
                current_key = None
                current_val = None
            else:
                current_val += "\n" + line

        # 语言段结束
        if depth <= 0:
            break

    return entries


def planck_lua_text(text, key="en"):
    """解析 planet/codex 风格的内联 Lua 文本字段。
    提取 text = [[...]] 或 text = "..."
    """
    results = {}
    # 匹配: key = [[content]]
    for m in re.finditer(rf'(\w+)\s*=\s*\[\[(.*?)\]\]', text, re.DOTALL):
        results[m.group(1)] = m.group(2).strip()
    # 匹配: key = "content"
    for m in re.finditer(r'(\w+)\s*=\s*"([^"]*)"', text):
        if m.group(1) not in results:
            results[m.group(1)] = m.group(2)
    # 匹配: key = 'content'
    for m in re.finditer(r"(\w+)\s*=\s*'([^']*)'", text):
        if m.group(1) not in results:
            results[m.group(1)] = m.group(2)
    return results


def planck_translated_planet_lua(original, translations):
    """将翻译注入 planet.lua 文件。
    translations: { 'text': '译文', 'extendedText': '译文', ... }
    在各字段后添加 _zh 版本。
    """
    result = original
    for field, translation in translations.items():
        if not translation:
            continue
        # 在字段定义后插入 _zh 版本
        # text = [[...]], -> 后面加 text_zh = [[...]],
        escaped = translation.replace("\\", "\\\\").replace("'", "\\'")
        zh_line = f'\t\t\t{field}_zh = [[' + translation + ']],\n'
        # 在原始字段行后插入
        pattern = rf'(\t\t\t{field}\s*=\s*\[\[.*?\]\],)'
        repl = rf'\1\n{zh_line.rstrip()}'
        result = re.sub(pattern, repl, result, count=1, flags=re.DOTALL)
    return result


def lua_escape(s):
    """转义字符串为 Lua 安全格式"""
    s = s.replace("\\", "\\\\")
    s = s.replace('"', '\\"')
    s = s.replace("\n", "\\n")
    return s
