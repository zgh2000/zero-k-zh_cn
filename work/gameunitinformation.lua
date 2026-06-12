local nameList = {
	"cloakcon",
	"staticmex",
	"energysolar",
	"energyfusion",
	"energysingu",
	"energywind",
	"energygeo",
	"energyheavygeo",
	"staticstorage",
	"energypylon",
	"staticcon",
	"staticrearm",
	"factoryshield",
	"shieldcon",
	"factorycloak",
	"cloakraid",
	"cloakheavyraid",
	"cloakskirm",
	"cloakriot",
	"cloakassault",
	"cloakarty",
	"cloaksnipe",
	"cloakaa",
	"cloakbomb",
	"cloakjammer",
	"staticjammer",
	"factoryveh",
	"vehcon",
	"factoryplane",
	"planecon",
	"factorygunship",
	"gunshipcon",
	"factoryhover",
	"hovercon",
	"factoryamph",
	"amphcon",
	"factoryspider",
	"spidercon",
	"factoryjump",
	"jumpcon",
	"factorytank",
	"tankcon",
	"striderhub",
	"striderantiheavy",
	"striderscorpion",
	"striderdante",
	"striderarty",
	"striderfunnelweb",
	"dronelight",
	"droneheavyslow",
	"striderbantha",
	"striderdetriment",
	"shipheavyarty",
	"shipcarrier",
	"dronecarry",
	"subtacmissile",
	"factoryship",
	"shipcon",
	"staticradar",
	"staticheavyradar",
	"staticshield",
	"shieldshield",
	"turretmissile",
	"turretlaser",
	"turretimpulse",
	"turretemp",
	"turretriot",
	"turretheavylaser",
	"turretgauss",
	"turretantiheavy",
	"turretheavy",
	"turrettorp",
	"turretaalaser",
	"turretaaclose",
	"turretaafar",
	"turretaaflak",
	"turretaaheavy",
	"staticantinuke",
	"staticarty",
	"staticheavyarty",
	"staticmissilesilo",
	"tacnuke",
	"seismic",
	"empmissile",
	"napalmmissile",
	"staticnuke",
	"mahlazer",
	"raveparty",
	"zenith",
	"athena",
	"spiderscout",
	"shieldraid",
	"hoverassault",
	"jumpskirm",
	"spiderskirm",
	"tankheavyraid",
	"vehheavyarty",
	"spiderantiheavy",
	"amphtele",
	"shipscout",
	"shiptorpraider",
	"subraider",
	"shipriot",
	"shipskirm",
	"shipassault",
	"shiparty",
	"shipaa",
	"tankraid",
	"tankriot",
	"tankassault",
	"tankheavyassault",
	"tankarty",
	"tankheavyarty",
	"tankaa",
	"jumpscout",
	"jumpraid",
	"jumpblackhole",
	"jumpassault",
	"jumpsumo",
	"jumparty",
	"jumpaa",
	"jumpbomb",
	"spiderassault",
	"spideremp",
	"spiderriot",
	"spidercrabe",
	"spideraa",
	"amphraid",
	"amphimpulse",
	"amphfloater",
	"amphriot",
	"amphassault",
	"amphaa",
	"hoverraid",
	"hoverskirm",
	"hoverdepthcharge",
	"hoverriot",
	"hoverarty",
	"hoveraa",
	"gunshipbomb",
	"gunshipemp",
	"gunshipraid",
	"gunshipskirm",
	"gunshipheavyskirm",
	"gunshipassault",
	"gunshipkrow",
	"gunshipaa",
	"gunshiptrans",
	"gunshipheavytrans",
	"planefighter",
	"planeheavyfighter",
	"bomberprec",
	"bomberriot",
	"bomberdisarm",
	"bomberheavy",
	"bomberstrike",
	"bomberassault",
	"planescout",
	"vehscout",
	"vehraid",
	"vehsupport",
	"vehriot",
	"vehassault",
	"vehcapture",
	"veharty",
	"wolverine_mine",
	"vehaa",
	"shieldscout",
	"shieldskirm",
	"shieldassault",
	"shieldriot",
	"shieldfelon",
	"shieldarty",
	"shieldaa",
	"shieldbomb",
	"amphlaunch",
	"hoverheavyraid",
	"missileslow",
}

