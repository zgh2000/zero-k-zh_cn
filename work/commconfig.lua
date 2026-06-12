------------------------------------------------------------------------

-- Module Definitions

------------------------------------------------------------------------



local moduleImagePath = "LuaMenu/configs/gameConfig/zk/unitpics/"

local moduleDefNames = {}



local moduleDefs = {

	-- Empty Module Slots

	{

		name = "nullmodule",

		humanName = "空槽位",

		description = "在此槽位放置一个模组。",

		image = moduleImagePath .. "module_none.png",

		limit = false,

		emptyModule = true,

		cost = 0,

		requireLevel = 0,

		slotType = "module",

	},

	{

		name = "nullbasicweapon",

		humanName = "空武器槽位",

		description = "在此槽位放置一个武器。",

		image = moduleImagePath .. "module_none.png",

		limit = false,

		emptyModule = true,

		cost = 0,

		requireLevel = 0,

		slotType = "basic_weapon",

	},

	{

		name = "nulladvweapon",

		humanName = "空武器槽位",

		description = "在此槽位放置一个武器。",

		image = moduleImagePath .. "module_none.png",

		limit = false,

		emptyModule = true,

		cost = 0,

		requireLevel = 0,

		slotType = "adv_weapon",

	},

	

	-- Weapons

	{

		name = "commweapon_beamlaser",

		humanName = "光束激光",

		description = "光束激光：有效的近距离切割工具",

		image = moduleImagePath .. "commweapon_beamlaser.png",

		limit = 1,

		cost = 50,

		requireChassis = {"recon", "assault", "support", "strike"},

		requireLevel = 0,

		slotType = "basic_weapon",

		applicationFunction = function (modules, sharedData)

			if sharedData.noMoreWeapons then

				return

			end

			if not sharedData.weapon1 then

				sharedData.weapon1 = "commweapon_beamlaser"

			else

				sharedData.weapon2 = "commweapon_beamlaser"

			end

		end

	},

	{

		name = "commweapon_flamethrower",

		humanName = "火焰喷射器",

		description = "火焰喷射器：适合对付蜂群和大型目标",

		image = moduleImagePath .. "commweapon_flamethrower.png",

		limit = 1,

		cost = 50,

		requireChassis = {"recon", "assault"},

		requireLevel = 0,

		slotType = "basic_weapon",

		applicationFunction = function (modules, sharedData)

			if sharedData.noMoreWeapons then

				return

			end

			if not sharedData.weapon1 then

				sharedData.weapon1 = "commweapon_flamethrower"

			else

				sharedData.weapon2 = "commweapon_flamethrower"

			end

		end

	},

	{

		name = "commweapon_heatray",

		humanName = "热能射线",

		description = "热能射线：近距离快速融化任何东西；距离越远伤害越低",

		image = moduleImagePath .. "commweapon_heatray.png",

		limit = 1,

		cost = 50,

		requireChassis = {"assault"},

		requireLevel = 0,

		slotType = "basic_weapon",

		applicationFunction = function (modules, sharedData)

			if sharedData.noMoreWeapons then

				return

			end

			if not sharedData.weapon1 then

				sharedData.weapon1 = "commweapon_heatray"

			else

				sharedData.weapon2 = "commweapon_heatray"

			end

		end

	},

	{

		name = "commweapon_heavymachinegun",

		humanName = "机枪",

		description = "机枪：近距离范围攻击自动武器",

		image = moduleImagePath .. "commweapon_heavymachinegun.png",

		limit = 1,

		cost = 50,

		requireChassis = {"recon", "assault", "strike"},

		requireLevel = 0,

		slotType = "basic_weapon",

		applicationFunction = function (modules, sharedData)

			if sharedData.noMoreWeapons then

				return

			end

			local weaponName = (modules[moduleDefNames.conversion_disruptor] and "commweapon_heavymachinegun_disrupt") or "commweapon_heavymachinegun"

			if not sharedData.weapon1 then

				sharedData.weapon1 = weaponName

			else

				sharedData.weapon2 = weaponName

			end

		end

	},

	--{

	--	name = "commweapon_hpartillery",

	--	humanName = "等离子火炮",

	--	description = "等离子火炮",

	--	image = moduleImagePath .. "commweapon_assaultcannon.png",

	--	limit = 1,

	--	cost = 300,

	--	requireChassis = {"assault"},

	--	requireLevel = 3,

	--	slotType = "adv_weapon",

	--	applicationFunction = function (modules, sharedData)

	--		if sharedData.noMoreWeapons then

	--			return

	--		end

	--		local weaponName = (modules[moduleDefNames.weaponmod_napalm_warhead] and "commweapon_hpartillery_napalm") or "commweapon_hpartillery"

	--		if not sharedData.weapon1 then

	--			sharedData.weapon1 = weaponName

	--		else

	--			sharedData.weapon2 = weaponName

	--		end

	--	end

	--},

	{

		name = "commweapon_lightninggun",

		humanName = "闪电步枪",

		description = "闪电步枪：麻痹并伤害恼人的虫子",

		image = moduleImagePath .. "commweapon_lightninggun.png",

		limit = 1,

		cost = 50,

		requireChassis = {"recon", "support", "strike"},

		requireLevel = 0,

		slotType = "basic_weapon",

		applicationFunction = function (modules, sharedData)

			if sharedData.noMoreWeapons then

				return

			end

			local weaponName = (modules[moduleDefNames.weaponmod_stun_booster] and "commweapon_lightninggun_improved") or "commweapon_lightninggun"

			if not sharedData.weapon1 then

				sharedData.weapon1 = weaponName

			else

				sharedData.weapon2 = weaponName

			end

		end

	},

	{

		name = "commweapon_lparticlebeam",

		humanName = "轻粒子束",

		description = "轻粒子束：快速轻型脉冲能量武器",

		image = moduleImagePath .. "commweapon_lparticlebeam.png",

		limit = 1,

		cost = 50,

		requireChassis = {"support", "recon", "strike"},

		requireLevel = 0,

		slotType = "basic_weapon",

		applicationFunction = function (modules, sharedData)

			if sharedData.noMoreWeapons then

				return

			end

			local weaponName = (modules[moduleDefNames.conversion_disruptor] and "commweapon_disruptor") or "commweapon_lparticlebeam"

			if not sharedData.weapon1 then

				sharedData.weapon1 = weaponName

			else

				sharedData.weapon2 = weaponName

			end

		end

	},

	{

		name = "commweapon_missilelauncher",

		humanName = "导弹发射器",

		description = "导弹发射器：轻型制导导弹，射程良好",

		image = moduleImagePath .. "commweapon_missilelauncher.png",

		limit = 1,

		cost = 50,

		requireChassis = {"support", "strike"},

		requireLevel = 0,

		slotType = "basic_weapon",

		applicationFunction = function (modules, sharedData)

			if sharedData.noMoreWeapons then

				return

			end

			if not sharedData.weapon1 then

				sharedData.weapon1 = "commweapon_missilelauncher"

			else

				sharedData.weapon2 = "commweapon_missilelauncher"

			end

		end

	},

	{

		name = "commweapon_riotcannon",

		humanName = "防暴炮",

		description = "防暴炮：控制人群的首选武器",

		image = moduleImagePath .. "commweapon_riotcannon.png",

		limit = 1,

		cost = 50,

		requireChassis = {"assault"},

		requireLevel = 0,

		slotType = "basic_weapon",

		applicationFunction = function (modules, sharedData)

			if sharedData.noMoreWeapons then

				return

			end

			local weaponName = (modules[moduleDefNames.weaponmod_napalm_warhead] and "commweapon_riotcannon_napalm") or "commweapon_riotcannon"

			if not sharedData.weapon1 then

				sharedData.weapon1 = weaponName

			else

				sharedData.weapon2 = weaponName

			end

		end

	},

	{

		name = "commweapon_rocketlauncher",

		humanName = "火箭发射器",

		description = "火箭发射器：中距离低速打击者",

		image = moduleImagePath .. "commweapon_rocketlauncher.png",

		limit = 1,

		cost = 50,

		requireChassis = {"assault"},

		requireLevel = 0,

		slotType = "basic_weapon",

		applicationFunction = function (modules, sharedData)

			if sharedData.noMoreWeapons then

				return

			end

			local weaponName = (modules[moduleDefNames.weaponmod_napalm_warhead] and "commweapon_rocketlauncher_napalm") or "commweapon_rocketlauncher"

			if not sharedData.weapon1 then

				sharedData.weapon1 = weaponName

			else

				sharedData.weapon2 = weaponName

			end

		end

	},

	{

		name = "commweapon_shotgun",

		humanName = "霰弹枪",

		description = "霰弹枪：可以重击单个大型目标或撕裂多个小型目标",

		image = moduleImagePath .. "commweapon_shotgun.png",

		limit = 1,

		cost = 50,

		requireChassis = {"recon", "support", "strike"},

		requireLevel = 0,

		slotType = "basic_weapon",

		applicationFunction = function (modules, sharedData)

			if sharedData.noMoreWeapons then

				return

			end

			local weaponName = (modules[moduleDefNames.conversion_disruptor] and "commweapon_shotgun_disrupt") or "commweapon_shotgun"

			if not sharedData.weapon1 then

				sharedData.weapon1 = weaponName

			else

				sharedData.weapon2 = weaponName

			end

		end

	},

	{

		name = "commweapon_hparticlebeam",

		humanName = "重粒子束",

		description = "重粒子束 - 替换其他武器，需要4级槽位。短程高能光束武器，中等装填时间",

		image = moduleImagePath .. "conversion_hparticlebeam.png",

		limit = 1,

		cost = 150,

		requireChassis = {"support"},

		requireLevel = 1,

		slotType = "adv_weapon",

		applicationFunction = function (modules, sharedData)

			if sharedData.noMoreWeapons then

				return

			end

			local weaponName = (modules[moduleDefNames.conversion_disruptor] and "commweapon_heavy_disruptor") or "commweapon_hparticlebeam"

			sharedData.weapon1 = weaponName

			sharedData.weapon2 = nil

			sharedData.noMoreWeapons = true

		end

	},

	{

		name = "commweapon_shockrifle",

		humanName = "冲击步枪",

		description = "冲击步枪 - 替换其他武器，需要4级槽位。远程狙击步枪",

		image = moduleImagePath .. "conversion_shockrifle.png",

		limit = 1,

		cost = 150,

		requireChassis = {"support"},

		requireLevel = 1,

		slotType = "adv_weapon",

		applicationFunction = function (modules, sharedData)

			if sharedData.noMoreWeapons then

				return

			end

			sharedData.weapon1 = "commweapon_shockrifle"

			sharedData.weapon2 = nil

			sharedData.noMoreWeapons = true

		end

	},

	{

		name = "commweapon_clusterbomb",

		humanName = "集束炸弹",

		description = "集束炸弹 - 手动发射的炸弹连射。需要4级武器槽位。",

		image = moduleImagePath .. "commweapon_clusterbomb.png",

		limit = 1,

		cost = 150,

		requireChassis = {"recon", "assault"},

		requireLevel = 3,

		slotType = "adv_weapon",

		applicationFunction = function (modules, sharedData)

			if sharedData.noMoreWeapons then

				return

			end

			if not sharedData.weapon1 then

				sharedData.weapon1 = "commweapon_clusterbomb"

			else

				sharedData.weapon2 = "commweapon_clusterbomb"

			end

		end

	},

	{

		name = "commweapon_concussion",

		humanName = "震荡弹",

		description = "震荡弹 - 手动发射的高冲击力弹丸。需要4级武器槽位。",

		image = moduleImagePath .. "commweapon_concussion.png",

		limit = 1,

		cost = 150,

		requireChassis = {"recon"},

		requireLevel = 3,

		slotType = "adv_weapon",

		applicationFunction = function (modules, sharedData)

			if sharedData.noMoreWeapons then

				return

			end

			if not sharedData.weapon1 then

				sharedData.weapon1 = "commweapon_concussion"

			else

				sharedData.weapon2 = "commweapon_concussion"

			end

		end

	},

	{

		name = "commweapon_disintegrator",

		humanName = "分解器",

		description = "分解器 - 手动发射的武器，可以摧毁几乎所有触及的物体。需要4级武器槽位。",

		image = moduleImagePath .. "commweapon_disintegrator.png",

		limit = 1,

		cost = 150,

		requireChassis = {"assault", "strike"},

		requireLevel = 3,

		slotType = "adv_weapon",

		applicationFunction = function (modules, sharedData)

			if sharedData.noMoreWeapons then

				return

			end

			if not sharedData.weapon1 then

				sharedData.weapon1 = "commweapon_disintegrator"

			else

				sharedData.weapon2 = "commweapon_disintegrator"

			end

		end

	},

	{

		name = "commweapon_disruptorbomb",

		humanName = "干扰炸弹",

		description = "干扰炸弹 - 手动发射的炸弹，可以在大范围内减速敌人。需要4级武器槽位。",

		image = moduleImagePath .. "commweapon_disruptorbomb.png",

		limit = 1,

		cost = 150,

		requireChassis = {"recon", "support", "strike"},

		requireLevel = 3,

		slotType = "adv_weapon",

		applicationFunction = function (modules, sharedData)

			if sharedData.noMoreWeapons then

				return

			end

			if not sharedData.weapon1 then

				sharedData.weapon1 = "commweapon_disruptorbomb"

			else

				sharedData.weapon2 = "commweapon_disruptorbomb"

			end

		end

	},

	{

		name = "commweapon_multistunner",

		humanName = "多重眩晕器",

		description = "多重眩晕器 - 手动发射的持续闪电连射。需要4级武器槽位。",

		image = moduleImagePath .. "commweapon_multistunner.png",

		limit = 1,

		cost = 150,

		requireChassis = {"support", "recon", "strike"},

		requireLevel = 3,

		slotType = "adv_weapon",

		applicationFunction = function (modules, sharedData)

			if sharedData.noMoreWeapons then

				return

			end

			local weaponName = (modules[moduleDefNames.weaponmod_stun_booster] and "commweapon_multistunner_improved") or "commweapon_multistunner"

			if not sharedData.weapon1 then

				sharedData.weapon1 = weaponName

			else

				sharedData.weapon2 = weaponName

			end

		end

	},

	{

		name = "commweapon_napalmgrenade",

		humanName = "地狱火手雷",

		description = "地狱火手雷 - 手动发射的炸弹，可以在大范围内引燃。需要4级武器槽位。",

		image = moduleImagePath .. "commweapon_napalmgrenade.png",

		limit = 1,

		cost = 150,

		requireChassis = {"assault", "recon"},

		requireLevel = 3,

		slotType = "adv_weapon",

		applicationFunction = function (modules, sharedData)

			if sharedData.noMoreWeapons then

				return

			end

			if not sharedData.weapon1 then

				sharedData.weapon1 = "commweapon_napalmgrenade"

			else

				sharedData.weapon2 = "commweapon_napalmgrenade"

			end

		end

	},

	{

		name = "commweapon_slamrocket",

		humanName = "S.L.A.M. 火箭弹",

		description = "S.L.A.M. 火箭弹 - 手动发射的微型战术核弹。需要4级武器槽位。",

		image = moduleImagePath .. "commweapon_slamrocket.png",

		limit = 1,

		cost = 200,

		requireChassis = {"assault"},

		requireLevel = 3,

		slotType = "adv_weapon",

		applicationFunction = function (modules, sharedData)

			if sharedData.noMoreWeapons then

				return

			end

			if not sharedData.weapon1 then

				sharedData.weapon1 = "commweapon_slamrocket"

			else

				sharedData.weapon2 = "commweapon_slamrocket"

			end

		end

	},

	

	-- Unique Modules

	{

		name = "econ",

		humanName = "先锋经济套餐",

		description = "先锋经济套餐 - 建立滩头阵地的关键部分，所有新指挥官都配备此模组以启动经济。提供4点金属收入和6点能量收入。",

		image = moduleImagePath .. "module_energy_cell.png",

		limit = 1,

		unequipable = true,

		cost = 200,

		requireLevel = 0,

		slotType = "module",

		applicationFunction = function (modules, sharedData)

			sharedData.metalIncome = (sharedData.metalIncome or 0) + 4

			sharedData.energyIncome = (sharedData.energyIncome or 0) + 6

		end

	},

	{

		name = "commweapon_personal_shield",

		humanName = "个人护盾",

		description = "个人护盾 - 小型保护性气泡护盾。不能与隐形同时使用。需要至少2级模组槽位。",

		image = moduleImagePath .. "module_personal_shield.png",

		limit = 1,

		cost = 300,

		prohibitingModules = {"module_personal_cloak"},

		requireLevel = 1,

		slotType = "module",

		applicationFunction = function (modules, sharedData)

			-- Do not override area shield

			sharedData.shield = sharedData.shield or "commweapon_personal_shield"

		end

	},

	{

		name = "commweapon_areashield",

		humanName = "区域护盾",

		description = "区域护盾 - 投射大型护盾。需要并替换已安装的个人护盾。需要至少4级模组槽位。",

		image = moduleImagePath .. "module_areashield.png",

		limit = 1,

		cost = 250,

		requireChassis = {"assault", "support"},

		requireOneOf = {"commweapon_personal_shield"},

		prohibitingModules = {"module_personal_cloak"},

		requireLevel = 3,

		slotType = "module",

		applicationFunction = function (modules, sharedData)

			sharedData.shield = "commweapon_areashield"

		end

	},

	{

		name = "weaponmod_napalm_warhead",

		humanName = "凝固汽油弹弹头",

		description = "凝固汽油弹弹头 - 防暴炮、火箭发射器和等离子火炮可以点燃目标。降低直接伤害。需要至少3级模组槽位。",

		image = moduleImagePath .. "weaponmod_napalm_warhead.png",

		limit = 1,

		cost = 350,

		requireChassis = {"assault"},

		requireOneOf = {"commweapon_rocketlauncher", "commweapon_hpartillery", "commweapon_riotcannon"},

		requireLevel = 2,

		slotType = "module",

	},

	{

		name = "conversion_disruptor",

		humanName = "干扰弹药",

		description = "干扰弹药 - 重机枪、霰弹枪和粒子束造成减速伤害。降低直接伤害。需要至少3级模组槽位。",

		image = moduleImagePath .. "weaponmod_disruptor_ammo.png",

		limit = 1,

		cost = 450,

		requireChassis = {"strike", "recon", "support"},

		requireOneOf = {"commweapon_heavymachinegun", "commweapon_shotgun", "commweapon_hparticlebeam", "commweapon_lparticlebeam"},

		requireLevel = 2,

		slotType = "module",

	},

	{

		name = "weaponmod_stun_booster",

		humanName = "通量放大器",

		description = "通量放大器 - 提高闪电步枪和多重眩晕器的EMP持续时间和强度。需要至少3级模组槽位。",

		image = moduleImagePath .. "weaponmod_stun_booster.png",

		limit = 1,

		cost = 300,

		requireChassis = {"support", "strike", "recon"},

		requireOneOf = {"commweapon_lightninggun", "commweapon_multistunner"},

		requireLevel = 2,

		slotType = "module",

	},

	{

		name = "module_jammer",

		humanName = "雷达干扰器",

		description = "雷达干扰器 - 隐藏附近单位的雷达信号。需要至少2级模组槽位。",

		image = moduleImagePath .. "module_jammer.png",

		limit = 1,

		cost = 200,

		requireLevel = 1,

		slotType = "module",

		applicationFunction = function (modules, sharedData)

			if not sharedData.cloakFieldRange then

				sharedData.radarJammingRange = 500

			end

		end

	},

	{

		name = "module_radarnet",

		humanName = "战场雷达",

		description = "战场雷达 - 安装基础雷达系统。需要至少2级模组槽位。",

		image = moduleImagePath .. "module_fieldradar.png",

		limit = 1,

		cost = 75,

		requireLevel = 1,

		slotType = "module",

		applicationFunction = function (modules, sharedData)

			sharedData.radarRange = 1800

		end

	},

	{

		name = "module_personal_cloak",

		humanName = "个人隐形",

		description = "个人隐形 - 个人隐形装置。降低总速度12%，不能与护盾同时使用。需要至少2级模组槽位。",

		image = moduleImagePath .. "module_personal_cloak.png",

		limit = 1,

		cost = 400,

		prohibitingModules = {"commweapon_personal_shield", "commweapon_areashield"},

		requireLevel = 1,

		slotType = "module",

		applicationFunction = function (modules, sharedData)

			sharedData.decloakDistance = math.max(sharedData.decloakDistance or 0, 150)

			sharedData.personalCloak = true

		end

	},

	{

		name = "module_cloak_field",

		humanName = "隐形力场",

		description = "隐形力场 - 使所有附近单位隐形。需要雷达干扰器。需要至少4级模组槽位。",

		image = moduleImagePath .. "module_cloak_field.png",

		limit = 1,

		cost = 600,

		requireChassis = {"support", "strike"},

		requireOneOf = {"module_jammer"},

		requireLevel = 3,

		slotType = "module",

		applicationFunction = function (modules, sharedData)

			sharedData.areaCloak = true

			sharedData.decloakDistance = 180

			sharedData.cloakFieldRange = 350

			sharedData.cloakFieldUpkeep = 15

			sharedData.radarJammingRange = 350

		end

	},

	{

		name = "module_resurrect",

		humanName = "拉撒路装置",

		description = "拉撒路装置 - 升级纳米蚀刻以允许复活。需要至少3级模组槽位。",

		image = moduleImagePath .. "module_resurrect.png",

		limit = 1,

		cost = 400,

		requireChassis = {"support"},

		requireLevel = 2,

		slotType = "module",

		applicationFunction = function (modules, sharedData)

			sharedData.canResurrect = true

		end

	},

	{

		name = "module_jumpjet",

		humanName = "跳跃喷射",

		description = "跳跃喷射 - 跳过障碍物和脱离危险。每个大功率伺服电机减少1秒跳跃冷却。需要至少4级模组槽位。",

		image = moduleImagePath .. "module_jumpjet.png",

		limit = 1,

		cost = 400,

		requireChassis = {"knight"},

		requireLevel = 3,

		slotType = "module",

		applicationFunction = function (modules, sharedData)

			sharedData.canJump = true

		end

	},

	

	-- Repeat Modules

	{

		name = "module_companion_drone",

		humanName = "伴侣无人机",

		description = "伴侣无人机 - 指挥官生成保护无人机。需要至少3级模组槽位。_COUNT_",

		image = moduleImagePath .. "module_companion_drone.png",

		limit = 8,

		cost = 300,

		requireLevel = 2,

		slotType = "module",

		applicationFunction = function (modules, sharedData)

			sharedData.drones = (sharedData.drones or 0) + 1

		end

	},

	{

		name = "module_battle_drone",

		humanName = "战斗无人机",

		description = "战斗无人机 - 指挥官生成重型无人机。需要伴侣无人机和至少4级模组槽位。_COUNT_",

		image = moduleImagePath .. "module_battle_drone.png",

		limit = 8,

		cost = 500,

		requireChassis = {"support"},

		requireOneOf = {"module_companion_drone"},

		requireLevel = 3,

		slotType = "module",

		applicationFunction = function (modules, sharedData)

			sharedData.battleDrones = (sharedData.battleDrones or 0) + 1

		end

	},

	{

		name = "module_autorepair",

		humanName = "自动修复",

		description = "自动修复 - 指挥官以+12 hp/s的速度自我修复，消耗100点生命值。_COUNT_",

		image = moduleImagePath .. "module_autorepair.png",

		limit = 8,

		cost = 150,

		requireLevel = 0,

		slotType = "module",

		applicationFunction = function (modules, sharedData)

			sharedData.autorepairRate = (sharedData.autorepairRate or 0) + 10

			sharedData.healthBonus = (sharedData.healthBonus or 0) - 100

		end

	},

	{

		name = "module_ablative_armor",

		humanName = "烧蚀装甲板",

		description = "烧蚀装甲板 - 提供750点生命值。_COUNT_",

		image = moduleImagePath .. "module_ablative_armor.png",

		limit = 8,

		cost = 150,

		requireLevel = 0,

		slotType = "module",

		applicationFunction = function (modules, sharedData)

			sharedData.healthBonus = (sharedData.healthBonus or 0) + 600

		end

	},

	{

		name = "module_heavy_armor",

		humanName = "高密度装甲",

		description = "高密度装甲 - 提供2000点生命值但减少总速度2%。需要烧蚀装甲板和至少3级模组槽位。_COUNT_",

		image = moduleImagePath .. "module_heavy_armor.png",

		limit = 8,

		cost = 400,

		requireOneOf = {"module_ablative_armor"},

		requireLevel = 2,

		slotType = "module",

		applicationFunction = function (modules, sharedData)

			sharedData.healthBonus = (sharedData.healthBonus or 0) + 1600

			sharedData.speedMult = (sharedData.speedMult or 1) - 0.1

		end

	},

	{

		name = "module_dmg_booster",

		humanName = "伤害增幅器",

		description = "伤害增幅器 - 增加15%伤害但减少总速度2%。_COUNT_",

		image = moduleImagePath .. "module_dmg_booster.png",

		limit = 8,

		cost = 150,

		requireLevel = 0,

		slotType = "module",

		applicationFunction = function (modules, sharedData)

			-- Damage boost is applied via clone swapping

			sharedData.damageMult = (sharedData.damageMult or 1) + 0.1

			sharedData.speedMult = (sharedData.speedMult or 1) - 0.025

		end

	},

	{

		name = "module_high_power_servos",

		humanName = "大功率伺服电机",

		description = "大功率伺服电机 - 增加4点速度。_COUNT_",

		image = moduleImagePath .. "module_high_power_servos.png",

		limit = 8,

		cost = 150,

		requireLevel = 0,

		slotType = "module",

		applicationFunction = function (modules, sharedData)

			sharedData.speedMult = (sharedData.speedMult or 1) + 0.1

		end

	},

	{

		name = "module_adv_targeting",

		humanName = "高级瞄准系统",

		description = "高级瞄准系统 - 增加7.5%射程但减少总速度2%。_COUNT_",

		image = moduleImagePath .. "module_adv_targeting.png",

		limit = 8,

		cost = 150,

		requireLevel = 0,

		slotType = "module",

		applicationFunction = function (modules, sharedData)

			sharedData.rangeMult = (sharedData.rangeMult or 1) + 0.075

			sharedData.speedMult = (sharedData.speedMult or 1) - 0.025

		end

	},

	{

		name = "module_adv_nano",

		humanName = "修车匠的纳米蚀刻",

		description = "修车匠的纳米蚀刻 - 增加5点建筑力。_COUNT_",

		image = moduleImagePath .. "module_adv_nano.png",

		limit = 8,

		cost = 150,

		requireLevel = 0,

		slotType = "module",

		applicationFunction = function (modules, sharedData)

			-- All comms have 10 BP in their unitDef (even support)

			sharedData.bonusBuildPower = (sharedData.bonusBuildPower or 0) + 4

		end

	},

}



