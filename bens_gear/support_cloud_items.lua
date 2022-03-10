
local S = minetest.get_translator()

bens_gear.reduce_tool_stat("cloud_items:cloud_axe")
bens_gear.reduce_tool_stat("cloud_items:cloud_pickaxe")
bens_gear.reduce_tool_stat("cloud_items:cloud_shovel")
bens_gear.reduce_tool_stat("cloud_items:cloud_sword")



bens_gear.add_ore({
	internal_name = "cloud_items_cloud",
	display_name = S("Cloud"),
	item_name = "cloud_items:cloud_ingot",
	max_drop_level = 3,
	damage_groups_any = {fleshy=4.5},
	damage_groups_sword = {fleshy=11},
	damage_groups_axe = {fleshy=7.50},
	full_punch_interval = 0.8,
	uses = 60,
	flammable = false,
	groupcaps = { --the groupcaps for the tool. durability is typically used instead of "uses" so there is no need to define it
		crumbly = {times={[1]=0.5, [2]=0.50, [3]=0.30}, maxlevel=3},
		cracky = {times={[1]=1.0, [2]=1.0, [3]=0.50}, maxlevel=3},
		choppy = {times={[1]=0.5, [2]=0.60, [3]=0.60}, maxlevel=3},
		snappy = {times={[1]=1.90, [2]=0.90, [3]=0.30}, maxlevel=3},
	
	},
	tool_list = {
	--"pickaxe"
	},
	tool_list_whitelist = false, --if this is true, then tool_list should act like a whitelist, otherwise, it'll act like a blacklist
	color = "F0EFFF",
	tool_textures = {
		default_alias = "metal", --what to append to the end of the default texture name, example: "bens_gear_axe_" would become "bens_gear_axe_metal"
		pickaxe = {"bens_gear_cloudsup_pick.png",false},
		axe = {"bens_gear_cloudsup_axe.png",false},
		shovel = {"bens_gear_cloudsup_shovel.png",false},
		sword = {"bens_gear_cloudsup_sword.png",false},
		hoe = {"bens_gear_cloudsup_hoe.png",false}
	},
	misc_data = {magic=10}, --here you can store various other weird stats for other mods to utilize, the only stat that is officially supported at the moment is "magic"
	additional_functions = { --a list of additional functions that'll be called upon certain conditions. This is here so that custom tools don't have to have support manually added.
		node_mined = nil,
		tool_destroyed = nil,
		tool_attempt_place = nil,
	},
	pre_finalization_function = function(tool_type,data)
		if (tool_type == "sword") then
			data.range = 5
		end

	end
	--this function should be called RIGHT BEFORE the tool/item/whatever gets created, so that the material can add its own custom handling/data
	--it should be called like this: func(tool_id,data)
})