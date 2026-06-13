-- This is the list of name ("action name") related to unit command. This name won't work using command line (eg: /fight, won't activate FIGHT command) but it can be binded to a key (eg: /bind f fight, will activate FIGHT when f is pressed)
-- In reverse, one can use Spring.GetActionHotkey(name) to get the key binded to this name.
-- This table is used in Epicmenu for hotkey management.

VFS.Include("LuaRules/Configs/customcmds.h.lua")

local custom_cmd_actions = {
	-- cmdTypes are:
	-- 1: Targeted commands (eg attack)
	-- 2: State commands (eg on/off). Parameter 'state' creates actions to set a particular state
	-- 3: Instant commands (eg self-d)

	--SPRING COMMANDS
	selfd = {cmdType = 3, name = "自毁"},
	attack = {cmdType = 1, name = "强制攻击"},
	stop = {cmdType = 3, name = "停止"},
	fight = {cmdType = 1, name = "攻击移动"},
	guard = {cmdType = 1, name = "守卫"},
	move = {cmdType = 1, name = "移动"},
	patrol = {cmdType = 1, name = "巡逻"},
	wait = {cmdType = 3, name = "等待"},
	timewait = {cmdType = 3, name = "等待：计时器"},
	deathwait = {cmdType = 3, name = "等待：死亡"},
	squadwait = {cmdType = 3, name = "等待：小队"},
	gatherwait = {cmdType = 3, name = "等待：集合"},
	repair = {cmdType = 1, name = "修复"},
	reclaim = {cmdType = 1, name = "回收"},
	resurrect = {cmdType = 1, name = "复活"},
	manualfire = {cmdType = 1, name = "发射特殊武器"},
	airmanualfire = {cmdType = 1, name = "发射特殊武器（飞行器）"},
	loadunits = {cmdType = 1, name = "装载单位"},
	unloadunits = {cmdType = 1, name = "卸载单位"},
	areaattack = {cmdType = 1, name = "区域攻击"},

	rawmove = {cmdType = 1, name = "移动"},

	-- states
	wantonoff =       {cmdType = 2, cmdID = CMD_WANT_ONOFF, name = "开/关", states = {'关闭', '开启'}},
	['repeat'] =      {cmdType = 2, cmdID = CMD.REPEAT, name = "重复", states = {'关闭', '开启'}},
	wantcloak =       {cmdType = 2, cmdID = CMD_WANT_CLOAK, name = "隐身", states = {'关闭', '开启'}},
	movestate =       {cmdType = 2, cmdID = CMD.MOVE_STATE, name = "移动状态", states = {'坚守阵地', '机动', '漫游'}},
	firestate =       {cmdType = 2, cmdID = CMD.FIRE_STATE, name = "开火状态", states = {'停火', '还击', '自由开火'}},
	idlemode =        {cmdType = 2, cmdID = CMD.IDLEMODE, name = "空中空闲状态", states = {'着陆', '飞行'}},
	autorepairlevel = {cmdType = 2, name = "空中撤退阈值", states = {'关闭', '30%', '50%', '80%'}},
	preventoverkill = {cmdType = 2, cmdID = CMD_PREVENT_OVERKILL, name = "过度杀伤预防", states = {'关闭', '自动瞄准时', '自由开火时', '停火时单目标除外', '开启'}},
	preventbait     = {cmdType = 2, cmdID = CMD_PREVENT_BAIT, name = "避免不良目标", states = {'禁用', '35', '90', '240', '420'}},
	fireatshields   = {cmdType = 2, cmdID = CMD_FIRE_AT_SHIELD, name = "攻击护盾", states = {'关闭', '开启'}},
	firetowards     = {cmdType = 2, cmdID = CMD_FIRE_TOWARDS_ENEMY, name = "向敌人开火", states = {'关闭', '开启'}},
	trajectory      = {cmdType = 2, cmdID = CMD.TRAJECTORY, name = "弹道", states = {'低', '高'}},

	--CUSTOM COMMANDS
	sethaven = {cmdType = 1, name = "添加撤退区域"},
	excludeairpad = {cmdType = 1, name = "排除机场"},
	--build = {cmdType = 1, name = "--build"},
	areamex = {cmdType = 1, name = "区域金属"},
	areaterramex = {cmdType = 1, name = "区域地形金属"},
	mine = {cmdType = 1, name = "布雷"},
	build = {cmdType = 1, name = "建造"},
	jump = {cmdType = 1, name = "跳跃"},
	find_pad = {cmdType = 3, name = "返回机场"},
	exclude_pad = {cmdType = 1, name = "排除机场"},
	field_fac_select = {cmdType = 1, name = "复制工厂蓝图"},
	build_field_unit = {cmdType = 1, name = "建造复制蓝图"},
	embark = {cmdType = 3, name = "登船"},
	disembark = {cmdType = 3, name = "下船"},
	loadselected = {cmdType = 3, name = "装载选中单位"},
	oneclickwep = {cmdType = 3, name = "激活特殊能力"},
	settargetcircle = {cmdType = 1, name = "设置目标"},
	settarget = {cmdType = 1, name = "设置目标（矩形）"},
	canceltarget = {cmdType = 3, name = "取消目标"},
	setferry = {cmdType = 1, name = "创建运输路线"},
	setfirezone = {cmdType = 1, name = "设置牛顿火力区域"},
	cancelfirezone = {cmdType = 3, name = "取消牛顿火力区域"},
	--selectmissiles = {cmdType = 3, name = "Select Missiles"},
	radialmenu = {cmdType = 3, name = "打开径向建造菜单"},
	placebeacon = {cmdType = 1, name = "放置灯塔"},
	recalldrones = {cmdType = 3, name = "召回无人机到母舰"},
	buildprev = {cmdType = 1, name = "建造上一个"},
	areaguard = {cmdType = 1, name = "区域守卫"},
	dropflag = {cmdType = 3, name = "放置旗帜"},
	upgradecomm = {cmdType = 3, name = "升级指挥官"},
	upgradecommstop = {cmdType = 3, name = "停止升级指挥官"},
	stopproduction = {cmdType = 3, name = "停止工厂生产"},
	globalbuildcancel = {cmdType = 1, name = "取消全局建造任务"},
	evacuate = {cmdType = 3, name = "疏散"},
	morph = {cmdType = 3, name = "变形（并停止变形）"},

	-- terraform
	rampground = {cmdType = 1, name = "地形改造：坡道"},
	levelground = {cmdType = 1, name = "地形改造：平整"},
	raiseground = {cmdType = 1, name = "地形改造：抬升"},
	smoothground = {cmdType = 1, name = "地形改造：平滑"},
	restoreground = {cmdType = 1, name = "地形改造：恢复"},
	--terraform_internal = {cmdType = 1, name = "--terraform_internal"},

	--build a "generic" plate from build factory menu
	buildplate = {cmdType = 1, name = "建造板"},
	
	resetfire = {cmdType = 3, name = "重置开火"},
	resetmove = {cmdType = 3, name = "重置移动"},

	--states
--	stealth = {cmdType = 2, name = "stealth"},
	cloak_shield =      {cmdType = 2, cmdID = CMD_CLOAK_SHIELD, name = "区域隐形", states = {'关闭', '开启'}},
	retreat =           {cmdType = 2, cmdID = CMD_RETREAT, name = "撤退阈值", states = {'关闭', '30%', '65%', '99%'}, actionOverride = {'cancelretreat'}},
	['luaui noretreat'] = {cmdType = 2, name = "luaui noretreat"},
	priority =          {cmdType = 2, cmdID = CMD_PRIORITY, name = "建造优先级", states = {'低', '普通', '高'}},
	miscpriority =      {cmdType = 2, cmdID = CMD_MISC_PRIORITY, name = "杂项优先级", states = {'低', '普通', '高'}},
	ap_fly_state =      {cmdType = 2, cmdID = CMD_AP_FLY_STATE, name = "空中空闲状态", states = {'着陆', '飞行'}},
	ap_autorepairlevel = {cmdType = 2, name = "自动修复", states = {'关闭', '30%', '50%', '80%'}},
	floatstate =        {cmdType = 2, name = "漂浮状态", states = {'下沉', '射击时', '漂浮'}},
	dontfireatradar =   {cmdType = 2, cmdID = CMD_DONT_FIRE_AT_RADAR, name = "攻击雷达点", states = {'关闭', '开启'}},
	antinukezone =      {cmdType = 2, name = "停火反核区域", states = {'关闭', '开启'}},
	unitai =            {cmdType = 2, cmdID = CMD_UNIT_AI, name = "单位AI", states = {'关闭', '开启'}},
	selection_rank =    {cmdType = 2, name = "选择优先级", states = {'0', '1', '2', '3'}},
	formation_rank =    {cmdType = 2, name = "编队优先级", states = {'0', '1', '2', '3'}},
	autocalltransport = {cmdType = 2, name = "自动呼叫运输", states = {'关闭', '开启'}},
	unit_kill_subordinates = {cmdType = 2, cmdID = CMD_UNIT_KILL_SUBORDINATES, name = "击杀被捕获单位", states = {'关闭', '开启'}},
	goostate =     {cmdType = 2, cmdID = CMD_GOO_GATHER, name = "粘液状态", states = {'关闭', '未隐身时', '开启'}},
	disableattack = {cmdType = 2, cmdID = CMD_DISABLE_ATTACK, name = "允许攻击", states = {'允许', '阻止'}},
	pushpull =      {cmdType = 2, cmdID = CMD_PUSH_PULL, name = "冲量模式", states = {'拉动', '推动'}},
	autoassist =    {cmdType = 2, cmdID = CMD_FACTORY_GUARD, name = "工厂自动协助", states = {'关闭', '开启'}},
	airstrafe =     {cmdType = 2, cmdID = CMD_AIR_STRAFE, name = "炮艇扫射", states = {'关闭', '开启'}},
	divestate =     {cmdType = 2, cmdID = CMD_UNIT_BOMBER_DIVE_STATE, name = "渡鸦俯冲", states = {'从不', '护盾下', '对移动单位', '始终低飞'}},
	globalbuild =   {cmdType = 2, cmdID = CMD_GLOBAL_BUILD, name = "工程单位全局AI", states = {'关闭', '开启'}},
	toggledrones =  {cmdType = 2, cmdID = CMD_TOGGLE_DRONES, name = "无人机建造", states = {'关闭', '开启'}},
}

