local buildCmdFactory, buildCmdEconomy, buildCmdDefence, buildCmdSpecial, buildCmdUnits, cmdPosDef, factoryUnitPosDef = include("Configs/integral_menu_commands_processed.lua", nil, VFS.RAW_FIRST)

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Tooltips

local imageDir = 'LuaUI/Images/commands/'

local tooltips = {
	WANT_ONOFF = "激活 (_STATE_)\n  切换单位能力，如雷达、护盾充能和雷达干扰。",
	UNIT_AI = "单位AI (_STATE_)\n  在战斗中智能移动。",
	FIRE_AT_SHIELD = "攻击护盾 (_STATE_)\n  当没有其他目标时，射击Thugs、Felons和Convicts的护盾。",
	FIRE_TOWARDS_ENEMY = "向敌人开火 (_STATE_)\n  当没有其他目标时，向敌人方向射击。",
	REPEAT = "重复 (_STATE_)\n  循环工厂建造，或单位的命令队列。",
	WANT_CLOAK = "隐身 (_STATE_)\n  变为隐形。受到伤害、开火、能力和附近敌人干扰。",
	CLOAK_SHIELD = "区域隐形 (_STATE_)\n  隐形区域内所有友方单位。不适用于建筑或护盾携带者。",
	PRIORITY = "建造优先级 (_STATE_)\n  更高优先级的建造优先获取资源。",
	MISC_PRIORITY = "杂项优先级 (_STATE_)\n  其他资源使用的优先级，如变形、储备和雷达。",
	FACTORY_GUARD = "自动协助 (_STATE_)\n  新建造的工程单位留下协助并提高产量。",
	AUTO_CALL_TRANSPORT = "呼叫运输 (_STATE_)\n  自动在工程任务之间呼叫运输。",
	GLOBAL_BUILD = "全局建造命令 (_STATE_)\n  设置工程单位执行全局建造命令。",
	MOVE_STATE = "坚守阵地 (_STATE_)\n  防止单位空闲时移动。状态是持久且可切换的。",
	FIRE_STATE = "停火 (_STATE_)\n  防止单位开火，除非有直接命令或目标。",
	RETREAT = "撤退 (_STATE_)\n  撤退到最近的机场或撤退区域（通过屏幕左上角放置）。右键点击禁用。",
	IDLEMODE = "空中空闲状态 (_STATE_)\n  设置飞机空闲时是否着陆。",
	AP_FLY_STATE = "空中工厂空闲状态 (_STATE_)\n  设置生产的飞机空闲时是否着陆。",
	UNIT_BOMBER_DIVE_STATE = "轰炸机俯冲状态 (_STATE_)\n  设置渡鸦何时俯冲。",
	UNIT_KILL_SUBORDINATES = "击杀被捕获单位 (_STATE_)\n  设置是否击杀被捕获的单位。",
	GOO_GATHER = "幼犬复制 (_STATE_)\n  设置幼犬是否使用附近残骸制造更多幼犬。",
	DISABLE_ATTACK = "允许攻击命令 (_STATE_)\n  设置单位是否响应攻击命令。",
	PUSH_PULL = "冲量模式 (_STATE_)\n  设置重力枪是推动还是拉动。",
	DONT_FIRE_AT_RADAR = "攻击雷达状态 (_STATE_)\n  设置高精度长装填单位是否射击雷达点。",
	PREVENT_BAIT = "避免不良目标 (_STATE_)\n  _DESC_",
	PREVENT_OVERKILL = "过度杀伤预防 (_STATE_)\n  防止单位射击已经注定死亡的敌人。",
	TRAJECTORY = "弹道 (_STATE_)\n  设置单位以高弧线还是低弧线射击。",
	AIR_STRAFE = "炮艇扫射 (_STATE_)\n  设置炮艇战斗时是否扫射。",
	UNIT_FLOAT_STATE = "漂浮状态 (_STATE_)\n  设置某些两栖单位何时浮出水面。",
	SELECTION_RANK = "选择优先级 (_STATE_)\n  选择过滤的优先级。",
	FORMATION_RANK = "编队优先级 (_STATE_)\n  设置编队中的优先级。",
	TOGGLE_DRONES = "无人机建造 (_STATE_)\n  切换无人机创建。"
}

local tooltipsAlternate = {
	MOVE_STATE = "移动状态 (_STATE_)\n  设置单位为攻击敌人会走多远。",
	FIRE_STATE = "开火状态 (_STATE_)\n  设置单位何时自动射击。",
}

