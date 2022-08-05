local S = minetest.get_translator()

bens_gear.reduce_tool_stat("nether:pick_nether")
bens_gear.reduce_tool_stat("nether:axe_nether")
bens_gear.reduce_tool_stat("nether:shovel_nether")
bens_gear.reduce_tool_stat("nether:sword_nether")


bens_gear.add_ore({
	internal_name = "nether_nether",
	display_name = S("Nether"),
	item_name = "nether:nether_ingot",
	max_drop_level = 3,
	damage_groups_any = {fleshy=4},
	damage_groups_sword = {fleshy=10},
	damage_groups_axe = {fleshy=7},
	full_punch_interval = 0.8,
	uses = 35,
	flammable = false,
	groupcaps = { --the groupcaps for the tool. durability is typically used instead of "uses" so there is no need to define it
        crumbly = {times={[1]=1.0, [2]=0.4, [3]=0.25}, maxlevel=3},
		cracky = {times={[1]=1.90, [2]=0.9, [3]=0.3}, maxlevel=2},
		choppy = {times={[1]=1.9, [2]=0.7, [3]=0.4}, maxlevel=3},
		snappy = {times={[1]=1.5, [2]=0.6, [3]=0.2}, maxlevel=3},
	
	},
	tool_list = {
	--"pickaxe"
	},
	tool_list_whitelist = false, --if this is true, then tool_list should act like a whitelist, otherwise, it'll act like a blacklist
	color = "718470",
	tool_textures = {
		default_alias = "metal", --what to append to the end of the default texture name, example: "bens_gear_axe_" would become "bens_gear_axe_metal"
		pickaxe = {"bens_gear_nether_pick.png",false},
		axe = {"bens_gear_nether_axe.png",false},
		shovel = {"bens_gear_nether_shovel.png",false},
		sword = {"bens_gear_nether_sword.png",false},
		hoe = {"bens_gear_hoe_gem.png",true}
	},
	misc_data = {magic=11}, --here you can store various other weird stats for other mods to utilize, the only stat that is officially supported at the moment is "magic"
	additional_functions = { --a list of additional functions that'll be called upon certain conditions. This is here so that custom tools don't have to have support manually added.
		node_mined = nil,
		tool_destroyed = nil,
		tool_attempt_place = nil,
        after_use = function(itemstack, user, node, digparams)
            local wearDivisor = 1
            local nodeDef = minetest.registered_nodes[node.name]
            if nodeDef ~= nil and nodeDef.groups ~= nil then
                -- The nether pick hardly wears out when mining netherrack
                local workable = nodeDef.groups.workable_with_nether_tools or 0
                wearDivisor =  1 + (3 * workable) -- 10 for netherrack, 1 otherwise. Making it able to mine 350 netherrack nodes, instead of 35.
            end
    
            local wear = math.floor(digparams.wear / wearDivisor)
            itemstack:add_wear(wear)  -- apply the adjusted wear as usual
            return itemstack
        end
	},
	pre_finalization_function = function(tool_type,data)
        if (tool_type == "pickaxe") then
            data.description = data.description .. "\n" .. S("Well suited for mining netherrack")
        end
	end
	--this function should be called RIGHT BEFORE the tool/item/whatever gets created, so that the material can add its own custom handling/data
	--it should be called like this: func(tool_id,data)
})