Assets = {
    Asset("IMAGE", "images/skilltree/wilson_skilltree.tex"),
    Asset("ATLAS", "images/skilltree/wilson_skilltree.xml"),
    Asset("IMAGE", "images/skilltree/icon-lightfooted.tex"),
    Asset("ATLAS", "images/skilltree/icon-lightfooted.xml"),
    Asset("IMAGE", "images/skilltree/icon-efficient-illumination.tex"),
    Asset("ATLAS", "images/skilltree/icon-efficient-illumination.xml"),
    Asset("IMAGE", "images/skilltree/icon-refueling.tex"),
    Asset("ATLAS", "images/skilltree/icon-refueling.xml"),
    Asset("IMAGE", "images/skilltree/icon-shaven.tex"),
    Asset("ATLAS", "images/skilltree/icon-shaven.xml"),
    Asset("IMAGE", "images/skilltree/icon-beast.tex"),
    Asset("ATLAS", "images/skilltree/icon-beast.xml"),
    Asset("IMAGE", "images/skilltree/icon-goop.tex"),
    Asset("ATLAS", "images/skilltree/icon-goop.xml"),
    Asset("IMAGE", "images/skilltree/icon-chilly.tex"),
    Asset("ATLAS", "images/skilltree/icon-chilly.xml"),
}

RegisterSkilltreeBGForCharacter("images/skilltree/wilson_skilltree.xml", "wilson")
----------------------------------------------------------------------------------

local STRINGS    = GLOBAL.STRINGS
local EQUIPSLOTS = GLOBAL.EQUIPSLOTS
local Ingredient = GLOBAL.Ingredient
local AllRecipes = GLOBAL.AllRecipes

-- The "Backpack slot" mod replaces EQUIPSLOTS entirely, dropping BEARD.
-- Restore it so beard_sack.lua doesn't crash when Wilson's beard grows.
if EQUIPSLOTS.BEARD == nil then
    EQUIPSLOTS.BEARD = "beard"
end
----------------------------------------------------------------------------------
-- Light
STRINGS.SKILLTREE.PANELS.LIGHT                                   = "LIGHT"

STRINGS.SKILLTREE.WILSON.WILSON_TORCH_3_TITLE                    = "Torch Longevity"
STRINGS.SKILLTREE.WILSON.WILSON_TORCH_3_DESC                     = "Wilson's torches burn 50% longer."
STRINGS.SKILLTREE.WILSON.WILSON_TORCH_6_TITLE                    = "Torch Range"
STRINGS.SKILLTREE.WILSON.WILSON_TORCH_6_DESC                     = "Wilson's torches emit a greatly expanded light radius."

STRINGS.SKILLTREE.WILSON.WILSON_TORCH_1_LOCK_DESC                = "Unlock at least 1 Light skill to access this."
-- Torch throw skill unchanged

STRINGS.SKILLTREE.WILSON.WILSON_LIGHT_LOCK_2_DESC                = "Unlock at least 2 Light skills to access these."
STRINGS.SKILLTREE.WILSON.WILSON_LIGHT_CRAFTING_TITLE             = "Efficient Illumination"
STRINGS.SKILLTREE.WILSON.WILSON_LIGHT_CRAFTING_DESC              = "Light tab recipes cost 50% fewer resources."
STRINGS.SKILLTREE.WILSON.WILSON_LIGHT_REFUEL_TITLE               = "Masterful Refueling"
STRINGS.SKILLTREE.WILSON.WILSON_LIGHT_REFUEL_DESC                =
"Wilson refuels light sources (lanterns, campfires etc) at 50% greater efficiency."
STRINGS.SKILLTREE.WILSON.WILSON_LIGHT_SPEED_TITLE                = "Light-Footed"
STRINGS.SKILLTREE.WILSON.WILSON_LIGHT_SPEED_DESC                 =
"Wilson moves 10% faster while a light item is equipped in any slot (does not stack with multiple light items)."
----------------------------------------------------------------------------------
-- Alchemy
STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_1_DESC                   =
    "Transform 2 Twigs into a Log.\n" ..
    "Transform a Log into 2 Twigs."
STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_2_DESC                   =
    "Transform a Red Gem into a Blue Gem.\n" ..
    "Transform a Blue Gem into a Red Gem.\n" ..
    "Transform 2 Purple Gems into an Orange Gem."
STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_5_TITLE                  = "Transmute Gems II"
STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_5_DESC                   =
    "Transform 2 Orange Gems into a Yellow Gem.\n" ..
    "Transform 2 Yellow Gems into a Green Gem.\n" ..
    "Transform 6 Gems of different colors into an Iridescent Gem."
STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_3_TITLE                  = "Transmute Rare I"
STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_3_DESC                   =
    "Transform 2 Gold Nuggets into Nitre. \n" ..
    "Transform 4 Silk into Tentacle Spots.\n" ..
    "Transform 2 Pig Skins into Steel Wool."
STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_7_TITLE                  = "Transmute Rare II"
STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_7_DESC                   =
    "Transform 20 Logs into a Living Log.\n" ..
    "Transform a Volt Goat Horn into a Walrus Tusk."
STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_4_DESC                   =
    "Transform 2 Monster Meat into a Meat.\n" ..
    "Transform a Meat into 2 Morsels."
STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_9_TITLE                  = "Transmute Icky II"
STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_9_DESC                   =
    "Transform 2 Carrots into a Bunny Puff.\n" ..
    "Transform 2 Hound's Teeth into a Bone Shard."

STRINGS.RECIPE_DESC.TRANSMUTE_MEAT                               = "Transmute Monster Meat into Meat."
STRINGS.RECIPE_DESC.TRANSMUTE_ORANGEGEM                          = "Transmute Purple Gems into an Orange Gem."
STRINGS.RECIPE_DESC.TRANSMUTE_YELLOWGEM                          = "Transmute Orange Gems into a Yellow Gem."
STRINGS.RECIPE_DESC.TRANSMUTE_TENTACLESPOTS                      = "Transmute Silk into Tentacle Spots."
STRINGS.RECIPE_DESC.TRANSMUTE_STEELWOOL                          = "Transmute Pig Skin into Steel Wool."
STRINGS.RECIPE_DESC.TRANSMUTE_LIVINGLOG                          = "Transmute Logs into a Living Log."
STRINGS.RECIPE_DESC.TRANSMUTE_WALRUS_TUSK                        = "Transmute a Volt Goat Horn into a Walrus Tusk."
STRINGS.RECIPE_DESC.TRANSMUTE_MANRABBIT_TAIL                     = "Transmute Carrots into a Bunny Puff."
STRINGS.RECIPE_DESC.TRANSMUTE_HORRORFUEL_FROM_NIGHTMAREFUEL      = "Transmute Nightmare Fuel into Pure Horror."
STRINGS.RECIPE_DESC.TRANSMUTE_MOONGLASS_CHARGED_FROM_MOONGLASS   = "Transmute Moon Shards into Infused Moon Shards."
STRINGS.RECIPE_DESC.TRANSMUTE_BEARGER_FUR_TO_DEERCLOPS_EYEBALL   = "Transmute Thick Fur into Deerclops Eyeball."
STRINGS.RECIPE_DESC.TRANSMUTE_DEERCLOPS_EYEBALL_TO_GOOSE_FEATHER = "Transmute Deerclops Eyeball into Down Feathers."
STRINGS.RECIPE_DESC.TRANSMUTE_GOOSE_FEATHER_TO_DRAGON_SCALES     = "Transmute Down Feathers into Dragonfly Scale."
STRINGS.RECIPE_DESC.TRANSMUTE_DRAGON_SCALES_TO_BEARGER_FUR       = "Transmute Dragonfly Scale into Thick Fur."

