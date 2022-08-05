local S = minetest.get_translator()

bens_gear.reduce_tool_stat("ethereal:pick_crystal")
bens_gear.reduce_tool_stat("ethereal:axe_crystal")
bens_gear.reduce_tool_stat("ethereal:shovel_crystal")
bens_gear.reduce_tool_stat("ethereal:sword_crystal")

bens_gear.add_ore({
	internal_name = "ethereal_crystal",
	display_name = S("Crystal"),
	item_name = "ethereal:crystal_ingot",
	max_drop_level = 3,
	damage_groups_any = {fleshy=4},
	damage_groups_sword = {fleshy=10},
	damage_groups_axe = {fleshy=6},
	full_punch_interval = 0.7,
	uses = 40,
	flammable = false,
	groupcaps = { --the groupcaps for the tool. durability is typically used instead of "uses" so there is no need to define it
        crumbly = {times = {[1] = 1.10, [2] = 0.50, [3] = 0.30}, maxlevel = 3},
		cracky = {times = {[1] = 1.8, [2] = 0.8, [3] = 0.50}, maxlevel = 3}, --tweaked this a bit, cry about it
		choppy = {times = {[1] = 2.00, [2] = 0.80, [3] = 0.40}, maxlevel = 3},
		snappy = {times = {[1] = 1.70, [2] = 0.70, [3] = 0.25}, maxlevel = 3},
	
	},
	tool_list = {
	--"pickaxe"
	},
	tool_list_whitelist = false, --if this is true, then tool_list should act like a whitelist, otherwise, it'll act like a blacklist
	color = "8C96C9",
	tool_textures = {
		default_alias = "gem", --what to append to the end of the default texture name, example: "bens_gear_axe_" would become "bens_gear_axe_metal"
		pickaxe = {"bens_gear_ethcrystal_pick.png",false},
		axe = {"bens_gear_ethcrystal_axe.png",false},
		shovel = {"bens_gear_ethcrystal_shovel.png",false},
		sword = {"bens_gear_ethcrystal_sword.png",false},
		hoe = {"bens_gear_ethcrystal_hoe.png",false}
	},
	misc_data = {magic=12}, --here you can store various other weird stats for other mods to utilize, the only stat that is officially supported at the moment is "magic"
	additional_functions = { --a list of additional functions that'll be called upon certain conditions. This is here so that custom tools don't have to have support manually added.
		node_mined = nil,
		tool_destroyed = nil,
		tool_attempt_place = nil,
        after_use = nil
	},
	pre_finalization_function = nil
	--this function should be called RIGHT BEFORE the tool/item/whatever gets created, so that the material can add its own custom handling/data
	--it should be called like this: func(tool_id,data)
})

local old_handle_node_drops = minetest.handle_node_drops

function minetest.handle_node_drops(pos, drops, digger)

	-- are we holding a Ben's Gear Crystal Shovel?
	if not digger then
		return old_handle_node_drops(pos, drops, digger)
	end

    local regis_tool = minetest.registered_tools[digger:get_wielded_item():get_name()]

    if (regis_tool == nil) then
        return old_handle_node_drops(pos, drops, digger)
    end

    if (regis_tool.groups["shovel"] ~= 1 or regis_tool.groups["beng_o_ethereal_crystal"] ~= 1) then
        return old_handle_node_drops(pos, drops, digger)
    end

	local nn = minetest.get_node(pos).name

	if minetest.get_item_group(nn, "crumbly") == 0 then
		return old_handle_node_drops(pos, drops, digger)
	end

	return old_handle_node_drops(pos, {ItemStack(nn)}, digger)
end