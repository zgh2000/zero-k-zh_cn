local invertZoomMult = -1

local TRUE = "true"
local FALSE = "false"

local lupsFileTarget = "lups.cfg"
local cmdcolorsFileTarget = "cmdcolors.txt"

local function UpdateLups(_, conf)
	conf = conf or (WG.Chobby and WG.Chobby.Configuration)
	local settings = conf and conf.settingsMenuValues
	if not settings then
		return
	end

	local lupsFileName = settings.ShaderDetail_file or "LuaMenu/configs/gameConfig/zk/lups/lups3.cfg"
	local lupsAirJetDisabled = ((settings.LupsAirJet == "开启") and FALSE) or TRUE
	local lupsRibbonDisabled = ((settings.LupsRibbon == "开启") and FALSE) or TRUE
	local lupsNanoParticlesDisabled = ((settings.LupsNanoParticles == "云") and FALSE) or TRUE
	local LupsShieldShaderDisabled = ((settings.LupsShieldShader == "关闭") and TRUE) or FALSE
	local LupsShieldHighQualityDisabled = ((settings.LupsShieldShader == "默认") and FALSE) or TRUE
	local lupsWaterRefractEnabled = ((settings.LupsWaterSettings == "折射" or settings.LupsWaterSettings == "折射和反射") and 1) or 0
	local lupsWaterReflectEnabled = ((settings.LupsWaterSettings == "反射" or settings.LupsWaterSettings == "折射和反射") and 1) or 0

	local sourceFile = VFS.LoadFile(lupsFileName)

	sourceFile = sourceFile:gsub("__AIR_JET__", lupsAirJetDisabled)
	sourceFile = sourceFile:gsub("__RIBBON__", lupsRibbonDisabled)
	sourceFile = sourceFile:gsub("__NANO_PARTICLES__", lupsNanoParticlesDisabled)
	sourceFile = sourceFile:gsub("__SHIELD_SPHERE_COLOR__", LupsShieldShaderDisabled)
	sourceFile = sourceFile:gsub("__SHIELD_SPHERE_HIGH_QUALITY__", LupsShieldHighQualityDisabled)
	sourceFile = sourceFile:gsub("__ENABLE_REFRACT__", lupsWaterRefractEnabled)
	sourceFile = sourceFile:gsub("__ENABLE_REFLECT__", lupsWaterReflectEnabled)

	local settingsFile = io.open(lupsFileTarget, "w")
	settingsFile:write(sourceFile)
	settingsFile:close()
end

local function UpdateCmdcolors(_, conf)
	conf = conf or (WG.Chobby and WG.Chobby.Configuration)
	local settings = conf and conf.settingsMenuValues
	if not settings then
		return
	end

	local cmdAlpha = (settings.CommandAlpha or 70)/100
	local cmdAlphaDark
	if cmdAlpha >= 0.7 then
		cmdAlphaDark = cmdAlpha + 0.1
	elseif cmdAlpha >= 0.6 then
		cmdAlphaDark = cmdAlpha + 0.05
	else
		cmdAlphaDark = cmdAlpha + 0.02
	end
	
	local queueIconAlpha = (settings.QueueIconAlpha or 50)/100

	local cmdcolorsFileName = "LuaMenu/configs/gameConfig/zk/cmdcolors/cmdcolors_source.txt"
	local sourceFile = VFS.LoadFile(cmdcolorsFileName)

	sourceFile = sourceFile:gsub("__CMD_ALPHA__", cmdAlpha)
	sourceFile = sourceFile:gsub("__CMD_ALPHA_DARK__", cmdAlphaDark)
	sourceFile = sourceFile:gsub("__QUEUE_ICON_ALPHA__", queueIconAlpha)

	local settingsFile = io.open(cmdcolorsFileTarget, "w")
	settingsFile:write(sourceFile)
	settingsFile:close()
	
	return {
		CmdAlpha = cmdAlpha,
		CmdAlphaDark = cmdAlphaDark,
		CmdIconAlpha = queueIconAlpha,
	}
end

local function GetUiScaleParameters()
	local realWidth, realHeight = Spring.Orig.GetViewSizes()
	local defaultUiScale = 100
	if realHeight > 1900 then
		defaultUiScale = 200
	elseif realHeight > 1220 or realWidth > 2500 then
		defaultUiScale = 125
	end
	local maxUiScale = math.max(2, realWidth/1000)*100
	local minUiScale = math.min(0.5, realWidth/4000)*100
	return defaultUiScale, maxUiScale, minUiScale
end