-- Transmute recipes
local DISABLED_SKILL                                             = "wilson_alchemy_disabled"
local function SetIngredients(recname, ingredients)
    local r = AllRecipes[recname]
    if r then r.ingredients = ingredients end
end
local function SetBuilderSkill(recname, skill)
    local r = AllRecipes[recname]
    if r then r.builder_skill = skill end
end
local function DisableRecipe(recname)
    SetBuilderSkill(recname, DISABLED_SKILL)
    local filter = GLOBAL.CRAFTING_FILTERS.CHARACTER.recipes
    for i = #filter, 1, -1 do
        if filter[i] == recname then table.remove(filter, i) end
    end
end

SetIngredients("transmute_log", { Ingredient("twigs", 2) })

SetIngredients("transmute_bluegem", { Ingredient("redgem", 1) })
SetIngredients("transmute_redgem", { Ingredient("bluegem", 1) })
SetIngredients("transmute_orangegem", { Ingredient("purplegem", 2) })
SetBuilderSkill("transmute_orangegem", "wilson_alchemy_2")
SetIngredients("transmute_yellowgem", { Ingredient("orangegem", 2) })
SetIngredients("transmute_greengem", { Ingredient("yellowgem", 2) })
SetBuilderSkill("transmute_greengem", "wilson_alchemy_5")
SetBuilderSkill("transmute_opalpreciousgem", "wilson_alchemy_5")
SetIngredients("transmute_meat", { Ingredient("monstermeat", 2) })
SetBuilderSkill("transmute_boneshard", "wilson_alchemy_9")
SetBuilderSkill("transmute_nitre", "wilson_alchemy_3")

DisableRecipe("transmute_purplegem")
DisableRecipe("transmute_beardhair")
DisableRecipe("transmute_beefalowool")
DisableRecipe("transmute_houndstooth")
DisableRecipe("transmute_poop")
DisableRecipe("transmute_flint")
DisableRecipe("transmute_rocks")
DisableRecipe("transmute_goldnugget")
DisableRecipe("transmute_marble")
DisableRecipe("transmute_cutstone")
DisableRecipe("transmute_moonrocknugget")
DisableRecipe("transmute_nightmarefuel")
DisableRecipe("transmute_moonglass_charged")

SetIngredients("transmute_dreadstone", { Ingredient("horrorfuel", 2) })
SetIngredients("transmute_purebrilliance", { Ingredient("moonglass_charged", 2) })

local function AddTransmute(name, ingredients, builder_skill, product, image)
    AddRecipe2(name, ingredients, GLOBAL.TECH.NONE, {
        product       = product,
        image         = image or (product .. ".tex"),
        builder_skill = builder_skill,
        description   = name,
    }, { "CHARACTER" })
end

AddTransmute("transmute_tentaclespots", { Ingredient("silk", 4) }, "wilson_alchemy_3", "tentaclespots")
AddTransmute("transmute_steelwool", { Ingredient("pigskin", 2) }, "wilson_alchemy_3", "steelwool")
AddTransmute("transmute_livinglog", { Ingredient("log", 20) }, "wilson_alchemy_7", "livinglog")
AddTransmute("transmute_walrus_tusk", { Ingredient("lightninggoathorn", 1) }, "wilson_alchemy_7", "walrus_tusk")
AddTransmute("transmute_manrabbit_tail", { Ingredient("carrot", 2) }, "wilson_alchemy_9", "manrabbit_tail")
AddTransmute("transmute_horrorfuel_from_nightmarefuel",
    { Ingredient("nightmarefuel", 10) }, "wilson_allegiance_shadow", "horrorfuel")
AddTransmute("transmute_moonglass_charged_from_moonglass",
    { Ingredient("moonglass", 4) }, "wilson_allegiance_lunar", "moonglass_charged")
AddTransmute("transmute_bearger_fur_to_deerclops_eyeball",
    { Ingredient("bearger_fur", 1) }, "wilson_alchemy_8", "deerclops_eyeball")