local commandDisplayConfig = {
	[CMD.ATTACK] = { texture = imageDir .. 'Bold/attack.png', tooltip = "强制攻击：射击特定目标。单位会移动以找到清晰的射击角度。"},
	[CMD.STOP] = { texture = imageDir .. 'Bold/cancel.png', tooltip = "停止：停止单位并清除其命令队列。"},
	[CMD.FIGHT] = { texture = imageDir .. 'Bold/fight.png', tooltip = "攻击移动：移动到目标位置，沿途攻击敌人。"},
	[CMD.GUARD] = { texture = imageDir .. 'Bold/guard.png'},
	[CMD.MOVE] = { texture = imageDir .. 'Bold/move.png'},
	[CMD_RAW_MOVE] = { texture = imageDir .. 'Bold/move.png'},
	[CMD.PATROL] = { texture = imageDir .. 'Bold/patrol.png', tooltip = "巡逻：在两个或多个路径点之间来回攻击移动。"},
	[CMD.WAIT] = { texture = imageDir .. 'Bold/wait.png', tooltip = "等待：暂停单位的命令队列，让其保持当前位置。"},

	[CMD.REPAIR] = {texture = imageDir .. 'Bold/repair.png', tooltip = "修复：协助建造或修复单位。点击并拖动进行区域修复。"},
	[CMD.RECLAIM] = {texture = imageDir .. 'Bold/reclaim.png', tooltip = "回收：从残骸中获取资源。点击并拖动进行区域回收。"},
	[CMD.RESURRECT] = {texture = imageDir .. 'Bold/resurrect.png', tooltip = "复活：消耗能量将残骸变成单位。"},
	[CMD_BUILD] = {texture = imageDir .. 'Bold/build.png'},
	[CMD.MANUALFIRE] = {texture = imageDir .. 'Bold/dgun.png', tooltip = "发射特殊武器：发射单位的特殊武器。"},
	[CMD_AIR_MANUALFIRE] = {texture = imageDir .. 'Bold/dgun.png', tooltip = "发射特殊武器：发射单位的特殊武器。"},
	[CMD.STOCKPILE] = {tooltip = "储备：排队生产导弹。右键点击减少队列。"},

	[CMD.LOAD_UNITS] = { texture = imageDir .. 'Bold/load.png', tooltip = "装载：拾取单位。点击并拖动在区域内装载单位。"},
	[CMD.UNLOAD_UNITS] = { texture = imageDir .. 'Bold/unload.png', tooltip = "卸载：放下携带的单位。点击并拖动在区域内卸载。"},
	[CMD.AREA_ATTACK] = { texture = imageDir .. 'Bold/areaattack.png', tooltip = "区域攻击：在区域内无差别轰炸地形。"},
	[CMD_BUILD_PLATE] = {texture = imageDir .. 'Bold/buildplate.png', tooltip = "建造板：放置在工厂附近以获得额外的生产队列。"},

	[CMD_RAMP] = {texture = imageDir .. 'ramp.png'},
	[CMD_LEVEL] = {texture = imageDir .. 'level.png'},
	[CMD_RAISE] = {texture = imageDir .. 'raise.png'},
	[CMD_SMOOTH] = {texture = imageDir .. 'smooth.png'},
	[CMD_RESTORE] = {texture = imageDir .. 'restore.png'},
	[CMD_BUMPY] = {texture = imageDir .. 'bumpy.png'},

	[CMD_AREA_GUARD] = { texture = imageDir .. 'Bold/guard.png', tooltip = "守卫：保护目标并协助其生产。"},

	[CMD_AREA_MEX] = {texture = imageDir .. 'Bold/mex.png'},
	[CMD_AREA_TERRA_MEX] = {texture = imageDir .. 'Bold/mex.png'},

	[CMD_JUMP] = {texture = imageDir .. 'Bold/jump.png'},

	[CMD_FIND_PAD] = {texture = imageDir .. 'Bold/rearm.png', tooltip = "Resupply: Return to nearest Airpad for repairs and, for bombers, ammo."},

	[CMD_EXCLUDE_PAD] = {texture = imageDir .. 'Bold/excludeairpad.png', tooltip = "Exclude Airpad: Toggle whether any of your aircraft use the targeted airpad."},
	[CMD_FIELD_FAC_SELECT] = {texture = imageDir .. 'Bold/fac_select.png', tooltip = "Copy Factory Blueprint: Copy a production option from target functional friendly factory."},

	[CMD_EMBARK] = {texture = imageDir .. 'Bold/embark.png'},
	[CMD_DISEMBARK] = {texture = imageDir .. 'Bold/disembark.png'},

	[CMD_UNIT_SET_TARGET_CIRCLE] = {texture = imageDir .. 'Bold/settarget.png'},
	[CMD_UNIT_CANCEL_TARGET] = {texture = imageDir .. 'Bold/canceltarget.png'},

	[CMD_ABANDON_PW] = {texture = imageDir .. 'Bold/drop_beacon.png'},

	[CMD_PLACE_BEACON] = {texture = imageDir .. 'Bold/drop_beacon.png'},
	[CMD_UPGRADE_STOP] = { texture = imageDir .. 'Bold/cancelupgrade.png'},
	[CMD_STOP_PRODUCTION] = { texture = imageDir .. 'Bold/stopbuild.png'},
	[CMD_GBCANCEL] = { texture = imageDir .. 'Bold/stopbuild.png'},

	[CMD_RECALL_DRONES] = {texture = imageDir .. 'Bold/recall_drones.png'},
	
	[CMD_MORPH_STOP] = {
		DynamicDisplayFunc = function (cmdID, command)
			return {texture = imageDir .. 'Bold/cancel.png', tex2 = command.texture}
		end
	},
	
	-- states
	[CMD_WANT_ONOFF] = {
		texture = {imageDir .. 'states/off.png', imageDir .. 'states/on.png'},
		stateTooltip = {tooltips.WANT_ONOFF:gsub("_STATE_", "Off"), tooltips.WANT_ONOFF:gsub("_STATE_", "On")}
	},
	[CMD_UNIT_AI] = {
		texture = {imageDir .. 'states/bulb_off.png', imageDir .. 'states/bulb_on.png'},
		stateTooltip = {tooltips.UNIT_AI:gsub("_STATE_", "Disabled"), tooltips.UNIT_AI:gsub("_STATE_", "Enabled")},
	},
	[CMD_FIRE_TOWARDS_ENEMY] = {
		texture = {imageDir .. 'states/shoot_towards_off.png', imageDir .. 'states/shoot_towards_on.png'},
		stateTooltip = {tooltips.FIRE_TOWARDS_ENEMY:gsub("_STATE_", "Disabled"), tooltips.FIRE_TOWARDS_ENEMY:gsub("_STATE_", "Enabled")},
	},
	[CMD_FIRE_AT_SHIELD] = {
		texture = {imageDir .. 'states/ward_off.png', imageDir .. 'states/ward_on.png'},
		stateTooltip = {tooltips.FIRE_AT_SHIELD:gsub("_STATE_", "Disabled"), tooltips.FIRE_AT_SHIELD:gsub("_STATE_", "Enabled")},
	},
	[CMD.REPEAT] = {
		texture = {imageDir .. 'states/repeat_off.png', imageDir .. 'states/repeat_on.png'},
		stateTooltip = {tooltips.REPEAT:gsub("_STATE_", "Disabled"), tooltips.REPEAT:gsub("_STATE_", "Enabled")}
	},
	[CMD_WANT_CLOAK] = {
		texture = {imageDir .. 'states/cloak_off.png', imageDir .. 'states/cloak_on.png'},
		stateTooltip = {tooltips.WANT_CLOAK:gsub("_STATE_", "Disabled"), tooltips.WANT_CLOAK:gsub("_STATE_", "Enabled")}
	},
	[CMD_CLOAK_SHIELD] = {
		texture = {imageDir .. 'states/areacloak_off.png', imageDir .. 'states/areacloak_on.png'},
		stateTooltip = {tooltips.CLOAK_SHIELD:gsub("_STATE_", "Disabled"), tooltips.CLOAK_SHIELD:gsub("_STATE_", "Enabled")}
	},
	[CMD_PRIORITY] = {
		texture = {imageDir .. 'states/wrench_low.png', imageDir .. 'states/wrench_med.png', imageDir .. 'states/wrench_high.png'},
		stateTooltip = {
			tooltips.PRIORITY:gsub("_STATE_", "Low"),
			tooltips.PRIORITY:gsub("_STATE_", "Normal"),
			tooltips.PRIORITY:gsub("_STATE_", "High")
		}
	},
	[CMD_MISC_PRIORITY] = {
		texture = {imageDir .. 'states/wrench_low_other.png', imageDir .. 'states/wrench_med_other.png', imageDir .. 'states/wrench_high_other.png'},
		stateTooltip = {
			tooltips.MISC_PRIORITY:gsub("_STATE_", "Low"),
			tooltips.MISC_PRIORITY:gsub("_STATE_", "Normal"),
			tooltips.MISC_PRIORITY:gsub("_STATE_", "High")
		}
	},
	[CMD_FACTORY_GUARD] = {
		texture = {imageDir .. 'states/autoassist_off.png',
		imageDir .. 'states/autoassist_on.png'},
		stateTooltip = {tooltips.FACTORY_GUARD:gsub("_STATE_", "Disabled"), tooltips.FACTORY_GUARD:gsub("_STATE_", "Enabled")}
	},
	[CMD_AUTO_CALL_TRANSPORT] = {
		texture = {imageDir .. 'states/auto_call_off.png', imageDir .. 'states/auto_call_on.png'},
		stateTooltip = {tooltips.AUTO_CALL_TRANSPORT:gsub("_STATE_", "Disabled"), tooltips.AUTO_CALL_TRANSPORT:gsub("_STATE_", "Enabled")}
	},
	[CMD_GLOBAL_BUILD] = {
		texture = {imageDir .. 'Bold/buildgrey.png', imageDir .. 'Bold/build_light.png'},
		stateTooltip = {tooltips.GLOBAL_BUILD:gsub("_STATE_", "Disabled"), tooltips.GLOBAL_BUILD:gsub("_STATE_", "Enabled")}
	},
	[CMD.MOVE_STATE] = {
		texture = {imageDir .. 'states/move_hold.png', imageDir .. 'states/move_engage.png', imageDir .. 'states/move_roam.png'},
		stateTooltip = {
			tooltips.MOVE_STATE:gsub("_STATE_", "Enabled"),
			tooltips.MOVE_STATE:gsub("_STATE_", "Disabled"),
			tooltips.MOVE_STATE:gsub("_STATE_", "Roam")
		},
		stateNameOverride = {"Enabled", "Disabled", "Roam (not in toggle)"},
		altConfig = {
			texture = {imageDir .. 'states/move_hold.png', imageDir .. 'states/move_engage.png', imageDir .. 'states/move_roam.png'},
			stateTooltip = {
				tooltipsAlternate.MOVE_STATE:gsub("_STATE_", "Hold Position"),
				tooltipsAlternate.MOVE_STATE:gsub("_STATE_", "Maneuver"),
				tooltipsAlternate.MOVE_STATE:gsub("_STATE_", "Roam")
			},
		}
	},
	[CMD.FIRE_STATE] = {
		texture = {imageDir .. 'states/fire_hold.png', imageDir .. 'states/fire_return.png', imageDir .. 'states/fire_atwill.png'},
		stateTooltip = {
			tooltips.FIRE_STATE:gsub("_STATE_", "Enabled"),
			tooltips.FIRE_STATE:gsub("_STATE_", "Return Fire"),
			tooltips.FIRE_STATE:gsub("_STATE_", "Disabled")
		},
		stateNameOverride = {"Enabled", "Return Fire (not in toggle)", "Disabled"},
		altConfig = {
			texture = {imageDir .. 'states/fire_hold.png', imageDir .. 'states/fire_return.png', imageDir .. 'states/fire_atwill.png'},
			stateTooltip = {
				tooltipsAlternate.FIRE_STATE:gsub("_STATE_", "Hold Fire"),
				tooltipsAlternate.FIRE_STATE:gsub("_STATE_", "Return Fire"),
				tooltipsAlternate.FIRE_STATE:gsub("_STATE_", "Fire At Will")
			},
		}
	},
	[CMD_PREVENT_BAIT] = {
		texture = {
			imageDir .. 'states/bait_off_alternate.png',
			imageDir .. 'states/bait_1.png',
			imageDir .. 'states/bait_2.png',
			imageDir .. 'states/bait_3.png',
			imageDir .. 'states/bait_4.png',
		},
		stateTooltip = {
			tooltips.PREVENT_BAIT:gsub("_STATE_", "Disabled"):gsub("_DESC_", "Enable this to ignore bad targets when not on Force Fire or Attack Move."),
			tooltips.PREVENT_BAIT:gsub("_STATE_", "Free"):gsub("_DESC_", "Avoid light drones, Wind, Solar, Claw, Dirtbag and armoured targets."),
			tooltips.PREVENT_BAIT:gsub("_STATE_", "Light"):gsub("_DESC_", "Avoid cost under 90, Razor, Sparrow, unknown radar and armour."),
			tooltips.PREVENT_BAIT:gsub("_STATE_", "Medium"):gsub("_DESC_", "Avoid cost under 240, minus Stardust, Raptor, unknown radar and armour."),
			tooltips.PREVENT_BAIT:gsub("_STATE_", "Heavy"):gsub("_DESC_", "Avoid cost under 420, unknown radar dots and armour."),
		}
	},
	[CMD_RETREAT] = {
		texture = {imageDir .. 'states/retreat_off.png', imageDir .. 'states/retreat_30.png', imageDir .. 'states/retreat_60.png', imageDir .. 'states/retreat_90.png'},
		stateTooltip = {
			tooltips.RETREAT:gsub("_STATE_", "Disabled"),
			tooltips.RETREAT:gsub("_STATE_", "30%% Health"),
			tooltips.RETREAT:gsub("_STATE_", "65%% Health"),
			tooltips.RETREAT:gsub("_STATE_", "99%% Health")
		}
	},
	[CMD.IDLEMODE] = {
		texture = {imageDir .. 'states/fly_on.png', imageDir .. 'states/fly_off.png'},
		stateTooltip = {tooltips.IDLEMODE:gsub("_STATE_", "Fly"), tooltips.IDLEMODE:gsub("_STATE_", "Land")}
	},
	[CMD_AP_FLY_STATE] = {
		texture = {imageDir .. 'states/fly_on.png', imageDir .. 'states/fly_off.png'},
		stateTooltip = {tooltips.AP_FLY_STATE:gsub("_STATE_", "Fly"), tooltips.AP_FLY_STATE:gsub("_STATE_", "Land")}
	},
	[CMD_UNIT_BOMBER_DIVE_STATE] = {
		texture = {imageDir .. 'states/divebomb_off.png', imageDir .. 'states/divebomb_shield.png', imageDir .. 'states/divebomb_attack.png', imageDir .. 'states/divebomb_always.png'},
		stateTooltip = {
			tooltips.UNIT_BOMBER_DIVE_STATE:gsub("_STATE_", "Always Fly High"),
			tooltips.UNIT_BOMBER_DIVE_STATE:gsub("_STATE_", "Against Shields and Units"),
			tooltips.UNIT_BOMBER_DIVE_STATE:gsub("_STATE_", "Against Units"),
			tooltips.UNIT_BOMBER_DIVE_STATE:gsub("_STATE_", "Always Fly Low")
		}
	},
	[CMD_UNIT_KILL_SUBORDINATES] = {
		texture = {imageDir .. 'states/capturekill_off.png', imageDir .. 'states/capturekill_on.png'},
		stateTooltip = {tooltips.UNIT_KILL_SUBORDINATES:gsub("_STATE_", "Keep"), tooltips.UNIT_KILL_SUBORDINATES:gsub("_STATE_", "Kill")}
	},
	[CMD_GOO_GATHER] = {
		texture = {imageDir .. 'states/goo_off.png', imageDir .. 'states/goo_on.png', imageDir .. 'states/goo_cloak.png'},
		stateTooltip = {
			tooltips.GOO_GATHER:gsub("_STATE_", "Off"),
			tooltips.GOO_GATHER:gsub("_STATE_", "On except when cloaked"),
			tooltips.GOO_GATHER:gsub("_STATE_", "On always")
		}
	},
	[CMD_DISABLE_ATTACK] = {
		texture = {imageDir .. 'states/disableattack_off.png', imageDir .. 'states/disableattack_on.png'},
		stateTooltip = {tooltips.DISABLE_ATTACK:gsub("_STATE_", "Allowed"), tooltips.DISABLE_ATTACK:gsub("_STATE_", "Blocked")}
	},
	[CMD_PUSH_PULL] = {
		texture = {imageDir .. 'states/pull_alt.png', imageDir .. 'states/push_alt.png'},
		stateTooltip = {tooltips.PUSH_PULL:gsub("_STATE_", "Pull"), tooltips.PUSH_PULL:gsub("_STATE_", "Push")}
	},
	[CMD_DONT_FIRE_AT_RADAR] = {
		texture = {imageDir .. 'states/stealth_on.png', imageDir .. 'states/stealth_off.png'},
		stateTooltip = {tooltips.DONT_FIRE_AT_RADAR:gsub("_STATE_", "Fire"), tooltips.DONT_FIRE_AT_RADAR:gsub("_STATE_", "Hold Fire")}
	},
	[CMD_PREVENT_OVERKILL] = {
		texture = {
			imageDir .. 'states/overkill_off.png',
			imageDir .. 'states/overkill_auto_target.png',
			imageDir .. 'states/overkill_fire_at_will.png',
			imageDir .. 'states/overkill_on_except_single.png',
			imageDir .. 'states/overkill_on.png',
		},
		stateTooltip = {
			tooltips.PREVENT_OVERKILL:gsub("_STATE_", "Disabled"),
			tooltips.PREVENT_OVERKILL:gsub("_STATE_", "Enabled for automatic targeting"),
			tooltips.PREVENT_OVERKILL:gsub("_STATE_", "Enabled when set to Fire At Will"),
			tooltips.PREVENT_OVERKILL:gsub("_STATE_", "Enabled except for single attack command"),
			tooltips.PREVENT_OVERKILL:gsub("_STATE_", "Always"),
		}
	},
	[CMD.TRAJECTORY] = {
		texture = {imageDir .. 'states/traj_low.png', imageDir .. 'states/traj_high.png'},
		stateTooltip = {tooltips.TRAJECTORY:gsub("_STATE_", "Low"), tooltips.TRAJECTORY:gsub("_STATE_", "High")}
	},
	[CMD_AIR_STRAFE] = {
		texture = {imageDir .. 'states/strafe_off.png', imageDir .. 'states/strafe_on.png'},
		stateTooltip = {tooltips.AIR_STRAFE:gsub("_STATE_", "No Strafe"), tooltips.AIR_STRAFE:gsub("_STATE_", "Strafe")}
	},
	[CMD_UNIT_FLOAT_STATE] = {
		texture = {imageDir .. 'states/amph_sink.png', imageDir .. 'states/amph_attack.png', imageDir .. 'states/amph_float.png'},
		stateTooltip = {
			tooltips.UNIT_FLOAT_STATE:gsub("_STATE_", "Never Float"),
			tooltips.UNIT_FLOAT_STATE:gsub("_STATE_", "Float To Fire"),
			tooltips.UNIT_FLOAT_STATE:gsub("_STATE_", "Always Float")
		}
	},
	[CMD_SELECTION_RANK] = {
		texture = {imageDir .. 'states/selection_rank_0.png', imageDir .. 'states/selection_rank_1.png', imageDir .. 'states/selection_rank_2.png', imageDir .. 'states/selection_rank_3.png'},
		stateTooltip = {
			tooltips.SELECTION_RANK:gsub("_STATE_", "0"),
			tooltips.SELECTION_RANK:gsub("_STATE_", "1"),
			tooltips.SELECTION_RANK:gsub("_STATE_", "2"),
			tooltips.SELECTION_RANK:gsub("_STATE_", "3")
		}
	},
	[CMD_FORMATION_RANK] = {
		texture = {imageDir .. 'states/formation_rank_0.png', imageDir .. 'states/formation_rank_1.png', imageDir .. 'states/formation_rank_2.png', imageDir .. 'states/formation_rank_3.png'},
		stateTooltip = {
			tooltips.FORMATION_RANK:gsub("_STATE_", "0"),
			tooltips.FORMATION_RANK:gsub("_STATE_", "1"),
			tooltips.FORMATION_RANK:gsub("_STATE_", "2"),
			tooltips.FORMATION_RANK:gsub("_STATE_", "3")
		}
	},
	[CMD_TOGGLE_DRONES] = {
		texture = {imageDir .. 'states/drones_off.png', imageDir .. 'states/drones_on.png'},
		stateTooltip = {
			tooltips.TOGGLE_DRONES:gsub("_STATE_", "Disabled"),
			tooltips.TOGGLE_DRONES:gsub("_STATE_", "Enabled"),
		}
	},
}

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Panel Configuration and Layout

