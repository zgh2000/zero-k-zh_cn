# Zero-K 汉化经验总结

基于 Spring RTS / RecoilEngine 游戏的 Lua 汉化实践经验。

## 1. .sdz 文件处理

### 格式与限制
- `.sdz` 是标准 ZIP 格式（DEFLATED 压缩），Spring VFS 直接挂载
- **不能解压全部文件再重新打包**——会破坏 Spring VFS 兼容性
- 必须用**流式方法**：读取原 ZIP entry → 修改内容 → writestr 写回

```python
with zipfile.ZipFile(src, 'r') as zin:
    with zipfile.ZipFile(tmp, 'w', zipfile.ZIP_DEFLATED) as zout:
        for item in zin.infolist():
            if item.filename in file_data:
                zout.writestr(item, file_data[item.filename])
            else:
                zout.writestr(item, zin.read(item.filename))
```

### 文件锁定
- 游戏运行时 .sdz 被锁定，部署前**必须关闭游戏**

## 2. UTF-8 BOM 陷阱

- Windows PowerShell `Out-File -Encoding utf8` 添加 `EF BB BF` BOM 头
- **Spring/RecoilEngine Lua 解析器不兼容 BOM**，导致文件静默解析失败
- 解决：写文件后检查并去除前 3 字节 BOM

```python
raw = path.read_bytes()
if raw[:3] == b'\xef\xbb\xbf':
    path.write_bytes(raw[3:])
```

## 3. Spring Lua 沙箱限制

### 函数对象不能存储字段
```lua
-- 错误：Spring Lua 报 "attempt to index upvalue 'func' (a function value)"
local function foo()
    if not foo._count then foo._count = 0 end  -- 崩溃！
end

-- 正确：使用文件级局部变量
local foo_count = 0
local function foo()
    if foo_count < 5 then foo_count = foo_count + 1 end
end
```

### pcall 静默失败
```lua
-- 加载失败时无提示，zhCN 保持 nil，所有翻译静默回退英文
local zhOk, zhResult = pcall(VFS.Include, "path/to/file.lua")
if zhOk then zhCN = zhResult end
-- 调试时加 Spring.Echo 检查 zhOk
```

## 4. VFS.Include 在 Widget 中的使用

- Widget 文件级代码在引擎解析时立即同步执行
- 翻译数据文件应设为纯数据（`local T = {} ... return T`），无副作用
- 每个 widget 有独立作用域，需各自 `VFS.Include` 翻译文件
- 推荐 loader 放在 `widget:GetInfo()` 之前

## 5. Chili.TreeView 百科界面汉化

### 核心问题
`GetNodeByCaption(name)` 按节点标题查找。翻译标题后所有查找也必须用翻译后的名称。

### 正确方案："源翻译"
在 `LoadCodexEntries` 中一次性翻译 keys + `entry.category`：

```lua
for id, entry in pairs(codexEntries) do
    local catKey = T_cat(entry.category) or entry.category
    categories[catKey] = categories[catKey] or {}
    entry.category = catKey  -- 覆写为翻译值
    cat[#cat + 1] = entry
end
```

### 翻译键必须精确匹配
```lua
T.codex_categories = {
    ["1. Entries"] = "1. 条目",
    ["2. Threats"] = "2. 威胁",
    -- 键必须与 codex.lua 中 entry.category 完全一致
}
```

## 6. 调试策略

### 二分法定位崩溃
修改叠加后崩溃 → 逐个回退 → 从 loader-only 开始逐步加 mods → 定位根因

### Spring.Echo 诊断
输出到 `infolog.txt`，用唯一前缀便于 grep：
```lua
Spring.Echo("[zh_CN_codex] message")
```

### 检查清单
- [ ] 翻译键 ID 与源数据匹配？
- [ ] VFS.Include 路径与部署路径一致？
- [ ] 文件无 BOM？
- [ ] 函数对象无字段存储？（Spring Lua 限制）
- [ ] GetNodeByCaption 查找键与节点 caption 一致？
- [ ] 长字符串 `[[...]]` 括号平衡？

## 7. 部署清单

| 文件 | 修改内容 |
|------|----------|
| `configuration.lua` | 添加 `zh_CN` 语言注册 |
| `chililobby.lua` | 添加 `zh_CN = {...}` 翻译段 |
| `gui_campaign_handler.lua` | zhCN loader + `T()` + 标签汉化 |
| `gui_campaign_codex_handler.lua` | zhCN loader + `T_codex()` + `T_cat()` + LoadCodexEntries 源翻译 |
| `api_planet_battle_handler.lua` | zhCN loader + `T()` |
| `campaign_zh_CN.lua` | **新建**翻译数据库 |
