
local S = default.get_translator

bens_gear = {}

local default_path = minetest.get_modpath("bens_gear")

bens_gear.ores = {}
bens_gear.rods = {}
bens_gear.charms = {}
bens_gear.tool_iterates = {}
bens_gear.ore_iterates = {}
bens_gear.mine_tool_functions = {}

bens_gear.on_all_materials_registered = {}

bens_gear.features = {
	tool_destroyed_implementation = false

}


local groups_to_process = {}

local items_to_ignore = {}





minetest.register_craftitem("bens_gear:blueprint_paper", {
	description = "Blueprint Paper",
	inventory_image = "(default_paper.png^[multiply:#0000FF)",
	groups = {paper=1}
})


minetest.register_craftitem("bens_gear:half_stick", {
	description = "Short Stick",
	inventory_image = "(bens_gear_short_stick.png)"
})


minetest.register_craft({
		type = "shapeless",
		output = "bens_gear:half_stick 2",
		recipe = {
			"group:stick"
		}
})

minetest.register_craftitem("bens_gear:blueprint_paper_light", {
	description = "Light Blueprint Paper",
	inventory_image = "(default_paper.png^[multiply:#3333FF)",
	groups = {paper=1}
})


minetest.register_craft({
		type = "shapeless",
		output = "bens_gear:blueprint_paper_light 1",
		recipe = {
			"bens_gear:blueprint_paper", "dye:white"
		}
})

minetest.register_craft({
		type = "shapeless",
		output = "bens_gear:blueprint_paper 3",
		recipe = {
			"default:paper", "default:paper", "default:paper", "dye:blue"
		}
})


bens_gear.create_blueprint_and_template = function(tool_type, tool_display, outline_tex, recipe_temp, material_needed) --helper function for creating templates and blueprints, i got sick of copying and pasting the same code can you blame me
	minetest.register_craftitem("bens_gear:blueprint_" .. tool_type, {
	description = tool_display .. " Blueprint" .. "\n" .. material_needed .. " material needed.",
	inventory_image = "(default_paper.png^[multiply:#0000FF)^(" .. outline_tex .. ")"
	})

	minetest.register_craftitem("bens_gear:template_" .. tool_type, {
	description = tool_display .. " Template\n(Can only be used once)\n" .. material_needed .. " material needed.",
	short_description = tool_display .. " Template",
	inventory_image = "(default_wood.png)^(bens_gear_frame_overlay.png)^(" .. outline_tex .. "^[multiply:#000000)"
	})

	if (recipe_temp == nil) then
		return
	end
	--very high quality I JUST WANNA GO TO BED code right here
	--this copies a table. very poorly. but it works.
	local blueprint_recipe = {{recipe_temp[1][1],recipe_temp[1][2],recipe_temp[1][3]},{recipe_temp[2][1],recipe_temp[2][2],recipe_temp[2][3]},{recipe_temp[3][1],recipe_temp[3][2],recipe_temp[3][3]}}
	
	for i=1, #blueprint_recipe do
		for j=1, #blueprint_recipe[i] do
			if (blueprint_recipe[i][j] == true) then
				blueprint_recipe[i][j] = "bens_gear:blueprint_paper"
			else
				if (blueprint_recipe[i][j] == "light") then
					blueprint_recipe[i][j] = "bens_gear:blueprint_paper_light"
				else
					blueprint_recipe[i][j] = ""
				end
			end
		end
	end
	
	
	local template_recipe = {{recipe_temp[1][1],recipe_temp[1][2],recipe_temp[1][3]},{recipe_temp[2][1],recipe_temp[2][2],recipe_temp[2][3]},{recipe_temp[3][1],recipe_temp[3][2],recipe_temp[3][3]}}
	
	for i=1, #template_recipe do
		for j=1, #template_recipe[i] do
			if (template_recipe[i][j] == true) then
				template_recipe[i][j] = "group:stick"
			else
				if (template_recipe[i][j] == "light") then
					template_recipe[i][j] = "bens_gear:half_stick"
				else
					template_recipe[i][j] = ""
				end
			end
		end
	end
	
	minetest.register_craft({
		
		output = "bens_gear:blueprint_" .. tool_type,
		recipe = blueprint_recipe
	})
	

	minetest.register_craft({
		
		output = "bens_gear:template_" .. tool_type,
		recipe = template_recipe

	})