local factoryPlates = {
	"platecloak",
	"plateshield",
	"plateveh",
	"platehover",
	"plategunship",
	"plateplane",
	"platespider",
	"platejump",
	"platetank",
	"plateamph",
	"plateship",
}

local plateCommandID = {}
for i = 1, #factoryPlates do
	plateCommandID[-UnitDefNames[factoryPlates[i]].id] = true
end

local function CommandClickFunction(isInstantCommand, isStateCommand)
	local _,_, meta,_ = Spring.GetModKeyState()
	if not meta then
		return false
	end
	
	if isStateCommand then
		WG.crude.OpenPath("Hotkeys/Commands/State")
	elseif isInstantCommand then
		WG.crude.OpenPath("Hotkeys/Commands/Instant")
	else
		WG.crude.OpenPath("Hotkeys/Commands/Targeted")
	end
	WG.crude.ShowMenu() --make epic Chili menu appear.
	return true
end

local textConfig = {
	bottomLeft = {
		name = "bottomLeft",
		x = "15%",
		right = 0,
		bottom = 2,
		height = 12,
		fontsize = 12,
	},
	topLeft = {
		name = "topLeft",
		x = "12%",
		y = "11%",
		fontsize = 12,
	},
	bottomRightLarge = {
		name = "bottomRightLarge",
		x = "15%",
		right = "14%",
		bottom = "16%",
		height = 14,
		fontsize = 14,
	},
	queue = {
		name = "queue",
		right = "18%",
		bottom = "14%",
		align = "right",
		fontsize = 16,
		height = 16,
	},
}