AddRecipe2("transmute_deerclops_eyeball_to_goose_feather",
    { Ingredient("deerclops_eyeball", 1) }, GLOBAL.TECH.NONE, {
        product       = "goose_feather",
        numtogive     = 10,
        image         = "goose_feather.tex",
        builder_skill = "wilson_alchemy_8",
        description   = "transmute_deerclops_eyeball_to_goose_feather",
    }, { "CHARACTER" })

AddTransmute("transmute_goose_feather_to_dragon_scales",
    { Ingredient("goose_feather", 10) }, "wilson_alchemy_10", "dragon_scales")
AddTransmute("transmute_dragon_scales_to_bearger_fur",
    { Ingredient("dragon_scales", 1) }, "wilson_alchemy_10", "bearger_fur")
----------------------------------------------------------------------------------
-- Beard
STRINGS.SKILLTREE.WILSON.WILSON_BEARD_3_TITLE       = "Beard Insulation"
STRINGS.SKILLTREE.WILSON.WILSON_BEARD_3_DESC        = "Wilson's beard provides 70% more insulation against cold."
STRINGS.SKILLTREE.WILSON.WILSON_BEARD_6_TITLE       = "Beard Growth"
STRINGS.SKILLTREE.WILSON.WILSON_BEARD_6_DESC        = "Wilson's beard grows significantly faster."
STRINGS.SKILLTREE.WILSON.WILSON_BEARD_SHAVED_TITLE  = "Clean Shaven"
STRINGS.SKILLTREE.WILSON.WILSON_BEARD_SHAVED_DESC   = "Shaving grants an additional 40 sanity (50 total)."

STRINGS.SKILLTREE.WILSON.WILSON_BEARD_BEAST_TITLE   = "Beast of a Man"
STRINGS.SKILLTREE.WILSON.WILSON_BEARD_BEAST_DESC    = "Gain double the amount of beard hair from shaving."
STRINGS.SKILLTREE.WILSON.WILSON_BEARD_GOOP_TITLE    = "Five o' Clock Shadow"
STRINGS.SKILLTREE.WILSON.WILSON_BEARD_GOOP_DESC     =
"Consume Glommer's Goop to instantly grow your beard to the next level."

STRINGS.SKILLTREE.WILSON.WILSON_BEARD_1_LOCK_DESC   = "Unlock at least 3 Beard skills to access these."
-- Beard storage skill unchanged
STRINGS.SKILLTREE.WILSON.WILSON_BEARD_CHILLY_TITLE  = "Chilly Beard"
STRINGS.SKILLTREE.WILSON.WILSON_BEARD_CHILLY_DESC   =
"Wilson's beard chills food in the beard inventory, slowing spoilage."

STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_6_LOCK_DESC = "Unlock at least 3 Transmute skills to access these."
STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_8_TITLE     = "Transmute Boss I"
STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_8_DESC      =
    "Transform a Thick Fur into a Deerclops Eyeball.\n" ..
    "Transform a Deerclops Eyeball into 10 Down Feathers."
STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_10_TITLE    = "Transmute Boss II"
STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_10_DESC     =
    "Transform 10 Down Feathers into a Dragonfly Scale.\n" ..
    "Transform a Dragonfly Scale into a Thick Fur."
----------------------------------------------------------------------------------
-- Light recipes lookup — CRAFTING_FILTERS.LIGHT.recipes as a set
----------------------------------------------------------------------------------
local LIGHT_RECIPES_LOOKUP                          = {}
for _, name in ipairs({
    "lighter", "torch", "campfire", "portablefirepit_item", "firepit",
    "coldfire", "coldfirepit", "pumpkin_lantern", "minerhat", "molehat",
    "wx78module_nightvision", "lantern", "wx78module_light", "nightstick",
    "nightlight", "winona_spotlight", "winona_spotlight_item",
    "dragonflyfurnace", "mushroom_light", "mushroom_light2",
    "archive_resonator_item",
}) do
    LIGHT_RECIPES_LOOKUP[name] = true
