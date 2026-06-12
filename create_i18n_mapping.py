"""
将所有硬编码的中文字符串改为使用 i18n 系统
"""
import os
import re

# 定义需要添加到 chililobby.lua 的翻译键
i18n_translations = {
    # awards.lua
    '"完全歼灭"': '"完成歼灭"',
    '"舰队上将"': '"舰队上将"',
    '"空军上将"': '"空军上将"',
    '"末日成就奖"': '"末日成就奖"',
    '"龟壳"': '"龟壳"',
    '"烧烤大师"': '"烧烤大师"',
    '"EMP巫师"': '"EMP巫师"',
    '"交通警察"': '"交通警察"',
    '"和平使者"': '"和平使者"',
    '"实验工程师"': '"实验工程师"',
    
    # badges.lua
    '"200级"': '"200级"',
    '"前3名玩家"': '"前3名玩家"',
    '"青铜捐赠者"': '"青铜捐赠者"',
    '"白银捐赠者"': '"白银捐赠者"',
    '"黄金捐赠者"': '"黄金捐赠者"',
    '"钻石捐赠者"': '"钻石捐赠者"',
    '"外部开发者"': '"外部开发者"',
    '"游戏开发者"': '"游戏开发者"',
    '"首席开发者"': '"首席开发者"',
}

# 定义硬编码字符串到 i18n 键的映射
hardcoded_to_i18n = {
    # downloader.lua
    'caption = "队列:"': 'caption = i18n("queue_label")',
    'caption = "取消"': 'caption = i18n("cancel")',
    
    # gui_battle_room_window.lua
    'caption = "选项"': 'caption = i18n("options")',
    'caption = "等待列表"': 'caption = i18n("waiting_list")',
    'caption = "高级"': 'caption = i18n("advanced")',
    'caption = "返回"': 'caption = i18n("back")',
    
    # gui_benchmark_handler.lua
    'caption = "中止"': 'caption = i18n("abort")',
    'caption = "基准测试"': 'caption = i18n("benchmark")',
    'caption = "生成脚本"': 'caption = i18n("generate_script")',
    
    # gui_campaign_commander_loadout.lua
    'caption = "等级 "': 'caption = i18n("level") .. " "',
    
    # gui_campaign_handler.lua
    'caption = "战役测试"': 'caption = i18n("campaign_testing")',
    'caption = "提交反馈"': 'caption = i18n("post_feedback")',
    'caption = "反馈"': 'caption = i18n("feedback")',
    'caption = "难度"': 'caption = i18n("difficulty")',
    'caption = "在 "': 'caption = i18n("victory_on")',
    'caption = "星球 "': 'caption = i18n("planet")',
    'caption = "继续"': 'caption = i18n("continue")',
    'caption = "全自动"': 'caption = i18n("full_auto")',
    'caption = "奖励"': 'caption = i18n("bonuses")',
    'caption = "自动胜利"': 'caption = i18n("auto_win")',
    'caption = "自动失败"': 'caption = i18n("auto_lose")',
    
    # gui_campaign_options.lua
    'caption = "难度"': 'caption = i18n("difficulty")',
    
    # gui_campaign_saveload.lua
    'caption = "难度"': 'caption = i18n("difficulty")',
    'text = "等级: "': 'text = i18n("level") .. ": "',
    
    # gui_chili_commander_upgrade.lua
    'caption = "模组"': 'caption = i18n("modules")',
    
    # gui_chili_endgamewindow.lua
    'caption = "奖项"': 'caption = i18n("awards")',
    'caption = "统计"': 'caption = i18n("statistics")',
    'caption = "退出到大厅"': 'caption = i18n("exit_to_lobby")',
    'caption = "游戏结束！"': 'caption = i18n("game_over")',
    'caption = "胜利！"': 'caption = i18n("victory")',
    'caption = "失败！"': 'caption = i18n("defeat")',
    'caption = "平局！"': 'caption = i18n("draw")',
    'caption = "游戏中断"': 'caption = i18n("game_aborted")',
    
    # gui_chili_inactivity_win.lua
    'text = "检测到对手连接问题"': 'text = i18n("connection_problems")',
    'text = "等待 或"': 'text = i18n("wait_or")',
    'caption = "胜利"': 'caption = i18n("win")',
    
    # gui_color_change_window.lua
    'caption = "选择颜色"': 'caption = i18n("choose_color")',
    
    # gui_community_window.lua
    'caption = "欢迎来到 Zero-K"': 'caption = i18n("welcome_to_zk")',
    'caption = "开始战役"': 'caption = i18n("play_campaign")',
    'caption = "社区"': 'caption = i18n("community")',
    
    # gui_download_window.lua
    'caption = "下载"': 'caption = i18n("downloads")',
    
    # gui_epicmenu.lua
    'caption = "否"': 'caption = i18n("no")',
    
    # gui_friend_window.lua
    'caption = "等级 "': 'caption = i18n("level") .. " "',
    'caption = "奖项:"': 'caption = i18n("awards_label")',
    
    # gui_maplist_panel.lua
    'caption = "选择地图"': 'caption = i18n("select_map")',
    'caption = "加载中"': 'caption = i18n("loading")',
    
    # gui_planetwars_list_window.lua
    'caption = "加入"': 'caption = i18n("join")',
    'caption = "阵营页面"': 'caption = i18n("factions_page")',
    'caption = "星球战争"': 'caption = i18n("planetwars")',
    'caption = "星图"': 'caption = i18n("galaxy_map")',
    
    # gui_queue_list_window.lua
    'caption = "匹配对战"': 'caption = i18n("matchmaking")',
    
    # gui_queue_status_panel.lua
    'caption = "取消"': 'caption = i18n("cancel")',
    'caption = "开始"': 'caption = i18n("start")',
    
    # gui_replay_handler.lua
    'caption = "回放"': 'caption = i18n("replays")',
    'caption = "加载中"': 'caption = i18n("loading")',
    
    # gui_report_panel.lua
    'caption = "踢出"': 'caption = i18n("kick")',
    
    # gui_steam_release_notifier.lua
    'caption = "商店页面"': 'caption = i18n("store_page")',
    'caption = "设置指南"': 'caption = i18n("settings_guide")',
    
    # gui_tooltip.lua
    'text = "等级: "': 'text = i18n("level") .. ": "',
    
    # gui_tutorial_handler.lua
    'caption = "开始教程"': 'caption = i18n("play_tutorial")',
    
    # gui_zk_comm_config.lua
    'caption = "等级 "': 'caption = i18n("level") .. " "',
    
    # helpsubmenuconfig.lua
    'caption = "社区和开发链接"': 'caption = i18n("community_links")',
    'caption = "发送Bug报告"': 'caption = i18n("send_bug_report")',
    'caption = "标题:"': 'caption = i18n("title_label")',
    'caption = "提交"': 'caption = i18n("submit")',
    
    # interface_root.lua
    'caption = "菜单"': 'caption = i18n("menu")',
    'caption = "返回战斗"': 'caption = i18n("return_to_battle")',
    'caption = "离开战斗"': 'caption = i18n("leave_battle")',
    
    # localwidgets.lua
    'caption = "关闭"': 'caption = i18n("close")',
    
    # login_window.lua
    'caption = "用户协议"': 'caption = i18n("user_agreement")',
    'caption = "接受"': 'caption = i18n("accept")',
    'caption = "拒绝"': 'caption = i18n("decline")',
    
    # mission_messagebox_zk.lua
    'caption = "下一步"': 'caption = i18n("next")',
    
    # zk_campaign_handler.lua
    'caption = "类型"': 'caption = i18n("type")',
    'caption = "半径"': 'caption = i18n("radius")',
    'caption = "主要"': 'caption = i18n("primary")',
    'caption = "军事评级"': 'caption = i18n("military_rating")',
    'caption = "星图"': 'caption = i18n("galaxy_map")',
}