local buttonLayoutConfig = {
	command = {
		image = {
			x = "7%",
			y = "7%",
			right = "7%",
			bottom = "7%",
			keepAspect = true,
		},
		noUnitOutline = true,
		ClickFunction = CommandClickFunction,
		tooltipPrefix = "BuildUnit",
	},
	build = {
		image = {
			x = "5%",
			y = "4%",
			right = "5%",
			bottom = 12,
			keepAspect = false,
		},
		tooltipPrefix = "Build",
		showCost = true
	},
	buildunit = {
		image = {
			x = "5%",
			y = "4%",
			right = "5%",
			bottom = 12,
			keepAspect = false,
		},
		tooltipPrefix = "BuildUnit",
		showCost = true
	},
	queue = {
		image = {
			x = "5%",
			y = "5%",
			right = "5%",
			height = "90%",
			keepAspect = false,
		},
		showCost = false,
		queueButton = true,
		tooltipOverride = "\255\1\255\1Left/Right click \255\255\255\255: Add to/subtract from queue\n\255\1\255\1Hold Left mouse \255\255\255\255: Drag to a different position in queue",
		dragAndDrop = true,
	},
	queueWithDots = {
		image = {
			x = "5%",
			y = "5%",
			right = "5%",
			height = "90%",
			keepAspect = false,
		},
		caption = "...",
		showCost = false,
		queueButton = true,
		-- "\255\1\255\1Hold Left mouse \255\255\255\255: drag drop to different factory or position in queue\n"
		tooltipOverride = "\255\1\255\1Left/Right click \255\255\255\255: Add to/subtract from queue\n\255\1\255\1Hold Left mouse \255\255\255\255: Drag to a different position in queue",
		dragAndDrop = true,
		dotDotOnOverflow = true,
	}
}

