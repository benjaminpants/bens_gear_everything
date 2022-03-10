
local S = minetest.get_translator()

bens_gear.create_blueprint_and_template("axe",S("Axe"),"bens_gear_outline_axe.png",{
{true,true,false},
{true,true,false},
{false,true,false}
},3)

bens_gear.create_example_item("axe_head_example","Example Axe Head", "bens_gear_axe_metal.png")

bens_gear.create_example_item("axe_example","Example Axe", "default_tool_bronzeaxe.png")

minetest.register_craft({
		type = "shapeless",
		output = "bens_gear:axe_head_example 1",
		recipe = {
			"bens_gear:blueprint_axe", "bens_gear:invalid_material", "bens_gear:invalid_material", "bens_gear:invalid_material"
		}
})

minetest.register_craft({
		type = "shapeless",
		output = "bens_gear:axe_head_example 1",
		recipe = {
			"bens_gear:template_axe", "bens_gear:invalid_material", "bens_gear:invalid_material", "bens_gear:invalid_material"
		}
})

minetest.register_craft({
		
		output = "bens_gear:axe_example 1",
		recipe = {
		{"","bens_gear:axe_head_example",""},
		{"","bens_gear:invalid_rod",""},
		{"","bens_gear:invalid_rod","bens_gear:example_charm"}
		}

})

bens_gear.add_ore_iterate(function(ore_data)
	local axe_head_texture = bens_gear.get_viable_tool_texture("axe","bens_gear_axe_",ore_data.tool_textures,ore_data.color)
	minetest.register_craftitem(":bens_gear:axe_head_" .. ore_data.internal_name, {
	description = S("@1 Axe Head", ore_data.display_name),
	inventory_image = axe_head_texture
	})
	minetest.register_craft({
		type = "shapeless",
		output = "bens_gear:axe_head_" .. ore_data.internal_name .. " 1",
		recipe = {
			"bens_gear:blueprint_axe", ore_data.item_name, ore_data.item_name, ore_data.item_name
		},
		replacements = {{"bens_gear:blueprint_axe","bens_gear:blueprint_axe"}}
	})
	minetest.register_craft({
		type = "shapeless",
		output = "bens_gear:axe_head_" .. ore_data.internal_name .. " 1",
		recipe = {
			"bens_gear:template_axe", ore_data.item_name, ore_data.item_name, ore_data.item_name
		}
	})
end)


bens_gear.add_tool_iterate(function(ore_data,rod_data, charm_data)

if (not bens_gear.can_tool_be_made("axe",ore_data)) then return end

local last_append = "no_charm"
if (charm_data ~= nil) then
	last_append = charm_data.charm_name
end

local charm_texture = ""
if (charm_data ~= nil) then
	charm_texture = "^" .. bens_gear.get_viable_tool_texture_no_default("axe",charm_data.valid_tools)
	if (charm_texture == "^") then
		charm_texture = ""
		return
	end
end

local axe_head_texture = bens_gear.get_viable_tool_texture("axe","bens_gear_axe_",ore_data.tool_textures,ore_data.color)
local pick_name = "bens_gear:axe_" .. ore_data.internal_name .. "_" .. rod_data.internal_name .. "_" .. last_append
local rod_texture = bens_gear.get_viable_tool_texture("axe","bens_gear_rod_axe_",rod_data.rod_textures,rod_data.color)
local can_fire = (ore_data.flammable and rod_data.flammable)
local temp_groups = {}

if (can_fire) then
	temp_groups = {axe = 1, flammable = 2}
	minetest.register_craft({
		type = "fuel",
		recipe = pick_name,
		burntime = 5,
	})
else
	temp_groups = {axe = 1}
end

temp_groups["not_in_creative_inventory"] = 1

local axe_data = {
	description = S("@1 Axe",ore_data.display_name),
	short_description = S("@1 Axe",ore_data.display_name),
	inventory_image = "(" .. rod_texture .. ")^" .. "(" .. axe_head_texture .. ")" .. charm_texture,
	tool_capabilities = {
		full_punch_interval = (ore_data.full_punch_interval * 1.22) * rod_data.full_punch_interval_multiplier,
		max_drop_level=ore_data.max_drop_level,
		groupcaps={
			choppy = bens_gear.multiply_times(ore_data.groupcaps.choppy,rod_data.speed_multiplier),
		},
		damage_groups = bens_gear.multiply_groups(ore_data.damage_groups_axe,rod_data.damage_multiplier),
	},
	sound = {breaks = "default_tool_breaks"},
	groups=temp_groups
}


axe_data.tool_capabilities.groupcaps.choppy.uses = math.ceil(ore_data.uses * rod_data.uses_multiplier)

axe_data.on_place = ore_data.additional_functions["tool_attempt_place"]

axe_data.on_node_mine = ore_data.additional_functions["node_mined"]

if (ore_data.pre_finalization_function ~= nil) then
	ore_data.pre_finalization_function("axe",axe_data)
end

if (charm_data ~= nil) then
	charm_data.charm_function("axe",axe_data,ore_data,rod_data,pick_name)
end

axe_data.description = axe_data.description .. bens_gear.add_tool_generic_description(axe_data,ore_data,rod_data,"choppy",axe_data.tool_capabilities.groupcaps.choppy.uses)


bens_gear.mine_tool_functions[pick_name] = axe_data.on_node_mine

minetest.register_tool(":" .. pick_name, axe_data)

charm_data = charm_data or {}

minetest.register_craft({
		
		output = pick_name .. " 1",
		recipe = {
		{"","bens_gear:axe_head_" .. ore_data.internal_name,""},
		{"",rod_data.mod_origin .. ":rod_" .. rod_data.internal_name,""},
		{"",rod_data.mod_origin .. ":rod_" .. rod_data.internal_name,charm_data.item_name or ""}
		}

})

end)