# 添加到 chililobby.lua 的翻译键
new_i18n_keys = {
    'queue_label': '"队列:"',
    'options': '"选项"',
    'waiting_list': '"等待列表"',
    'advanced': '"高级"',
    'abort': '"中止"',
    'benchmark': '"基准测试"',
    'generate_script': '"生成脚本"',
    'level': '"等级"',
    'campaign_testing': '"战役测试"',
    'post_feedback': '"提交反馈"',
    'feedback': '"反馈"',
    'difficulty': '"难度"',
    'victory_on': '"在 "',
    'bonuses': '"奖励"',
    'auto_win': '"自动胜利"',
    'auto_lose': '"自动失败"',
    'modules': '"模组"',
    'awards': '"奖项"',
    'statistics': '"统计"',
    'exit_to_lobby': '"退出到大厅"',
    'game_over': '"游戏结束！"',
    'victory': '"胜利！"',
    'defeat': '"失败！"',
    'draw': '"平局！"',
    'game_aborted': '"游戏中断"',
    'connection_problems': '"检测到对手连接问题"',
    'wait_or': '"等待 或"',
    'win': '"胜利"',
    'choose_color': '"选择颜色"',
    'welcome_to_zk': '"欢迎来到 Zero-K"',
    'play_campaign': '"开始战役"',
    'community': '"社区"',
    'downloads': '"下载"',
    'no': '"否"',
    'awards_label': '"奖项:"',
    'select_map': '"选择地图"',
    'loading': '"加载中"',
    'join': '"加入"',
    'factions_page': '"阵营页面"',
    'planetwars': '"星球战争"',
    'galaxy_map': '"星图"',
    'matchmaking': '"匹配对战"',
    'start': '"开始"',
    'cancel': '"取消"',
    'replays": '"回放"',
    'kick': '"踢出"',
    'store_page': '"商店页面"',
    'settings_guide': '"设置指南"',
    'play_tutorial': '"开始教程"',
    'community_links': '"社区和开发链接"',
    'send_bug_report': '"发送Bug报告"',
    'title_label': '"标题:"',
    'submit': '"提交"',
    'menu': '"菜单"',
    'return_to_battle': '"返回战斗"',
    'leave_battle': '"离开战斗"',
    'close': '"关闭"',
    'user_agreement': '"用户协议"',
    'accept': '"接受"',
    'decline': '"拒绝"',
    'next': '"下一步"',
    'type': '"类型"',
    'radius': '"半径"',
    'primary': '"主要"',
    'military_rating': '"军事评级"',
}

print('Translation mapping created.')
print(f'Total i18n keys to add: {len(new_i18n_keys)}')
print(f'Total hardcoded strings to fix: {len(hardcoded_to_i18n)}')
