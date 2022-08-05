local S = minetest.get_translator()

bens_gear.reduce_tool_stat("draconis:pick_dragonbone")
bens_gear.reduce_tool_stat("draconis:shovel_dragonbone")
bens_gear.reduce_tool_stat("draconis:axe_dragonbone")
bens_gear.reduce_tool_stat("draconis:sword_dragonbone")

bens_gear.reduce_tool_stat("draconis:pick_ice_draconic_steel")
bens_gear.reduce_tool_stat("draconis:shovel_ice_draconic_steel")
bens_gear.reduce_tool_stat("draconis:axe_ice_draconic_steel")
bens_gear.reduce_tool_stat("draconis:sword_ice_draconic_steel")

bens_gear.reduce_tool_stat("draconis:pick_fire_draconic_steel")
bens_gear.reduce_tool_stat("draconis:shovel_fire_draconic_steel")
bens_gear.reduce_tool_stat("draconis:axe_fire_draconic_steel")
bens_gear.reduce_tool_stat("draconis:sword_fire_draconic_steel")


bens_gear.add_rod({
	internal_name = "draconis_bone_r",
	display_name = S("Dragon Bone Rod"),
	item_name = "draconis:dragon_bone",
	color = "585C58",
	uses_multiplier = 1.2,
	speed_multiplier = 1.25,
	damage_multiplier = 1.2,
	full_punch_interval_multiplier = 1.5,
	rod_main_texture = {"bens_gear_rod_def.png",true},
	flammable = true,
	rod_textures = {
		default_alias = "def", --what to append to the end of the default texture name, example: "bens_gear_rod_pick_" would become "bens_gear_rod_pick_def", custom tools might have their own texture varients
		--pickaxe = {"bens_gear_rod_pick_def",true} --use a custom rod for pickaxes, you can add more for other tools.
	}
})

bens_gear.add_ore({
	internal_name = "draconis_bone",
	display_name = S("Dragon Bone"),
	item_name = "draconis:dragon_bone",
	max_drop_level = 3,
	damage_groups_any = {fleshy=4},
	damage_groups_sword = {fleshy=12},
	damage_groups_axe = {fleshy=6},
	full_punch_interval = 0.4,
	uses = 40,
	flammable = false,
	groupcaps = { --the groupcaps for the tool. durability is typically used instead of "uses" so there is no need to define it
        crumbly = {times = {[1] = 0.8, [2] = 0.6, [3] = 0.4}, maxlevel = 3},
		cracky = {times = {[1] = 1.2, [2] = 0.8, [3] = 0.6}, maxlevel = 3},
		choppy = {times = {[1] = 1.2, [2] = 0.8, [3] = 0.6},maxlevel = 3},
		snappy = {times = {[1] = 0.4, [2] = 0.2, [3] = 0.1},maxlevel = 3}
	
	},
	tool_list = {
	--"pickaxe"
	},
	tool_list_whitelist = false, --if this is true, then tool_list should act like a whitelist, otherwise, it'll act like a blacklist
	color = "4A4D4A",
	tool_textures = {
		default_alias = "stone", --what to append to the end of the default texture name, example: "bens_gear_axe_" would become "bens_gear_axe_metal"
		pickaxe = {"bens_gear_dragonbone_pick.png",false},
		axe = {"bens_gear_dragonbone_axe.png",false},
		shovel = {"bens_gear_dragonbone_shovel.png",false},
		sword = {"bens_gear_dragonbone_sword.png",false},
		hoe = {"bens_gear_dragonbone_hoe.png",false}
	},
	misc_data = {magic=6}, --here you can store various other weird stats for other mods to utilize, the only stat that is officially supported at the moment is "magic"
	additional_functions = { --a list of additional functions that'll be called upon certain conditions. This is here so that custom tools don't have to have support manually added.
		node_mined = nil,
		tool_destroyed = nil,
		tool_attempt_place = nil,
        after_use = nil
	},
	pre_finalization_function = function(tool_id,data,name)
        if (tool_id == "hoe" or tool_id == "pickaxe" or tool_id == "axe" or tool_id == "shovel" or tool_id == "sword") then
            data.wield_scale = {x = 1.5, y = 1.5, z = 1}
        end
    end
	--this function should be called RIGHT BEFORE the tool/item/whatever gets created, so that the material can add its own custom handling/data
	--it should be called like this: func(tool_id,data)
})

local elements = {"ice", "fire"}

for i=1, 2 do
    local e = elements[i]
    local name = S("Fire-Forged Draconic Steel")
    local col = "CEBFBB"
    if (e == "ice") then
        name = S("Ice-Forged Draconic Steel")
        col = "CDE4E8"
    end
    bens_gear.add_ore({
        internal_name = "draconis_" .. e .. "steel",
        display_name = name,
        item_name = "draconis:draconic_steel_ingot_" .. e,
        max_drop_level = 3,
        damage_groups_any = {fleshy=30},
        damage_groups_sword = {fleshy=60},
        damage_groups_axe = {fleshy=55},
        full_punch_interval = 1.4,
        uses = 90,
        flammable = false,
        groupcaps = { --the groupcaps for the tool. durability is typically used instead of "uses" so there is no need to define it
            crumbly = {times = {[1] = 0.4, [2] = 0.2, [3] = 0.1},maxlevel = 3},
            cracky = {times={[1]=0.3, [2]=0.15, [3]=0.075}, maxlevel=3},
            choppy = {times={[1]=0.3, [2]=0.15, [3]=0.075},maxlevel = 3},
            snappy = {times = {[1] = 0.05, [2] = 0.025, [3] = 0.01},maxlevel = 3},
        },
        tool_list = {
        --"pickaxe"
        },
        tool_list_whitelist = false, --if this is true, then tool_list should act like a whitelist, otherwise, it'll act like a blacklist
        color = col,
        tool_textures = {
            default_alias = "metal", --what to append to the end of the default texture name, example: "bens_gear_axe_" would become "bens_gear_axe_metal"
            pickaxe = {"bens_gear_dragon" .. e .. "_pick.png",false},
            axe = {"bens_gear_dragon" .. e .. "_axe.png",false},
            shovel = {"bens_gear_dragon" .. e .. "_shovel.png",false},
            sword = {"bens_gear_dragon" .. e .. "_sword.png",false},
            hoe = {"bens_gear_dragon" .. e .. "_hoe.png",false}
        },
        misc_data = {magic=9}, --here you can store various other weird stats for other mods to utilize, the only stat that is officially supported at the moment is "magic"
        additional_functions = { --a list of additional functions that'll be called upon certain conditions. This is here so that custom tools don't have to have support manually added.
            node_mined = nil,
            tool_destroyed = nil,
            tool_attempt_place = nil,
            after_use = nil
        },
        pre_finalization_function = function(tool_id,data,name)
            if (tool_id == "hoe" or tool_id == "pickaxe" or tool_id == "axe" or tool_id == "shovel" or tool_id == "sword") then
                data.wield_scale = {x = 2, y = 2, z = 1}
            end
        end
        --this function should be called RIGHT BEFORE the tool/item/whatever gets created, so that the material can add its own custom handling/data
        --it should be called like this: func(tool_id,data)
    })
end