local defaultUiScale, maxUiScale, minUiScale = GetUiScaleParameters()

local settingsConfig = {
	{
		name = "图形设置",
		presets = {
			{
				name = "兼容",
				settings = {
					WaterType_2 = "基础",
					WaterQuality = "低",
					Shadows = "无",
					ShadowMapSize = "1024",
					ShadowDetail = "低",
					ParticleLimit = "2000",
					TerrainDetail = "最小",
					SoftParticles = "Compatibility",
					VegetationDetail = "最小",
					FeatureFade = "开启",
					CompatibilityMode = "开启",
					AtiIntelCompatibility_2 = "自动",
					AntiAliasing = "关闭",
					VSync = "关闭",
					ShaderDetail = "最小",
					LupsAirJet = "关闭",
					LupsRibbon = "关闭",
					LupsNanoParticles = "光束",
					LupsShieldShader = "关闭",
					LupsWaterSettings = "关闭",
					FancySky = "关闭",
					UseNewChili = "关闭",
				}
			},
			{
				name = "最低",
				settings = {
					WaterType_2 = "凹凸贴图",
					WaterQuality = "低",
					Shadows = "无",
					ShadowMapSize = "1024",
					ShadowDetail = "低",
					ParticleLimit = "6000",
					TerrainDetail = "低",
					SoftParticles = "启用",
					VegetationDetail = "低",
					FeatureFade = "开启",
					CompatibilityMode = "关闭",
					AtiIntelCompatibility_2 = "自动",
					AntiAliasing = "低",
					VSync = "关闭",
					ShaderDetail = "最小",
					LupsAirJet = "关闭",
					LupsRibbon = "关闭",
					LupsNanoParticles = "光束",
					LupsShieldShader = "关闭",
					LupsWaterSettings = "关闭",
					FancySky = "关闭",
					UseNewChili = "关闭",
				}
			},
			{
				name = "低",
				settings = {
					WaterType_2 = "凹凸贴图",
					WaterQuality = "低",
					Shadows = "仅单位",
					ShadowMapSize = "2048",
					ShadowDetail = "低",
					ParticleLimit = "12000",
					TerrainDetail = "低",
					SoftParticles = "启用",
					VegetationDetail = "低",
					FeatureFade = "开启",
					CompatibilityMode = "关闭",
					AtiIntelCompatibility_2 = "自动",
					AntiAliasing = "低",
					VSync = "关闭",
					ShaderDetail = "低",
					LupsAirJet = "关闭",
					LupsRibbon = "开启",
					LupsNanoParticles = "光束",
					LupsShieldShader = "默认",
					LupsWaterSettings = "关闭",
					FancySky = "关闭",
					UseNewChili = "关闭",
				}
			},
			{
				name = "中",
				settings = {
					WaterType_2 = "凹凸贴图",
					WaterQuality = "中",
					Shadows = "单位和地形",
					ShadowMapSize = "2048",
					ShadowDetail = "中",
					ParticleLimit = "15000",
					TerrainDetail = "中",
					SoftParticles = "启用",
					VegetationDetail = "中",
					FeatureFade = "开启",
					CompatibilityMode = "关闭",
					AtiIntelCompatibility_2 = "自动",
					AntiAliasing = "低",
					VSync = "关闭",
					ShaderDetail = "中",
					LupsAirJet = "开启",
					LupsRibbon = "开启",
					LupsNanoParticles = "云",
					LupsShieldShader = "默认",
					LupsWaterSettings = "关闭",
					FancySky = "关闭",
					UseNewChili = "关闭",
				}
			},
			{
				name = "高",
				settings = {
					WaterType_2 = "凹凸贴图",
					WaterQuality = "高",
					Shadows = "单位和地形",
					ShadowMapSize = "8192",
					ShadowDetail = "高",
					ParticleLimit = "25000",
					TerrainDetail = "高",
					SoftParticles = "启用",
					VegetationDetail = "高",
					FeatureFade = "开启",
					CompatibilityMode = "关闭",
					AtiIntelCompatibility_2 = "自动",
					AntiAliasing = "高",
					VSync = "关闭",
					ShaderDetail = "高",
					LupsAirJet = "开启",
					LupsRibbon = "开启",
					LupsNanoParticles = "云",
					LupsShieldShader = "默认",
					LupsWaterSettings = "关闭",
					FancySky = "关闭",
					UseNewChili = "关闭",
				}
			}
		},

		-- FIXME: this list is in dire need of resorting
		settings = {
			{
				name = "DisplayMode",
				humanName = "游戏内显示模式",
				displayModeToggle = true,
			},
			{
				name = "LobbyDisplayMode",
				humanName = "菜单显示模式",
				lobbyDisplayModeToggle = true,
			},
			{
				name = "ActiveGraphicsLabel",
				humanName = "显卡驱动: ",
				isLabelSetting = true,
				desc = Platform.gpuVendor,
				size = 2,
			},
			{
				name = "AntiAliasing",
				humanName = "抗锯齿",
				options = {
					{
						name = "关闭",
						apply = {
							MSAALevel = 1, -- Required, see https://springrts.com/mantis/view.php?id=5625
							FSAA = 0,
							SmoothLines = 0,
							SmoothPoints = 0,
						}
					},
					{
						name = "低",
						apply = {
							MSAALevel = 4,
							FSAA = 1,
							SmoothLines = 1,
							SmoothPoints = 1,
						}
					},
					{
						name = "高",
						apply = {
							MSAALevel = 8,
							FSAA = 1,
							SmoothLines = 3,
							SmoothPoints = 3,
						}
					},
				},
			},
			{
				name = "LupsAirJet",
				humanName = "飞机引擎",
				options = {
					{
						name = "开启",
						applyFunction = UpdateLups,
					},
					{
						name = "关闭",
						applyFunction = UpdateLups,
					},
				},
			},
			{
				name = "LupsRibbon",
				humanName = "飞机尾迹",
				options = {
					{
						name = "开启",
						applyFunction = UpdateLups,
					},
					{
						name = "关闭",
						applyFunction = UpdateLups,
					},
				},
			},
			{
				name = "CompatibilityMode",
				humanName = "兼容模式",
				options = {
					{
						name = "关闭",
						apply = {
							AllowDeferredModelRendering = 1,
							AllowDeferredMapRendering = 1,
							LoadingMT = 0, -- See https://github.com/spring/spring/commit/bdd6b641960759ccadf3e7201e37f2192d873791
							AdvUnitShading = 1,
							AdvMapShading = 1,
							LuaShaders = 1,
							CubeTexSizeReflection = 1024,
							ForceDisableShaders = 0,
							UsePBO = 1,
							["3DTrees"] = 1,
							MaxDynamicMapLights = 1,
							MaxDynamicModelLights = 1,
							ROAM = 1, --Maybe ROAM = 0 when the new renderer is fully developed
						}
					},
					{
						name = "开启",
						apply = {
							AllowDeferredModelRendering = 1,
							AllowDeferredMapRendering = 1,
							LoadingMT = 0,
							AdvUnitShading = 0,
							AdvMapShading = 0,
							LuaShaders = 1,
							CubeTexSizeReflection = 1024,
							ForceDisableShaders = 0,
							UsePBO = 0,
							["3DTrees"] = 0,
							MaxDynamicMapLights = 0,
							MaxDynamicModelLights = 0,
							ROAM = 1,
						}
					},
					{
						name = "极端",
						apply = {
							AllowDeferredModelRendering = 0,
							AllowDeferredMapRendering = 0,
							LoadingMT = 0,
							AdvUnitShading = 0,
							AdvMapShading = 0,
							LuaShaders = 0,
							CubeTexSizeReflection = 1,
							ForceDisableShaders = 1,
							UsePBO = 0,
							["3DTrees"] = 0,
							MaxDynamicMapLights = 0,
							MaxDynamicModelLights = 0,
							ROAM = 1,
						}
					},
				},
			},
			{
				name = "LupsNanoParticles",
				humanName = "建造特效",
				options = {
					{
						name = "云",
						applyFunction = UpdateLups,
					},
					{
						name = "光束",
						applyFunction = UpdateLups,
					},
				},
			},
			{
				name = "UseNewChili",
				humanName = "实验性界面渲染器",
				options = {
					{
						name = "关闭",
						apply = {
							ZKUseNewChiliRTT = 0,
						}
					},
					{
						name = "开启",
						apply = {
							ZKUseNewChiliRTT = 1,
						}
					},
				},
			},
			{
				name = "FancySky",
				humanName = "华丽天空",
				options = {
					{
						name = "开启",
						apply = {
							DynamicSky = 1,
							AdvSky = 1,
						}
					},
					{
						name = "关闭",
						apply = {
							DynamicSky = 0,
							AdvSky = 0,
						}
					},
				},
			},
			{
				name = "VSync",
				humanName = "帧率限制（垂直同步）",
				options = {
					{
						name = "标准",
						apply = {
							VSync = 1,
						}
					},
					{
						name = "自适应",
						apply = {
							VSync = -1,
						}
					},
					{
						name = "关闭",
						apply = {
							VSync = 0,
						}
					},
				},
			},
			{
				name = "ParticleLimit",
				humanName = "粒子上限",
				options = {
					{
						name = "2000",
						apply = {
							MaxParticles = 2000
						}
					},
					{
						name = "4000",
						apply = {
							MaxParticles = 4000
						}
					},
					{
						name = "6000",
						apply = {
							MaxParticles = 6000
						}
					},
					{
						name = "9000",
						apply = {
							MaxParticles = 9000
						}
					},
					{
						name = "12000",
						apply = {
							MaxParticles = 12000
						}
					},
					{
						name = "15000",
						apply = {
							MaxParticles = 15000
						}
					},
					{
						name = "20000",
						apply = {
							MaxParticles = 15000
						}
					},
					{
						name = "25000",
						apply = {
							MaxParticles = 25000
						}
					},
					{
						name = "35000",
						apply = {
							MaxParticles = 25000
						}
					},
					{
						name = "50000",
						apply = {
							MaxParticles = 50000
						}
					},
				},
			},
			{
				name = "FeatureFade",
				humanName = "岩石和残骸淡出",
				options = {
					{
						name = "开启",
						apply = {
							FeatureDrawDistance = 6000,
							FeatureFadeDistance = 4500,
						}
					},
					{
						name = "关闭",
						apply = {
							FeatureDrawDistance = 600000,
							FeatureFadeDistance = 600000,
						}
					},
				},
			},
			{
				name = "ShaderDetail",
				humanName = "着色器细节",
				fileTarget = lupsFileTarget,
				applyFunction = UpdateLups,
				options = {
					{
						name = "最小",
						file = "LuaMenu/configs/gameConfig/zk/lups/lups0.cfg"
					},
					{
						name = "低",
						file = "LuaMenu/configs/gameConfig/zk/lups/lups1.cfg"
					},
					{
						name = "中",
						file = "LuaMenu/configs/gameConfig/zk/lups/lups2.cfg"
					},
					{
						name = "高",
						file = "LuaMenu/configs/gameConfig/zk/lups/lups3.cfg"
					},
					{
						name = "极高",
						file = "LuaMenu/configs/gameConfig/zk/lups/lups4.cfg"
					},
				},
			},
			{
				name = "LupsWaterSettings",
				humanName = "受水体影响的着色器",
				options = {
					{
						name = "关闭",
						applyFunction = UpdateLups,
					},
					{
						name = "折射",
						applyFunction = UpdateLups,
					},
					{
						name = "反射",
						applyFunction = UpdateLups,
					},
					{
						name = "折射和反射",
						applyFunction = UpdateLups,
					},
				},
			},
			{
				name = "LupsShieldShader",
				humanName = "护盾效果着色器",
				options = {
					{
						name = "默认",
						applyFunction = UpdateLups,
					},
					{
						name = "简单",
						applyFunction = UpdateLups,
					},
					{
						name = "关闭",
						applyFunction = UpdateLups,
					},
				},
			},
			{
				name = "阴影",
				humanName = "阴影",
				options = {
					{
						name = "无",
						apply = {
							Shadows = 0
						}
					},
					{
						name = "仅单位",
						apply = {
							Shadows = 2
						}
					},
					{
						name = "单位和地形",
						apply = {
							Shadows = 1
						}
					},
				},
			},
			{
				name = "ShadowMapSize",
				humanName = "阴影贴图大小",
				options = {
					{
						name = "1024",
						apply = {
							ShadowMapSize = 1024
						}
					},
					{
						name = "2048",
						apply = {
							ShadowMapSize = 2048
						}
					},
					{
						name = "4096",
						apply = {
							ShadowMapSize = 4096
						}
					},
					{
						name = "8192",
						apply = {
							ShadowMapSize = 8192
						}
					},
					{
						name = "16384",
						apply = {
							ShadowMapSize = 16384
						}
					},
				},
			},
			{
				name = "SoftParticles",
				humanName = "柔和粒子",
				options = {
					{
						name = "禁用",
						apply = {
							SoftParticles = 0
						}
					},
					{
						name = "Compatibility",
						apply = {
							SoftParticles = 1
						}
					},
					{
						name = "启用",
						apply = {
							SoftParticles = 2
						}
					},
				},
			},
			{
				name = "TerrainDetail",
				humanName = "地形细节",
				options = {
					{
						name = "最小",
						apply = {
							GroundScarAlphaFade = 1,
							GroundDecals = 0,
							GroundDetail = 50,
						}
					},
					{
						name = "低",
						apply = {
							GroundScarAlphaFade = 0,
							GroundDecals = 1,
							GroundDetail = 70,
						}
					},
					{
						name = "中",
						apply = {
							GroundScarAlphaFade = 1,
							GroundDecals = 2,
							GroundDetail = 90,
						}
					},
					{
						name = "高",
						apply = {
							GroundScarAlphaFade = 1,
							GroundDecals = 5,
							GroundDetail = 120,
						}
					},
					{
						name = "极高",
						apply = {
							GroundScarAlphaFade = 1,
							GroundDecals = 10,
							GroundDetail = 180,
						}
					},
				},
			},
			{
				name = "UnitReflections",
				humanName = "单位反射质量",
				options = {
					{
						name="关闭",
						apply = {
							CubeTexSizeSpecular = 1,
						}
					},
					{
						name="低",
						apply = {
							CubeTexSizeSpecular = 64,
						}
					},
					{
						name="中",
						apply = {
							CubeTexSizeSpecular = 128,
						}
					},
					{
						name="高",
						apply = {
							CubeTexSizeSpecular = 256,
						}
					},
					{
						name="极高",
						apply = {
							CubeTexSizeSpecular = 1024,
						}
					},
				},
			},
			{
				name = "VegetationDetail",
				humanName = "植被细节",
				options = {
					{
						name = "最小",
						apply = {
							TreeRadius = 1000,
							GrassDetail = 0,
						}
					},
					{
						name = "低",
						apply = {
							TreeRadius = 1000,
							GrassDetail = 0,
						}
					},
					{
						name = "中",
						apply = {
							TreeRadius = 1200,
							GrassDetail = 0,
						}
					},
					{
						name = "高",
						apply = {
							TreeRadius = 1500,
							GrassDetail = 0,
						}
					},
					{
						name = "极高",
						apply = {
							TreeRadius = 2500,
							GrassDetail = 0,
						}
					},
					{
						name = "荒谬",
						apply = {
							TreeRadius = 2500,
							GrassDetail = 0,
						}
					},
				},
			},

			{
				name = "WaterType_2",
				humanName = "水体类型",
				options = {
					{
						name = "基础",
						apply = {
							Water = 0,
						}
					},
					{
						name = "反射",
						apply = {
							Water = 1,
						}
					},
					{
						name = "折射",
						apply = {
							Water = 2,
						}
					},
					--{
					--	name = "Dynamic",
					--	apply = {
					--		Water = 3,
					--	}
					--},
					{
						name = "凹凸贴图",
						apply = {
							Water = 4,
						}
					},
				},
			},
			{
				name = "WaterQuality",
				humanName = "水体质量",
				options = {
					{
						name = "低",
						apply = {
							BumpWaterAnisotropy = 0,
							BumpWaterBlurReflection = 0,
							BumpWaterReflection = 0,
							BumpWaterRefraction = 0,
							BumpWaterDepthBits = 16,
							BumpWaterShoreWaves = 0,
							BumpWaterTexSizeReflection = 64,
						}
					},
					{
						name = "中",
						apply = {
							BumpWaterAnisotropy = 0,
							BumpWaterBlurReflection = 1,
							BumpWaterReflection = 1,
							BumpWaterRefraction = 1,
							BumpWaterDepthBits = 24,
							BumpWaterShoreWaves = 1,
							BumpWaterTexSizeReflection = 128,
						}
					},
					{
						name = "高",
						apply = {
							BumpWaterAnisotropy = 2,
							BumpWaterBlurReflection = 1,
							BumpWaterReflection = 2,
							BumpWaterRefraction = 1,
							BumpWaterDepthBits = 32,
							BumpWaterShoreWaves = 1,
							BumpWaterTexSizeReflection = 256,
						}
					},
					{
						name = "极高",
						apply = {
							BumpWaterAnisotropy = 2,
							BumpWaterBlurReflection = 1,
							BumpWaterReflection = 2,
							BumpWaterRefraction = 2,
							BumpWaterDepthBits = 32,
							BumpWaterShoreWaves = 1,
							BumpWaterTexSizeReflection = 1024,
						}
					},
				},
			},
		},
	},
	{
		name = "游戏设置",
		presets = {
			{
				name = "默认",
				settings = {
					--IconDistance = 151,
					InterfaceScale = defaultUiScale,
					MouseZoomSpeed = 25,
					InvertZoom = "关闭",
					HardwareCursor = "开启",
					TextToSpeech = "开启",
					EdgeScroll = "开启",
					CommandAlpha = 60,
					QueueIconAlpha = 45,
					MiddlePanSpeed = 15,
					CameraPanSpeed = 50,
					NetworkSettings = "平衡",
					SmoothBuffer = "关闭",
				}
			},
		},
		settings = {
			--{
			--	name = "IconDistance",
			--	humanName = "图标距离",
			--	isNumberSetting = true,
			--	applyName = "UnitIconDist",
			--	minValue = 0,
			--	maxValue = 10000,
			--	springConversion = function(value)
			--		return value
			--	end,
			--},
			{
				name = "InterfaceScale",
				humanName = "游戏界面缩放",
				isNumberSetting = true,
				minValue = minUiScale,
				maxValue = maxUiScale,
				isPercent = true,
				applyFunction = function(value)
					if Spring.GetGameName() ~= "" then
						Spring.SendLuaUIMsg("SetInterfaceScale " .. value)
					end
					return {
						interfaceScale = value,
					}
				end,
			},
			{
				name = "MouseZoomSpeed",
				humanName = "鼠标缩放速度",
				isNumberSetting = true,
				applyName = "ScrollWheelSpeed",
				minValue = 1,
				maxValue = 500,
				springConversion = function(value)
					return value*invertZoomMult
				end,
			},
			{
				name = "InvertZoom",
				humanName = "反转缩放",
				options = {
					{
						name = "开启",
						applyFunction = function(_, conf)
							conf = conf or (WG.Chobby and WG.Chobby.Configuration)
							if not conf then
								return {}
							end
							invertZoomMult = 1
							local currentZoom = conf.settingsMenuValues["MouseZoomSpeed"] or 25
							return {
								ScrollWheelSpeed = currentZoom,
							}
						end
					},
					{
						name = "关闭",
						applyFunction = function(_, conf)
							conf = conf or (WG.Chobby and WG.Chobby.Configuration)
							if not conf then
								return {}
							end
							invertZoomMult = -1
							local currentZoom = conf.settingsMenuValues["MouseZoomSpeed"] or 25
							return {
								ScrollWheelSpeed = currentZoom * -1,
							}
						end
					},
				},
			},
			{
				name = "HardwareCursor",
				humanName = "硬件光标",
				options = {
					{
						name = "开启",
						apply = {
							HardwareCursor = 1,
						}
					},
					{
						name = "关闭",
						apply = {
							HardwareCursor = 0,
						}
					},
				},
			},
			{
				name = "TextToSpeech",
				humanName = "文字转语音",
				options = {
					{
						name = "开启",
						applyFunction = function(_, conf)
							conf = conf or (WG.Chobby and WG.Chobby.Configuration)
							if not conf then
								return {}
							end
							conf:SetConfigValue("enableTextToSpeech", true)
							return false
						end
					},
					{
						name = "关闭",
						applyFunction = function(_, conf)
							conf = conf or (WG.Chobby and WG.Chobby.Configuration)
							if not conf then
								return false
							end
							conf:SetConfigValue("enableTextToSpeech", false)
							return false
						end
					},
				},
			},
			{
				name = "EdgeScroll",
				humanName = "屏幕边缘滚动",
				options = {
					{
						name = "开启",
						apply = {
							FullscreenEdgeMove = 1,
							WindowedEdgeMove = 1,
						}
					},
					{
						name = "关闭",
						apply = {
							FullscreenEdgeMove = 0,
							WindowedEdgeMove = 0,
						}
					},
				},
			},
			{
				name = "CommandAlpha",
				humanName = "Command Line Alpha (%)",
				isNumberSetting = true,
				minValue = 10,
				maxValue = 100,
				applyFunction = UpdateCmdcolors
			},
			{
				name = "QueueIconAlpha",
				humanName = "Command Icon Alpha (%)",
				isNumberSetting = true,
				minValue = 10,
				maxValue = 100,
				applyFunction = UpdateCmdcolors
			},
			{
				name = "MiddlePanSpeed",
				humanName = "中键平移速度",
				isNumberSetting = true,
				minValue = 0,
				maxValue = 1000,
				applyFunction = function(value, conf)
					conf = conf or (WG.Chobby and WG.Chobby.Configuration)
					local camPan = 50
					if conf and conf.game_settings then
						camPan = conf.game_settings.OverheadScrollSpeed or camPan
					end
					value = value*(-1/200)
					return {
						MiddleClickScrollSpeed = value/camPan,
					}
				end,
			},
			{
				name = "CameraPanSpeed",
				humanName = "相机平移速度",
				isNumberSetting = true,
				minValue = 0,
				maxValue = 1000,
				applyFunction = function(value, conf)
					conf = conf or (WG.Chobby and WG.Chobby.Configuration)
					local middleScroll = 10
					if conf and conf.settingsMenuValues then
						middleScroll = conf.settingsMenuValues.MiddlePanSpeed or middleScroll
					end
					middleScroll = middleScroll*(-1/200)
					return {
						MiddleClickScrollSpeed = middleScroll/value,
						OverheadScrollSpeed = value,
						RotOverheadScrollSpeed = value,
						CamFreeScrollSpeed = value,
						FPSScrollSpeed = value,
					}
				end,
			},
			{
				name = "NetworkSettings",
				humanName = "网络连接",
				options = {
					{
						name = "可靠",
						apply = {
							NetworkLossFactor = 0,
							LinkOutgoingBandwidth = 65536,
							LinkIncomingSustainedBandwidth = 2048,
							LinkIncomingPeakBandwidth = 32768,
							LinkIncomingMaxPacketRate = 64,
						}
					},
					{
						name = "平衡",
						apply = {
							NetworkLossFactor = 1,
							LinkOutgoingBandwidth = 131072,
							LinkIncomingSustainedBandwidth = 65536,
							LinkIncomingPeakBandwidth = 65536,
							LinkIncomingMaxPacketRate = 512,
						}
					},
					{
						name = "快速",
						apply = {
							NetworkLossFactor = 2,
							LinkOutgoingBandwidth = 262144,
							LinkIncomingSustainedBandwidth = 262144,
							LinkIncomingPeakBandwidth = 262144,
							LinkIncomingMaxPacketRate = 2048,
						}
					},
				},
			},
			{
				name = "SmoothBuffer",
				humanName = "平滑缓冲",
				options = {
					{
						name = "开启",
						apply = {
							UseNetMessageSmoothingBuffer = 1,
						}
					},
					{
						name = "关闭",
						apply = {
							UseNetMessageSmoothingBuffer = 0,
						}
					},
				},
			},
			{
				name = "GcRate",
				humanName = "垃圾回收频率",
				options = {
					{
						name = "最高性能",
						apply = {
							LuaGarbageCollectionMemLoadMult = 1.7,
						}
					},
					{
						name = "较高性能",
						apply = {
							LuaGarbageCollectionMemLoadMult = 2.4,
						}
					},
					{
						name = "较高性能",
						apply = {
							LuaGarbageCollectionMemLoadMult = 3.2,
						}
					},
					{
						name = "推荐",
						apply = {
							LuaGarbageCollectionMemLoadMult = 4.5,
						}
					},
					{
						name = "较高稳定性",
						apply = {
							LuaGarbageCollectionMemLoadMult = 6,
						}
					},
					{
						name = "较高稳定性",
						apply = {
							LuaGarbageCollectionMemLoadMult = 8,
						}
					},
					{
						name = "最高稳定性",
						apply = {
							LuaGarbageCollectionMemLoadMult = 10,
						}
					},
				},
			},
			{
				name = "GcTimeMult",
				humanName = "垃圾回收时间倍率",
				options = {
					{
						name = "最高性能",
						apply = {
							LuaGarbageCollectionRunTimeMult = 1.4,
						}
					},
					{
						name = "Higher Performance",
						apply = {
							LuaGarbageCollectionRunTimeMult = 1.7,
						}
					},
					{
						name = "More Performance",
						apply = {
							LuaGarbageCollectionRunTimeMult = 2,
						}
					},
					{
						name = "推荐",
						apply = {
							LuaGarbageCollectionRunTimeMult = 3,
						}
					},
					{
						name = "较高稳定性",
						apply = {
							LuaGarbageCollectionRunTimeMult = 4,
						}
					},
					{
						name = "较高稳定性",
						apply = {
							LuaGarbageCollectionRunTimeMult = 5,
						}
					},
					{
						name = "最高稳定性",
						apply = {
							LuaGarbageCollectionRunTimeMult = 6,
						}
					},
				},
			},
			{
				name = "AtiIntelCompatibility_2",
				humanName = "ATI/Intel 兼容模式",
				options = {
					{
						name = "开启",
						applyFunction = function(_, conf)
							conf:UpdateFixedSettings(conf.AtiIntelSettingsOverride)
							Spring.Echo("Set ATI/intel/other non-nvidia compatibility state: Enabled")
							return
						end
					},
					{
						name = "自动",
						applyFunction = function(_, conf)
							if conf:GetIsNotRunningNvidia() then
								conf:UpdateFixedSettings(conf.AtiIntelSettingsOverride)
								Spring.Echo("Set ATI/intel/other non-nvidia compatibility state: Enabled (Automatic)")
								return
							end
							conf:UpdateFixedSettings()
							Spring.Echo("Set ATI/intel/other non-nvidia compatibility state: Disabled (Automatic)")
							return
						end
					},
					{
						name = "关闭",
						applyFunction = function(_, conf)
							conf:UpdateFixedSettings()
							Spring.Echo("Set ATI/intel/other non-nvidia compatibility state: Disabled")
							return
						end
					},
				},
			},
		},
	},
}

