"""
Zero-K 简体中文汉化部署脚本 v2
流式 zip 修改 - 兼容 Spring VFS
"""
import zipfile, shutil, sys
from pathlib import Path
from datetime import datetime

GAMES_DIR = Path(r"D:\SteamLibrary\steamapps\common\Zero-K\games")
WORK_DIR = Path(r"D:\SteamLibrary\steamapps\common\Zero-K\zh_cn_translation\work")
BACKUP_DIR = Path(r"D:\SteamLibrary\steamapps\common\Zero-K\zh_cn_translation\backup")

DEPLOY_PLAN = {
    "zkmenu-stable.sdz": {
        "luamenu/widgets/chobby/components/configuration.lua": "configuration.lua",
        "luamenu/widgets/chobby/i18n/chililobby.lua": "chililobby.lua",
        "luamenu/widgets/gui_chili_lobby.lua": "gui_chili_lobby.lua",
        "luamenu/widgets/gui_settings_window.lua": "gui_settings_window.lua",
        "luamenu/configs/gameconfig/zk/settingsmenu.lua": "settingsmenu.lua",
        "luamenu/widgets/gui_campaign_handler.lua": "gui_campaign_handler.lua",
        "luamenu/widgets/api_planet_battle_handler.lua": "api_planet_battle_handler.lua",
        "luamenu/widgets/gui_campaign_codex_handler.lua": "gui_campaign_codex_handler.lua",
        "luamenu/widgets/gui_campaign_saveload.lua": "gui_campaign_saveload.lua",
        "luamenu/widgets/chobby/components/interface_root.lua": "interface_root.lua",
        "luamenu/widgets/gui_queue_status_panel.lua": "gui_queue_status_panel.lua",
        "luamenu/widgets/gui_download_window.lua": "gui_download_window.lua",
        "campaign/sample/campaign_zh_CN.lua": "campaign_zh_CN.lua",
        "campaign/sample/commconfig.lua": "commconfig.lua",
    },
    "zk-stable.sdz": {
        "luaui/configs/lang/campaign_units.zh_cn.json": "campaign_units.zh_cn.json",
        "luaui/configs/lang/common.zh_cn.json": "common.zh_cn.json",
        "luaui/configs/lang/epicmenu.zh_cn.json": "epicmenu.zh_cn.json",
        "luaui/configs/lang/healthbars.zh_cn.json": "healthbars.zh_cn.json",
        "luaui/configs/lang/interface.zh_cn.json": "interface.zh_cn.json",
        "luaui/configs/lang/misc.zh_cn.json": "misc.zh_cn.json",
        "luaui/configs/lang/pw_units.zh_cn.json": "pw_units.zh_cn.json",
        "luaui/configs/lang/resbars.zh_cn.json": "resbars.zh_cn.json",
        "luaui/configs/lang/units.zh_cn.json": "units.zh_cn.json",
        "gamedata/modularcomms/moduledefs.lua": "moduledefs.lua",
        "luaui/widgets/gui_chili_endgamewindow.lua": "gui_chili_endgamewindow.lua",
        "luaui/widgets/gui_chili_inactivity_win.lua": "gui_chili_inactivity_win.lua",
        "luaui/widgets/gui_chili_vote.lua": "gui_chili_vote.lua",
        "luaui/widgets/mission_messagebox_zk.lua": "mission_messagebox_zk.lua",
    },
}

def verify_no_bom(data, name):
    if data[:3] == b'\xef\xbb\xbf':
        raise ValueError(f"BOM detected in {name}! Remove it first.")


def stream_deploy(sdz_name, updates):
    src = GAMES_DIR / sdz_name
    tmp = GAMES_DIR / (sdz_name + ".tmp")

    file_data = {}
    for arcname, fname in updates.items():
        fpath = WORK_DIR / fname
        if not fpath.exists():
            print(f"  SKIP: {fname} not found")
            continue
        data = fpath.read_bytes()
        verify_no_bom(data, fname)
        file_data[arcname] = data
        print(f"  {fname} ({len(data)} bytes, OK)")

    bak = BACKUP_DIR / datetime.now().strftime("%Y%m%d_%H%M%S") / sdz_name
    bak.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(src, bak)

    existing = set()
    modified = 0
    new_added = 0

    with zipfile.ZipFile(src, 'r') as zin:
        for item in zin.infolist():
            existing.add(item.filename)

        with zipfile.ZipFile(tmp, 'w', zipfile.ZIP_DEFLATED) as zout:
            for item in zin.infolist():
                if item.filename in file_data:
                    zout.writestr(item, file_data[item.filename])
                    modified += 1
                else:
                    zout.writestr(item, zin.read(item.filename))

            for arcname, data in file_data.items():
                if arcname not in existing:
                    zout.writestr(arcname, data)
                    new_added += 1

    shutil.move(str(src), str(src) + ".bak")
    shutil.move(str(tmp), str(src))
    # Clean up stale .bak (we already have a backup)
    old_bak = Path(str(src) + ".bak")
    if old_bak.exists():
        old_bak.unlink()

    size_mb = src.stat().st_size / 1024 / 1024
    print(f"  Packed: {sdz_name} ({size_mb:.0f} MB) | backup: {bak.name}")
    print(f"  Modified: {modified}, New: {new_added}")


def main():
    print("=" * 60)
    print("  Zero-K 简体中文汉化部署 v2")
    print("=" * 60)

    for sdz_name, updates in DEPLOY_PLAN.items():
        print(f"\n[{sdz_name}]")
        stream_deploy(sdz_name, updates)

    print(f"\n备份位置: {BACKUP_DIR}")
    print("请启动游戏 -> 设置 -> Language -> 简体中文")


if __name__ == "__main__":
    main()
