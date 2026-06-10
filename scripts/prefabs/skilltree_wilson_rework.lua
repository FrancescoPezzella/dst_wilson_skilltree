local function CustomIcon(tex_name)
    local atlas = "images/skilltree/" .. tex_name .. ".xml"
    local tex   = tex_name .. ".tex"
    return {
        init = function(button, root, fromfrontend, prefabname, activatedskills)
            -- Track which ring texture was set so onlocked can tell available vs unavailable
            local orig_SetTextures = button.SetTextures
            button.SetTextures = function(self_btn, atlas_arg, normal_tex, ...)
                self_btn._current_ring_tex = normal_tex
                return orig_SetTextures(self_btn, atlas_arg, normal_tex, ...)
            end

            local Image = require("widgets/image")
            local icon = button:AddChild(Image(atlas, tex))
            icon:ScaleToSize(28, 28)
            icon:MoveToFront()
            button._skill_icon = icon
        end,
        onlocked = function(button, initial)
            if button._skill_icon then
                -- "selectable.tex" = available but not yet purchased > full color
                -- anything else (unselected.tex) = not available yet > dim
                if button._current_ring_tex == "selectable.tex" then
                    button._skill_icon:SetTint(1, 1, 1, 1)
                else
                    button._skill_icon:SetTint(0.4, 0.4, 0.4, 1)
                end
            end
        end,
        onunlocked = function(button, initial)
            if button._skill_icon then button._skill_icon:SetTint(1, 1, 1, 1) end
        end,
    }
end

local ORDERS =
{
    { "light",      { -190, 176 + 30 } },
    { "alchemy",    { -62, 176 + 30 } },
    { "beard",      { 85, 176 + 30 } },
    { "survival",   { 85, 24 + 30 } },
    { "allegiance", { 204, 176 + 30 } },
}