for i = 1, #moduleDefs do

	moduleDefNames[moduleDefs[i].name] = i

end



------------------------------------------------------------------------

-- Chassis Definition

------------------------------------------------------------------------



local highestDefinedLevel = 7

local levelDefs = {

	[0] = {

		upgradeSlots = {

			{

				defaultModule = "commweapon_beamlaser",

				slotAllows = "basic_weapon",

			},

			{

				defaultModule = "nullmodule",

				slotAllows = "module",

			},

		},

	},

	[1] = {

		upgradeSlots = {

			{

				defaultModule = "nullmodule",

				slotAllows = "module",

			},

			{

				defaultModule = "nullmodule",

				slotAllows = "module",

			},

		},

	},

	[2] = {

		upgradeSlots = {

			{

				defaultModule = "nullmodule",

				slotAllows = "module",

			},

			{

				defaultModule = "nullmodule",

				slotAllows = "module",

			},

		},

	},

	[3] = {

		upgradeSlots = {

			{

				defaultModule = "nullbasicweapon",

				slotAllows = {"adv_weapon", "basic_weapon"},

			},

			{

				defaultModule = "nullmodule",

				slotAllows = "module",

			},

			{

				defaultModule = "nullmodule",

				slotAllows = "module",

			},

		},

	},

}