end
----------------------------------------------------------------------------------
-- Shaved sanity bonus
----------------------------------------------------------------------------------
local function ApplyShavedSanityBonus(inst)
    local stu = inst.components.skilltreeupdater
    if stu and inst.components.sanity then
        local bonus = 0
        if stu:IsActivated("wilson_beard_shaved") then
            bonus = 40
        end
        if bonus > 0 then
            inst.components.sanity:DoDelta(bonus)
        end
    end
end
----------------------------------------------------------------------------------
-- Beast of a Man: spawn extra beard hair equal to what was dropped when shaving
local function DoubleBeardHair(beard, bits_before)
    local extra = bits_before - beard.bits
    if extra > 0 and beard.prize ~= nil then
        for k = 1, extra do
            local bit = GLOBAL.SpawnPrefab(beard.prize)
            local x, y, z = beard.inst.Transform:GetWorldPosition()
            bit.Transform:SetPosition(x, y + 2, z)
            local speed = 1 + math.random()
            local angle = math.random() * GLOBAL.TWOPI
            bit.Physics:SetVel(speed * math.cos(angle), 2 + math.random() * 3, speed * math.sin(angle))
        end
    end
end

AddComponentPostInit("beard", function(self)
    local orig_Shave = self.Shave
    self.Shave = function(self_beard, who, withwhat)
        local bits_before = self_beard.bits
        local result, reason = orig_Shave(self_beard, who, withwhat)
        if result then
            local stu = self_beard.inst.components.skilltreeupdater
            if stu and stu:IsActivated("wilson_beard_beast") then
                DoubleBeardHair(self_beard, bits_before)
            end
        end
        return result, reason
    end
end)
----------------------------------------------------------------------------------
-- Five o' Clock Shadow: eating Glommer's Goop advances beard to next level
local function AdvanceBeardLevel(beard)
    local next_day = nil
    for k in pairs(beard.callbacks) do
        if k > beard.daysgrowth then
            if next_day == nil or k < next_day then
                next_day = k
            end
        end
    end
    if next_day ~= nil then
        beard.daysgrowth = next_day
        local cb = beard.callbacks[next_day]
        if cb then cb(beard.inst, beard.skinname) end
        beard:UpdateBeardInventory()
    end
end

AddPrefabPostInit("glommerfuel", function(inst)
    if not GLOBAL.TheWorld.ismastersim then return end
    if inst.components.edible then
        local orig_oneaten = inst.components.edible.oneaten
        inst.components.edible.oneaten = function(food, eater)
            if orig_oneaten then orig_oneaten(food, eater) end
            if eater and eater.prefab == "wilson" then
                local stu = eater.components.skilltreeupdater
                if stu and stu:IsActivated("wilson_beard_goop") then
                    local beard = eater.components.beard
                    if beard then AdvanceBeardLevel(beard) end
                end
            end
        end
    end
end)
----------------------------------------------------------------------------------
-- Light speed buff
----------------------------------------------------------------------------------
local function RefreshLightSpeedBuff(inst)
    local stu = inst.components.skilltreeupdater
    local has_skill = stu and stu:IsActivated("wilson_light_speed")

    local has_light = false
    if has_skill and inst.components.inventory then
        local inv = inst.components.inventory
        for _, slot in ipairs({ EQUIPSLOTS.HANDS, EQUIPSLOTS.HEAD, EQUIPSLOTS.BODY }) do
            local item = inv:GetEquippedItem(slot)
            if item and LIGHT_RECIPES_LOOKUP[item.prefab] then
                has_light = true
                break
            end
        end
    end

    if inst.components.locomotor then
        if has_light then
            inst.components.locomotor:SetExternalSpeedMultiplier(inst, "wilson_light_speed", 1.10)
        else
            inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "wilson_light_speed")
        end
    end