local settingsDefault = {
	WaterType_2 = "凹凸贴图",
	WaterQuality = "中",
	Shadows = "单位和地形",
	ShadowMapSize = "2048",
	ShadowDetail = "中",
	ParticleLimit = "15000",
	TerrainDetail = "中",
	SoftParticles = "启用",
	VegetationDetail = "中",
	FeatureFade = "关闭",
	CompatibilityMode = "关闭",
	AtiIntelCompatibility_2 = "自动",
	AntiAliasing = "低",
	VSync = "关闭",
	ShaderDetail = "中",
	LupsAirJet = "开启",
	LupsRibbon = "开启",
	LupsNanoParticles = "云",
	LupsShieldShader = "默认",
	LupsWaterSettings = "关闭",
	FancySky = "关闭",
	UseNewChili = "关闭",
	--IconDistance = 151,
	InterfaceScale = defaultUiScale,
	MouseZoomSpeed = 25,
	InvertZoom = "关闭",
	HardwareCursor = "开启",
	TextToSpeech = "开启",
	EdgeScroll = "开启",
	CommandAlpha = 60,
	QueueIconAlpha = 45,
	MiddlePanSpeed = 15,
	CameraPanSpeed = 50,
	NetworkSettings = "平衡",
	SmoothBuffer = "关闭",
	GcRate = "推荐",
	GcTimeMult = "推荐",
}