-- These actions are created from echoing all actions that appear when all units are selected.
-- See cmd_layout_handler for how to generate these actions.
local usedActions = {
	["stop"] = true,
	["attack"] = true,
	["wait"] = true,
	["timewait"] = true,
	["deathwait"] = true,
	["squadwait"] = true,
	["gatherwait"] = true,
	["selfd"] = true,
	["firestate"] = true,
	["movestate"] = true,
	["repeat"] = true,
	["loadonto"] = true,
	["rawmove"] = true,
	["patrol"] = true,
	["fight"] = true,
	["guard"] = true,
	["areaguard"] = true,
	["orbitdraw"] = true,
	["preventoverkill"] = true,
	["preventbait"] = true,
	["retreat"] = true,
	["unitai"] = true,
	["settarget"] = true,
	["settargetcircle"] = true,
	["canceltarget"] = true,
	["embark"] = true,
	["disembark"] = true,
	["transportto"] = true,
	["wantonoff"] = true,
	["miscpriority"] = true,
	["manualfire"] = true,
	["airmanualfire"] = true,
	["repair"] = true,
	["reclaim"] = true,
	["areamex"] = true,
	["areaterramex"] = true,
	["priority"] = true,
	["rampground"] = true,
	["levelground"] = true,
	["raiseground"] = true,
	["smoothground"] = true,
	["restoreground"] = true,
	["buildplate"] = true,
	["jump"] = true,
	["idlemode"] = true,
	["areaattack"] = true,
	--["rearm"] = true, -- Not useful to send directly so unbindable to prevent confusion. Right click on pad is better.
	["find_pad"] = true,
	["recalldrones"] = true,
	["toggledrones"] = true,
	--["divestate"] = true,
	["wantcloak"] = true,
	["oneclickwep"] = true,
	["floatstate"] = true,
	["airstrafe"] = true,
	["dontfireatradar"] = true,
	["stockpile"] = true,
	["trajectory"] = true,
	["cloak_shield"] = true,
	["stopproduction"] = true,
	["resurrect"] = true,
	["loadunits"] = true,
	["unloadunits"] = true,
	["loadselected"] = true,
	["apFlyState"] = true,
	["placebeacon"] = true,
	["morph"] = true,
	--["prevmenu"] = true,
	--["nextmenu"] = true,
	["upgradecomm"] = true,
	["autoassist"] = true,
	["autocalltransport"] = true,
	["setferry"] = true,
	["sethaven"] = true,
	["exclude_pad"] = true,
	["field_fac_select"] = true,
	["build_field_unit"] = true,
	["setfirezone"] = true,
	["cancelfirezone"] = true,
	["selection_rank"] = true,
	["formation_rank"] = true,
	["pushpull"] = true,
	["unit_kill_subordinates"] = true,
	["fireatshields"] = true,
	["firetowards"] = true,
	["goostate"] = true,

	-- These actions are used, just not by selecting everything with default UI
	["globalbuild"] = true,
	["upgradecommstop"] = true,
	["autoeco"] = true,
	["evacuate"] = true,
}

-- Clear unused actions.
for name,_ in pairs(custom_cmd_actions) do
	if not usedActions[name] then
		custom_cmd_actions[name] = nil
	end
end

-- Add toggle-to-particular-state commands
local fullCustomCmdActions = {}
for name, data in pairs(custom_cmd_actions) do
	if data.states then
		for i = 1, #data.states do
			local cmdName = (data.actionOverride and data.actionOverride[i]) or (name .. " " .. (i-1))
			fullCustomCmdActions[cmdName] = {
				cmdType = data.cmdType,
				name = data.name .. ": set " .. data.states[i],
				setValue = (i - 1),
				cmdID = data.cmdID,
			}
		end
		data.name = data.name .. ": toggle"
	end
	fullCustomCmdActions[name] = data
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local modCommands = VFS.Include("LuaRules/Configs/modCommandsDefs.lua")
for i = 1, #modCommands do
	local cmd = modCommands[i]
	fullCustomCmdActions[cmd.actionName] = {
		cmdType = (cmd.isState and 2) or (cmd.isInstant and 3) or 1,
		cmdID = cmd.cmdID,
		name = cmd.humanName,
		states = cmd.stateNames,
	}
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

return fullCustomCmdActions
