"""
逆向转化脚本：将翻译修改应用回源文件
从 translation_cache.json 读取数据，写回 campaign_zh_CN.lua 和 JSON 文件
工作流：gen_diff_table.py -> 查阅 translation_diff.md -> rev_diff_table.py
"""
import json, shutil
from pathlib import Path

WORK_DIR = Path(r"D:\SteamLibrary\steamapps\common\Zero-K\zh_cn_translation\work")
CACHE = Path(r"D:\SteamLibrary\steamapps\common\Zero-K\zh_cn_translation\translation_cache.json")


def load_cache():
    if not CACHE.exists():
        raise FileNotFoundError(f"{CACHE} not found. Run gen_diff_table.py first.")
    with open(CACHE, 'r', encoding='utf-8') as f:
        return json.load(f)


def find_lua_blocks(content, section_marker):
    """
    在 content 中找到 section_marker 之后的所有顶层条目块。
    返回 [(key, start_pos, end_pos), ...]，按文件中出现顺序。

    每个条目块以 ["key"] = { 开始，以匹配的 }, 结束。
    """
    pos = content.find(section_marker)
    if pos < 0:
        return []
    pos += len(section_marker)

    blocks = []
    # Find each ["key"] = { ... },
    i = pos
    while i < len(content):
        # Skip whitespace and commas
        while i < len(content) and content[i] in ' \t\n\r,':
            i += 1
        if i >= len(content):
            break
        # Check if this starts a new top-level section
        if content[i:i+2] in ('--', 're') and i < len(content) - 10:
            # Check for 'return T' or '-- comment'
            rest = content[i:i+30].strip()
            if rest.startswith('return') or content[i] == '-':
                break
        # Must start with ["
        if content[i:i+2] != '["':
            break
        # Extract key
        j = content.find('"]', i)
        if j < 0:
            break
        key = content[i+2:j]
        # Find = {
        k = content.find('{', j)
        if k < 0:
            break
        # Track brace depth from the opening {
        depth = 1
        p = k + 1
        while p < len(content) and depth > 0:
            if content[p] == '{':
                depth += 1
            elif content[p] == '}':
                depth -= 1
            p += 1
        # Block spans from i to p
        blocks.append((key, i, p))
        i = p

    return blocks


def replace_field_in_block(content, block_start, block_end, field_name, new_value, is_multiline=False):
    """
    在指定的块内替换 field_name 的值。
    is_multiline=True 表示值用 [[...]] 包裹，False 表示用 "..." 包裹。
    返回 (new_content, changed)。
    """
    block = content[block_start:block_end]

    # Find the field within the block
    search = field_name + ' = '
    field_pos = block.find(search)
    if field_pos < 0:
        return content, False

    value_start = field_pos + len(search)

    if is_multiline:
        # Find [[ .. ]]
        if block[value_start:value_start+2] != '[[':
            return content, False
        # Find matching ]]
        close = block.find(']]', value_start + 2)
        if close < 0:
            return content, False
        old_value = block[value_start+2:close]
        if old_value.strip() == new_value.strip():
            return content, False
        # Build replacement
        new_block = block[:value_start+2] + new_value + block[close:]
    else:
        # String value
        if block[value_start] != '"':
            return content, False
        close = block.find('"', value_start + 1)
        if close < 0:
            return content, False
        old_value = block[value_start+1:close]
        if old_value == new_value:
            return content, False
        new_block = block[:value_start+1] + new_value + block[close:]

    new_content = content[:block_start] + new_block + content[block_end:]
    return new_content, True


def update_campaign_zh_cn(cache):
    """将缓存中的翻译写回 campaign_zh_CN.lua"""
    path = WORK_DIR / "campaign_zh_CN.lua"
    raw = path.read_bytes()
    if raw[:3] == b'\xef\xbb\xbf':
        raw = raw[3:]
    content = raw.decode('utf-8').replace('\r\n', '\n').replace('\r', '\n')
    modified = 0

    # --- Update planet entries (reverse order to keep positions stable) ---
    planet_blocks = find_lua_blocks(content, 'T.planets = {')
    planet_cache = cache.get('planets', {})
    for key, start, end in reversed(planet_blocks):
        pdata = planet_cache.get(key, {})
        if not pdata:
            continue

        for field, long_field in [('hintText', False), ('text', True), ('extendedText', True)]:
            zh_val = pdata.get(field + '_zh', '')
            if not zh_val:
                continue
            content, changed = replace_field_in_block(
                content, start, end, field, zh_val, is_multiline=long_field
            )
            if changed:
                modified += 1

    # --- Update codex entries (reverse order) ---
    codex_blocks = find_lua_blocks(content, 'T.codex = {')
    codex_cache = cache.get('codex', {})
    for key, start, end in reversed(codex_blocks):
        edata = codex_cache.get(key, {})
        if not edata:
            continue

        zh_name = edata.get('name_zh', '')
        if zh_name:
            content, changed = replace_field_in_block(
                content, start, end, 'name', zh_name, is_multiline=False
            )
            if changed:
                modified += 1

        zh_text = edata.get('text_zh', '')
        if zh_text:
            content, changed = replace_field_in_block(
                content, start, end, 'text', zh_text, is_multiline=True
            )
            if changed:
                modified += 1

    if modified > 0:
        bak = path.with_suffix('.lua.bak')
        shutil.copy2(path, bak)
        with open(path, 'w', encoding='utf-8', newline='') as f:
            f.write(content)
        print(f"  Updated {modified} fields in {path.name} (backup: {bak.name})")
    else:
        print(f"  No changes in {path.name}")

    return modified


def update_json_files(cache):
    """将缓存中的翻译写回 JSON 文件"""
    total = 0
    for fname, translations in cache.get('json', {}).items():
        fpath = WORK_DIR / fname
        if not fpath.exists():
            print(f"  SKIP: {fname} not found")
            continue
        with open(fpath, 'r', encoding='utf-8') as f:
            data = json.load(f)

        modified = 0
        for en_key, zh_val in translations.items():
            if en_key in data and data[en_key] != zh_val:
                data[en_key] = zh_val
                modified += 1

        if modified > 0:
            bak = fpath.with_suffix('.json.bak')
            shutil.copy2(fpath, bak)
            with open(fpath, 'w', encoding='utf-8', newline='') as f:
                json.dump(data, f, ensure_ascii=False, indent='\t')
                f.write('\n')
            print(f"  Updated {modified} entries in {fname}")
        else:
            print(f"  No changes in {fname} ({len(translations)} entries checked)")
        total += modified
    return total


def main():
    print("Reverse: cache -> translation files")
    cache = load_cache()
    print(f"  Planets: {len(cache.get('planets', {}))}")
    print(f"  Codex: {len(cache.get('codex', {}))}")
    print(f"  JSON files: {list(cache.get('json', {}).keys())}")

    print("\nUpdating campaign_zh_CN.lua...")
    n_lua = update_campaign_zh_cn(cache)

    print("\nUpdating JSON files...")
    n_json = update_json_files(cache)

    print(f"\nDone: {n_lua} Lua + {n_json} JSON updates")


if __name__ == '__main__':
    main()
