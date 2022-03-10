
local S = minetest.get_translator()

bens_gear.add_ore({
	internal_name = "default_stone",
	display_name = S("Stone"),
	item_name = "group:stone",
	max_drop_level = 0,
	damage_groups_any = {fleshy=1},
	damage_groups_sword = {fleshy=3},
	damage_groups_axe = {fleshy=4},
	full_punch_interval = 1.3,
	uses = 14,
	flammable = false,
	groupcaps = { --the groupcaps for the tool. durability is typically used instead of "uses" so there is no need to define it
		crumbly = {times={[1]=1.80, [2]=1.20, [3]=0.50}, maxlevel=1},
		cracky = {times={[2]=2.0, [3]=1.00}, maxlevel=1},
		choppy = {times={[1]=3.00, [2]=2.00, [3]=1.30}, maxlevel=1},
		snappy = {times={[2]=1.4, [3]=0.40}, maxlevel=1},
	
	},
	tool_list = {
	--"pickaxe"
	},
	tool_list_whitelist = false, --if this is true, then tool_list should act like a whitelist, otherwise, it'll act like a blacklist
	color = "635F5D",
	tool_textures = {
		default_alias = "stone", --what to append to the end of the default texture name, example: "bens_gear_axe_" would become "bens_gear_axe_metal"
		--pickaxe = {"bens_gear_pick_wood.png",true} --use a custom texture for pickaxes, you can add more for other tools
	},
	misc_data = {magic=0}, --here you can store various other weird stats for other mods to utilize, the only stat that is officially supported at the moment is "magic"
	additional_functions = { --a list of additional functions that'll be called upon certain conditions. This is here so that custom tools don't have to have support manually added.
		node_mined = nil,
		tool_destroyed = nil,
		tool_attempt_place = nil,
	},
	pre_finalization_function = nil --this function should be called RIGHT BEFORE the tool/item/whatever gets created, so that the material can add its own custom handling/data
	--it should be called like this: func(tool_id,data)
})

bens_gear.add_ore({
	internal_name = "default_steel",
	display_name = S("Steel"),
	item_name = "default:steel_ingot",
	max_drop_level = 1,
	damage_groups_any = {fleshy=2},
	damage_groups_sword = {fleshy=4},
	damage_groups_axe = {fleshy=5},
	full_punch_interval = 1.0,
	uses = 17,
	flammable = false,
	groupcaps = { --the groupcaps for the tool. durability is typically used instead of "uses" so there is no need to define it
		crumbly = {times={[1]=1.50, [2]=0.90, [3]=0.40}, maxlevel=2},
		cracky = {times={[1]=4.00, [2]=1.60, [3]=0.80}, maxlevel=2},
		choppy = {times={[1]=2.50, [2]=1.40, [3]=1.00}, maxlevel=2},
		snappy = {times={[1]=2.5, [2]=1.20, [3]=0.35}, maxlevel=2},
	
	},
	tool_list = {
	--"pickaxe"
	},
	tool_list_whitelist = false, --if this is true, then tool_list should act like a whitelist, otherwise, it'll act like a blacklist
	color = "FFFFFF",
	tool_textures = {
		default_alias = "metal", --what to append to the end of the default texture name, example: "bens_gear_axe_" would become "bens_gear_axe_metal"
		--pickaxe = {"bens_gear_pick_wood.png",true} --use a custom texture for pickaxes, you can add more for other tools
	},
	misc_data = {magic=1}, --here you can store various other weird stats for other mods to utilize, the only stat that is officially supported at the moment is "magic"
	additional_functions = { --a list of additional functions that'll be called upon certain conditions. This is here so that custom tools don't have to have support manually added.
		node_mined = nil,
		tool_destroyed = nil,
		tool_attempt_place = nil,
	},
	pre_finalization_function = nil --this function should be called RIGHT BEFORE the tool/item/whatever gets created, so that the material can add its own custom handling/data
	--it should be called like this: func(tool_id,data)
})


