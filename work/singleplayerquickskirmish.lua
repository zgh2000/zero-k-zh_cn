
local AiPrefixFunc = VFS.Include(LUA_DIRNAME .. "configs/gameConfig/zk/aiPrefixFunc.lua")

local skirmishSetupData = {
	pages = {
		{
			humanName = "选择游戏类型",
			name = "gameType",
			options = {
				"1v1",
				"2v2",
				"3v3",
				"生存模式",
			},
		},
		{
			humanName = "选择难度",
			name = "difficulty",
			options = {
				"新手",
				"初学者",
				"简单",
				"普通",
				"困难",
				"残酷",
			},
			optionTooltip = {
				"Recommended for players with no strategy game experience.",
				"Recommended for players with some strategy game experience, or experience with related genres (such as MOBA).",
				"Recommended for experienced strategy gamers with some familiarity with streaming economy.",
				"Recommended for veteran strategy gamers.",
				"Recommended for veteran strategy gamers who aren't afraid of losing.",
				"Recommended for veterans of Zero-K.",
			}
		},
		{
			humanName = "选择地图",
			name = "map",
			tipText = "点击'高级'查看更多地图和游戏模式。",
			minimap = true,
			options = {
				"TitanDuel 2.2",
				"Obsidian_1.5",
				"Fairyland 1.31",
				"Calamity 1.1",
			},
		},
	},
}

local chickenDifficulty = {
	"鸡模式: 新手",
	"鸡模式: 非常简单",
	"鸡模式: 简单",
	"鸡模式: 普通",
	"鸡模式: 困难",
	"鸡模式: 自杀",
}

local aiDifficultyMap = {
	"CircuitAIBeginner",
	"CircuitAINovice",
	"CircuitAIEasy",
	"CircuitAINormal",
	"CircuitAIHard",
	"CircuitAIBrutal",
}

function skirmishSetupData.ApplyFunction(battleLobby, pageChoices)
	local difficulty = pageChoices.difficulty or 2 -- easy is default
	local gameType = pageChoices.gameType or 1
	local map = pageChoices.map or 1

	local Configuration = WG.Chobby.Configuration
	local pageConfig = skirmishSetupData.pages
	battleLobby:SelectMap(pageConfig[3].options[map])

	battleLobby:SetBattleStatus({
		allyNumber = 0,
		isSpectator = false,
	})

	-- Chickens
	if gameType == 4 then
		battleLobby:AddAi(chickenDifficulty[difficulty], chickenDifficulty[difficulty], 1)
		return
	end

	local bitAppend = (Configuration:GetIsRunning64Bit() and "64") or "32"
	local aiName = AiPrefixFunc() .. aiDifficultyMap[difficulty] .. bitAppend
	local displayName = aiName

	if Configuration.gameConfig.GetAiSimpleName then
		local betterName = Configuration.gameConfig.GetAiSimpleName(displayName)
		if betterName then
			displayName = betterName
		end
	end

	-- AI game
	local aiNumber = 1
	local allies = gameType - 1
	for i = 1, allies do
		battleLobby:AddAi(displayName .. " (" .. aiNumber .. ")", aiName, 0, Configuration.gameConfig.aiVersion)
		aiNumber = aiNumber + 1
	end

	local enemies = gameType
	for i = 1, enemies do
		battleLobby:AddAi(displayName .. " (" .. aiNumber .. ")", aiName, 1, Configuration.gameConfig.aiVersion)
		aiNumber = aiNumber + 1
	end
end

return skirmishSetupData