end

bens_gear.create_blueprint_and_template("rod","Rod","bens_gear_outline_rod.png", nil, 1)


minetest.register_craft({
		
		output = "bens_gear:blueprint_rod",
		recipe = {
			{"","",""},
			{"","bens_gear:blueprint_paper",""},
			{"","bens_gear:blueprint_paper",""},
		}
})

minetest.register_craft({
		
		output = "bens_gear:template_rod",
		recipe = {
			{"","",""},
			{"","bens_gear:half_stick",""},
			{"","bens_gear:half_stick",""},
		}
})


	
minetest.register_on_dignode(function(pos, oldnode, digger)
	if (digger == nil) then
		return
	end
	local current_tool = digger:get_wielded_item():get_name()
	if (bens_gear.mine_tool_functions[current_tool] ~= nil) then
		local output = bens_gear.mine_tool_functions[current_tool](pos,oldnode,digger)
		if (output ~= nil) then
			return output
		end
	end
	

end)



bens_gear.reduce_tool_stat = function(tool_to_reduce)
	if (minetest.registered_tools[tool_to_reduce] == nil) then
		error("(Ben's Gear) Attempted to modify non-existant tool " .. tool_to_reduce .. "!\nMake sure all mods are properly installed and no dependencies are missing.\nThis can also be caused by a poorly programmed support mod.")
	end
	local registered_tool = minetest.registered_tools[tool_to_reduce]
	local tool_abilities = registered_tool.tool_capabilities
	for i, ab in pairs(tool_abilities.groupcaps) do
		tool_abilities.groupcaps[i].uses = math.ceil(5 / tool_abilities.groupcaps[i].maxlevel)
	end
	local short_desc = registered_tool.short_description
	if (short_desc == nil and (select(1,string.find(registered_tool.description,"\n")) == nil)) then
		short_desc = registered_tool.description
	end
	local desc = registered_tool.description .. "\n(This tool was poorly made and won't last long)"
	minetest.override_item(tool_to_reduce,{tool_capabilities=tool_abilities,description=desc,short_description=short_desc})
end


local function table_deepcopy(o, seen) -- https://stackoverflow.com/a/16077650
  seen = seen or {}
  if o == nil then return nil end
  if seen[o] then return seen[o] end

  local no
  if type(o) == 'table' then
    no = {}
    seen[o] = no

    for k, v in next, o, nil do
      no[table_deepcopy(k, seen)] = table_deepcopy(v, seen)
    end
    setmetatable(no, table_deepcopy(getmetatable(o), seen))
  else -- number, string, boolean, etc
    no = o
  end
  return no
end



bens_gear.add_coloring = function(data,color)
	local inv_img = data[1]
	
	if (data[2] == true) then
		inv_img = inv_img .. "^[multiply:#" .. color
	end
	
	return inv_img

end



bens_gear.multiply_times = function(group_thingy,mult)
	local group_clone = table_deepcopy(group_thingy)
	for i, tim in pairs(group_clone.times) do
		group_clone.times[i] = tim * mult
	end
	return group_clone
end

bens_gear.multiply_groups = function(group_thingy,mult)
	local group_clone = table_deepcopy(group_thingy)
	for i, tim in pairs(group_clone) do
		group_clone[i] = tim * mult
	end
	return group_clone
end

bens_gear.get_viable_tool_texture = function(tool_type,default,tex_list,color)
	if (tex_list[tool_type]) then
		return bens_gear.add_coloring(tex_list[tool_type],color)
	else
		return bens_gear.add_coloring({default .. tex_list.default_alias .. ".png",true},color)
	end

end

bens_gear.get_viable_tool_texture_no_default = function(tool_type,tex_list)
	if (tex_list[tool_type]) then
		return tex_list[tool_type]
	else
		return ""
	end

end

bens_gear.calculate_average_group = function(group_thingy)
	local group_clone = group_thingy
	local cur_value = 0
	local amount = 0
	for i, tim in pairs(group_clone) do
		amount = amount + 1
		cur_value = cur_value + tim
	end
	return cur_value / amount