local function BuildSkillsData(SkillTreeFns, revert_alchemy)
    local skills =
    {
        --------------------------------------------------------------------------
        -- LIGHT (renamed from TORCH)
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

        -- Throw torch
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
            title              = STRINGS.SKILLTREE.WILSON.WILSON_LIGHT_CRAFTING_TITLE,
            desc               = STRINGS.SKILLTREE.WILSON.WILSON_LIGHT_CRAFTING_DESC,
            button_decorations = CustomIcon("icon-efficient-illumination"),
            pos                = { -214 + 18 + 6 - 38, 24 },
            group              = "light",
            tags               = { "light" },
        },

        -- +50% refuel efficiency for light items
        wilson_light_refuel = {
            title              = STRINGS.SKILLTREE.WILSON.WILSON_LIGHT_REFUEL_TITLE,
            desc               = STRINGS.SKILLTREE.WILSON.WILSON_LIGHT_REFUEL_DESC,
            button_decorations = CustomIcon("icon-refueling"),
            pos                = { -214 + 18 + 6, 24 },
            group              = "light",
            tags               = { "light" },
        },

        -- +10% speed while any light item is equipped
        wilson_light_speed = {
            title              = STRINGS.SKILLTREE.WILSON.WILSON_LIGHT_SPEED_TITLE,
            desc               = STRINGS.SKILLTREE.WILSON.WILSON_LIGHT_SPEED_DESC,
            button_decorations = CustomIcon("icon-lightfooted"),
            pos                = { -214 + 18 + 6 + 38, 24 },
            group              = "light",
            tags               = { "light" },
            onactivate         = function(inst, fromload)
                if not fromload then inst:PushEvent("wilson_light_skill_changed") end
            end,
            ondeactivate       = function(inst, fromload)
                if not fromload then inst:PushEvent("wilson_light_skill_changed") end
            end,
        },
        --------------------------------------------------------------------------
        -- ALCHEMY
    }

    if revert_alchemy then
        -- Vanilla alchemy tree (original 3-branch × 3-tier layout, vanilla IDs/icons/strings)
        skills.wilson_alchemy_1  = { title=STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_1_TITLE,  desc=STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_1_DESC,  icon="wilson_alchemy_1",     pos={-62,176},  group="alchemy", tags={"alchemy"}, root=true, connects={"wilson_alchemy_2","wilson_alchemy_3","wilson_alchemy_4"} }
        skills.wilson_alchemy_2  = { title=STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_2_TITLE,  desc=STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_2_DESC,  icon="wilson_alchemy_gem_1", pos={-62,122},  group="alchemy", tags={"alchemy"}, connects={"wilson_alchemy_5"} }
        skills.wilson_alchemy_5  = { title=STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_5_TITLE,  desc=STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_5_DESC,  icon="wilson_alchemy_gem_2", pos={-62,84},   group="alchemy", tags={"alchemy"}, connects={"wilson_alchemy_6"} }
        skills.wilson_alchemy_6  = { title=STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_6_TITLE,  desc=STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_6_DESC,  icon="wilson_alchemy_gem_3", pos={-62,46},   group="alchemy", tags={"alchemy"} }
        skills.wilson_alchemy_3  = { title=STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_3_TITLE,  desc=STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_3_DESC,  icon="wilson_alchemy_ore_1", pos={-100,122}, group="alchemy", tags={"alchemy"}, connects={"wilson_alchemy_7"} }
        skills.wilson_alchemy_7  = { title=STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_7_TITLE,  desc=STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_7_DESC,  icon="wilson_alchemy_ore_2", pos={-100,84},  group="alchemy", tags={"alchemy"}, connects={"wilson_alchemy_8"} }
        skills.wilson_alchemy_8  = { title=STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_8_TITLE,  desc=STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_8_DESC,  icon="wilson_alchemy_ore_3", pos={-100,46},  group="alchemy", tags={"alchemy"} }
        skills.wilson_alchemy_4  = { title=STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_4_TITLE,  desc=STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_4_DESC,  icon="wilson_alchemy_iky_1", pos={-24,122},  group="alchemy", tags={"alchemy"}, connects={"wilson_alchemy_9"} }
        skills.wilson_alchemy_9  = { title=STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_9_TITLE,  desc=STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_9_DESC,  icon="wilson_alchemy_iky_2", pos={-24,84},   group="alchemy", tags={"alchemy"}, connects={"wilson_alchemy_10"} }
        skills.wilson_alchemy_10 = { title=STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_10_TITLE, desc=STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_10_DESC, icon="wilson_alchemy_iky_3", pos={-24,46},   group="alchemy", tags={"alchemy"} }
    else
        -- Reworked alchemy tree
        skills.wilson_alchemy_1 = {
            title    = STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_1_TITLE,
            desc     = STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_1_DESC,
            icon     = "wilson_alchemy_1",
            pos      = { -62 + 4, 176 },
            group    = "alchemy",
            tags     = { "alchemy", "trans1" },
            root     = true,
            connects = { "wilson_alchemy_2", "wilson_alchemy_3", "wilson_alchemy_4" },
        }
        skills.wilson_alchemy_2 = {
            title    = STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_2_TITLE,
            desc     = STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_2_DESC,
            icon     = "wilson_alchemy_gem_2",
            pos      = { -62 + 4, 190 - 54 },
            group    = "alchemy",
            tags     = { "alchemy", "trans1" },
            connects = { "wilson_alchemy_5" },
        }
        skills.wilson_alchemy_5 = {
            title = STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_5_TITLE,
            desc  = STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_5_DESC,
            icon  = "wilson_alchemy_gem_3",
            pos   = { -62 + 4, 190 - 54 - 38 },
            group = "alchemy",
            tags  = { "alchemy", "trans1" },
        }
        skills.wilson_alchemy_3 = {
            title    = STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_3_TITLE,
            desc     = STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_3_DESC,
            icon     = "wilson_alchemy_ore_2",
            pos      = { -62 - 38 + 4, 190 - 54 },
            group    = "alchemy",
            tags     = { "alchemy", "trans1" },
            connects = { "wilson_alchemy_7" },
        }
        skills.wilson_alchemy_7 = {
            title = STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_7_TITLE,
            desc  = STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_7_DESC,
            icon  = "wilson_alchemy_ore_3",
            pos   = { -62 - 38 + 4, 190 - 54 - 38 },
            group = "alchemy",
            tags  = { "alchemy", "trans1" },
        }
        skills.wilson_alchemy_4 = {
            title    = STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_4_TITLE,
            desc     = STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_4_DESC,
            icon     = "wilson_alchemy_iky_2",
            pos      = { -62 + 38 + 4, 190 - 54 },
            group    = "alchemy",
            tags     = { "alchemy", "trans1" },
            connects = { "wilson_alchemy_9" },
        }
        skills.wilson_alchemy_9 = {
            title = STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_9_TITLE,
            desc  = STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_9_DESC,
            icon  = "wilson_alchemy_iky_3",
            pos   = { -62 + 38 + 4, 190 - 54 - 38 },
            group = "alchemy",
            tags  = { "alchemy", "trans1" },
        }
        -- Lock for boss transmutes
        skills.wilson_alchemy_6 = {
            desc      = STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_6_LOCK_DESC,
            pos       = { -62 - 38 + 4, 24 + 24 },
            group     = "alchemy",
            tags      = { "alchemy", "lock" },
            root      = true,
            lock_open = function(prefabname, activatedskills, readonly)
                return SkillTreeFns.CountTags(prefabname, "trans1", activatedskills) >= 3
            end,
            connects  = { "wilson_alchemy_8" },
        }
        -- Boss transmutes I
        skills.wilson_alchemy_8 = {
            title              = STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_8_TITLE,
            desc               = STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_8_DESC,
            button_decorations = CustomIcon("icon-boss-deerclops"),
            pos                = { -62 + 4, 24 + 24 },
            group              = "alchemy",
            tags               = { "alchemy" },
            connects           = { "wilson_alchemy_10" },
        }
        -- Boss transmutes II
        skills.wilson_alchemy_10 = {
            title              = STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_10_TITLE,
            desc               = STRINGS.SKILLTREE.WILSON.WILSON_ALCHEMY_10_DESC,
            button_decorations = CustomIcon("icon-boss-moose"),
            pos                = { -62 + 38 + 4, 24 + 24 },
            group              = "alchemy",
            tags               = { "alchemy" },
        }
    end

    --------------------------------------------------------------------------
    -- BEARD
    skills.wilson_beard_3 = {
        title = STRINGS.SKILLTREE.WILSON.WILSON_BEARD_3_TITLE,
        desc  = STRINGS.SKILLTREE.WILSON.WILSON_BEARD_3_DESC,
        icon  = "wilson_beard_insulation_3",
        pos   = { 47, 176 },
        group = "beard",
        tags  = { "beard", "beard1" },
        root  = true,
    }

    skills.wilson_beard_6 = {
        title        = STRINGS.SKILLTREE.WILSON.WILSON_BEARD_6_TITLE,
        desc         = STRINGS.SKILLTREE.WILSON.WILSON_BEARD_6_DESC,
        icon         = "wilson_beard_speed_3",
        pos          = { 85, 176 },
        group        = "beard",
        tags         = { "beard", "beard1" },
        root         = true,
        onactivate   = function(inst, fromload)
            if not fromload then inst:PushEvent("wilson_beard_skill_changed") end
        end,
        ondeactivate = function(inst, fromload)
            if not fromload then inst:PushEvent("wilson_beard_skill_changed") end
        end,
    }

    skills.wilson_beard_shaved = {
        title              = STRINGS.SKILLTREE.WILSON.WILSON_BEARD_SHAVED_TITLE,
        desc               = STRINGS.SKILLTREE.WILSON.WILSON_BEARD_SHAVED_DESC,
        button_decorations = CustomIcon("icon-shaven"),
        pos                = { 123, 176 },
        group              = "beard",
        tags               = { "beard", "beard1" },
        root               = true,
    }

    skills.wilson_beard_beast = {
        title              = STRINGS.SKILLTREE.WILSON.WILSON_BEARD_BEAST_TITLE,
        desc               = STRINGS.SKILLTREE.WILSON.WILSON_BEARD_BEAST_DESC,
        button_decorations = CustomIcon("icon-beast"),
        pos                = { 66, 138 },
        group              = "beard",
        tags               = { "beard", "beard1" },
        root               = true,
        onactivate         = function(inst, fromload)
            if not fromload then inst:PushEvent("wilson_beard_skill_changed") end
            inst:DoTaskInTime(0, function() inst:PushEvent("wilson_beard_bits_changed") end)
        end,
        ondeactivate       = function(inst, fromload)
            if not fromload then inst:PushEvent("wilson_beard_skill_changed") end
            if inst.components.combat then
                inst.components.combat.externaldamagetakenmultipliers:RemoveModifier(inst, "wilson_beard_beast")
            end
        end,
    }

    skills.wilson_beard_goop = {
        title              = STRINGS.SKILLTREE.WILSON.WILSON_BEARD_GOOP_TITLE,
        desc               = STRINGS.SKILLTREE.WILSON.WILSON_BEARD_GOOP_DESC,
        button_decorations = CustomIcon("icon-goop"),
        pos                = { 104, 138 },
        group              = "beard",
        tags               = { "beard", "beard1" },
        root               = true,
    }

    skills.wilson_beard_lock_1 = {
        desc      = STRINGS.SKILLTREE.WILSON.WILSON_BEARD_1_LOCK_DESC,
        pos       = { 47, 96 },
        group     = "beard",
        tags      = { "beard", "lock" },
        root      = true,
        lock_open = function(prefabname, activatedskills, readonly)
            return SkillTreeFns.CountTags(prefabname, "beard1", activatedskills) >= 3
        end,
        connects  = { "wilson_beard_7" },
    }

    skills.wilson_beard_7 = {
        title        = STRINGS.SKILLTREE.WILSON.WILSON_BEARD_7_TITLE,
        desc         = STRINGS.SKILLTREE.WILSON.WILSON_BEARD_7_DESC,
        icon         = "wilson_beard_inventory",
        pos          = { 85, 96 },
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
    }

    skills.wilson_beard_chilly = {
        title              = STRINGS.SKILLTREE.WILSON.WILSON_BEARD_CHILLY_TITLE,
        desc               = STRINGS.SKILLTREE.WILSON.WILSON_BEARD_CHILLY_DESC,
        button_decorations = CustomIcon("icon-chilly"),
        pos                = { 123, 96 },
        group              = "beard",
        tags               = { "beard" },
        onactivate         = function(inst, fromload)
            if not fromload then inst:PushEvent("wilson_beard_skill_changed") end
        end,
        ondeactivate       = function(inst, fromload)
            if not fromload then inst:PushEvent("wilson_beard_skill_changed") end
        end,
    }

    --------------------------------------------------------------------------
    -- SURVIVAL
    skills.wilson_survival = {
        title              = STRINGS.SKILLTREE.WILSON.WILSON_SURVIVAL_TITLE,
        desc               = STRINGS.SKILLTREE.WILSON.WILSON_SURVIVAL_DESC,
        button_decorations = CustomIcon("icon-survival"),
        pos                = { 85, 24 },
        group              = "survival",
        tags               = { "survival" },
        root               = true,
    }

    --------------------------------------------------------------------------
    -- ALLEGIANCE (reduced locks from 5 > 3)
    skills.wilson_allegiance_lock_1 = {
        desc      = STRINGS.SKILLTREE.WILSON.WILSON_ALLEGIANCE_LOCK_1_DESC,
        pos       = { 204 + 2, 176 },
        group     = "allegiance",
        tags      = { "allegiance", "lock" },
        root      = true,
        lock_open = function(prefabname, activatedskills, readonly)
            return SkillTreeFns.CountSkills(prefabname, activatedskills) >= 10
        end,
        connects  = { "wilson_allegiance_shadow", "wilson_allegiance_lunar" },
    }

    skills.wilson_allegiance_lock_2 = {
        desc      = STRINGS.SKILLTREE.ALLEGIANCE_LOCK_2_DESC,
        pos       = { 204 - 22 + 2, 176 - 40 },
        group     = "allegiance",
        tags      = { "allegiance", "lock" },
        root      = true,
        lock_open = function(prefabname, activatedskills, readonly)
            if SkillTreeFns.CountTags(prefabname, "lunar_favor", activatedskills) > 0 then
                return false
            end
            if readonly then return "question" end
            return TheGenericKV:GetKV("fuelweaver_killed") == "1"
        end,
        connects  = { "wilson_allegiance_shadow" },
    }

    skills.wilson_allegiance_shadow = {
        title        = STRINGS.SKILLTREE.WILSON.WILSON_ALLEGIANCE_SHADOW_TITLE,
        desc         = STRINGS.SKILLTREE.WILSON.WILSON_ALLEGIANCE_SHADOW_DESC,
        icon         = "wilson_favor_shadow",
        pos          = { 204 - 22 + 2, 176 - 84 },
        group        = "allegiance",
        tags         = { "allegiance", "shadow", "shadow_favor" },
        locks        = { "wilson_allegiance_lock_1", "wilson_allegiance_lock_2" },
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
        connects     = { "wilson_shadow_pouch" },
    }

    skills.wilson_shadow_pouch = {
        title              = STRINGS.SKILLTREE.WILSON.WILSON_SHADOW_POUCH_TITLE,
        desc               = STRINGS.SKILLTREE.WILSON.WILSON_SHADOW_POUCH_DESC,
        button_decorations = CustomIcon("shadow_pouch_wilson"),
        pos                = { 204 - 22 + 2, 176 - 130 },
        group              = "allegiance",
        tags               = { "allegiance", "shadow" },
        onactivate         = function(inst, fromload) inst:AddTag("shadow_pouch_crafter") end,
        ondeactivate       = function(inst, fromload) inst:RemoveTag("shadow_pouch_crafter") end,
    }

    skills.wilson_allegiance_lock_3 = {
        desc      = STRINGS.SKILLTREE.ALLEGIANCE_LOCK_3_DESC,
        pos       = { 204 + 22 + 2, 176 - 40 },
        group     = "allegiance",
        tags      = { "allegiance", "lock" },
        root      = true,
        lock_open = function(prefabname, activatedskills, readonly)
            if SkillTreeFns.CountTags(prefabname, "shadow_favor", activatedskills) > 0 then
                return false
            end
            if readonly then return "question" end
            return TheGenericKV:GetKV("celestialchampion_killed") == "1"
        end,
        connects  = { "wilson_allegiance_lunar" },
    }

    skills.wilson_allegiance_lunar = {
        title        = STRINGS.SKILLTREE.WILSON.WILSON_ALLEGIANCE_LUNAR_TITLE,
        desc         = STRINGS.SKILLTREE.WILSON.WILSON_ALLEGIANCE_LUNAR_DESC,
        icon         = "wilson_favor_lunar",
        pos          = { 204 + 22 + 2, 176 - 84 },
        group        = "allegiance",
        tags         = { "allegiance", "lunar", "lunar_favor" },
        locks        = { "wilson_allegiance_lock_1", "wilson_allegiance_lock_3" },
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
        connects     = { "wilson_lunar_pouch" },
    }

    skills.wilson_lunar_pouch = {
        title              = STRINGS.SKILLTREE.WILSON.WILSON_LUNAR_POUCH_TITLE,
        desc               = STRINGS.SKILLTREE.WILSON.WILSON_LUNAR_POUCH_DESC,
        button_decorations = CustomIcon("lunar_pouch_wilson"),
        pos                = { 204 + 22 + 2, 176 - 130 },
        group              = "allegiance",
        tags               = { "allegiance", "lunar" },
        onactivate         = function(inst, fromload) inst:AddTag("lunar_pouch_crafter") end,
        ondeactivate       = function(inst, fromload) inst:RemoveTag("lunar_pouch_crafter") end,
    }

    return {
        SKILLS = skills,
        ORDERS = ORDERS,
    }
end

return BuildSkillsData