local categories = {
	cloak = {
		name = "隐形机器人",
		order = 1,
	},
	shield = {
		name = "护盾机器人",
		order = 2,
	},
	veh = {
		name = "漫游车",
		order = 3,
	},
	tank = {
		name = "坦克",
		order = 4,
	},
	hover = {
		name = "悬浮车",
		order = 5,
	},
	amph = {
		name = "两栖机器人",
		order = 6,
	},
	jump = {
		name = "跳跃机器人",
		order = 7,
	},
	spider = {
		name = "机械蜘蛛",
		order = 8,
	},
	gunship = {
		name = "炮艇",
		order = 9,
	},
	plane = {
		name = "飞机",
		order = 10,
	},
	ship = {
		name = "舰船",
		order = 11,
	},
	strider = {
		name = "巨神兵",
		order = 12,
	},
	econ = {
		name = "经济",
		order = 13,
	},
	defence = {
		name = "防御",
		order = 14,
	},
	special = {
		name = "特殊",
		order = 15,
	},
	missilesilo = {
		name = "导弹发射井",
		order = 16,
	},
	drone = {
		name = "无人机",
		order = 17,
	},
}

local humanNames = {
	-- Cloak
	factorycloak = {
		category = "cloak",
		order = 1,
		description = "生产隐形机器人，建造速度10 m/s",
		humanName = "隐形机器人工厂",
	},
	cloakcon = {
		category = "cloak",
		order = 2,
		description = "隐形工程机器人，建造速度5 m/s",
		humanName = "术士",
	},
	cloakraid = {
		category = "cloak",
		order = 3,
		description = "轻型突袭机器人",
		humanName = "长刀",
	},
	cloakheavyraid = {
		category = "cloak",
		order = 4,
		description = "隐形突袭机器人",
		humanName = "镰刀",
	},
	cloakskirm = {
		category = "cloak",
		order = 5,
		description = "游击机器人（直射）",
		humanName = "浪人",
	},
	cloakriot = {
		category = "cloak",
		order = 6,
		description = "防暴机器人",
		humanName = "掠夺者",
	},
	cloakassault = {
		category = "cloak",
		order = 7,
		description = "闪电突击机器人",
		humanName = "骑士",
	},
	cloakarty = {
		category = "cloak",
		order = 8,
		description = "轻型火炮机器人",
		humanName = "弹弓",
	},
	cloaksnipe = {
		category = "cloak",
		order = 9,
		description = "隐形游击/反重型火炮机器人",
		humanName = "幽灵",
	},
	cloakaa = {
		category = "cloak",
		order = 10,
		description = "隐形防空机器人",
		humanName = "小妖精",
	},
	cloakbomb = {
		category = "cloak",
		order = 11,
		description = "全地形EMP炸弹（潜伏）",
		humanName = "小鬼",
	},
	cloakjammer = {
		category = "cloak",
		order = 12,
		description = "区域隐形/干扰步行者",
		humanName = "虹膜",
	},

	-- Shield
	factoryshield = {
		category = "shield",
		order = 1,
		description = "生产坚固机器人，建造速度10 m/s",
		humanName = "护盾机器人工厂",
	},
	shieldcon = {
		category = "shield",
		order = 2,
		description = "护盾工程机器人，建造速度5 m/s",
		humanName = "罪犯",
	},
	shieldraid = {
		category = "shield",
		order = 3,
		description = "中轻型突袭机器人",
		humanName = "强盗",
	},
	shieldscout = {
		category = "shield",
		order = 4,
		description = "土箱",
		humanName = "脏袋子",
	},
	shieldskirm = {
		category = "shield",
		order = 5,
		description = "游击机器人（间接火力）",
		humanName = "流氓",
	},
	shieldriot = {
		category = "shield",
		order = 6,
		description = "防暴机器人",
		humanName = "亡命徒",
	},
	shieldassault = {
		category = "shield",
		order = 7,
		description = "护盾突击机器人",
		humanName = "暴徒",
	},
	shieldfelon = {
		category = "shield",
		order = 8,
		description = "护盾防暴/游击机器人",
		humanName = "重罪犯",
	},
	shieldarty = {
		category = "shield",
		order = 9,
		description = "解除武装火炮",
		humanName = "勒索者",
	},
	shieldaa = {
		category = "shield",
		order = 10,
		description = "防空机器人",
		humanName = "破坏者",
	},
	shieldbomb = {
		category = "shield",
		order = 11,
		description = "爬行炸弹（潜伏）",
		humanName = "告密者",
	},
	shieldshield = {
		category = "shield",
		order = 12,
		description = "区域护盾步行者",
		humanName = "盾牌",
	},

	-- Vehicle
	factoryveh = {
		category = "veh",
		order = 1,
		description = "生产轻型轮式车辆，建造速度10 m/s",
		humanName = "漫游车装配厂",
	},
	vehcon = {
		category = "veh",
		order = 2,
		description = "工程漫游车，建造速度5 m/s",
		humanName = "石匠",
	},
	vehscout = {
		category = "veh",
		order = 3,
		description = "干扰突袭/侦察漫游车",
		humanName = "飞镖",
	},
	vehraid = {
		category = "veh",
		order = 4,
		description = "突袭漫游车",
		humanName = "灼烧者",
	},
	vehsupport = {
		category = "veh",
		order = 5,
		description = "可部署导弹漫游车（需停下才能开火）",
		humanName = "击剑手",
	},
	vehriot = {
		category = "veh",
		order = 6,
		description = "防暴漫游车",
		humanName = "撕裂者",
	},
	vehassault = {
		category = "veh",
		order = 7,
		description = "突击漫游车",
		humanName = "掠夺者",
	},
	veharty = {
		category = "veh",
		order = 8,
		description = "火炮布雷漫游车",
		humanName = "獾式",
	},
	vehheavyarty = {
		category = "veh",
		order = 9,
		description = "精确火炮漫游车",
		humanName = "穿刺者",
	},
	vehaa = {
		category = "veh",
		order = 10,
		description = "快速防空漫游车",
		humanName = "撞击者",
	},
	vehcapture = {
		category = "veh",
		order = 11,
		description = "俘获漫游车",
		humanName = "支配者",
	},

	-- Tank
	factorytank = {
		category = "tank",
		order = 1,
		description = "生产重型履带车辆，建造速度10 m/s",
		humanName = "坦克工厂",
	},
	tankcon = {
		category = "tank",
		order = 2,
		description = "武装工程坦克，建造速度7.5 m/s",
		humanName = "焊接者",
	},
	tankraid = {
		category = "tank",
		order = 4,
		description = "突袭坦克",
		humanName = "小太刀",
	},
	tankheavyraid = {
		category = "tank",
		order = 3,
		description = "闪电突击/突袭坦克",
		humanName = "闪电",
	},
	tankriot = {
		category = "tank",
		order = 5,
		description = "重型防暴支援坦克",
		humanName = "食人魔",
	},
	tankassault = {
		category = "tank",
		order = 6,
		description = "突击坦克",
		humanName = "牛头人",
	},
	tankheavyassault = {
		category = "tank",
		order = 7,
		description = "超重型坦克杀手",
		humanName = "独眼巨人",
	},
	tankarty = {
		category = "tank",
		order = 8,
		description = "通用火炮",
		humanName = "使者",
	},
	tankheavyarty = {
		category = "tank",
		order = 9,
		description = "重型饱和火炮坦克",
		humanName = "震颤者",
	},
	tankaa = {
		category = "tank",
		order = 10,
		description = "高射炮防空坦克",
		humanName = "双头巨人",
	},

	-- Hover
	factoryhover = {
		category = "hover",
		order = 1,
		description = "生产悬浮车，建造速度10 m/s",
		humanName = "悬浮车平台",
	},
	hovercon = {
		category = "hover",
		order = 2,
		description = "工程悬浮车，建造速度5 m/s",
		humanName = "豪猪",
	},
	hoverraid = {
		category = "hover",
		order = 3,
		description = "快速攻击悬浮车",
		humanName = "匕首",
	},
	hoverskirm = {
		category = "hover",
		order = 4,
		description = "游击/反重型悬浮车",
		humanName = "手术刀",
	},
	hoverriot = {
		category = "hover",
		order = 5,
		description = "防暴悬浮车",
		humanName = "钉锤",
	},
	hoverassault = {
		category = "hover",
		order = 6,
		description = "突破封锁悬浮车",
		humanName = "戟",
	},
	hoverarty = {
		category = "hover",
		order = 7,
		description = "反重型火炮悬浮车",
		humanName = "长矛",
	},
	hoveraa = {
		category = "hover",
		order = 8,
		description = "防空悬浮车",
		humanName = "连枷",
	},
	hoverdepthcharge = {
		category = "hover",
		order = 9,
		description = "反潜悬浮车",
		humanName = "阔剑",
	},
    hoverheavyraid = {
		category = "hover",
		order = 10,
		description = "干扰悬浮车",
		humanName = "流星锤",
	},
	-- Amph
	factoryamph = {
		category = "amph",
		order = 1,
		description = "生产两栖机器人，建造速度10 m/s",
		humanName = "两栖机器人工厂",
	},
	amphcon = {
		category = "amph",
		order = 2,
		description = "两栖工程机器人，建造速度7.5 m/s",
		humanName = "海螺",
	},
	amphraid = {
		category = "amph",
		order = 3,
		description = "两栖突袭机器人（反潜）",
		humanName = "鸭子",
	},
	amphimpulse = {
		category = "amph",
		order = 4,
		description = "两栖突袭/防暴机器人",
		humanName = "弓箭手",
	},
	amphriot = {
		category = "amph",
		order = 5,
		description = "两栖防暴机器人（反潜）",
		humanName = "扇贝",
	},
	amphfloater = {
		category = "amph",
		order = 6,
		description = "重型两栖游击机器人",
		humanName = "浮标",
	},
	amphassault = {
		category = "amph",
		order = 7,
		description = "重型两栖突击步行者",
		humanName = "灰熊",
	},
    amphsupport = {
		category = "amph",
		order = 8,
		description = "可部署两栖火力支援（需停下才能开火）",
		humanName = "舱壁",
	},
	amphlaunch = {
		category = "amph",
		order = 9,
		description = "两栖发射机器人",
		humanName = "龙虾",
	},
	amphaa = {
		category = "amph",
		order = 10,
		description = "两栖防空机器人",
		humanName = "灯笼鱼",
	},
	amphbomb = {
		category = "amph",
		order = 11,
		description = "两栖减速炸弹",
		humanName = "帽贝",
	},
	amphtele = {
		category = "amph",
		order = 12,
		description = "两栖传送桥",
		humanName = "灯神",
	},
    
	-- Jump
	factoryjump = {
		category = "jump",
		order = 1,
		description = "生产装备跳跃喷射的机器人，建造速度10 m/s",
		humanName = "跳跃机器人工厂",
	},
	jumpcon = {
		category = "jump",
		order = 2,
		description = "跳跃工程机器人，建造速度5 m/s",
		humanName = "警官",
	},
	jumpscout = {
		category = "jump",
		order = 3,
		description = "行走导弹",
		humanName = "幼犬",
	},
	jumpraid = {
		category = "jump",
		order = 4,
		description = "突袭/防暴跳跃者",
		humanName = "纵火者",
	},
	jumpskirm = {
		category = "jump",
		order = 5,
		description = "干扰游击步行者",
		humanName = "调节器",
	},
	jumpblackhole = {
		category = "jump",
		order = 6,
		description = "黑洞发射器",
		humanName = "占位符",
	},
	jumpassault = {
		category = "jump",
		order = 7,
		description = "近战突击跳跃者",
		humanName = "千斤顶",
	},
	jumpsumo = {
		category = "jump",
		order = 8,
		description = "重型防暴跳跃者",
		humanName = "杂耍者",
	},
	jumparty = {
		category = "jump",
		order = 9,
		description = "饱和火炮步行者",
		humanName = "火行者",
	},
	jumpaa = {
		category = "jump",
		order = 10,
		description = "重型防空跳跃者",
		humanName = "蟾蜍",
	},
	jumpbomb = {
		category = "jump",
		order = 11,
		description = "隐形跳跃反重型炸弹",
		humanName = "跳蚤",
	},

	-- Spider
	factoryspider = {
		category = "spider",
		order = 1,
		description = "生产机械蜘蛛，建造速度10 m/s",
		humanName = "机械蜘蛛工厂",
	},
	spidercon = {
		category = "spider",
		order = 2,
		description = "工程机械蜘蛛，建造速度7.5 m/s",
		humanName = "织网者",
	},
	spiderscout = {
		category = "spider",
		order = 3,
		description = "超轻侦察机械蜘蛛（潜伏）",
		humanName = "跳蚤",
	},
	spideremp = {
		category = "spider",
		order = 4,
		description = "闪电防暴机械蜘蛛",
		humanName = "毒液",
	},
	spiderriot = {
		category = "spider",
		order = 5,
		description = "防暴机械蜘蛛",
		humanName = "红背蛛",
	},
	spiderskirm = {
		category = "spider",
		order = 6,
		description = "游击机械蜘蛛（间接火力）",
		humanName = "隐士",
	},
	spiderassault = {
		category = "spider",
		order = 7,
		description = "全地形突击机器人",
		humanName = "隐居者",
	},
	spidercrabe = {
		category = "spider",
		order = 8,
		description = "重型防暴/游击机械蜘蛛 - 静止时蜷缩成装甲形态",
		humanName = "螃蟹",
	},
	spideraa = {
		category = "spider",
		order = 9,
		description = "防空机械蜘蛛",
		humanName = "狼蛛",
	},
	spiderantiheavy = {
		category = "spider",
		order = 10,
		description = "隐形侦察/反重型",
		humanName = "寡妇",
	},

	-- Gunship
	factorygunship = {
		category = "gunship",
		order = 1,
		description = "生产炮艇，建造速度10 m/s",
		humanName = "炮艇工厂",
	},
	gunshipcon = {
		category = "gunship",
		order = 2,
		description = "重型工程飞机，建造速度7.5 m/s",
		humanName = "黄蜂",
	},
	gunshipemp = {
		category = "gunship",
		order = 3,
		description = "反重型EMP无人机",
		humanName = "蚊子",
	},
	gunshipraid = {
		category = "gunship",
		order = 4,
		description = "突袭炮艇",
		humanName = "蝗虫",
	},
	gunshipskirm = {
		category = "gunship",
		order = 5,
		description = "多用途支援炮艇",
		humanName = "鹰身女妖",
	},
	gunshipheavyskirm = {
		category = "gunship",
		order = 6,
		description = "火力支援炮艇",
		humanName = "雨云",
	},
	gunshipassault = {
		category = "gunship",
		order = 7,
		description = "重型突袭/突击炮艇",
		humanName = "亡魂",
	},
	gunshipkrow = {
		category = "gunship",
		order = 8,
		description = "飞行堡垒",
		humanName = "乌鸦",
	},
	gunshipaa = {
		category = "gunship",
		order = 9,
		description = "防空炮艇",
		humanName = "三叉戟",
	},
	gunshipbomb = {
		category = "gunship",
		order = 10,
		description = "飞行炸弹（潜伏）",
		humanName = "爆翼",
	},
	gunshiptrans = {
		category = "gunship",
		order = 11,
		description = "空运运输机",
		humanName = "卡戎",
	},
	gunshipheavytrans = {
		category = "gunship",
		order = 12,
		description = "武装重型空运运输机",
		humanName = "大力神",
	},

	-- Plane
	factoryplane = {
		category = "plane",
		order = 1,
		description = "生产飞机，建造速度10 m/s",
		humanName = "飞机工厂",
	},
	planecon = {
		category = "plane",
		order = 2,
		description = "工程飞机，建造速度5 m/s",
		humanName = "鹤",
	},
	planefighter = {
		category = "plane",
		order = 3,
		description = "多用途战斗机",
		humanName = "雨燕",
	},
	planeheavyfighter = {
		category = "plane",
		order = 4,
		description = "空优战斗机",
		humanName = "猛禽",
	},
	bomberstrike = {
		category = "plane",
		order = 5,
		description = "战术攻击轰炸机",
		humanName = "喜鹊",
	},
	bomberprec = {
		category = "plane",
		order = 6,
		description = "精确轰炸机",
		humanName = "渡鸦",
	},
	bomberriot = {
		category = "plane",
		order = 7,
		description = "饱和凝固汽油弹轰炸机",
		humanName = "凤凰",
	},
	bomberdisarm = {
		category = "plane",
		order = 8,
		description = "解除武装闪电轰炸机",
		humanName = "雷鸟",
	},
	bomberassault = {
		category = "plane",
		order = 9,
		description = "重型突击/多用途轰炸机（反静态）",
		humanName = "奥丁",
	},
	bomberheavy = {
		category = "plane",
		order = 10,
		description = "奇点轰炸机",
		humanName = "利赫",
	},
	planelightscout = {
		category = "plane",
		order = 12,
		description = "轻型侦察/区域干扰机",
		humanName = "麻雀",
	},
	planescout = {
		category = "plane",
		order = 10,
		description = "雷达/声纳侦察机",
		humanName = "猫头鹰",
	},

	-- Ship
	factoryship = {
		category = "ship",
		order = 1,
		description = "生产海军单位，建造速度10 m/s",
		humanName = "舰船厂",
	},
	shipcon = {
		category = "ship",
		order = 2,
		description = "工程舰船，建造速度7.5 m/s",
		humanName = "水手",
	},
	shipscout = {
		category = "ship",
		order = 3,
		description = "哨戒舰（解除武装侦察）",
		humanName = "快艇",
	},
	shiptorpraider = {
		category = "ship",
		order = 4,
		description = "鱼雷艇（突袭）",
		humanName = "猎人",
	},
	subraider = {
		category = "ship",
		order = 5,
		description = "攻击潜艇（隐形突袭）",
		humanName = "海狼",
	},
	shipskirm = {
		category = "ship",
		order = 6,
		description = "火箭艇（游击）",
		humanName = "密斯特拉尔",
	},
	shipriot = {
		category = "ship",
		order = 7,
		description = "护卫舰（突袭/防暴）",
		humanName = "海盗",
	},
	shipassault = {
		category = "ship",
		order = 8,
		description = "驱逐舰（防暴/突击）",
		humanName = "海妖",
	},
	shiparty = {
		category = "ship",
		order = 9,
		description = "巡洋舰（火炮）",
		humanName = "使者",
	},
	shipaa = {
		category = "ship",
		order = 10,
		description = "防空护卫舰",
		humanName = "西风",
	},

	-- Strider
	striderhub = {
		category = "strider",
		order = 1,
		description = "建造巨神兵，建造速度10 m/s",
		humanName = "巨神兵中心",
	},
	athena = {
		category = "strider",
		order = 2,
		description = "空降特种工程兵，建造速度7.5 m/s",
		humanName = "雅典娜",
	},
	striderantiheavy = {
		category = "strider",
		order = 3,
		description = "隐形反重型/反巨神兵步行者",
		humanName = "最后通牒",
	},
	striderscorpion = {
		category = "strider",
		order = 4,
		description = "隐形渗透巨神兵",
		humanName = "蝎子",
	},
	striderdante = {
		category = "strider",
		order = 5,
		description = "突击/防暴巨神兵",
		humanName = "但丁",
	},
	striderarty = {
		category = "strider",
		order = 6,
		description = "重型饱和火炮巨神兵",
		humanName = "梅林",
	},
	striderfunnelweb = {
		category = "strider",
		order = 7,
		description = "无人机/护盾支援巨神兵",
		humanName = "漏斗网蛛",
	},
	striderbantha = {
		category = "strider",
		order = 8,
		description = "远程支援巨神兵",
		humanName = "圣骑士",
	},
	striderdetriment = {
		category = "strider",
		order = 9,
		description = "终极突击巨神兵",
		humanName = "损害",
	},
	subtacmissile = {
		category = "strider",
		order = 10,
		description = "战术核弹潜艇，消耗20 m/s，30秒充能",
		humanName = "斯库拉",
	},
	shipcarrier = {
		category = "strider",
		order = 11,
		description = "航空母舰（轰炸），以10 m/s速度充能战术核弹",
		humanName = "礁石",
	},
	shipheavyarty = {
		category = "strider",
		order = 12,
		description = "战列舰（重型火炮）",
		humanName = "将军",
	},

	-- Econ
	staticmex = {
		category = "econ",
		order = 1,
		description = "生产金属",
		humanName = "金属提取器",
	},
	energywind = {
		category = "econ",
		order = 2,
		description = "小型发电站",
		humanName = "风力/潮汐发电机",
	},
	energysolar = {
		category = "econ",
		order = 3,
		description = "小型发电站（+2）",
		humanName = "太阳能收集器",
	},
	energygeo = {
		category = "econ",
		order = 4,
		description = "中型发电站（+25）",
		humanName = "地热发电机",
	},
	energyfusion = {
		category = "econ",
		order = 5,
		description = "中型发电站（+35）",
		humanName = "聚变反应堆",
	},
	energyheavygeo = {
		category = "econ",
		order = 6,
		description = "大型发电站（+100）- 危险",
		humanName = "高级地热",
	},
	energysingu = {
		category = "econ",
		order = 7,
		description = "大型发电站（+225）- 危险",
		humanName = "奇点反应堆",
	},
	energypylon = {
		category = "econ",
		order = 8,
		description = "扩展过载电网",
		humanName = "能量塔",
	},
	staticstorage = {
		category = "econ",
		order = 9,
		description = "储存金属和能量（500）",
		humanName = "仓库",
	},
	staticcon = {
		category = "econ",
		order = 10,
		description = "建筑助手，建造速度10 m/s",
		humanName = "看护者",
	},
	staticrearm = {
		category = "econ",
		order = 11,
		description = "维修和重新武装飞机，每个停机坪维修速度2.5 e/s",
		humanName = "停机坪",
	},

	-- Defence
	turretlaser = {
		category = "defence",
		order = 1,
		description = "轻型激光塔",
		humanName = "莲花",
	},
	turretmissile = {
		category = "defence",
		order = 2,
		description = "轻型导弹塔",
		humanName = "哨所",
	},
	turretriot = {
		category = "defence",
		order = 3,
		description = "反蜂群炮塔",
		humanName = "星尘",
	},
	turretemp = {
		category = "defence",
		order = 4,
		description = "EMP炮塔",
		humanName = "法拉第",
	},
	turretgauss = {
		category = "defence",
		order = 5,
		description = "高斯炮塔，关闭时10点生命值/秒",
		humanName = "高斯",
	},
	turretheavylaser = {
		category = "defence",
		order = 6,
		description = "高能激光塔",
		humanName = "毒刺",
	},
	turretaalaser = {
		category = "defence",
		order = 7,
		description = "硬化防空激光",
		humanName = "剃刀",
	},
	turretaaclose = {
		category = "defence",
		order = 8,
		description = "爆发防空炮塔",
		humanName = "钢锯",
	},
	turretaaflak = {
		category = "defence",
		order = 9,
		description = "防空高射炮",
		humanName = "脱粒机",
	},
	turretaafar = {
		category = "defence",
		order = 10,
		description = "远程防空导弹电池",
		humanName = "电锯",
	},
	turretaaheavy = {
		category = "defence",
		order = 11,
		description = "超远程防空导弹塔",
		humanName = "阿尔忒弥斯",
	},
	turretimpulse = {
		category = "defence",
		order = 12,
		description = "引力炮塔",
		humanName = "牛顿",
	},
	turrettorp = {
		category = "defence",
		order = 13,
		description = "鱼雷发射器",
		humanName = "海胆",
	},
	turretheavy = {
		category = "defence",
		order = 14,
		description = "中程防御堡垒 - 需要连接50能量电网",
		humanName = "毁灭者",
	},
	turretantiheavy = {
		category = "defence",
		order = 15,
		description = "超光速投射器 - 需要连接50能量电网",
		humanName = "路西法",
	},
	staticshield = {
		category = "defence",
		order = 16,
		description = "区域护盾",
		humanName = "神盾",
	},

	-- Special
	staticradar = {
		category = "special",
		order = 1,
		description = "预警系统",
		humanName = "雷达塔",
	},
	staticjammer = {
		category = "special",
		order = 2,
		description = "区域隐形/干扰器",
		humanName = "角膜",
	},
	staticheavyradar = {
		category = "special",
		order = 3,
		description = "远程雷达",
		humanName = "高级雷达",
	},
	staticantinuke = {
		category = "special",
		order = 4,
		description = "战略核弹拦截系统",
		humanName = "反核",
	},
	staticarty = {
		category = "special",
		order = 5,
		description = "等离子火炮电池 - 需要连接50能量电网",
		humanName = "地狱犬",
	},
	staticheavyarty = {
		category = "special",
		order = 6,
		description = "战略等离子炮",
		humanName = "大贝莎",
	},
	staticnuke = {
		category = "special",
		order = 7,
		description = "战略核弹发射器，消耗18 m/s，3分钟充能",
		humanName = "三位一体",
	},
	zenith = {
		category = "special",
		order = 8,
		description = "陨石控制器",
		humanName = "天顶",
	},
	raveparty = {
		category = "special",
		order = 9,
		description = "毁灭彩虹投射器",
		humanName = "迪斯科狂欢",
	},
	mahlazer = {
		category = "special",
		order = 10,
		description = "行星能量雕刻器",
		humanName = "星光",
	},

	-- Missile Silo
	staticmissilesilo = {
		category = "missilesilo",
		order = 1,
		description = "生产战术导弹，建造速度10 m/s",
		humanName = "导弹发射井",
	},
	tacnuke = {
		category = "missilesilo",
		order = 2,
		description = "战术核弹",
		humanName = "黎明",
	},
	seismic = {
		category = "missilesilo",
		order = 2,
		description = "地震导弹",
		humanName = "地震",
	},
	empmissile = {
		category = "missilesilo",
		order = 3,
		description = "EMP导弹",
		humanName = "肖克利",
	},
	napalmmissile = {
		category = "missilesilo",
		order = 4,
		description = "凝固汽油弹导弹",
		humanName = "炼狱",
	},
	missileslow = {
		category = "missilesilo",
		order = 5,
		description = "减速制导导弹",
		humanName = "芝诺",
	},

	-- Drone
	wolverine_mine = {
		category = "drone",
		order = 1,
		description = "獾式地雷",
		humanName = "利爪",
	},
	dronelight = {
		category = "drone",
		order = 2,
		description = "攻击无人机",
		humanName = "萤火虫",
	},
	droneheavyslow = {
		category = "drone",
		order = 3,
		description = "高级战斗无人机",
		humanName = "毒蛇",
	},
	dronecarry = {
		category = "drone",
		order = 4,
		description = "航母无人机",
		humanName = "海鸥",
	},
}

