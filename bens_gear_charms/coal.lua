minetest.register_craftitem("bens_gear_charms:coal_pick_ends", {
	description = "Coal Pickaxe Ends\nMakes it so a short spark of light appears whenever a block is mined.\n-2 Uses\n(Can be applied to pickaxes)",
	short_description = "Coal Pickaxe Ends",
	inventory_image = "bens_gear_charms_coal_ends.png"
})

minetest.register_craft({
	output = "bens_gear_charms:coal_pick_ends",
	recipe = {
		{"group:coal", "group:coal", "group:coal"},
		{"", "default:bronze_ingot", ""},
		{"group:coal", "group:coal", "group:coal"},
	}
})

bens_gear.add_charm({
	item_name = "bens_gear_charms:coal_pick_ends", --charms use already existing items.
	charm_name = "coal_pick_ends", --for creating IDs
	exclusive = true, --if false, mods are allowed to use this charm even if not explicitly supported. (EX: a super axe using an axe charm if this is off, if this is on then the axe won't use this charm)
	valid_tools = { --the charm can only be applied to the following tools
		pickaxe = "bens_gear_charms_coal_ends_attached.png"
	},
	charm_function = function(tool_type,tool_data,ore_data,rod_data)
		if (tool_type == "pickaxe") then
			tool_data.tool_capabilities.groupcaps.cracky.uses = tool_data.tool_capabilities.groupcaps.cracky.uses - 2
			if (tool_data.on_node_mine ~= nil) then
				local old_func = tool_data.on_node_mine
				tool_data.on_node_mine = function(pos)
					old_func(pos,oldnode,digger)
					if (minetest.get_node(pos).name == "air") then
						minetest.set_node(pos,{name="bens_gear_bonus_materials:coal_light_brightest"})
					end
				end
			else
				tool_data.on_node_mine = function(pos)
					minetest.set_node(pos,{name="bens_gear_bonus_materials:coal_light_brightest"})
				end
			end
		end
		
	end
	
})