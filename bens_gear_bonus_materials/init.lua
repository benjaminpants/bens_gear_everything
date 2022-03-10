
local S = minetest.get_translator()

local default_path = minetest.get_modpath("bens_gear_bonus_materials")

bens_gear.add_ore({
	internal_name = "default_obsidian",
	display_name = S("Obsidian"),
	item_name = "default:obsidian",
	max_drop_level = 3,
	damage_groups_any = {fleshy=3},
	damage_groups_sword = {fleshy=9},
	damage_groups_axe = {fleshy=8},
	full_punch_interval = 2,
	uses = 50,
	flammable = false,
	groupcaps = { --the groupcaps for the tool. durability is typically used instead of "uses" so there is no need to define it
		crumbly = {times={[1]=1.10 * 3.3, [2]=0.50 * 3.2, [3]=0.30 * 3.1}, maxlevel=3},
		cracky = {times={[1]=2.0 * 3.3, [2]=1.0 * 3.2, [3]=0.50 * 3.1}, maxlevel=3},
		choppy = {times={[1]=2.10 * 3.3, [2]=0.90 * 3.2, [3]=0.50 * 3.1}, maxlevel=3},
		snappy = {times={[1]=1.90 * 3.3, [2]=0.90 * 3.2, [3]=0.30 * 3.1}, maxlevel=3},
	
	},
	tool_list = {
	--"pickaxe"
	},
	tool_list_whitelist = false, --if this is true, then tool_list should act like a whitelist, otherwise, it'll act like a blacklist
	color = "0F1219",
	tool_textures = {
		default_alias = "stone", --what to append to the end of the default texture name, example: "bens_gear_axe_" would become "bens_gear_axe_metal"
		shovel = {"bens_gear_shovel_metal.png",true}, --use a custom texture for pickaxes, you can add more for other tools
		pickaxe = {"bens_gear_pick_wood.png",true} --use a custom texture for pickaxes, you can add more for other tools
	},
	misc_data = {magic=5}, --here you can store various other weird stats for other mods to utilize, the only stat that is officially supported at the moment is "magic"
	additional_functions = { --a list of additional functions that'll be called upon certain conditions. This is here so that custom tools don't have to have support manually added.
		node_mined = nil,
		tool_destroyed = nil,
		tool_attempt_place = nil,
	},
	pre_finalization_function = nil --this function should be called RIGHT BEFORE the tool/item/whatever gets created, so that the material can add its own custom handling/data
	--it should be called like this: func(tool_id,data)
})


bens_gear.add_rod({
	internal_name = "default_glass",
	display_name = S("Glass Rod"),
	item_name = "default:glass",
	color = "DDDDFF",
	uses_multiplier = 0.20,
	speed_multiplier = 0.5,
	damage_multiplier = 1.2,
	full_punch_interval_multiplier = 1,
	rod_main_texture = {"bens_gear_bonus_materials_glass_stick.png",false},
	flammable = false,
	rod_textures = {
		default_alias = "def", --what to append to the end of the default texture name, example: "bens_gear_rod_pick_" would become "bens_gear_rod_pick_def", custom tools might have their own texture varients
		pickaxe = {"bens_gear_bonus_materials_glass_pick.png",false},
		axe = {"bens_gear_bonus_materials_glass_axe.png",false},
		shovel = {"bens_gear_bonus_materials_glass_shovel.png",false},
		sword = {"bens_gear_bonus_materials_glass_sword.png",false}
	}
})


dofile(default_path .. "/coal.lua")