end

-- Refuel efficiency multiplier returned to fuelmaster component.
local function WilsonLightRefuelBonus(inst, item, target)
    local stu = inst.components.skilltreeupdater
    if stu and stu:IsActivated("wilson_light_refuel")
        and target and LIGHT_RECIPES_LOOKUP[target.prefab] then
        return 1.5
    end
    return 1
end

----------------------------------------------------------------------------------
-- Chilly Beard: tag the beard_sack with "fridge" + "nocool"
local function RefreshChillyTags(beardsack)
    local owner = beardsack.components.inventoryitem and beardsack.components.inventoryitem.owner
    local has_chilly = owner
        and owner.components.skilltreeupdater
        and owner.components.skilltreeupdater:IsActivated("wilson_beard_chilly")

    if has_chilly and not beardsack:HasTag("fridge") then
        beardsack:AddTag("fridge")
        beardsack:AddTag("nocool")
    elseif not has_chilly and beardsack:HasTag("fridge") then
        beardsack:RemoveTag("fridge")
        beardsack:RemoveTag("nocool")
    end
end

local function BeardSackPostInit(inst)
    if not GLOBAL.TheWorld.ismastersim then return end

    inst:ListenForEvent("equipped", function(inst, data)
        RefreshChillyTags(inst)
        if data and data.owner then
            inst._chilly_owner   = data.owner
            inst._chilly_watcher = function() RefreshChillyTags(inst) end
            data.owner:ListenForEvent("wilson_beard_skill_changed", inst._chilly_watcher)
        end
    end)

    inst:ListenForEvent("unequipped", function(inst, data)
        if inst._chilly_owner and inst._chilly_watcher then
            inst._chilly_owner:RemoveEventCallback("wilson_beard_skill_changed", inst._chilly_watcher)
            inst._chilly_owner   = nil
            inst._chilly_watcher = nil
        end
        RefreshChillyTags(inst)
    end)
end

AddPrefabPostInit("beard_sack_1", BeardSackPostInit)
AddPrefabPostInit("beard_sack_2", BeardSackPostInit)
AddPrefabPostInit("beard_sack_3", BeardSackPostInit)

----------------------------------------------------------------------------------
-- Wilson PostInit
----------------------------------------------------------------------------------
AddPrefabPostInit("wilson", function(inst)
    if not GLOBAL.TheWorld.ismastersim then return end

    -- Shaved sanity bonus
    inst:ListenForEvent("shaved", function(inst)
        ApplyShavedSanityBonus(inst)
    end)

    -- Light speed buff listeners
    inst:ListenForEvent("equip", function(inst) RefreshLightSpeedBuff(inst) end)
    inst:ListenForEvent("unequip", function(inst) RefreshLightSpeedBuff(inst) end)
    inst:ListenForEvent("wilson_light_skill_changed", function(inst)
        RefreshLightSpeedBuff(inst)
    end)

    -- Light refuel bonus via fuelmaster component
    if not inst.components.fuelmaster then
        inst:AddComponent("fuelmaster")
    end
    inst.components.fuelmaster:SetBonusFn(WilsonLightRefuelBonus)

    -- Light crafting discount: temporarily swap recipe.ingredients so HasIngredients
    -- and GetIngredients (called inside DoBuild) both see 50% amounts.
    -- We deliberately avoid mutating self.ingredientmod because that triggers the
    -- oningredientmod setter, which calls SetIngredientMod and syncs the value to
    -- the client replica — overwriting the persistent classified.ingredientmod=HALF
    -- we set client-side for the button affordability check.
    local function WithLightDiscount(recname, fn)
        local stu = inst.components.skilltreeupdater
        if recname and LIGHT_RECIPES_LOOKUP[recname]
            and stu and stu:IsActivated("wilson_light_crafting") then
            local recipe = AllRecipes[recname]
            if recipe and recipe.ingredients then
                local orig_ingredients = recipe.ingredients
                local discounted = {}
                for i, ing in ipairs(orig_ingredients) do
                    discounted[i] = Ingredient(ing.type, math.max(1, math.ceil(ing.amount * 0.5)))
                end
                recipe.ingredients = discounted
                local result = fn()
                recipe.ingredients = orig_ingredients
                return result
            end
        end
        return fn()
    end

    local orig_DoBuild = inst.components.builder.DoBuild
    inst.components.builder.DoBuild = function(self, recname, pt, rotation, skin)
        return WithLightDiscount(recname, function()
            return orig_DoBuild(self, recname, pt, rotation, skin)
        end)
    end

    local orig_BufferBuild = inst.components.builder.BufferBuild
    inst.components.builder.BufferBuild = function(self, recname)
        return WithLightDiscount(recname, function()
            return orig_BufferBuild(self, recname)
        end)
    end

    local orig_HasIngredients = inst.components.builder.HasIngredients
    inst.components.builder.HasIngredients = function(self, recipe)
        local recname = type(recipe) == "string" and recipe
            or (recipe ~= nil and recipe.name or nil)
        return WithLightDiscount(recname, function()
            return orig_HasIngredients(self, recipe)
        end)
    end

    -- Deferred so component save data is loaded before we calculate.
    inst:DoTaskInTime(0, function(inst)
        RefreshLightSpeedBuff(inst)
    end)
end)

