local function mod_loaded(str)
  if minetest.get_modpath(str) ~= nil then
    return true
  else
    return false
  end
end

local default_path = minetest.get_modpath("bens_gear_charms")

minetest.register_craftitem("bens_gear_charms:mossy_mese_charm", {
	description = "Mossy Mese\nReduces the time it takes to mine weaker blocks by 25%.\n(Can be applied to pickaxes)",
	short_description = "Mossy Mese",
	inventory_image = "bens_gear_charms_mossy_mese.png"
})

minetest.register_craft({
	output = "bens_gear_charms:mossy_mese_charm",
	recipe = {
		{"default:glass", "group:leaves", "default:glass"},
		{"group:leaves", "default:mese_crystal", "group:leaves"},
		{"default:glass", "group:leaves", "default:glass"},
	}
})

bens_gear.add_charm({
	item_name = "bens_gear_charms:mossy_mese_charm", --charms use already existing items.
	charm_name = "mossy_mese", --for creating IDs
	exclusive = false, --if false, mods are allowed to use this charm even if not explicitly supported. (EX: a super axe using an axe charm if this is off, if this is on then the axe won't use this charm)
	valid_tools = { --the charm can only be applied to the following tools
		pickaxe = "bens_gear_charms_mossy_mese_pick.png"
	},
	charm_function = function(tool_type,tool_data,ore_data,rod_data)
		if (tool_type == "pickaxe") then
			tool_data.tool_capabilities.groupcaps.cracky.times[3] = tool_data.tool_capabilities.groupcaps.cracky.times[3] * 0.75
		end
		
	end
	
})


minetest.register_craftitem("bens_gear_charms:extendo_tin_rod", {
	description = "Tin Pole\nDoubles the range of the tool its put on.\nIncreases Mining time by 30%\n(Can be applied to most tools except for swords)",
	short_description = "Tin Pole",
	inventory_image = "bens_gear_charms_extended_range_item.png"
})

minetest.register_craft({
	output = "bens_gear_charms:extendo_tin_rod",
	recipe = {
		{"", "default:tinblock", ""},
		{"", "default:tinblock", ""},
		{"", "default:tinblock", ""},
	}
})

bens_gear.add_charm({
	item_name = "bens_gear_charms:extendo_tin_rod", --charms use already existing items.
	charm_name = "extendo_tin_rod", --for creating IDs
	exclusive = false, --if false, mods are allowed to use this charm even if not explicitly supported. (EX: a super axe using an axe charm if this is off, if this is on then the axe won't use this charm)
	valid_tools = { --the charm can only be applied to the following tools
		pickaxe = "bens_gear_charms_extended_range.png",
		axe = "bens_gear_charms_extended_range_axe.png",
		shovel = "bens_gear_charms_extended_range.png",
		hoe = "bens_gear_charms_extended_range.png"
	},
	charm_function = function(tool_type,tool_data,ore_data,rod_data)
		tool_data.range = ((tool_data.range or 4) * 2) + 1
		tool_data.wield_scale = {x = 2, y = 2, z = 1} --this doesn't work on hoes currently :(
		if (tool_data.tool_capabilities == nil) then
			return
		end
		for i, thing in pairs(tool_data.tool_capabilities.groupcaps) do
			tool_data.tool_capabilities.groupcaps[i] = bens_gear.multiply_times(thing,1.30)
		end
	end
	
})


minetest.register_craftitem("bens_gear_charms:lumberjack_charm", {
	description = "Lumber Bundle\nMakes it so axes dig all matching nodes above the node dug.\nMultiplies Mining Time by 2.\n(Can be applied to axes)",
	short_description = "Lumber Bundle",
	inventory_image = "bens_gear_charms_lumberjack_item.png"
})

minetest.register_craft({
	output = "bens_gear_charms:lumberjack_charm",
	recipe = {
		{"default:mese_crystal_fragment", "default:mese_crystal_fragment", "default:mese_crystal_fragment"},
		{"default:mese_crystal_fragment", "group:sapling", "default:mese_crystal_fragment"},
		{"default:mese_crystal_fragment", "default:mese_crystal_fragment", "default:mese_crystal_fragment"},
	}
})


local function begin_lumberjacking(pos,oldnode,digger)
	if digger == nil then return end
	local has_choppy = false
	for i, thing in pairs(minetest.registered_nodes[oldnode.name].groups) do
		if (i == "choppy") then
			has_choppy = true
		end
	end
	if (not has_choppy) then
		return false
	end
	local np = {x = pos.x, y = pos.y + 1, z = pos.z}
	local nn = minetest.get_node(np)
	if nn.name == oldnode.name then
		minetest.node_dig(np, nn, digger)
		begin_lumberjacking(np,oldnode,digger)
	end
end

bens_gear.add_charm({
	item_name = "bens_gear_charms:lumberjack_charm", --charms use already existing items.
	charm_name = "lumberjack_sapling_charm", --for creating IDs
	exclusive = false, --if false, mods are allowed to use this charm even if not explicitly supported. (EX: a super axe using an axe charm if this is off, if this is on then the axe won't use this charm)
	valid_tools = { --the charm can only be applied to the following tools
		axe = "bens_gear_charms_lumberjack.png"
	},
	charm_function = function(tool_type,tool_data,ore_data,rod_data)
		tool_data.tool_capabilities.groupcaps.choppy = bens_gear.multiply_times(tool_data.tool_capabilities.groupcaps.choppy,2)
		if (tool_data.on_node_mine ~= nil) then
				local old_func = tool_data.on_node_mine
				tool_data.on_node_mine = function(pos,oldnode,digger)
					old_func()
					begin_lumberjacking(pos,oldnode,digger)
				end
		else
			tool_data.on_node_mine = function(pos,oldnode,digger)
				begin_lumberjacking(pos,oldnode,digger)
			end
		end
		
	end
	
})

if (mod_loaded("bens_gear_bonus_materials")) then
	dofile(default_path .. "/coal.lua")
end