local specialButtonLayoutOverride = {}
for i = 1, 5 do
	specialButtonLayoutOverride[i] = {
		[3] = {
			buttonLayoutConfig = buttonLayoutConfig.command,
			isStructure = false,
		}
	}
end

local factoryButtonLayoutOverride = {
	[4] = {
		[3] = {
			buttonLayoutConfig = buttonLayoutConfig.command,
			isStructure = false,
		}
	}
}

local commandPanels = {
	{
		humanName = "Orders",
		name = "orders",
		inclusionFunction = function(cmdID, factoryUnitDefID, forceOrdersCommand, unitMobilePanelSize)
			return ((cmdID >= 0 or unitMobilePanelSize == 1) and
				not buildCmdEconomy[cmdID] and not buildCmdFactory[cmdID] and
				not buildCmdSpecial[cmdID] and not buildCmdDefence[cmdID] and
				not plateCommandID[cmdID])
		end,
		loiterable = true,
		buttonLayoutConfig = buttonLayoutConfig.command,
	},
	{
		humanName = "Econ",
		name = "economy",
		inclusionFunction = function(cmdID)
			local position = buildCmdEconomy[cmdID]
			return position and true or false, position
		end,
		isBuild = true,
		isStructure = true,
		gridHotkeys = true,
		returnOnClick = "orders",
		optionName = "tab_economy",
		buttonLayoutConfig = buttonLayoutConfig.build,
	},
	{
		humanName = "Defence",
		name = "defence",
		inclusionFunction = function(cmdID)
			local position = buildCmdDefence[cmdID]
			return position and true or false, position
		end,
		isBuild = true,
		isStructure = true,
		gridHotkeys = true,
		returnOnClick = "orders",
		optionName = "tab_defence",
		buttonLayoutConfig = buttonLayoutConfig.build,
	},
	{
		humanName = "Special",
		name = "special",
		inclusionFunction = function(cmdID)
			local position = buildCmdSpecial[cmdID]
			return position and true or false, position
		end,
		isBuild = true,
		isStructure = true,
		notBuildRow = 3,
		gridHotkeys = true,
		returnOnClick = "orders",
		optionName = "tab_special",
		buttonLayoutConfig = buttonLayoutConfig.build,
		buttonLayoutOverride = specialButtonLayoutOverride,
	},
	{
		humanName = "Factory",
		name = "factory",
		inclusionFunction = function(cmdID)
			local position = buildCmdFactory[cmdID]
			return position and true or false, position
		end,
		isBuild = true,
		isStructure = true,
		notBuildRow = 3,
		gridHotkeys = true,
		returnOnClick = "orders",
		optionName = "tab_factory",
		buttonLayoutConfig = buttonLayoutConfig.build,
		buttonLayoutOverride = factoryButtonLayoutOverride,
	},
	{
		humanName = "Units",
		name = "units_mobile",
		inclusionFunction = function(cmdID, factoryUnitDefID)
			-- This has to be perfect to predict the size of the units tab in integral menu.
			return (cmdID < 0 and not factoryUnitDefID and
				not buildCmdEconomy[cmdID] and not buildCmdFactory[cmdID] and
				not buildCmdSpecial[cmdID] and not buildCmdDefence[cmdID] and
				not plateCommandID[cmdID])
		end,
		isBuild = true,
		gridHotkeys = true,
		returnOnClick = "orders",
		optionName = "tab_units",
		buttonLayoutConfig = buttonLayoutConfig.build,
	},
	{
		humanName = "Units",
		name = "units_factory",
		inclusionFunction = function(cmdID, factoryUnitDefID)
			if not (factoryUnitDefID and buildCmdUnits[factoryUnitDefID]) then
				return false
			end
			local buildOptions = UnitDefs[factoryUnitDefID].buildOptions
			for i = 1, #buildOptions do
				if buildOptions[i] == -cmdID then
					local position = buildCmdUnits[factoryUnitDefID][cmdID]
					return position and true or false, position
				end
			end
			return false
		end,
		loiterable = true,
		factoryQueue = true,
		isBuild = true,
		hotkeyReplacement = "Orders",
		gridHotkeys = true,
		disableableKeys = true,
		buttonLayoutConfig = buttonLayoutConfig.buildunit,
	},
}

