bens_gear.reduce_tool_stat("moreores:axe_silver")
bens_gear.reduce_tool_stat("moreores:pick_silver")
bens_gear.reduce_tool_stat("moreores:shovel_silver")
bens_gear.reduce_tool_stat("moreores:sword_silver")
bens_gear.reduce_hoe_stat("moreores:hoe_silver")

bens_gear.reduce_tool_stat("moreores:axe_mithril")
bens_gear.reduce_tool_stat("moreores:pick_mithril")
bens_gear.reduce_tool_stat("moreores:shovel_mithril")
bens_gear.reduce_tool_stat("moreores:sword_mithril")
bens_gear.reduce_hoe_stat("moreores:hoe_mithril")



bens_gear.add_ore({
	internal_name = "moreores_silver",
	display_name = "Silver",
	item_name = "moreores:silver_ingot",
	max_drop_level = 3,
	damage_groups_any = {fleshy=3},
	damage_groups_sword = {fleshy=6},
	damage_groups_axe = {fleshy=5},
	full_punch_interval = 1.0,
	uses = 60,
	flammable = false,
	groupcaps = { --the groupcaps for the tool. durability is typically used instead of "uses" so there is no need to define it
		crumbly = {times = {[1] = 1.10, [2] = 0.40, [3] = 0.25}, maxlevel = 1},
		cracky = {times = {[1] = 2.60, [2] = 1.00, [3] = 0.60}, maxlevel = 1},
		choppy = {times = {[1] = 2.50, [2] = 0.80, [3] = 0.50}, maxlevel = 1},
		snappy = {times = {[1] = 1.70, [2] = 0.70, [3] = 0.30}, maxlevel = 1},
	
	},
	tool_list = {
	--"pickaxe"
	},
	tool_list_whitelist = false, --if this is true, then tool_list should act like a whitelist, otherwise, it'll act like a blacklist
	color = "BCD6E2",
	tool_textures = {
		default_alias = "metal", --what to append to the end of the default texture name, example: "bens_gear_axe_" would become "bens_gear_axe_metal"
		--pickaxe = {"bens_gear_pick_wood.png",true} --use a custom texture for pickaxes, you can add more for other tools
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

bens_gear.add_ore({
	internal_name = "moreores_mithril",
	display_name = "Mithril",
	item_name = "moreores:mithril_ingot",
	max_drop_level = 3,
	damage_groups_any = {fleshy=5},
	damage_groups_sword = {fleshy=10},
	damage_groups_axe = {fleshy=8},
	full_punch_interval = 0.45,
	uses = 70,
	flammable = false,
	groupcaps = { --the groupcaps for the tool. durability is typically used instead of "uses" so there is no need to define it
		crumbly = {times = {[1] = 0.70, [2] = 0.35, [3] = 0.20}, maxlevel = 3},
		cracky = {times = {[1] = 2.25, [2] = 0.55, [3] = 0.35}, maxlevel = 3},
		choppy = {times = {[1] = 1.75, [2] = 0.45, [3] = 0.45}, maxlevel = 3},
		snappy = {times = {[1] = 1.70, [2] = 0.70, [3] = 0.25}, maxlevel = 3},
	
	},
	tool_list = {
	--"pickaxe"
	},
	tool_list_whitelist = false, --if this is true, then tool_list should act like a whitelist, otherwise, it'll act like a blacklist
	color = "5B73EA",
	tool_textures = {
		default_alias = "metal", --what to append to the end of the default texture name, example: "bens_gear_axe_" would become "bens_gear_axe_metal"
		--pickaxe = {"bens_gear_pick_wood.png",true} --use a custom texture for pickaxes, you can add more for other tools
	},
	misc_data = {magic=7}, --here you can store various other weird stats for other mods to utilize, the only stat that is officially supported at the moment is "magic"
	additional_functions = { --a list of additional functions that'll be called upon certain conditions. This is here so that custom tools don't have to have support manually added.
		node_mined = nil,
		tool_destroyed = nil,
		tool_attempt_place = nil,
	},
	pre_finalization_function = nil --this function should be called RIGHT BEFORE the tool/item/whatever gets created, so that the material can add its own custom handling/data
	--it should be called like this: func(tool_id,data)
})