bens_gear.add_ore({
	internal_name = "default_bronze",
	display_name = S("Bronze"),
	item_name = "default:bronze_ingot",
	max_drop_level = 1,
	damage_groups_any = {fleshy=2},
	damage_groups_sword = {fleshy=4},
	damage_groups_axe = {fleshy=4},
	full_punch_interval = 1.0,
	uses = 18,
	flammable = false,
	groupcaps = { --the groupcaps for the tool. durability is typically used instead of "uses" so there is no need to define it
		crumbly = {times={[1]=1.65, [2]=1.05, [3]=0.45}, maxlevel=2},
		cracky = {times={[1]=4.50, [2]=1.80, [3]=0.90}, maxlevel=2},
		choppy = {times={[1]=2.75, [2]=1.70, [3]=1.15}, maxlevel=2},
		snappy = {times={[1]=2.75, [2]=1.30, [3]=0.375}, maxlevel=2},
	
	},
	tool_list = {
	--"pickaxe"
	},
	tool_list_whitelist = false, --if this is true, then tool_list should act like a whitelist, otherwise, it'll act like a blacklist
	color = "FF873D",
	tool_textures = {
		default_alias = "metal", --what to append to the end of the default texture name, example: "bens_gear_axe_" would become "bens_gear_axe_metal"
		--pickaxe = {"bens_gear_pick_wood.png",true} --use a custom texture for pickaxes, you can add more for other tools
	},
	misc_data = {magic=2}, --here you can store various other weird stats for other mods to utilize, the only stat that is officially supported at the moment is "magic"
	additional_functions = { --a list of additional functions that'll be called upon certain conditions. This is here so that custom tools don't have to have support manually added.
		node_mined = nil,
		tool_destroyed = nil,
		tool_attempt_place = nil,
	},
	pre_finalization_function = nil --this function should be called RIGHT BEFORE the tool/item/whatever gets created, so that the material can add its own custom handling/data
	--it should be called like this: func(tool_id,data)
})

bens_gear.add_ore({
	internal_name = "default_diamond",
	display_name = S("Diamond"),
	item_name = "default:diamond",
	max_drop_level = 3,
	damage_groups_any = {fleshy=4},
	damage_groups_sword = {fleshy=8},
	damage_groups_axe = {fleshy=7},
	full_punch_interval = 0.7,
	uses = 30,
	flammable = false,
	groupcaps = { --the groupcaps for the tool. durability is typically used instead of "uses" so there is no need to define it
		crumbly = {times={[1]=1.10, [2]=0.50, [3]=0.30}, maxlevel=3},
		cracky = {times={[1]=2.0, [2]=1.0, [3]=0.50}, maxlevel=3},
		choppy = {times={[1]=2.10, [2]=0.90, [3]=0.50}, maxlevel=3},
		snappy = {times={[1]=1.90, [2]=0.90, [3]=0.30}, maxlevel=3},
	
	},
	tool_list = {
	--"pickaxe"
	},
	tool_list_whitelist = false, --if this is true, then tool_list should act like a whitelist, otherwise, it'll act like a blacklist
	color = "4BEAE5",
	tool_textures = {
		default_alias = "gem", --what to append to the end of the default texture name, example: "bens_gear_axe_" would become "bens_gear_axe_metal"
		--pickaxe = {"bens_gear_pick_wood.png",true} --use a custom texture for pickaxes, you can add more for other tools
	},
	misc_data = {magic=6}, --here you can store various other weird stats for other mods to utilize, the only stat that is officially supported at the moment is "magic"
	additional_functions = { --a list of additional functions that'll be called upon certain conditions. This is here so that custom tools don't have to have support manually added.
		node_mined = nil,
		tool_destroyed = nil,
		tool_attempt_place = nil,
	},
	pre_finalization_function = nil --this function should be called RIGHT BEFORE the tool/item/whatever gets created, so that the material can add its own custom handling/data
	--it should be called like this: func(tool_id,data)
})

bens_gear.add_ore({
	internal_name = "default_mese",
	display_name = S("Mese"),
	item_name = "default:mese_crystal",
	max_drop_level = 3,
	damage_groups_any = {fleshy=4},
	damage_groups_sword = {fleshy=7},
	damage_groups_axe = {fleshy=6},
	full_punch_interval = 0.7,
	uses = 24,
	flammable = false,
	groupcaps = { --the groupcaps for the tool. durability is typically used instead of "uses" so there is no need to define it
		crumbly = {times={[1]=1.20, [2]=0.60, [3]=0.30}, maxlevel=3},
		cracky = {times={[1]=2.4, [2]=1.2, [3]=0.60}, maxlevel=3},
		choppy = {times={[1]=2.20, [2]=1.00, [3]=0.60}, maxlevel=3},
		snappy= {times={[1]=2.0, [2]=1.00, [3]=0.35}, maxlevel=3},
	
	},
	tool_list = {
	--"pickaxe"
	},
	tool_list_whitelist = false, --if this is true, then tool_list should act like a whitelist, otherwise, it'll act like a blacklist
	color = "FDFF2D",
	tool_textures = {
		default_alias = "gem", --what to append to the end of the default texture name, example: "bens_gear_axe_" would become "bens_gear_axe_metal"
		--pickaxe = {"bens_gear_pick_wood.png",true} --use a custom texture for pickaxes, you can add more for other tools
	},
	misc_data = {magic=10}, --here you can store various other weird stats for other mods to utilize, the only stat that is officially supported at the moment is "magic"
	additional_functions = { --a list of additional functions that'll be called upon certain conditions. This is here so that custom tools don't have to have support manually added.
		node_mined = nil,
		tool_destroyed = nil,
		tool_attempt_place = nil,
	},
	pre_finalization_function = nil --this function should be called RIGHT BEFORE the tool/item/whatever gets created, so that the material can add its own custom handling/data
	--it should be called like this: func(tool_id,data)
})