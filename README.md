# Zero-K 简体中文汉化

Steam 游戏 [Zero-K](https://store.steampowered.com/app/334920/ZeroK/) 的简体中文汉化补丁，一键脚本部署。

## 前置条件

- 已安装 Zero-K（Steam 版）
- [Python 3](https://www.python.org/) + [uv](https://docs.astral.sh/uv/)

## 使用方法

```bash
cd zh_cn_translation
uv run python deploy_zh.py
```

启动游戏 → 设置 → Language → 简体中文。

## 注意事项

- **运行脚本前必须关闭游戏**，否则 .sdz 文件被锁定无法写入
- Steam 验证游戏文件后会还原为英文，重新运行脚本即可
- 每次运行自动备份原文件到 `backup/` 目录

## 文件结构

```
zh_cn_translation/
├── deploy_zh.py              # 主部署脚本（运行这个）
├── zk_i18n.py                # 流式 ZIP 修改工具
├── SKILL.md                  # 翻译经验总结
└── work/
    ├── campaign_zh_CN.lua    # 翻译数据库（星球、百科、通用）
    ├── chililobby.lua        # 大厅 UI（233 条）
    ├── configuration.lua     # 语言注册
    ├── gui_campaign_handler.lua       # 星球界面
    ├── gui_campaign_codex_handler.lua # 百科界面
    ├── api_planet_battle_handler.lua  # 星球战斗界面
    ├── campaign_units.zh_cn.json     # 战役单位
    ├── common.zh_cn.json             # 游戏内通用文本
    ├── epicmenu.zh_cn.json           # Epic 菜单
    ├── healthbars.zh_cn.json         # 血条标签
    ├── interface.zh_cn.json          # 界面文本
    ├── misc.zh_cn.json               # 杂项文本
    ├── pw_units.zh_cn.json           # 行星战争单位
    ├── resbars.zh_cn.json            # 资源栏文本
    └── units.zh_cn.json              # 单位名称
```

## 翻译范围

| 模块 | 条目数 | 状态 |
|------|--------|------|
| 大厅 UI | 233 条 | 完成 |
| 星球描述 | ~71 星球 | 完成 |
| 百科条目 + 分类 | 52 条目 / 6 分类 | 完成 |
| 地形类型 | 21 种 | 完成 |
| Epic 菜单 | 41 条 | 完成 |
| 单位名称 | 248 条 | 完成 |
| 界面文本 | 127 条 | 完成 |
| 资源栏文本 | 41 条 | 完成 |
| 战役单位 | 19 条 | 完成 |
| 行星战争单位 | 23 条 | 完成 |
| 血条标签 | 22 条 | 完成 |
| 杂项文本 | 3 条 | 完成 |
| 游戏内通用文本 | 81 条 | 完成 |