end

local function round_to_two(value)
	return math.floor(value * 100)/100
end

bens_gear.create_ore_description = function(ore_data)
	local val = ""
	val = val .. (ore_data.description_append or "")
	val = val .. "\nMax Drop Level: " .. ore_data.max_drop_level
	local av_mining_speed = 0
	local av_amount = 0
	for i, thing in pairs(ore_data.groupcaps) do
		av_amount = av_amount + 1
		av_mining_speed = av_mining_speed + bens_gear.calculate_average_group(thing.times)
	end
	av_mining_speed = av_mining_speed / av_amount
	val = val .. "\nAverage Mining Time: " .. round_to_two(av_mining_speed)
	val = val .. "\nUses: " .. ore_data.uses
	val = val .. "\nSword Damage: " .. ore_data.damage_groups_sword.fleshy
	val = val .. "\nAttack Speed: " .. ore_data.full_punch_interval
	return val
end


bens_gear.add_ore = function(ore_data)
	if (ore_data.additional_functions["tool_destroyed"]) then
		error("tool_destroyed has not been implemented yet!")
	end
	table.insert(bens_gear.ores,ore_data)
	if (string.sub(ore_data.item_name,1,5) ~= "group") then
		local find_item = minetest.registered_nodes[ore_data.item_name] or minetest.registered_craftitems[ore_data.item_name] or minetest.registered_items[ore_data.item_name]
		if (find_item == nil) then
			return
		end
		minetest.override_item(ore_data.item_name,{description=find_item.description .. bens_gear.create_ore_description(ore_data)})
		table.insert(items_to_ignore,ore_data.item_name)
	else
		table.insert(groups_to_process,ore_data.item_name)
	end
end

bens_gear.add_tool_iterate = function(iterate)
	table.insert(bens_gear.tool_iterates,iterate)
end

bens_gear.add_ore_iterate = function(iterate)
	table.insert(bens_gear.ore_iterates,iterate)
end

bens_gear.register_on_all_materials_registered = function(func)
	table.insert(bens_gear.on_all_materials_registered,func)
end


bens_gear.can_tool_be_made = function(typ, ore_data)
	local contains_me = false
	for i=1, #ore_data.tool_list do
		if (ore_data.tool_list[i] == typ) then
			contains_me = true
		end
	end
	return (contains_me == true and ore_data.tool_list_whitelist) or (contains_me == false and not ore_data.tool_list_whitelist) or false
end



bens_gear.add_tool_generic_description = function(tool_data,ore_data,rod_data,mining,uses)
	local mining_speed = ""
	local tool_cap_stuff = ""
	local tool_caps_available = (tool_data.tool_capabilities ~= nil)
	if (mining ~= nil) then
		mining_speed = "\nAvg Mining Speed: " .. round_to_two(bens_gear.calculate_average_group(tool_data.tool_capabilities.groupcaps[mining].times))
	end
	if (tool_caps_available) then
		tool_cap_stuff = "\nDamage: " .. bens_gear.calculate_average_group(tool_data.tool_capabilities.damage_groups) .. "\nAttack Speed: " .. round_to_two(tool_data.tool_capabilities.full_punch_interval)
	end
	
	return (ore_data.description_append or "") .. "\nUses: " .. uses .. mining_speed .. tool_cap_stuff
end


bens_gear.add_rod = function(rod_data)
	
	local cur_loading_mod = core.get_current_modname()
	
	rod_data.mod_origin = cur_loading_mod
	
	local inv_img = bens_gear.add_coloring(rod_data.rod_main_texture,rod_data.color)
	
	minetest.register_craftitem(cur_loading_mod .. ":rod_" .. rod_data.internal_name, {
		description = rod_data.display_name .. "\nUses: " .. rod_data.uses_multiplier .. "x" .. "\nMining Speed: " .. rod_data.speed_multiplier .. "x" .. "\nDamage: " .. rod_data.damage_multiplier .. "x" .. "\nAttack Speed: " .. rod_data.full_punch_interval_multiplier .. "x",
		short_description = rod_data.display_name,
		inventory_image = inv_img
	})
	
	minetest.register_craft({
		type = "shapeless",
		output = cur_loading_mod .. ":rod_" .. rod_data.internal_name .. " 2",
		recipe = {
			"bens_gear:blueprint_rod", rod_data.item_name
		},
		replacements = {{"bens_gear:blueprint_rod","bens_gear:blueprint_rod"}}
	})
	
	minetest.register_craft({
		type = "shapeless",
		output = cur_loading_mod .. ":rod_" .. rod_data.internal_name .. " 2",
		recipe = {
			"bens_gear:template_rod", rod_data.item_name
		}
	})
	table.insert(bens_gear.rods,rod_data)
