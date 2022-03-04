bens_gear.add_ore({
	internal_name = "default_wood",
	display_name = "Wooden",
	item_name = "group:wood",
	max_drop_level = 0,
	damage_groups_any = {fleshy=1},
	damage_groups_sword = {fleshy=2},
	damage_groups_axe = {fleshy=3},
	full_punch_interval = 1.2,
	uses = 10,
	flammable = true,
	groupcaps = { --the groupcaps for the tool. durability is typically used instead of "uses" so there is no need to define it
		crumbly = {times={[1]=3.00, [2]=1.60, [3]=0.60}, maxlevel=1},
		cracky = {times={[3]=1.60}, maxlevel=1},
		choppy = {times={[2]=3.00, [3]=1.60}, maxlevel=1},
		snappy = {times={[2]=1.6, [3]=0.40}, maxlevel=1},
	
	},
	tool_list = {
	--"pickaxe"
	},
	tool_list_whitelist = false, --if this is true, then tool_list should act like a whitelist, otherwise, it'll act like a blacklist
	color = "6C4913",
	tool_textures = {
		default_alias = "wood", --what to append to the end of the default texture name, example: "bens_gear_axe_" would become "bens_gear_axe_metal"
		--pickaxe = {"bens_gear_pick_wood.png",true} --use a custom texture for pickaxes, you can add more for other tools
	},
	misc_data = {magic=3}, --here you can store various other weird stats for other mods to utilize, the only stat that is officially supported at the moment is "magic"
	additional_functions = { --a list of additional functions that'll be called upon certain conditions. This is here so that custom tools don't have to have support manually added.
		node_mined = nil,
		tool_destroyed = nil,
		tool_attempt_place = nil,
	},
	pre_finalization_function = nil --this function should be called RIGHT BEFORE the tool/item/whatever gets created, so that the material can add its own custom handling/data
	--it should be called like this: func(tool_id,data)
})

--define extra woods here? I don't quite know yet.