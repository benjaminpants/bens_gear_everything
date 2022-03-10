
local S = minetest.get_translator()

bens_gear.add_rod({
	internal_name = "default_wooden",
	display_name = S("Wooden Rod"),
	item_name = "group:wood",
	color = "6C4913",
	uses_multiplier = 1,
	speed_multiplier = 1,
	damage_multiplier = 1,
	full_punch_interval_multiplier = 1,
	rod_main_texture = {"bens_gear_rod_def.png",true},
	flammable = true,
	rod_textures = {
		default_alias = "def", --what to append to the end of the default texture name, example: "bens_gear_rod_pick_" would become "bens_gear_rod_pick_def", custom tools might have their own texture varients
		--pickaxe = {"bens_gear_rod_pick_def",true} --use a custom rod for pickaxes, you can add more for other tools.
	}
})

bens_gear.add_rod({
	internal_name = "default_stone",
	display_name = S("Stone Rod"),
	item_name = "group:stone",
	color = "635F5D",
	uses_multiplier = 1.1,
	speed_multiplier = 1,
	damage_multiplier = 1,
	full_punch_interval_multiplier = 1,
	rod_main_texture = {"bens_gear_rod_def.png",true},
	flammable = false,
	rod_textures = {
		default_alias = "def", --what to append to the end of the default texture name, example: "bens_gear_rod_pick_" would become "bens_gear_rod_pick_def", custom tools might have their own texture varients
		--pickaxe = {"bens_gear_rod_pick_def",true} --use a custom rod for pickaxes, you can add more for other tools.
	}
})

bens_gear.add_rod({
	internal_name = "default_steel",
	display_name = S("Steel Rod"),
	item_name = "default:steel_ingot",
	color = "FFFFFF",
	uses_multiplier = 1.2,
	speed_multiplier = 1,
	damage_multiplier = 1,
	full_punch_interval_multiplier = 1,
	rod_main_texture = {"bens_gear_rod_def.png",true},
	flammable = false,
	rod_textures = {
		default_alias = "def", --what to append to the end of the default texture name, example: "bens_gear_rod_pick_" would become "bens_gear_rod_pick_def", custom tools might have their own texture varients
		--pickaxe = {"bens_gear_rod_pick_def",true} --use a custom rod for pickaxes, you can add more for other tools.
	}
})


bens_gear.add_rod({
	internal_name = "default_obsidian",
	display_name = S("Obsidian Rod"),
	item_name = "default:obsidian",
	color = "0F1219",
	uses_multiplier = 1.6,
	speed_multiplier = 2.7,
	damage_multiplier = 1.2,
	full_punch_interval_multiplier = 1.7,
	rod_main_texture = {"bens_gear_rod_def.png",true},
	flammable = false,
	rod_textures = {
		default_alias = "def", --what to append to the end of the default texture name, example: "bens_gear_rod_pick_" would become "bens_gear_rod_pick_def", custom tools might have their own texture varients
		--pickaxe = {"bens_gear_rod_pick_def",true} --use a custom rod for pickaxes, you can add more for other tools.
	}
})

bens_gear.add_rod({
	internal_name = "default_papyrus",
	display_name = S("Papyrus Rod"),
	item_name = "default:papyrus",
	color = "6B972A",
	uses_multiplier = 0.9,
	speed_multiplier = 0.9,
	damage_multiplier = 1,
	full_punch_interval_multiplier = 0.9,
	rod_main_texture = {"bens_gear_papyrus_rod.png",false},
	flammable = true,
	rod_textures = {
		default_alias = "def", --what to append to the end of the default texture name, example: "bens_gear_rod_pick_" would become "bens_gear_rod_pick_def", custom tools might have their own texture varients
		pickaxe = {"bens_gear_papyrus_rod_pick.png",false},
		shovel = {"bens_gear_papyrus_rod_shovel.png",false},
		axe = {"bens_gear_papyrus_rod_axe.png",false},
		sword = {"bens_gear_papyrus_rod_sword.png",false}
	}
})