local settingsNames = {}
for i = 1, #settingsConfig do
	local subSettings = settingsConfig[i].settings
	for j = 1, #subSettings do
		local data = subSettings[j]
		settingsNames[data.name] = data
		if data.options then
			data.optionNames = {}
			for k = 1, #data.options do
				data.optionNames[data.options[k].name] = data.options[k]
			end
		end
	end
end

local function DefaultPresetFunc()
	local gameDefault = settingsConfig[2].presets[1].settings

	if Platform then
		local gpuMemorySize = Platform.gpuMemorySize or 0
		if gpuMemorySize == 0 then
			-- Apparently gpuMemorySize only exists on nvidia
			if Platform.glVersionShort and string.sub(Platform.glVersionShort or "3", 1, 1) ~= "3" then
				-- Medium
				Spring.Echo("Medium settings preset", Platform.glVersionShort)
				return Spring.Utilities.MergeTable(gameDefault, settingsConfig[1].presets[4].settings, true)
			else
				-- Default to Low
				Spring.Echo("Low settings preset", Platform.glVersionShort)
				return Spring.Utilities.MergeTable(gameDefault, settingsConfig[1].presets[3].settings, true)
			end
		else
			-- gpuMemorySize is in KB even though wiki claims MB.
			if gpuMemorySize < 1024*1024 then
				-- Minimal
				Spring.Echo("Minimal settings preset", gpuMemorySize)
				return Spring.Utilities.MergeTable(gameDefault, settingsConfig[1].presets[2].settings, true)
			elseif gpuMemorySize < 2048*1024 then
				-- Low
				Spring.Echo("Low settings preset", gpuMemorySize)
				return Spring.Utilities.MergeTable(gameDefault, settingsConfig[1].presets[3].settings, true)
			elseif gpuMemorySize == 2048*1024 then
				-- Medium
				Spring.Echo("Medium settings preset", gpuMemorySize)
				return Spring.Utilities.MergeTable(gameDefault, settingsConfig[1].presets[4].settings, true)
			else
				-- High
				Spring.Echo("High settings preset", gpuMemorySize)
				return Spring.Utilities.MergeTable(gameDefault, settingsConfig[1].presets[5].settings, true)
			end
		end
	end

	-- Default to Medium
	Spring.Echo("Medium settings preset", Platform, (Platform or {}).gpuMemorySize, (Platform or {}).glVersionShort)
	return Spring.Utilities.MergeTable(gameDefault, settingsConfig[1].presets[4].settings, true)
end

return settingsConfig, settingsNames, settingsDefault, DefaultPresetFunc
