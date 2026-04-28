local ORDERS =
{
    { "light",      { -214 + 18, 176 + 30 } },
    { "alchemy",    { -62, 176 + 30 } },
    { "beard",      { 85, 176 + 30 } },
    { "allegiance", { 204, 176 + 30 } },
}

local function BuildSkillsData(SkillTreeFns)
    local skills =
    {
        --------------------------------------------------------------------------
        -- LIGHT (reuses torch_3/6 IDs for vanilla behavior)
        -- 50% longer torch burn time
        wilson_torch_3 = {
            title = STRINGS.SKILLTREE.WILSON.WILSON_TORCH_3_TITLE,
            desc  = STRINGS.SKILLTREE.WILSON.WILSON_TORCH_3_DESC,
            icon  = "wilson_torch_time_3",
            pos   = { -214 + 6, 176 },
            group = "light",
            tags  = { "light", "light1" },
            root  = true,
        },

        -- 4x torch light radius
        wilson_torch_6 = {
            title        = STRINGS.SKILLTREE.WILSON.WILSON_TORCH_6_TITLE,
            desc         = STRINGS.SKILLTREE.WILSON.WILSON_TORCH_6_DESC,
            icon         = "wilson_torch_brightness_3",
            pos          = { -214 + 38 + 6, 176 },
            group        = "light",
            tags         = { "light", "light1" },
            root         = true,
            defaultfocus = true,
        },

        wilson_torch_lock_1 = {
            desc      = STRINGS.SKILLTREE.WILSON.WILSON_TORCH_1_LOCK_DESC,
            pos       = { -214 + 18 + 6, 138 },
            group     = "light",
            tags      = { "light", "lock" },
            root      = true,
            lock_open = function(prefabname, activatedskills, readonly)
                return SkillTreeFns.CountTags(prefabname, "light1", activatedskills) >= 1
            end,
            connects  = { "wilson_torch_7" },
        },

        wilson_torch_7 = {
            title = STRINGS.SKILLTREE.WILSON.WILSON_TORCH_7_TITLE,
            desc  = STRINGS.SKILLTREE.WILSON.WILSON_TORCH_7_DESC,
            icon  = "wilson_torch_throw",
            pos   = { -214 + 18 + 6, 100 },
            group = "light",
            tags  = { "light", "light1" },
        },

        wilson_light_lock_2 = {
            desc      = STRINGS.SKILLTREE.WILSON.WILSON_LIGHT_LOCK_2_DESC,
            pos       = { -214 + 18 + 6, 62 },
            group     = "light",
            tags      = { "light", "lock" },
            root      = true,
            lock_open = function(prefabname, activatedskills, readonly)
                return SkillTreeFns.CountTags(prefabname, "light1", activatedskills) >= 2
            end,
            connects  = { "wilson_light_crafting", "wilson_light_refuel", "wilson_light_speed" },
        },

        -- 50% discount on light-tab recipes
        wilson_light_crafting = {
            title = STRINGS.SKILLTREE.WILSON.WILSON_LIGHT_CRAFTING_TITLE,
            desc  = STRINGS.SKILLTREE.WILSON.WILSON_LIGHT_CRAFTING_DESC,
            icon  = "wilson_alchemy_1",
            pos   = { -214 + 18 + 6 - 38, 24 },
            group = "light",
            tags  = { "light" },
        },

        -- +50% refuel efficiency for light items
        wilson_light_refuel = {
            title = STRINGS.SKILLTREE.WILSON.WILSON_LIGHT_REFUEL_TITLE,
            desc  = STRINGS.SKILLTREE.WILSON.WILSON_LIGHT_REFUEL_DESC,
            icon  = "wilson_torch_time_3",
            pos   = { -214 + 18 + 6, 24 },
            group = "light",
            tags  = { "light" },
        },

        -- +10% speed while carrying light item
        wilson_light_speed = {
            title        = STRINGS.SKILLTREE.WILSON.WILSON_LIGHT_SPEED_TITLE,
            desc         = STRINGS.SKILLTREE.WILSON.WILSON_LIGHT_SPEED_DESC,
            icon         = "wilson_torch_brightness_3",
            pos          = { -214 + 18 + 6 + 38, 24 },
            group        = "light",
            tags         = { "light" },
            onactivate   = function(inst, fromload)
                if not fromload then inst:PushEvent("wilson_light_skill_changed") end
            end,
            ondeactivate = function(inst, fromload)
                if not fromload then inst:PushEvent("wilson_light_skill_changed") end
            end,
        },
        --------------------------------------------------------------------------
        -- ALCHEMY (branches condensed 3 tiers → 2, IDs reused for vanilla compat)
        wilson_alchemy_1 = {
            title    = STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_1_TITLE,
            desc     = STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_1_DESC,
            icon     = "wilson_alchemy_1",
            pos      = { -62 + 4, 176 },
            group    = "alchemy",
            tags     = { "alchemy", "trans1" },
            root     = true,
            connects = { "wilson_alchemy_2", "wilson_alchemy_3", "wilson_alchemy_4" },
        },
        wilson_alchemy_2 = {
            title    = STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_2_TITLE,
            desc     = STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_2_DESC,
            icon     = "wilson_alchemy_gem_1",
            pos      = { -62 + 4, 190 - 54 },
            group    = "alchemy",
            tags     = { "alchemy", "trans1" },
            connects = { "wilson_alchemy_5" },
        },
        wilson_alchemy_5 = {
            title = STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_5_TITLE,
            desc  = STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_5_DESC,
            icon  = "wilson_alchemy_gem_2",
            pos   = { -62 + 4, 190 - 54 - 38 },
            group = "alchemy",
            tags  = { "alchemy", "trans1" },
        },
        wilson_alchemy_3 = {
            title    = STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_3_TITLE,
            desc     = STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_3_DESC,
            icon     = "wilson_alchemy_ore_1",
            pos      = { -62 - 38 + 4, 190 - 54 },
            group    = "alchemy",
            tags     = { "alchemy", "trans1" },
            connects = { "wilson_alchemy_7" },
        },
        wilson_alchemy_7 = {
            title = STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_7_TITLE,
            desc  = STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_7_DESC,
            icon  = "wilson_alchemy_ore_2",
            pos   = { -62 - 38 + 4, 190 - 54 - 38 },
            group = "alchemy",
            tags  = { "alchemy", "trans1" },
        },
        wilson_alchemy_4 = {
            title    = STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_4_TITLE,
            desc     = STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_4_DESC,
            icon     = "wilson_alchemy_iky_1",
            pos      = { -62 + 38 + 4, 190 - 54 },
            group    = "alchemy",
            tags     = { "alchemy", "trans1" },
            connects = { "wilson_alchemy_9" },
        },
        wilson_alchemy_9 = {
            title = STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_9_TITLE,
            desc  = STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_9_DESC,
            icon  = "wilson_alchemy_iky_2",
            pos   = { -62 + 38 + 4, 190 - 54 - 38 },
            group = "alchemy",
            tags  = { "alchemy", "trans1" },
        },

        -- Lock for boss transmutes: requires 4+ transmute skills
        wilson_alchemy_6 = {
            desc      = STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_6_LOCK_DESC,
            pos       = { -62 - 38 + 4, 24 },
            group     = "alchemy",
            tags      = { "alchemy", "lock" },
            root      = true,
            lock_open = function(prefabname, activatedskills, readonly)
                return SkillTreeFns.CountTags(prefabname, "trans1", activatedskills) >= 4
            end,
            connects  = { "wilson_alchemy_8" },
        },

        -- Boss transmutes I: thick fur > deerclops eyeball, eyeball > 10 down feathers
        wilson_alchemy_8 = {
            title    = STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_8_TITLE,
            desc     = STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_8_DESC,
            icon     = "wilson_alchemy_ore_1",
            pos      = { -62 + 4, 24 },
            group    = "alchemy",
            tags     = { "alchemy" },
            connects = { "wilson_alchemy_10" },
        },

        -- Boss transmutes II: 10 down feathers > dragonfly scale, scale > thick fur
        wilson_alchemy_10 = {
            title = STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_10_TITLE,
            desc  = STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_10_DESC,
            icon  = "wilson_alchemy_ore_2",
            pos   = { -62 + 38 + 4, 24 },
            group = "alchemy",
            tags  = { "alchemy" },
        },
        --------------------------------------------------------------------------
        -- BEARD (3 columns: insulation, growth, shaved; IDs reused for vanilla compat)
        wilson_beard_2 = {
            title    = STRINGS.SKILLTREE.WILSON.WILSON_BEARD_2_TITLE,
            desc     = STRINGS.SKILLTREE.WILSON.WILSON_BEARD_2_DESC,
            icon     = "wilson_beard_insulation_2",
            pos      = { 47, 176 },
            group    = "beard",
            tags     = { "beard", "beard1" },
            root     = true,
            connects = { "wilson_beard_3" },
        },
        wilson_beard_3 = {
            title = STRINGS.SKILLTREE.WILSON.WILSON_BEARD_3_TITLE,
            desc  = STRINGS.SKILLTREE.WILSON.WILSON_BEARD_3_DESC,
            icon  = "wilson_beard_insulation_3",
            pos   = { 47, 176 - 38 },
            group = "beard",
            tags  = { "beard", "beard1" },
        },

        wilson_beard_5 = {
            title        = STRINGS.SKILLTREE.WILSON.WILSON_BEARD_5_TITLE,
            desc         = STRINGS.SKILLTREE.WILSON.WILSON_BEARD_5_DESC,
            icon         = "wilson_beard_speed_2",
            pos          = { 85, 176 },
            group        = "beard",
            tags         = { "beard", "beard1" },
            root         = true,
            connects     = { "wilson_beard_6" },
            onactivate   = function(inst, fromload)
                if not fromload then inst:PushEvent("wilson_beard_skill_changed") end
            end,
            ondeactivate = function(inst, fromload)
                if not fromload then inst:PushEvent("wilson_beard_skill_changed") end
            end,
        },
        wilson_beard_6 = {
            title        = STRINGS.SKILLTREE.WILSON.WILSON_BEARD_6_TITLE,
            desc         = STRINGS.SKILLTREE.WILSON.WILSON_BEARD_6_DESC,
            icon         = "wilson_beard_speed_3",
            pos          = { 85, 176 - 38 },
            group        = "beard",
            tags         = { "beard", "beard1" },
            onactivate   = function(inst, fromload)
                if not fromload then inst:PushEvent("wilson_beard_skill_changed") end
            end,
            ondeactivate = function(inst, fromload)
                if not fromload then inst:PushEvent("wilson_beard_skill_changed") end
            end,
        },

        -- +30 sanity on shave
        wilson_beard_shaved_1 = {
            title    = STRINGS.SKILLTREE.WILSON.WILSON_BEARD_SHAVED_1_TITLE,
            desc     = STRINGS.SKILLTREE.WILSON.WILSON_BEARD_SHAVED_1_DESC,
            icon     = "wilson_beard_insulation_1",
            pos      = { 123, 176 },
            group    = "beard",
            tags     = { "beard", "beard1" },
            root     = true,
            connects = { "wilson_beard_shaved_2" },
        },
        -- +additional 30 sanity on shave (70 total with skill 1)
        wilson_beard_shaved_2 = {
            title = STRINGS.SKILLTREE.WILSON.WILSON_BEARD_SHAVED_2_TITLE,
            desc  = STRINGS.SKILLTREE.WILSON.WILSON_BEARD_SHAVED_2_DESC,
            icon  = "wilson_beard_speed_1",
            pos   = { 123, 176 - 38 },
            group = "beard",
            tags  = { "beard", "beard1" },
        },

        -- Lock centered under growth column (x=85). Opens once player has
        -- unlocked at least 4 beard-tagged skills.
        wilson_beard_lock_1 = {
            desc      = STRINGS.SKILLTREE.WILSON.WILSON_BEARD_1_LOCK_DESC,
            pos       = { 85, 100 },
            group     = "beard",
            tags      = { "beard", "lock" },
            root      = true,
            lock_open = function(prefabname, activatedskills, readonly)
                return SkillTreeFns.CountTags(prefabname, "beard1", activatedskills) >= 4
            end,
            connects  = { "wilson_beard_7" },
        },

        wilson_beard_7 = {
            title        = STRINGS.SKILLTREE.WILSON.WILSON_BEARD_7_TITLE,
            desc         = STRINGS.SKILLTREE.WILSON.WILSON_BEARD_7_DESC,
            icon         = "wilson_beard_inventory",
            pos          = { 85, 62 },
            group        = "beard",
            tags         = { "beard" },
            connects     = { "wilson_beard_chilly" },
            onactivate   = function(inst, fromload)
                if inst.components.beard then
                    inst.components.beard:UpdateBeardInventory()
                end
                if not fromload then inst:PushEvent("wilson_beard_skill_changed") end
            end,
            ondeactivate = function(inst, fromload)
                if inst.components.beard then
                    inst.components.beard:UpdateBeardInventory()
                end
                if not fromload then inst:PushEvent("wilson_beard_skill_changed") end
            end,
        },

        -- Sub-skill of beard_7. Tagging the beard_sack with "fridge"+"nocool"
        -- (modmain) makes it act like the Insulated Pack: slows perish on
        -- items in the beard inventory without freezing thermal stones.
        wilson_beard_chilly = {
            title        = STRINGS.SKILLTREE.WILSON.WILSON_BEARD_CHILLY_TITLE,
            desc         = STRINGS.SKILLTREE.WILSON.WILSON_BEARD_CHILLY_DESC,
            icon         = "wilson_beard_insulation_3",
            pos          = { 85, 24 },
            group        = "beard",
            tags         = { "beard" },
            onactivate   = function(inst, fromload)
                if not fromload then inst:PushEvent("wilson_beard_skill_changed") end
            end,
            ondeactivate = function(inst, fromload)
                if not fromload then inst:PushEvent("wilson_beard_skill_changed") end
            end,
        },
        --------------------------------------------------------------------------
        -- ALLEGIANCE (unchanged from vanilla)
        wilson_allegiance_lock_1 = {
            desc      = STRINGS.SKILLTREE.WILSON.WILSON_ALLEGIANCE_LOCK_1_DESC,
            pos       = { 204 + 2, 176 },
            group     = "allegiance",
            tags      = { "allegiance", "lock" },
            root      = true,
            lock_open = function(prefabname, activatedskills, readonly)
                return SkillTreeFns.CountSkills(prefabname, activatedskills) >= 12
            end,
            connects  = { "wilson_allegiance_shadow" },
        },
        wilson_allegiance_lock_2 = {
            desc      = STRINGS.SKILLTREE.ALLEGIANCE_LOCK_2_DESC,
            pos       = { 204 - 22 + 2, 176 - 50 + 2 },
            group     = "allegiance",
            tags      = { "allegiance", "lock" },
            root      = true,
            lock_open = function(prefabname, activatedskills, readonly)
                if readonly then return "question" end
                return TheGenericKV:GetKV("fuelweaver_killed") == "1"
            end,
            connects  = { "wilson_allegiance_shadow" },
        },
        wilson_allegiance_lock_4 = {
            desc      = STRINGS.SKILLTREE.ALLEGIANCE_LOCK_4_DESC,
            pos       = { 204 - 22 + 2, 176 - 100 + 8 },
            group     = "allegiance",
            tags      = { "allegiance", "lock" },
            root      = true,
            lock_open = function(prefabname, activatedskills, readonly)
                if SkillTreeFns.CountTags(prefabname, "lunar_favor", activatedskills) == 0 then
                    return true
                end
                return nil
            end,
            connects  = { "wilson_allegiance_shadow" },
        },
        wilson_allegiance_shadow = {
            title        = STRINGS.SKILLTREE.WILSON.WILSON_ALLEGIANCE_SHADOW_TITLE,
            desc         = STRINGS.SKILLTREE.WILSON.WILSON_ALLEGIANCE_SHADOW_DESC,
            icon         = "wilson_favor_shadow",
            pos          = { 204 - 22 + 2, 176 - 110 - 38 + 10 },
            group        = "allegiance",
            tags         = { "allegiance", "shadow", "shadow_favor" },
            locks        = { "wilson_allegiance_lock_1", "wilson_allegiance_lock_2", "wilson_allegiance_lock_4" },
            onactivate   = function(inst, fromload)
                inst:AddTag("player_shadow_aligned")
                local damagetyperesist = inst.components.damagetyperesist
                if damagetyperesist then
                    damagetyperesist:AddResist("shadow_aligned", inst, TUNING.SKILLS.WILSON_ALLEGIANCE_SHADOW_RESIST,
                        "wilson_allegiance_shadow")
                end
                local damagetypebonus = inst.components.damagetypebonus
                if damagetypebonus then
                    damagetypebonus:AddBonus("lunar_aligned", inst, TUNING.SKILLS.WILSON_ALLEGIANCE_VS_LUNAR_BONUS,
                        "wilson_allegiance_shadow")
                end
            end,
            ondeactivate = function(inst, fromload)
                inst:RemoveTag("player_shadow_aligned")
                local damagetyperesist = inst.components.damagetyperesist
                if damagetyperesist then
                    damagetyperesist:RemoveResist("shadow_aligned", inst, "wilson_allegiance_shadow")
                end
                local damagetypebonus = inst.components.damagetypebonus
                if damagetypebonus then
                    damagetypebonus:RemoveBonus("lunar_aligned", inst, "wilson_allegiance_shadow")
                end
            end,
        },
        wilson_allegiance_lock_3 = {
            desc      = STRINGS.SKILLTREE.ALLEGIANCE_LOCK_3_DESC,
            pos       = { 204 + 22 + 2, 176 - 50 + 2 },
            group     = "allegiance",
            tags      = { "allegiance", "lock" },
            root      = true,
            lock_open = function(prefabname, activatedskills, readonly)
                if readonly then return "question" end
                return TheGenericKV:GetKV("celestialchampion_killed") == "1"
            end,
            connects  = { "wilson_allegiance_lunar" },
        },
        wilson_allegiance_lock_5 = {
            desc      = STRINGS.SKILLTREE.ALLEGIANCE_LOCK_5_DESC,
            pos       = { 204 + 22 + 2, 176 - 100 + 8 },
            group     = "allegiance",
            tags      = { "allegiance", "lock" },
            root      = true,
            lock_open = function(prefabname, activatedskills, readonly)
                if SkillTreeFns.CountTags(prefabname, "shadow_favor", activatedskills) == 0 then
                    return true
                end
                return nil
            end,
            connects  = { "wilson_allegiance_lunar" },
        },
        wilson_allegiance_lunar = {
            title        = STRINGS.SKILLTREE.WILSON.WILSON_ALLEGIANCE_LUNAR_TITLE,
            desc         = STRINGS.SKILLTREE.WILSON.WILSON_ALLEGIANCE_LUNAR_DESC,
            icon         = "wilson_favor_lunar",
            pos          = { 204 + 22 + 2, 176 - 110 - 38 + 10 },
            group        = "allegiance",
            tags         = { "allegiance", "lunar", "lunar_favor" },
            locks        = { "wilson_allegiance_lock_1", "wilson_allegiance_lock_3", "wilson_allegiance_lock_5" },
            onactivate   = function(inst, fromload)
                inst:AddTag("player_lunar_aligned")
                local damagetyperesist = inst.components.damagetyperesist
                if damagetyperesist then
                    damagetyperesist:AddResist("lunar_aligned", inst, TUNING.SKILLS.WILSON_ALLEGIANCE_LUNAR_RESIST,
                        "wilson_allegiance_lunar")
                end
                local damagetypebonus = inst.components.damagetypebonus
                if damagetypebonus then
                    damagetypebonus:AddBonus("shadow_aligned", inst, TUNING.SKILLS.WILSON_ALLEGIANCE_VS_SHADOW_BONUS,
                        "wilson_allegiance_lunar")
                end
            end,
            ondeactivate = function(inst, fromload)
                inst:RemoveTag("player_lunar_aligned")
                local damagetyperesist = inst.components.damagetyperesist
                if damagetyperesist then
                    damagetyperesist:RemoveResist("lunar_aligned", inst, "wilson_allegiance_lunar")
                end
                local damagetypebonus = inst.components.damagetypebonus
                if damagetypebonus then
                    damagetypebonus:RemoveBonus("shadow_aligned", inst, "wilson_allegiance_lunar")
                end
            end,
        },
        --------------------------------------------------------------------------
    }

    return {
        SKILLS = skills,
        ORDERS = ORDERS,
    }
end

return BuildSkillsData
