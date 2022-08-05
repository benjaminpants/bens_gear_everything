
local S = minetest.get_translator()

bens_gear.create_blueprint_and_template("pickaxe",S("Pickaxe"),"bens_gear_outline_pickaxe.png",{
{true,true,true},
{false,true,false},
{false,true,false}
},3)

bens_gear.create_example_item("pickaxe_head_example","Example Pickaxe Head", "bens_gear_pick_metal.png")

bens_gear.create_example_item("pickaxe_example","Example Pickaxe", "default_tool_bronzepick.png")

minetest.register_craft({
		type = "shapeless",
		output = "bens_gear:pickaxe_head_example 1",
		recipe = {
			"bens_gear:blueprint_pickaxe", "bens_gear:invalid_material", "bens_gear:invalid_material", "bens_gear:invalid_material"
		}
})

minetest.register_craft({
		type = "shapeless",
		output = "bens_gear:pickaxe_head_example 1",
		recipe = {
			"bens_gear:template_pickaxe", "bens_gear:invalid_material", "bens_gear:invalid_material", "bens_gear:invalid_material"
		}
})

minetest.register_craft({
		
		output = "bens_gear:pickaxe_example 1",
		recipe = {
		{"","bens_gear:pickaxe_head_example",""},
		{"","bens_gear:invalid_rod",""},
		{"","bens_gear:invalid_rod","bens_gear:example_charm"}
		}

})


bens_gear.add_ore_iterate(function(ore_data)
	if (not bens_gear.can_tool_be_made("pickaxe",ore_data)) then return end
	local pick_head_texture = bens_gear.get_viable_tool_texture("pickaxe","bens_gear_pick_",ore_data.tool_textures,ore_data.color)
	minetest.register_craftitem(":bens_gear:pickaxe_head_" .. ore_data.internal_name, {
	description = S("@1 Pickaxe Head", ore_data.display_name),
	inventory_image = pick_head_texture
	})
	minetest.register_craft({
		type = "shapeless",
		output = "bens_gear:pickaxe_head_" .. ore_data.internal_name .. " 1",
		recipe = {
			"bens_gear:blueprint_pickaxe", ore_data.item_name, ore_data.item_name, ore_data.item_name
		},
		replacements = {{"bens_gear:blueprint_pickaxe","bens_gear:blueprint_pickaxe"}}
	})
	minetest.register_craft({
		type = "shapeless",
		output = "bens_gear:pickaxe_head_" .. ore_data.internal_name .. " 1",
		recipe = {
			"bens_gear:template_pickaxe", ore_data.item_name, ore_data.item_name, ore_data.item_name
		}
	})
end)


bens_gear.add_tool_iterate(function(ore_data,rod_data, charm_data)

if (not bens_gear.can_tool_be_made("pickaxe",ore_data)) then return end

local last_append = "no_charm"
if (charm_data ~= nil) then
	last_append = charm_data.charm_name
end

local charm_texture = ""
if (charm_data ~= nil) then
	charm_texture = "^" .. bens_gear.get_viable_tool_texture_no_default("pickaxe",charm_data.valid_tools)
	if (charm_texture == "^") then
		charm_texture = ""
		return
	end
end

local pick_head_texture = bens_gear.get_viable_tool_texture("pickaxe","bens_gear_pick_",ore_data.tool_textures,ore_data.color)
local pick_name = "bens_gear:pickaxe_" .. ore_data.internal_name .. "_" .. rod_data.internal_name .. "_" .. last_append
local rod_texture = bens_gear.get_viable_tool_texture("pickaxe","bens_gear_rod_pick_",rod_data.rod_textures,rod_data.color)
local can_fire = (ore_data.flammable and rod_data.flammable)
local temp_groups = {}

if (can_fire) then
	temp_groups = {pickaxe = 1, flammable = 2}
	minetest.register_craft({
		type = "fuel",
		recipe = pick_name,
		burntime = 5,
	})
else
	temp_groups = {pickaxe = 1}
end

temp_groups["not_in_creative_inventory"] = 1

temp_groups["beng_o_" .. ore_data.internal_name] = 1

temp_groups["beng_r_" .. rod_data.internal_name] = 1

local pick_data = {
	description = S("@1 Pickaxe",ore_data.display_name),
	short_description = S("@1 Pickaxe",ore_data.display_name),
	inventory_image = "(" .. rod_texture .. ")^" .. "(" .. pick_head_texture .. ")" .. charm_texture,
	tool_capabilities = {
		full_punch_interval = (ore_data.full_punch_interval * 1.1) * rod_data.full_punch_interval_multiplier,
		max_drop_level=ore_data.max_drop_level,
		groupcaps={
			cracky = bens_gear.multiply_times(ore_data.groupcaps.cracky,rod_data.speed_multiplier),
		},
		damage_groups = bens_gear.multiply_groups(ore_data.damage_groups_any,rod_data.damage_multiplier),
	},
	sound = {breaks = "default_tool_breaks"},
	groups=temp_groups
}

pick_data.tool_capabilities.groupcaps.cracky.uses = math.ceil(ore_data.uses * rod_data.uses_multiplier)

pick_data.after_use = ore_data.additional_functions.after_use

pick_data.on_place = ore_data.additional_functions["tool_attempt_place"]

pick_data.on_node_mine = ore_data.additional_functions["node_mined"]

if (rod_data.pre_finalization_function ~= nil) then
	rod_data.pre_finalization_function("pickaxe",pick_data,pick_name)
end

if (ore_data.pre_finalization_function ~= nil) then
	ore_data.pre_finalization_function("pickaxe",pick_data,pick_name)
end

if (charm_data ~= nil) then
	charm_data.charm_function("pickaxe",pick_data,ore_data,rod_data,pick_name)
end

pick_data.description = pick_data.description .. bens_gear.add_tool_generic_description(pick_data,ore_data,rod_data,"cracky",pick_data.tool_capabilities.groupcaps.cracky.uses)


bens_gear.mine_tool_functions[pick_name] = pick_data.on_node_mine

minetest.register_tool(":" .. pick_name, pick_data)

charm_data = charm_data or {}

minetest.register_craft({
		
		output = pick_name .. " 1",
		recipe = {
		{"","bens_gear:pickaxe_head_" .. ore_data.internal_name,""},
		{"",rod_data.mod_origin .. ":rod_" .. rod_data.internal_name,""},
		{"",rod_data.mod_origin .. ":rod_" .. rod_data.internal_name,charm_data.item_name or ""}
		}

})

end)
