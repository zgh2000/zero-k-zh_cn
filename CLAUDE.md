# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 项目概述

Zero-K 简体中文汉化补丁。Zero-K 是运行在 RecoilEngine（Spring RTS 分支 105.0）上的游戏。本项目通过修改游戏的 `.sdz` 归档文件来注入中文翻译。

## 常用命令

```bash
uv run python deploy_zh.py    # 部署全部汉化到游戏目录
```

**运行前必须关闭游戏**，否则 .sdz 被锁定无法写入。

## 架构

### 部署流水线

游戏文件在 `D:\SteamLibrary\steamapps\common\Zero-K\games\`：
- `zkmenu-stable.sdz`（~194 MB）— 大厅/菜单 UI（Lua widgets + 配置）
- `zk-stable.sdz`（~590 MB）— 游戏内 UI（JSON 翻译文件）

`deploy_zh.py` 通过流式 ZIP 修改将 `work/` 中的文件注入对应 .sdz。每个 .sdz 修改前自动备份到 `backup/`。

### 翻译模式

翻译数据集中在 `work/campaign_zh_CN.lua`（纯 Lua 表，`local T = {} ... return T`），包含：
- `T.planets` — 星球描述（name → {text, extendedText, hintText}）
- `T.codex` — 百科条目（entry_id → {name, text}）
- `T.codex_categories` — 百科分类（"1. Entries" → "1. 条目"）
- `T.common` — 通用标签（primary_label, type_label, locked_planet）
- `T.terrain_types` — 地形类型（"Terran" → "类地"）

每个需要翻译的 widget 通过文件级 `VFS.Include` 加载翻译表，然后通过局部查找函数（`T()`, `T_codex()`, `T_cat()`）获取翻译。Widget 有独立作用域，各自加载各自的翻译表实例。

### 关键文件

| 文件 | 角色 |
|------|------|
| `deploy_zh.py` | 主部署脚本，定义 DEPLOY_PLAN |
| `zk_i18n.py` | 工具模块（备份/解包/注入） |
| `work/campaign_zh_CN.lua` | 翻译数据库 |
| `work/configuration.lua` | 添加 zh_CN 语言注册 |
| `work/chililobby.lua` | 大厅 UI 翻译（233 条 i18n） |
| `work/gui_campaign_handler.lua` | 星球界面汉化 |
| `work/gui_campaign_codex_handler.lua` | 百科界面汉化 |
| `work/api_planet_battle_handler.lua` | 星球战斗界面汉化 |
| `SKILL.md` | 完整经验总结（踩坑记录） |

## 关键约束

### BOM 陷阱
Spring Lua 解析器**不接受 UTF-8 BOM**（`EF BB BF`）。部署前所有 .lua 文件必须去除 BOM。`deploy_zh.py` 中的 `verify_no_bom()` 会检查。

### Spring Lua 沙箱
RecoilEngine 的 Lua 环境**不允许在函数对象上存储字段**（如 `func._count`），必须用文件级局部变量代替。详见 `SKILL.md`。

### 流式 ZIP 修改
`.sdz` 文件**不能整体解压再重新打包**——会破坏 Spring VFS 兼容性。必须用流式方法逐文件替换（`deploy_zh.py:stream_deploy()`）。

### Chili.TreeView 百科
`GetNodeByCaption(name)` 按节点标题精确匹配。翻译分类名时必须用"源翻译"方案：在 `LoadCodexEntries` 中覆写 `entry.category`，确保所有后续代码引用一致。

## 添加新翻译

1. 在 `work/campaign_zh_CN.lua` 的对应 `T.*` 表中添加翻译条目
2. 如需在 widget 中使用，按标准模式添加 loader + 查找函数
3. 将修改的文件路径加入 `deploy_zh.py` 的 `DEPLOY_PLAN`
4. 运行 `uv run python deploy_zh.py`