for i = 4, highestDefinedLevel do

	levelDefs[i] = {

		upgradeSlots = {

			{

				defaultModule = "nullmodule",

				slotAllows = "module",

			},

			{

				defaultModule = "nullmodule",

				slotAllows = "module",

			},

			{

				defaultModule = "nullmodule",

				slotAllows = "module",

			},

		},

	}

end



local chassisDef = {

	name = "knight",

	chassis = "knight",

	humanName = "骑士",

	image = LUA_DIRNAME .. "images/chassis_cremcom.png",

	secondPeashooter = true,

	highestDefinedLevel = highestDefinedLevel,

	levelDefs = levelDefs

}



------------------------------------------------------------------------

-- Processing

------------------------------------------------------------------------



-- Transform from human readable format into number indexed format

--for i = 1, #moduleDefs do

--	local data = moduleDefs[i]

--

--	-- Required modules are a list of moduleDefIDs

--	if data.requireOneOf then

--		local newRequire = {}

--		for j = 1, #data.requireOneOf do

--			local reqModuleID = moduleDefNames[data.requireOneOf[j]]

--			if reqModuleID then

--				newRequire[#newRequire + 1] = reqModuleID

--			end

--		end

--		data.requireOneOf = newRequire

--	end

--

--	-- Prohibiting modules are a list of moduleDefIDs too

--	if data.prohibitingModules then

--		local newProhibit = {}

--		for j = 1, #data.prohibitingModules do

--			local reqModuleID = moduleDefNames[data.prohibitingModules[j]]

--			if reqModuleID then

--				newProhibit[#newProhibit + 1] = reqModuleID

--			end

--		end

--		data.prohibitingModules = newProhibit

--	end

--end



for i = 0, chassisDef.highestDefinedLevel do

	local slots = chassisDef.levelDefs[i].upgradeSlots

	for j = 1, #slots do

		local newSlotAllows = {}

		if type(slots[j].slotAllows) == "string" then

			newSlotAllows[slots[j].slotAllows] = true

		else

			for allow = 1, #slots[j].slotAllows do

				newSlotAllows[slots[j].slotAllows[allow]] = true

			end

		end

		slots[j].slotAllows = newSlotAllows

	end

end



------------------------------------------------------------------------

-- Module Ordering

------------------------------------------------------------------------



for i = 1, #moduleDefs do

	local data = moduleDefs[i]

	data.category = (data.slotType == "module" and "module") or "weapon"

	data.order = i

end



local categories = {

	module = {

		name = "模组",

		order = 1

	},

	weapon = {

		name = "武器",

		order = 2

	}

}



local function ModuleOrder(name1, name2)

	local data1 = name1 and moduleDefNames[name1] and moduleDefs[moduleDefNames[name1]]

	local data2 = name1 and moduleDefNames[name2] and moduleDefs[moduleDefNames[name2]]

	if not data1 then

		return (data2 and true)

	end

	if not data2 then

		return true

	end

	

	local category1 = categories[data1.category].order

	local category2 = categories[data2.category].order

	return category1 < category2 or (category1 == category2 and data1.order < data2.order)

end



------------------------------------------------------------------------

-- Commander Configuration

------------------------------------------------------------------------

local levelRequirement = {

	[0] = 0,

	[1] = 500,

	[2] = 1200,

	[3] = 2500,

	[4] = 5000,

	[5] = 8500,

	[6] = 12000,

}



local function GetLevelRequirement(level)

	return levelRequirement[level]

end



return {

	moduleDefs = moduleDefs,

	moduleDefNames = moduleDefNames,

	chassisDef = chassisDef,

	GetLevelRequirement = GetLevelRequirement,

	categories = categories,

	ModuleOrder = ModuleOrder,

}

