"""
Zero-K 还原英文脚本
从 backup/original/ 恢复原版英文 .sdz 到 games 目录
"""
import shutil, sys
from pathlib import Path

GAMES_DIR = Path(r"D:\SteamLibrary\steamapps\common\Zero-K\games")
BACKUP_DIR = Path(r"D:\SteamLibrary\steamapps\common\Zero-K\zh_cn_translation\backup")
ORIGINAL_DIR = BACKUP_DIR / "original"

SDZ_FILES = ["zkmenu-stable.sdz", "zk-stable.sdz"]


def restore():
    if not ORIGINAL_DIR.exists():
        print("错误: backup/original/ 目录不存在")
        print("从未部署过汉化，无需还原。")
        print("如需恢复原版，请在 Steam 中右键游戏 -> 属性 -> 本地文件 -> 验证游戏文件完整性")
        sys.exit(1)

    restored = 0
    for sdz in SDZ_FILES:
        orig = ORIGINAL_DIR / sdz
        dst = GAMES_DIR / sdz
        if not orig.exists():
            print(f"  跳过: {sdz} (原始备份不存在)")
            continue
        shutil.copy2(orig, dst)
        size_mb = dst.stat().st_size / 1024 / 1024
        print(f"  已还原: {sdz} ({size_mb:.0f} MB)")
        restored += 1

    if restored:
        print(f"\n还原完成，{restored} 个文件已恢复为原版英文")
    else:
        print("\n没有文件被还原")


if __name__ == "__main__":
    print("=" * 60)
    print("  Zero-K 还原英文")
    print("=" * 60)
    restore()
