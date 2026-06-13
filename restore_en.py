"""
Zero-K 还原脚本 - 从备份恢复原版 .sdz 文件
用法: uv run python restore_en.py
运行前必须关闭游戏。
"""
import shutil
from pathlib import Path

GAMES_DIR = Path(r"D:\SteamLibrary\steamapps\common\Zero-K\games")
BACKUP_DIR = Path(r"D:\SteamLibrary\steamapps\common\Zero-K\zh_cn_translation\backup")

def main():
    print("=" * 60)
    print("  Zero-K 还原原版英文")
    print("=" * 60)

    sdz_files = ["zkmenu-stable.sdz", "zk-stable.sdz"]

    for sdz_name in sdz_files:
        target = GAMES_DIR / sdz_name
        # 找到最新的备份
        backups = sorted(BACKUP_DIR.glob(f"*/{sdz_name}"), reverse=True)
        if not backups:
            print(f"  未找到 {sdz_name} 的备份，跳过")
            continue

        latest = backups[0]
        print(f"\n[{sdz_name}]")
        print(f"  备份: {latest.parent.name}/{latest.name}")
        shutil.copy2(latest, target)
        size_mb = target.stat().st_size / 1024 / 1024
        print(f"  已恢复: {size_mb:.0f} MB")

    print("\n还原完成。启动游戏即可恢复英文。")

if __name__ == "__main__":
    main()