----------------------------------------------------------------------------------
-- Skill tree registration
----------------------------------------------------------------------------------
local SkillTreeDefs   = require("prefabs/skilltree_defs")
local BuildSkillsData = require("prefabs/skilltree_wilson_rework")
local data            = BuildSkillsData(SkillTreeDefs.FN)
SkillTreeDefs.CreateSkillTreeFor("wilson", data.SKILLS)
SkillTreeDefs.SKILLTREE_ORDERS["wilson"] = data.ORDERS

----------------------------------------------------------------------------------
-- Client-side crafting UI: discount ingredient display and affordability for
-- light-tab recipes when wilson_light_crafting is active.
--
-- Both craftingmenu_ingredients and ingredientui call builder:IngredientMod()
-- to compute displayed amounts and the green/red affordability check.
-- We patch that method once on the builder replica and drive it with a flag
-- that tracks whether the currently selected recipe is a light one.
-- This avoids touching classified.ingredientmod globally, which would bleed
-- the -50% display into every other recipe widget.
----------------------------------------------------------------------------------
if not GLOBAL.TheNet:IsDedicated() then
    local _light_discount_for_selected = false

    AddClassPostConstruct("widgets/redux/craftingmenu_ingredients", function(self)
        local orig_SetRecipe = self.SetRecipe
        self.SetRecipe = function(self, recipe)
            local owner = self.owner
            local is_light = recipe ~= nil and LIGHT_RECIPES_LOOKUP[recipe.name]
            local has_skill = owner ~= nil
                and owner.components ~= nil
                and owner.components.skilltreeupdater ~= nil
                and owner.components.skilltreeupdater:IsActivated("wilson_light_crafting")

            _light_discount_for_selected = is_light and has_skill

            -- Patch IngredientMod on the builder replica once. After this, every
            -- call to builder:IngredientMod() returns 0.5 while a light recipe is
            -- selected, covering both the displayed amount and the button check.
            local builder_replica = owner ~= nil and owner.replica ~= nil and owner.replica.builder
            if builder_replica and not builder_replica._wilson_light_mod_patched then
                local orig_IngredientMod = builder_replica.IngredientMod
                builder_replica.IngredientMod = function(self)
                    if _light_discount_for_selected then return 0.5 end
                    return orig_IngredientMod(self)
                end
                builder_replica._wilson_light_mod_patched = true
            end

            return orig_SetRecipe(self, recipe)
        end
        if self.recipe ~= nil then
            self:SetRecipe(self.recipe)
        end
    end)
end
