--[[ Blueprint Bundle/Package.
By default this is given to every player.
It selects 1 random item from each slot.
Also please only put blueprints in the tables I will shame you if you put anything else in them

]]

local S = minetest.get_translator()
 
 
local choosechance = function(weightedlist) --totally not copied from minetest backrooms no why would i ever do that
	local currentweight = 0
	local maxweight = 0
	local currentoutcome = weightedlist[1][1]
	for i=1, #weightedlist do
		maxweight = maxweight + weightedlist[i][2]
	end
	currentweight = math.random(0,maxweight)
	for i=1, #weightedlist do
		if (weightedlist[i][2] > currentweight) then
			currentoutcome = weightedlist[i][1]
			break
		else
			currentweight = currentweight - weightedlist[i][2]
		end
	end
	return currentoutcome
end


bens_gear.blueprint_package = {}
bens_gear.blueprint_package.blueprints = {}
bens_gear.blueprint_package.add_tool_type_as_new_slot = function(tool_type,weight)
	table.insert(bens_gear.blueprint_package.blueprints,{{tool_type,weight}})
end

bens_gear.blueprint_package.add_tool_type_to_existing_slot = function(slot,tool_type,weight)
	table.insert(bens_gear.blueprint_package.blueprints[slot],{tool_type,weight})
end

bens_gear.blueprint_package.add_tool_type_as_new_slot("bens_gear:blueprint_pickaxe",100)
bens_gear.blueprint_package.add_tool_type_as_new_slot("bens_gear:blueprint_axe",100)
bens_gear.blueprint_package.add_tool_type_as_new_slot("bens_gear:blueprint_shovel",100)
bens_gear.blueprint_package.add_tool_type_as_new_slot("bens_gear:blueprint_sword",100)

minetest.register_craftitem("bens_gear:blueprint_package", {
	description = S("Blueprint Package"),
	inventory_image = "bens_gear_blueprint_bundle.png",
	on_use = function(itemstack, user, pointed_thing)
		itemstack:take_item()
		for i=1, #bens_gear.blueprint_package.blueprints do
			local stack = ItemStack(choosechance(bens_gear.blueprint_package.blueprints[i]))
			user:get_inventory():add_item("main",stack)
		end
		return itemstack
	end
})


minetest.register_on_newplayer(function(player)
	player:get_inventory():add_item("main", "bens_gear:blueprint_package")
end)