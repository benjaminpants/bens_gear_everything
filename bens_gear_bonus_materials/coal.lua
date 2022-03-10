
local S = minetest.get_translator()

minetest.register_node("bens_gear_bonus_materials:coal_light_brightest", {
    description = "Coal Light",
	sunlight_propagates = true,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
    paramtype = "light",
	light_source = 9,
	drawtype = "airlike",
	on_timer = function(pos, elapsed)
		minetest.set_node(pos,{name="bens_gear_bonus_materials:coal_light_brighter"})
	end,
	on_construct = function(pos)
		local timer = minetest.get_node_timer(pos)
		timer:set(0.3,0)
	end,
	groups = {not_in_creative_inventory=1}
})

minetest.register_node("bens_gear_bonus_materials:coal_light_brighter", {
    description = "Coal Light",
	sunlight_propagates = true,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
    paramtype = "light",
	light_source = 6,
	drawtype = "airlike",
	on_timer = function(pos, elapsed)
		minetest.set_node(pos,{name="bens_gear_bonus_materials:coal_light_dim"})
	end,
	on_construct = function(pos)
		local timer = minetest.get_node_timer(pos)
		timer:set(0.2,0)
	end,
	groups = {not_in_creative_inventory=1}
})

minetest.register_node("bens_gear_bonus_materials:coal_light_dim", {
    description = "Coal Light",
	sunlight_propagates = true,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
    paramtype = "light",
	light_source = 2,
	drawtype = "airlike",
	on_timer = function(pos, elapsed)
		minetest.set_node(pos,{name="air"})
	end,
	on_construct = function(pos)
		local timer = minetest.get_node_timer(pos)
		timer:set(0.1,0)
	end,
	groups = {not_in_creative_inventory=1}
})


bens_gear.add_ore({
	internal_name = "default_coal",
	display_name = S("Coal"),
	item_name = "group:coal",
	description_append = "\n" .. S("Emits a short spark of light whenever a block is mined."),
	max_drop_level = 0,
	damage_groups_any = {fleshy=1},
	damage_groups_sword = {fleshy=1},
	damage_groups_axe = {fleshy=2},
	full_punch_interval = 1.8,
	uses = 10,
	flammable = true,
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
	color = "484848",
	tool_textures = {
		default_alias = "stone", --what to append to the end of the default texture name, example: "bens_gear_axe_" would become "bens_gear_axe_metal"
		pickaxe = {"bens_gear_pick_wood.png",true}
	},
	misc_data = {magic=2}, --here you can store various other weird stats for other mods to utilize, the only stat that is officially supported at the moment is "magic"
	additional_functions = { --a list of additional functions that'll be called upon certain conditions. This is here so that custom tools don't have to have support manually added.
		node_mined = function(pos)
			minetest.set_node(pos,{name="bens_gear_bonus_materials:coal_light_brightest"})
		end,
		tool_destroyed = nil,
		tool_attempt_place = nil,
	},
	pre_finalization_function = nil --this function should be called RIGHT BEFORE the tool/item/whatever gets created, so that the material can add its own custom handling/data
	--it should be called like this: func(tool_id,data)
})

