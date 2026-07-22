--------------------------------------------------------------------------------
-- system functions
--------------------------------------------------------------------------------
Spring.Utilities = Spring.Utilities or {}
VFS.Include("LuaRules/Utilities/base64.lua")
VFS.Include("LuaRules/Utilities/tablefunctions.lua")
local CopyTable = Spring.Utilities.CopyTable
local MergeTable = Spring.Utilities.MergeTable

VFS.Include("gamedata/modularcomms/functions.lua")
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

weapons = {}

-- name is needed for widget; description is currently unused
upgrades = {
	-- weapons
	-- note that context menu CRASHES if you don't put them here!
	
	commweapon_peashooter = {
		name = "豌豆射手",
		description = "Basic self-defence weapon",
	},

	commweapon_assaultcannon = {
		name = "突击炮",
		description = "Conventional plasma cannon with decent range",
	},
	commweapon_beamlaser = {
		name = "光束激光",
		description = "An effective short-range cutting tool",
	},
	commweapon_flamethrower = {
		name = "火焰喷射器",
		description = "Perfect for well-done barbecues",
	},
	commweapon_gaussrifle = {
		name = "高斯步枪",
		description = "Precise armor-piercing weapon",
	},
	commweapon_heavymachinegun = {
		name = "重机枪",
		description = "Close-in automatic weapon with AoE",
	},
	commweapon_heatray = {
		name = "热能射线",
		description = "Rapidly melts anything at short range; loses damage over distance",
	},
	commweapon_lightninggun = {
		name = "闪电枪",
		description = "Paralyzes and damages annoying bugs",
	},
	commweapon_lparticlebeam = {
		name = "轻粒子束",
		description = "Fires rapid medium-range pulses",
	},
	commweapon_hparticlebeam = {
		name = "重粒子束",
		description = "Ranged high-energy pulse weapon",
	},
	commweapon_massdriver = {
		name = "质量驱动器",
		description = "High-velocity hunting rifle",
	},
	commweapon_missilelauncher = {
		name = "导弹发射器",
		description = "Fires light seeker missiles with good range",
	},
	commweapon_partillery = {
		name = "等离子火炮",
		description = "Long-range artillery gun",
	},
	commweapon_riotcannon = {
		name = "防暴炮",
		description = "The weapon of choice for crowd control",
	},
	commweapon_rocketlauncher = {
		name = "火箭发射器",
		description = "Medium-range low-velocity hitter",
	},
	commweapon_shotgun = {
		name = "霰弹枪",
		description = "Can hammer a single large target or shred many small ones",
	},
	commweapon_shotlaser = {
		name = "激光霰弹枪",
		description = "Shotgun but shoots nerd-ass lasers instead of GLOWING HOT BALLS OF STEEL",
	},
	commweapon_slowbeam = {
		name = "减速光束",
		description = "Slows an enemy's movement and firing rate; non-lethal",
	},
	commweapon_sonicgun = {
		name = "音波爆破器",
		description = "Short-range weapon that works when dry or wet",
	},
	commweapon_torpedo = {
		name = "鱼雷",
		description = "Fires a torpedo effective against waterborne targets",
	},
	
	-- dguns
	commweapon_concussion = {
		name = "震荡弹",
		description = "Extended range weapon with AoE and impulse",
	},
	commweapon_clusterbomb = {
		name = "集束炸弹",
		description = "Hammers multiple units in a wide line",
	},
	commweapon_disintegrator = {
		name = "分解枪",
		description = "Short-range weapon that vaporizes anything in its path",
	},
	commweapon_disruptorbomb = {
		name = "干扰炸弹",
		description = "Damages and slows units in a large area",
	},
	commweapon_multistunner = {
		name = "多重眩晕器",
		description = "Briefly disables multiple targets in an area",
	},
	commweapon_napalmgrenade = {
		name = "地狱火手雷",
		description = "Sets a moderate area ablaze",
	},
	commweapon_slamrocket = {
		name = "S.L.A.M.",
		description = "Long-range weapon with a lethal punch",
	},
	commweapon_sunburst = {
		name = "日冕炮",
		description = "Ruins a single target's day with a medium-range high-energy burst",
	},
	
	-- conversion kits
	conversion_disruptor = {
		name = "干扰光束",
		description = "Slow Beam: +33% reload time, +250 real damage",
		func = function(unitDef)
				ReplaceWeapon(unitDef, "commweapon_slowbeam", "commweapon_disruptor")
			end,
	},
	conversion_shockrifle = {
		name = "冲击步枪",
		description = "Light Particle Beam: Convert to a long-range sniper rifle",
		func = function(unitDef)
				ReplaceWeapon(unitDef, "commweapon_lparticlebeam", "commweapon_shockrifle")
			end,
	},
	conversion_partillery = {
		name = "等离子火炮",
		description = "Assault Cannon: Convert to a light artillery gun",
		func = function(unitDef)
				ReplaceWeapon(unitDef, "commweapon_assaultcannon", "commweapon_partillery")
				--unitDef.hightrajectory = 1
			end,
	},
	conversion_hparticlebeam = {
		name = "重粒子束",
		description = "Light Particle Beam: Convert to an extended range rifle weapon",
		func = function(unitDef)
				ReplaceWeapon(unitDef, "commweapon_lparticlebeam", "commweapon_hparticlebeam")
			end,
	},
	
	-- weapon mods
	weaponmod_antiair = {
		name = "防空套件",
		description = "Beam Laser/Riot Cannon/Missile Launcher: Convert to anti-air weapons",
		func = function(unitDef)
				for i,v in pairs(weapons) do
					local id = v.customparams.idstring
					if (id == "commweapon_riotcannon") then
						ReplaceWeapon(unitDef, "commweapon_riotcannon", "commweapon_flakcannon")
						ReplaceWeapon(unitDef, "commweapon_riotcannon", "commweapon_flakcannon")
					elseif (id == "commweapon_beamlaser") then
						ReplaceWeapon(unitDef, "commweapon_beamlaser", "commweapon_aalaser")
						ReplaceWeapon(unitDef, "commweapon_beamlaser", "commweapon_aalaser")
					elseif (id == "commweapon_missilelauncher") then
						ReplaceWeapon(unitDef, "commweapon_missilelauncher", "commweapon_aamissile")
						ReplaceWeapon(unitDef, "commweapon_missilelauncher", "commweapon_aamissile")
					end
				end
			end
	},
	weaponmod_autoflechette = {
		name = "自动箭矢",
		description = "Shotgun: -25% projectiles, -40% reload time",
		func = function(unitDef)
				local weapons = unitDef.weapondefs or {}
				for i,v in pairs(weapons) do
					if v.customparams.idstring == "commweapon_shotgun" then
						v.customparams.misceffect = nil
						v.projectiles = v.projectiles * 0.75
						v.reloadtime = v.reloadtime * 0.6
						--break
					end
				end
			end,
	},
	weaponmod_disruptor_ammo = {
		name = "干扰弹药",
		description = "Shotgun/Heavy Machine Gun/Shock Rifle: +40% slow damage",
		func = function(unitDef)
				local permitted = {
					commweapon_shotgun = true,
					commweapon_gaussrifle = true,
					commweapon_heavymachinegun = true,
					commweapon_shockrifle = true,
				}
				local weapons = unitDef.weapondefs or {}
				for i,v in pairs(weapons) do
					local wcp = v.customparams
					local id = wcp.idstring
					if permitted[id] then
						wcp.timeslow_damagefactor = "0.4"
						v.rgbcolor = [[0.9 0.1 0.9]]
						if id == "commweapon_shotgun" or id == "commweapon_heavymachinegun" then
							v.explosiongenerator = [[custom:BEAMWEAPON_HIT_PURPLE]]
						elseif id == "commweapon_gaussrifle" then
							v.explosiongenerator = [[custom:GAUSS_HIT_M_PURPLE]]
						end -- no visual effect on shock rifle
						if i == "commweapon_shotgun_green" or i == "commweapon_heavymachinegun_lime" then
							v.rgbcolor = "0 1 0.7"
							v.explosiongenerator = [[custom:BEAMWEAPON_HIT_TURQUOISE]]
						end
					end
				end
			end,
	},
	weaponmod_high_frequency_beam = {
		name = "高频光束",
		description = " +15% damage and range to Beam Laser/Slow Beam/Disruptor Beam/Light Particle Beam/Heavy Particle Beam",
		func = function(unitDef)
				local weapons = unitDef.weapondefs or {}
				local permitted = {
					commweapon_beamlaser = true,
					commweapon_slowbeam = true,
					commweapon_disruptor = true,
					commweapon_lparticlebeam = true,
					commweapon_hparticlebeam = true,
				}
				for i,v in pairs(weapons) do
					if permitted[v.customparams.idstring] then
						v.range = v.range * 1.15
						for armorname, dmg in pairs(v.damage) do
							v.damage[armorname] = dmg * 1.15
						end
					end
				end
			end,
	},
	weaponmod_railaccel = {
		name = "轨道加速器",
		description = "Gauss Rifle: +10% damage, +20% range",
		func = function(unitDef)
				local weapons = unitDef.weapondefs or {}
				for i,v in pairs(weapons) do
					local id = v.customparams.idstring
					if id == "commweapon_gaussrifle" or id == "commweapon_massdriver" then
						v.range = v.range * 1.2
						for armorname, dmg in pairs(v.damage) do
							v.damage[armorname] = dmg * 1.1
						end
					end
				end
			end,
	},
	weaponmod_high_caliber_barrel = {
		name = "大口径枪管",
		description = "Shotgun/Riot Cannon/Assault Cannon/Plasma Artillery: +150% damage, +100% reload time",
		func = function(unitDef)
				local weapons = unitDef.weapondefs or {}
				local permitted = {
					commweapon_assaultcannon = true,
					commweapon_shotgun = true,
					commweapon_gaussrifle = true,
					commweapon_partillery = true,
					commweapon_partillery_napalm = true,
					commweapon_riotcannon = true,
				}
				for i,v in pairs(weapons) do
					local id = v.customparams.idstring
					if permitted[id] then
						if not (id == "commweapon_partillery" or id == "commweapon_partillery_napalm") then
							v.reloadtime = v.reloadtime * 2
							v.customparams.highcaliber = true
							for armorname, dmg in pairs(v.damage) do
								v.damage[armorname] = dmg * 2.5
							end
						else
							ReplaceWeapon(unitDef, "commweapon_partillery", "commweapon_hpartillery")
							ReplaceWeapon(unitDef, "commweapon_partillery", "commweapon_hpartillery")
							ReplaceWeapon(unitDef, "commweapon_partillery_napalm", "commweapon_hpartillery_napalm")
							ReplaceWeapon(unitDef, "commweapon_partillery_napalm", "commweapon_hpartillery_napalm")
						end
					end
				end
			end,
	},
	weaponmod_standoff_rocket = {
		name = "远程火箭弹",
		description = "Rocket/Missile Launcher: +50% range, +25% damage, +50% reload time",
		func = function(unitDef)
				local weapons = unitDef.weapondefs or {}
				for i,v in pairs(weapons) do
					local id = v.customparams.idstring
					if id == "commweapon_rocketlauncher" then
						v.range = v.range * 1.5
						v.reloadtime = v.reloadtime * 1.5
						for armorname, dmg in pairs(v.damage) do
							v.damage[armorname] = dmg * 1.25
						end
						v.model = [[wep_m_dragonsfang.s3o]]
						v.soundhitvolume = 8
						v.soundstart = [[weapon/missile/missile2_fire_bass]]
						v.soundstartvolume = 7
						--break
					elseif id == "commweapon_missilelauncher" then
						v.range = v.range * 1.5
						v.reloadtime = v.reloadtime * 1.5
						for armorname, dmg in pairs(v.damage) do
							v.damage[armorname] = dmg * 1.25
						end
						v.model = [[wep_m_phoenix.s3o]]
						v.soundhitvolume = 5
						v.soundstart = [[weapon/missile/missile_fire7]]
						v.soundstartvolume = 3
					end
				end
			end,
	},
	weaponmod_stun_booster = {
		name = "通量放大器",
		description = "Lightning Gun: +25% paralyze damage, +2s paralyzetime",
		func = function(unitDef)
				local weapons = unitDef.weapondefs or {}
				for i,v in pairs(weapons) do
					if v.customparams.idstring == "commweapon_lightninggun" then
						v.customparams.extra_damage = v.customparams.extra_damage * 1.25
						v.paralyzetime = v.paralyzetime + 2
					end
				end
			end,
	},
	weaponmod_napalm_warhead = {
		name = "凝固汽油弹弹头",
		description = "Riot Cannon/Plasma Artillery/Rocket Launcher: Reduced direct damage, sets target on fire",
		func = function(unitDef)
				local weapons = unitDef.weapondefs or {}
				local permitted = {
					commweapon_partillery = true,
					commweapon_hpartillery = true,
					commweapon_rocketlauncher = true,
					commweapon_riotcannon = true,
				}
				for i,v in pairs(weapons) do
					local id = v.customparams.idstring
					if permitted[id] then
						if (id == "commweapon_riotcannon") then	-- -20% damage
							for armorname, dmg in pairs(v.damage) do
								v.damage[armorname] = dmg * 0.8
							end
							v.customparams.burntime = "420"
							v.rgbcolor = [[1 0.3 0.1]]
						elseif (id == "commweapon_hpartillery") then	-- -90% damage, 256 AoE, firewalker effect
							ReplaceWeapon(unitDef, "commweapon_hpartillery", "commweapon_hpartillery_napalm")
							ReplaceWeapon(unitDef, "commweapon_hpartillery", "commweapon_hpartillery_napalm")
						elseif (id == "commweapon_partillery") then	-- -25% damage, 128 AoE
							ReplaceWeapon(unitDef, "commweapon_partillery", "commweapon_partillery_napalm")
							ReplaceWeapon(unitDef, "commweapon_partillery", "commweapon_partillery_napalm")
						else	-- -25% damage, 128 AoE
							for armorname, dmg in pairs(v.damage) do
								v.damage[armorname] = dmg * 0.75
							end
							v.customparams.burntime = "450"
							v.areaofeffect = 128
						end
						
						if (id == "commweapon_riotcannon") or (id == "commweapon_rocketlauncher") then
							v.explosiongenerator = [[custom:napalm_koda]]
							v.customparams.burnchance = "1"
							v.soundhit = [[weapon/burn_mixed]]
						end
						v.customparams.setunitsonfire = "1"
					end
				end
			end,
	},
	weaponmod_flame_enhancer = {
		name = "长燃凝固汽油弹",
		description = "Flamethrower/Napalm Warhead: +40% on-fire time",
		func = function(unitDef)
				local weapons = unitDef.weapondefs or {}
				for i,v in pairs(weapons) do
					if v.customparams.burntime then
						v.customparams.burntime = v.customparams.burntime * 1.4
					end
					if v.customparams.idstring == "commweapon_hpartillery_napalm" then
						v.customparams.area_damage_duration = v.customparams.area_damage_duration * 1.4
						v.explosiongenerator = "custom:napalm_firewalker_long"
					end
				end
			end,
		order = 3.1,
	},
	weaponmod_plasma_containment = {
		name = "等离子约束场",
		description = "Heat Ray/Riot Cannon: +30% range",
		func = function(unitDef)
				local weapons = unitDef.weapondefs or {}
				for i,v in pairs(weapons) do
					local id = v.customparams.idstring
					if id == "commweapon_heatray" then
						v.range = v.range * 1.3
					elseif id == "commweapon_riotcannon" then
						v.range = v.range * 1.3
					end
				end
			end,
	},
	
	-- modules
	module_ablative_armor = {
		name = "烧蚀装甲板",
		description = "Adds 600 HP",
		func = function(unitDef)
				unitDef.health = unitDef.health + 600
			end,
	},
	module_adv_targeting = {
		name = "高级瞄准系统",
		description = "Extends range of all weapons by 10%",
		func = function(unitDef)
				local weapons = unitDef.weapondefs or {}
				for i,v in pairs(weapons) do
					v.customparams.rangemod = v.customparams.rangemod + 0.1
				end
			end,
	},
	module_adv_nano = {
		name = "修车匠的纳米蚀刻",
		description = "Adds +5 metal/s build speed",
		func = function(unitDef)
				if unitDef.workertime then unitDef.workertime = unitDef.workertime + 5 end
				--if unitDef.builddistance then unitDef.builddistance = unitDef.builddistance + 60 end
			end,
	},
	module_autorepair = {
		name = "自动修复系统",
		description = "Self-repairs 10 HP/s",
		func = function(unitDef)
				unitDef.autoheal = (unitDef.autoheal or 0) + 10
			end,
	},
	module_companion_drone = {
		name = "伴侣无人机",
		description = "Spawns a pair of attack drones",
		func = function(unitDef)
				unitDef.customparams.drones = unitDef.customparams.drones or {}
				unitDef.customparams.drones[#unitDef.customparams.drones+1] = "module_companion_drone"
			end,
	},
	module_battle_drone = {
		name = "战斗无人机",
		description = "Spawns an advanced combat drone",
		func = function(unitDef)
				unitDef.customparams.drones = unitDef.customparams.drones or {}
				unitDef.customparams.drones[#unitDef.customparams.drones+1] = "module_battle_drone"
			end,
	},
	module_dmg_booster = {
		name = "伤害增幅器",
		description = "Increases damage of all weapons by 10%",
		func = function(unitDef)
				if unitDef.customparams.dynamic_comm then
					-- Weapondefs are static
					unitDef.customparams.damagemod = (unitDef.customparams.damagemod or 0) + 1
				else
					-- Weapondefs stored in unitdef
					local weapons = unitDef.weapondefs or {}
					for i,v in pairs(weapons) do
						v.customparams.damagemod = (v.customparams.damagemod or 0) + 0.1
					end
				end
			end,
	},
	module_burst_loader = {
		name = "爆发装填器",
		description = "+1 burst, +70% reload time",
		func = function(unitDef)
				local weapons = unitDef.weapondefs or {}
				for i,v in pairs(weapons) do
					local id = v.customparams.idstring
					-- linear rather than exponential increase with stacking
					v.reloadtime = v.reloadtime or 1
					local previousCount = v.customparams.burstloaders or 0
					local baseReload = v.reloadtime / (1 + 0.7*previousCount)
					if id == "commweapon_beamlaser" or id == "commweapon_disruptor" or id == "commweapon_slowbeam" then
						-- v.beamtime = v.beamtime + 10 -- beamlaser has 0.1, it's in seconds
						v.corethickness = v.corethickness + v.corethickness/(previousCount + 1)
						for armorname, dmg in pairs(v.damage) do
							v.damage[armorname] = dmg + dmg/(previousCount + 1)
						end
					elseif id == "commweapon_shotgun" then
						v.burst = (v.burst or 1) + 3
						v.sprayangle = (v.sprayangle or 0) + 256
						v.reloadtime = v.reloadtime + baseReload * 0.7
					else
						v.burstrate = (v.burstrate or 0.1 )
						v.reloadtime = v.reloadtime + baseReload * 0.7
						v.burst = (v.burst or 1) + 1
						v.sprayangle = (v.sprayangle or 0) + 256
					end
					v.customparams.burstloaders = previousCount + 1
				end
			end,
	},
	module_energy_cell = {
		name = "能量电池",
		description = "Compact fuel cells that produce +6 energy",
		func = function(unitDef)
				unitDef.energymake = (unitDef.energymake or 0) + 6
			end,
	},
	module_fieldradar = {
		name = "战场雷达模块",
		description = "Basic radar system with 1800 range",
		func = function(unitDef)
				unitDef.radardistance = (unitDef.radardistance or 0)
				if unitDef.radardistance < 1800 then
					unitDef.radardistance = 1800
				end
				if (not unitDef.radaremitheight) or unitDef.radaremitheight < 100 then
					unitDef.radaremitheight = 24
				end
			end,
	},
	module_heavy_armor = {
		name = "高密度装甲",
		description = "Adds 1600 HP, slows comm by +10%",
		func = function(unitDef, attributeMods)
				unitDef.health = unitDef.health + 1600
				attributeMods.speed = attributeMods.speed - 0.1
			end,
	},
	module_high_power_servos = {
		name = "大功率伺服电机",
		description = "More powerful leg actuators increase speed by 10% of base",
		func = function(unitDef, attributeMods)
				attributeMods.speed = attributeMods.speed + 0.1
			end,
	},
	module_personal_cloak = {
		name = "个人隐形",
		description = "Cloaks the commander",
		func = function(unitDef)
				unitDef.cancloak = true
				unitDef.cloakcost = unitDef.cloakcost or 5
				unitDef.mincloakdistance = math.max(150, unitDef.mincloakdistance or 0)
				if unitDef.cloakcost > 5 then
					unitDef.cloakcost = 5
				end
				unitDef.cloakcostmoving = unitDef.cloakcostmoving or 10
				if unitDef.cloakcostmoving > 10 then
					unitDef.cloakcostmoving = 10
				end
			end,
	},
	module_personal_shield = {
		name = "个人护盾",
		order = 5,
		description = "Generates a small bubble shield",
		func = function(unitDef)
				if unitDef.customparams.dynamic_comm then
					DynamicApplyWeapon(unitDef, "commweapon_personal_shield", #unitDef.weapons + 1)
				else
					ApplyWeapon(unitDef, "commweapon_personal_shield", 4)
				end
			end,
	},
	
	module_resurrect = {
		name = "拉撒路装置",
		description = "Enables resurrection of wrecks",
		func = function(unitDef)
				unitDef.canresurrect = true
			end,
	},
	
	module_jumpjet = {
		name = "跳跃喷射",
		description = "Allows the commander to jump",
		func = function(unitDef)
				unitDef.customparams.canjump            = 1
				unitDef.customparams.jump_range         = 400
				unitDef.customparams.jump_speed         = 6
				unitDef.customparams.jump_reload        = 20
				unitDef.customparams.jump_from_midair   = 1
			end,
	},
	
	module_areashield = {
		name = "区域护盾",
		order = 6,
		description = "A bubble shield that protects surrounding units within 350 m",
		func = function(unitDef)
				--ApplyWeapon(unitDef, "commweapon_areashield", 2)
				
				if unitDef.customparams.dynamic_comm then
					DynamicApplyWeapon(unitDef, "commweapon_areashield", #unitDef.weapons) -- not +1 so as to replace personal
				else
					ReplaceWeapon(unitDef, "commweapon_personal_shield", "commweapon_areashield")
				end

				unitDef.customparams.lups_unit_fxs = unitDef.customparams.lups_unit_fxs or {}
				table.insert(unitDef.customparams.lups_unit_fxs, "commAreaShield")
			end,
	},
	module_cloak_field = {
		name = "隐形力场",
		description = "Cloaks all friendly units within 350 m",
		func = function(unitDef)
				unitDef.mincloakdistance = math.max(150, unitDef.mincloakdistance or 0)
				unitDef.onoffable = true
				unitDef.radarDistanceJam = (unitDef.radarDistanceJam and unitDef.radarDistanceJam > 350 and unitDef.radarDistanceJam) or 350
				unitDef.customparams.area_cloak = "1"
				unitDef.customparams.area_cloak_upkeep = "15"
				unitDef.customparams.area_cloak_radius = "350"
				unitDef.customparams.area_cloak_decloak_distance = "75"
			end,
	},
	module_jammer = {
		name = "雷达干扰器",
		description = "Masks radar signals of all units within 500 m",
		func = function(unitDef)
				unitDef.radardistancejam = 500
				unitDef.activatewhenbuilt = true
				unitDef.onoffable = true
			end,
	},
	
	module_jump_booster = {
		name = "蜻蜓助推器",
		description = "Increases jump range and height",
		func = function(unitDef)
				unitDef.customparams.jumpclass = "commrecon2"
			end,
	},
	
	module_radarnet = {
		name = "集成雷达网络",
		description = "Reduces radar wobble for all units",
		func = function(unitDef)
				unitDef.isTargetingUpgrade = true
				unitDef.activatewhenbuilt = true
		end,
	},
	
	module_ultralight_hull = {
		name = "超轻船体",
		description = "-1200 HP, +25% speed",
		func = function(unitDef, attributeMods)
				unitDef.health = unitDef.health - 1200
				attributeMods.speed = attributeMods.speed + 0.25
			end,
	},
	module_weapon_hicharge = {
		name = "武器高能充电器",
		description = "-1000 HP, +40% damage",
		func = function(unitDef, attributeMods)
				unitDef.health = unitDef.health - 1000
				local weapons = unitDef.weapondefs or {}
				for i,v in pairs(weapons) do
					v.customparams.damagemod = v.customparams.damagemod + 0.4
				end
			end,
	},
	-- modules that use a weapon slot
	module_guardian_armor = {
		name = "守护者防御系统",
		description = "Adds 100% HP (including other modules); self-repairs 20 HP/s",
		func = function(unitDef, attributeMods)
				attributeMods.health = attributeMods.health + 1
				unitDef.autoheal = (unitDef.autoheal or 0) + 20
		end,
		useWeaponSlot = true,
	},

	module_superspeed = {
		name = "马拉松运动控制",
		description = "Increases speed by 50% of base",
		func = function(unitDef, attributeMods)
				attributeMods.speed = attributeMods.speed + 0.5
		end,
		useWeaponSlot = true,
	},
	
	module_longshot = {
		name = "远程火控",
		description = "Extends range of all weapons by 40%",
		func = function(unitDef)
				local weapons = unitDef.weapondefs or {}
				for i,v in pairs(weapons) do
					v.customparams.rangemod = v.customparams.rangemod + 0.4
				end
			end,
		useWeaponSlot = true,
	},
		
	module_super_nano = {
		name = "工程师的复仇",
		description = "Adds 20 metal/s build speed and 200 build range",
		func = function(unitDef)
				if unitDef.workertime then unitDef.workertime = unitDef.workertime + 20 end
				if unitDef.builddistance then unitDef.builddistance = unitDef.builddistance + 200 end
		end,
		useWeaponSlot = true,
	},
	
	-- deprecated
	module_improved_optics = {
		name = "改进光学系统",
		description = "Increases sight distance by 100 m",
		func = function(unitDef)
				unitDef.sightdistance = unitDef.sightdistance + 100
			end,
	},
	module_repair_field = {
		name = "维修力场",
		description = "Passively repairs all friendly units within 450 m",
		func = function(unitDef)
				unitDef.customparams.repairaura_preset = "module_repairfield"
			end,
	},
	
	-- secret stuff!
	module_econ = {
		name = "经济套餐",
		description = "Produces +2 energy and metal",
		func = function(unitDef)
				unitDef.energymake = (unitDef.energymake or 0) + 2
				unitDef.metalmake = (unitDef.metalmake or 0) + 2
			end,
	},
	
	conversion_lazor = {
		name = "超级激光",
		description = "LOLOLOL",
		func = function(unitDef)
				ReplaceWeapon(unitDef, "commweapon_beamlaser", "commweapon_hparticlebeam")
			end,
	}
}

decorations = {
	skin_recon_dark = {
		func = function(unitDef)
				unitDef.customparams.altskin = [[unittextures/commrecon1dark.dds]]
				unitDef.customparams.altskin2 = [[unittextures/commrecon2alt.dds]]
				unitDef.buildpic = "skin_recon_dark.png"
			end,
	},
	skin_recon_red = {
		func = function(unitDef)
				unitDef.customparams.altskin = [[unittextures/commrecon1red.dds]]
				unitDef.customparams.altskin2 = [[unittextures/commrecon2alt.dds]]
				unitDef.buildpic = "skin_recon_red.png"
			end,
	},
	skin_recon_leopard = {
		func = function(unitDef)
				unitDef.customparams.altskin = [[unittextures/commrecon1leopard.dds]]
				unitDef.customparams.altskin2 = [[unittextures/commrecon2alt.dds]]
				unitDef.buildpic = "skin_recon_leopard.png"
			end,
	},
	skin_battle_blue = {
		func = function(unitDef)
				unitDef.customparams.altskin = [[unittextures/core_commander_1blue.dds]]
			end,
	},
	skin_battle_camo = {
		func = function(unitDef)
				unitDef.customparams.altskin = [[unittextures/core_commander_1camo.dds]]
				unitDef.buildpic = "skin_battle_camo.png"
			end,
	},
	skin_battle_tiger = {
		func = function(unitDef)
				unitDef.customparams.altskin = [[unittextures/core_commander_1tiger.dds]]
				unitDef.buildpic = "skin_battle_tiger.png"
			end,
	},
	skin_support_dark = {
		func = function(unitDef)
				unitDef.customparams.altskin = [[unittextures/commsupport1dark.dds]]
				unitDef.buildpic = "skin_support_dark.png"
			end,
	},
	skin_support_green = {
		func = function(unitDef)
				unitDef.customparams.altskin = [[unittextures/commsupport1green.dds]]
				unitDef.buildpic = "skin_support_green.png"
			end,
	},
	skin_support_hotrod = {
		func = function(unitDef)
				unitDef.customparams.altskin = [[unittextures/commsupport1hotrod.dds]]
				unitDef.buildpic = "skin_support_hotrod.png"
			end,
	},
	skin_support_zebra = {
		func = function(unitDef)
				unitDef.customparams.altskin = [[unittextures/commsupport1zebra.dds]]
				unitDef.buildpic = "skin_support_zebra.png"
			end,
	},
	skin_assault_steel = {
		func = function(unitDef)
				unitDef.customparams.altskin = [[unittextures/benzcom_1_steel.dds]]
				unitDef.buildpic = "skin_assault_steel.png"
			end,
	},
	skin_strike_renegade={
		func = function(unitDef)
			unitDef.customparams.altskin = [[unittextures/strikecom_renegade.dds]]
			unitDef.customparams.altskin2 = [[unittextures/strikecom_renegade_2.dds]]
			unitDef.buildpic = "skin_strike_renegade.png"
		end
	},
	skin_strike_chitin={
		func = function(unitDef)
			unitDef.customparams.altskin = [[unittextures/strikecom_chitin.dds]]
			unitDef.customparams.altskin2 = [[unittextures/strikecom_chitin_2.dds]]
			unitDef.buildpic = "skin_strike_chitin.png"
		end
	},
	shield_red = {
		func = function(unitDef)
				unitDef.customparams.lups_unit_fxs = unitDef.customparams.lups_unit_fxs or {}
				table.insert(unitDef.customparams.lups_unit_fxs, "commandShieldRed")
			end,
	},
	shield_green = {
		func = function(unitDef)
				unitDef.customparams.lups_unit_fxs = unitDef.customparams.lups_unit_fxs or {}
				table.insert(unitDef.customparams.lups_unit_fxs, "commandShieldGreen")
			end,
	},
	shield_blue = {
		func = function(unitDef)
				unitDef.customparams.lups_unit_fxs = unitDef.customparams.lups_unit_fxs or {}
				table.insert(unitDef.customparams.lups_unit_fxs, "commandShieldBlue")
			end,
	},
	shield_orange = {
		func = function(unitDef)
				unitDef.customparams.lups_unit_fxs = unitDef.customparams.lups_unit_fxs or {}
				table.insert(unitDef.customparams.lups_unit_fxs, "commandShieldOrange")
			end,
	},
	shield_violet = {
		func = function(unitDef)
				unitDef.customparams.lups_unit_fxs = unitDef.customparams.lups_unit_fxs or {}
				table.insert(unitDef.customparams.lups_unit_fxs, "commandShieldViolet")
			end,
	},
	
	icon_shoulders = {
		func = function(unitDef, config)
				if config.decorations and config.decorations.icon_shoulders then
					unitDef.customparams.decorationicons = unitDef.customparams.decorationicons or {}
					unitDef.customparams.decorationicons.shoulders = config.decorations.icon_shoulders.image
				end
			end,
	},
	
	icon_chest = {
		func = function(unitDef, config)
				if config.decorations and config.decorations.icon_chest then
					unitDef.customparams.decorationicons = unitDef.customparams.decorationicons or {}
					unitDef.customparams.decorationicons.chest = config.decorations.icon_chest.image
				end
			end,
	},
	
	icon_back = {
		func = function(unitDef, config)
				if config.decorations and config.decorations.icon_back then
					unitDef.customparams.decorationicons = unitDef.customparams.decorationicons or {}
					unitDef.customparams.decorationicons.back = config.decorations.icon_back.image
				end
			end,
	},
	
	icon_overhead = {
		func = function(unitDef, config)
				if config.decorations and config.decorations.icon_overhead then
					unitDef.customparams.decorationicons = unitDef.customparams.decorationicons or {}
					unitDef.customparams.decorationicons.overhead = config.decorations.icon_overhead.image
				end
			end,
	},
}

for name,data in pairs(upgrades) do
	local order = data.order
	if not order then
		if name:find("commweapon_") then
			order = 1
		elseif name:find("conversion_") then
			order = 2
		elseif name:find("weaponmod_") then
			order = 3
		else
			order = 4
		end
		data.order = order
	end
end

local weaponsList = VFS.DirList("gamedata/modularcomms/weapons", "*.lua") or {}
for i=1,#weaponsList do
	local name, array = VFS.Include(weaponsList[i])
	weapons[name] = lowerkeys(array)
	
	local weapon = weapons[name]
	weapon.customparams = weapon.customparams or {}
	if name ~= "FAKELASER" then
		weapon.customparams.idstring = name
	end
	
	if weapon.customparams.altforms then
		for form, mods in pairs(weapon.customparams.altforms) do
			local newName = name.."_"..form
			weapons[newName] = CopyTable(weapon, true)
			upgrades[newName] = CopyTable(upgrades[name], true)
			weapons[newName] = MergeTable(mods, weapons[newName], true)
		end
	end
end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
