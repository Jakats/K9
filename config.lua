K9Config = {}
K9Config = setmetatable(K9Config, {})

-- Restricts the dog to getting into certain vehicles
K9Config.VehicleRestriction = false
K9Config.VehiclesList = {
	
}

K9Config.OpenDoorsOnSearch = true

-- Used for Random Search Type --
K9Config.Items = {
	"joint",
	"cokebaggy",
	"crack_baggy",
	"xtcbaggy",
	"weed_white-widow",
	"weed_skunk",
	"weed_purple-haze",
	"weed_og-kush",
	"weed_amnesia",
	"weed_ak47",
	"weed_brick",
	"coke_brick",
	"coke_small_brick",
	"puremeth",
	"meth"
}

-- Language --
K9Config.LanguageChoice = "English"
K9Config.Languages = {
	["English"] = {
		follow = "Come",
		stop = "Heel",
		attack = "Bite",
		enter = "In",
		exit = "Out"
	}
}