--------- To Generate ------------
--[[
local inNameList = {}
local nameList = {}
local carrierDefs = VFS.Include("LuaRules/Configs/drone_defs.lua")
local function AddUnit(unitName)
	if inNameList[unitName] then
		return
	end
	inNameList[unitName] = true
	nameList[#nameList + 1] = unitName

	local ud = UnitDefNames[unitName]
	if ud.buildOptions then
		for i = 1, #ud.buildOptions do
			AddUnit(UnitDefs[ud.buildOptions[i] ].name)
		end
	end

	if ud.customParams.morphto then
		AddUnit(ud.customParams.morphto)
	end

	if ud.weapons then
		for i = 1, #ud.weapons do
			local wd = WeaponDefs[ud.weapons[i].weaponDef]
			if wd and wd.customParams and wd.customParams.spawns_name then
				AddUnit(wd.customParams.spawns_name)
			end
		end
	end

	if carrierDefs[ud.id] then
		local data = carrierDefs[ud.id]
		for i = 1, #data do
			local droneUnitDefID = data[i].drone
			if droneUnitDefID and UnitDefs[droneUnitDefID] then
				AddUnit(UnitDefs[droneUnitDefID].name)
			end
		end
	end
end

local function GenerateLists()
	AddUnit("cloakcon")
	local humanNames = {}
	for i = 1, #nameList do
		humanNames[nameList[i] ] = {
			humanName = UnitDefNames[nameList[i] ].humanName,
			description = UnitDefNames[nameList[i] ].tooltip,
		}
	end
	Spring.Echo(Spring.Utilities.TableToString(nameList, "nameList"))
	Spring.Echo(Spring.Utilities.TableToString(humanNames, "humanNames"))
end

GenerateLists()
--]]

local function UnitOrder(name1, name2)
	local data1 = name1 and humanNames[name1]
	local data2 = name1 and humanNames[name2]
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

return {
	nameList = nameList,
	humanNames = humanNames,
	categories = categories,
	UnitOrder = UnitOrder,
}