end

--You may notice that certain things relating to textures are formatted like {"image_name.png",false}
--The first is just the texture name, thats obvious, but the second one is whether or not it'll automatically be colored

bens_gear.ore_data_template = {
	internal_name = "unknown",
	display_name = "Unknown/Improperly Defined Material",
	item_name = "bens_gear:invalid_material",
	description_append = "\nThis is a test!", -- a string that will be added to the description, this can be omitted
	max_drop_level = 1,
	damage_groups_any = {fleshy=1},
	damage_groups_sword = {fleshy=2},
	damage_groups_axe = {fleshy=3},
	full_punch_interval = 1,
	uses = 20,
	flammable = true,
	groupcaps = { --the groupcaps for the tool. uses is typically used instead of "uses" so there is no need to define it
		crumbly = {times={[1]=3.00, [2]=1.60, [3]=0.60}, maxlevel=1},
		cracky = {times={[3]=1.60}, maxlevel=1},
		choppy = {times={[2]=3.00, [3]=1.60}, maxlevel=1},
	
	},
	tool_list = {
	--"pickaxe"
	},
	tool_list_whitelist = false, --if this is true, then tool_list should act like a whitelist, otherwise, it'll act like a blacklist
	color = "00FFFF",
	tool_textures = {
		default_alias = "stone", --what to append to the end of the default texture name, example: "bens_gear_axe_" would become "bens_gear_axe_metal"
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
}

bens_gear.add_charm = function(charm_data)
	table.insert(bens_gear.charms,charm_data)
end

bens_gear.rod_data_template = {
	internal_name = "unknown",
	display_name = "Unknown Rod",
	item_name = "bens_gear:invalid_material",
	color = "FFFFF0",
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
}

bens_gear.charm_data_template = {
	item_name = "bens_gear:invalid_material", --charms use already existing items.
	charm_name = "test_charm", --for creating IDs
	exclusive = false, --if false, mods are allowed to use this charm even if not explicitly supported. (EX: a super axe using an axe charm if this is off, if this is on then the axe won't use this charm)
	valid_tools = { --the charm can only be applied to the following tools
		sword = "bens_gear_question.png"
	},
	charm_function = function(tool_type,tool_data,ore_data,rod_data,pick_name)
		tool_data.description = tool_data.description .. "\nI'm homophobic!!!!"
	end
	
}

--bens_gear.add_charm(bens_gear.charm_data_template)

--guys, ik groups exist but this looks a bajillion times better
minetest.register_craftitem("bens_gear:invalid_material", {
	description = "Any Material",
	inventory_image = "(default_diamond.png^[colorize:#666666)^bens_gear_question.png",
	groups = {not_in_creative_inventory=1}
})

minetest.register_craftitem("bens_gear:invalid_rod", {
	description = "Any Rod",
	inventory_image = "(default_stick.png^[colorize:#666666)^bens_gear_question.png",
	groups = {not_in_creative_inventory=1}
})

bens_gear.create_example_item = function(id,name,texture)
	minetest.register_craftitem("bens_gear:" .. id, {
	description = name,
	inventory_image = "(" .. texture .. "^[colorize:#666666)^bens_gear_question.png",
	groups = {not_in_creative_inventory=1}
	})

end



local function mod_loaded(str)
  if minetest.get_modpath(str) ~= nil then
    return true
  else
    return false
  end
end

local farming_exists = mod_loaded("farming")

if (farming_exists) then
	bens_gear.reduce_hoe_stat = function(id)
		--TODO: actually reduce hoe stats instead of literally deleting the hoe but reducing stats on those things is so torturous it just isn't worth it right now.
		if (minetest.registered_tools[id] == nil) then
			return false
		end
		minetest.unregister_item(id)
		return true
	end
else
	bens_gear.reduce_hoe_stat = function(id)
		--do nothing :)
	end
end

--bens_gear.add_ore(bens_gear.ore_data_template)

--bens_gear.add_rod(bens_gear.rod_data_template)

bens_gear.create_example_item("example_charm","(Optional)A Charm", "default_copper_lump.png")

dofile(default_path .. "/pickaxes.lua")

dofile(default_path .. "/axes.lua")

dofile(default_path .. "/shovels.lua")

dofile(default_path .. "/swords.lua")

if (farming_exists) then
	dofile(default_path .. "/hoes.lua")
	bens_gear.reduce_hoe_stat("farming:hoe_wood")
	bens_gear.reduce_hoe_stat("farming:hoe_stone")
	bens_gear.reduce_hoe_stat("farming:hoe_steel")
end

dofile(default_path .. "/woods.lua")

dofile(default_path .. "/vanilla_materials.lua")

dofile(default_path .. "/rods.lua")

dofile(default_path .. "/blueprint_bundle.lua")

if (mod_loaded("cloud_items")) then
	dofile(default_path .. "/support_cloud_items.lua")
end

if (mod_loaded("moreores")) then
	dofile(default_path .. "/support_moreores.lua")
end


local mtg_materials = {"wood","stone","steel","bronze","mese","diamond"}

for i=1, #mtg_materials do
	bens_gear.reduce_tool_stat("default:pick_" .. mtg_materials[i])
	bens_gear.reduce_tool_stat("default:axe_" .. mtg_materials[i])
	bens_gear.reduce_tool_stat("default:shovel_" .. mtg_materials[i])
	bens_gear.reduce_tool_stat("default:sword_" .. mtg_materials[i])
end


local function split(pString, pPattern) --thanks to https://stackoverflow.com/a/1579673
   local Table = {}  -- NOTE: use {n = 0} in Lua-5.0
   local fpat = "(.-)" .. pPattern
   local last_end = 1
   local s, e, cap = pString:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
     table.insert(Table,cap)
      end
      last_end = e+1
      s, e, cap = pString:find(fpat, last_end)
   end
   if last_end <= #pString then
      cap = pString:sub(last_end)
      table.insert(Table, cap)
   end
   return Table
end

bens_gear.search_for_material = function(mat_item)
	for i=1, #bens_gear.ores do
		if (bens_gear.ores[i].item_name == mat_item) then
			return bens_gear.ores[i]
		end
	end
	return nil
end

local function should_ignore_item(item)
	for i=1, #items_to_ignore do
		if (items_to_ignore[i] == item) then
			return true
		end
	end
	return false
end


minetest.register_on_mods_loaded(function()
	for i=1, #groups_to_process do
		local to_process = groups_to_process[i]
		local split_result = split(to_process,":")
		local split_actual = split_result[2]
		for i, thing in pairs(minetest.registered_nodes) do
			if (thing.groups[split_actual] and not should_ignore_item(i)) then
				minetest.override_item(i,{description=thing.description .. bens_gear.create_ore_description(bens_gear.search_for_material(to_process))})
			end
		end
		for i, thing in pairs(minetest.registered_craftitems) do
			if (thing.groups[split_actual] and not should_ignore_item(i)) then
				minetest.override_item(i,{description=thing.description .. bens_gear.create_ore_description(bens_gear.search_for_material(to_process))})
			end
		end
	end
	groups_to_process = nil
	for i=1, #bens_gear.on_all_materials_registered do
		bens_gear.on_all_materials_registered[i]()
	end
	for i=1, #bens_gear.ores do
		for l=1, #bens_gear.ore_iterates do
			bens_gear.ore_iterates[l](bens_gear.ores[i])
		end
		for j=1, #bens_gear.rods do
			for x=0, #bens_gear.charms do
				for k=1, #bens_gear.tool_iterates do
					bens_gear.tool_iterates[k](bens_gear.ores[i],bens_gear.rods[j],bens_gear.charms[x] or nil)
				end
			end
		end
	end
end)