local commandPanelMap = {}
for i = 1, #commandPanels do
	commandPanelMap[commandPanels[i].name] = commandPanels[i]
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Hidden Commands

local instantCommands = {
	[CMD.SELFD] = true,
	[CMD.STOP] = true,
	[CMD.WAIT] = true,
	[CMD_FIND_PAD] = true,
	[CMD_EMBARK] = true,
	[CMD_DISEMBARK] = true,
	[CMD_LOADUNITS_SELECTED] = true,
	[CMD_ONECLICK_WEAPON] = true,
	[CMD_UNIT_CANCEL_TARGET] = true,
	[CMD_STOP_NEWTON_FIREZONE] = true,
	[CMD_RECALL_DRONES] = true,
	[CMD_MORPH_UPGRADE_INTERNAL] = true,
	[CMD_UPGRADE_STOP] = true,
	[CMD_STOP_PRODUCTION] = true,
	[CMD_RESETFIRE] = true,
	[CMD_RESETMOVE] = true,
}

-- Commands that only exist in LuaUI cannot have a hidden param. Therefore those that should be hidden are placed in this table.
local widgetSpaceHidden = {
	[60] = true, -- CMD.PAGES
	[CMD_SETHAVEN] = true,
	[CMD_SET_AI_START] = true,
	[CMD_CHEAT_GIVE] = true,
	[CMD_SET_FERRY] = true,
	[CMD.MOVE] = true,
}

-- Hide factory plates
for i = 1, #factoryPlates do
	local plateDefID = UnitDefNames[factoryPlates[i]].id
	widgetSpaceHidden[-plateDefID] = true
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local modCommands = VFS.Include("LuaRules/Configs/modCommandsDefs.lua")
for i = 1, #modCommands do
	local cmd = modCommands[i]
	commandDisplayConfig[cmd.cmdID] = {
		tooltip = cmd.tooltip,
		texture = cmd.image,
		stateTooltip = cmd.stateTooltip,
		DynamicDisplayFunc = cmd.DynamicDisplayFunc,
	}
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

return commandPanels, commandPanelMap, commandDisplayConfig, widgetSpaceHidden, textConfig, buttonLayoutConfig, instantCommands, cmdPosDef

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

