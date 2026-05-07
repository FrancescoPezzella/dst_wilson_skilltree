-- Item details:
-- Better backpack with 12 slots, not flammable, but food rots 50 % quicker. When something rots in the back it spawns nightmare fuel instead of rot

local assets = {
    Asset("ATLAS", "images/shadow_pouch.xml"),
    Asset("IMAGE", "images/shadow_pouch.tex"),
    Asset("ATLAS", "images/inventoryimages/shadow_pouch_smol.xml"),
    Asset("IMAGE", "images/inventoryimages/shadow_pouch_smol.tex"),
    Asset("ANIM", "anim/shadow_pouch.zip")
}

-- Function to replace spoiled item with nightmare fuel
local function ReplaceWithNightmareFuel(inst, spoiled_item)
    print("Replacing", spoiled_item.prefab, "with nightmare fuel")

    -- Find which slot the spoiled item is in
    local slot = nil
    for i = 1, inst.components.container:GetNumSlots() do
        if inst.components.container.slots[i] == spoiled_item then
            slot = i
            break
        end
    end

    if slot then
        -- Check if it's a stack and get the stack size
        local stack_size = 1
        if spoiled_item.components.stackable then
            stack_size = spoiled_item.components.stackable:StackSize()
            print("  -> Stack size:", stack_size)
        end

        -- Remove the spoiled item from the container
        inst.components.container:RemoveItemBySlot(slot)

        -- Spawn nightmare fuel for each item in the stack
        for i = 1, stack_size do
            local nightmare_fuel = SpawnPrefab("nightmarefuel")
            if nightmare_fuel then
                inst.components.container:GiveItem(nightmare_fuel, slot)
                print("Successfully added nightmare fuel", i, "of", stack_size)
            end
        end

        -- Remove the original spoiled item
        spoiled_item:Remove()
    else
        print("ERROR: Could not find slot for spoiled item")
    end
end

-- When an item is ADDED to the backpack
local function OnItemGet(inst, data)
    if data and data.item then
        local item = data.item
        print("Item added to shadow pouch:", data.item.prefab, "in slot", data.slot)

        -- Only watch items that can spoil
        if item.components.perishable then
            print("  -> This item can spoil, setting up watcher")

            -- Store the actual function so that it can be removed later
            local perish_function = function(it)
                print("  -> Item perished in shadow pouch:", it.prefab)
                ReplaceWithNightmareFuel(inst, it)
            end

            -- Mark that the item is being watched and store it
            item.shadow_pouch_watcher = perish_function

            -- Listen for when this item spoils
            inst:ListenForEvent("perished", perish_function, item)
        else
            print("  -> This item cannot spoil, ignoring")
        end
    end
end

-- When an item is REMOVED from the backpack
local function OnItemLose(inst, data)
    if data and data.prev_item then
        local item = data.prev_item
        print("Item removed from shadow pouch:", data.prev_item.prefab, "from slot", data.slot)

        -- Clean up if item is being watched
        if item.shadow_pouch_watcher then
            print("  -> Removing spoilage watcher")
            inst:RemoveEventCallback("perished", item.shadow_pouch_watcher, item)
            item.shadow_pouch_watcher = nil
        end
    end
end

-- Set up spoilage watching for ALL items already in backpack
local function SetupSpoilageWatching(inst)
    print("Setting up spoilage watching for all items")

    for slot = 1, inst.components.container:GetNumSlots() do
        local item = inst.components.container:GetItemInSlot(slot)
        if item and item.components.perishable and not item.shadow_pouch_watcher then
            print("Watching existing item:", item.prefab, "in slot", slot)

            local perish_function = function(it)
                print("Existing item perished:", it.prefab)
                ReplaceWithNightmareFuel(inst, it)
            end

            item.shadow_pouch_watcher = perish_function
            inst:ListenForEvent("perished", perish_function, item)
        end
    end
end

local function SetShadowPouch()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("shadow_pouch")
    inst.AnimState:SetBuild("shadow_pouch")
    inst.AnimState:PlayAnimation("idle")

    -- 64 x 64 pixels is too tiny apparently
    inst.AnimState:SetScale(1.5, 1.5, 1.5)

    inst:AddTag("shadow_pouch")
    inst:AddTag("backpack") -- This makes it behave like other backpacks
    inst:AddTag("spoiler")  -- This makes food spoil quicker
    inst:AddTag("shadow")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")
    inst:AddComponent("equippable")
    inst:AddComponent("container")
    inst:AddComponent("inventoryitem")

    -- Inventory item setup
    inst.components.inventoryitem.imagename = "shadow_pouch_smol"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/shadow_pouch_smol.xml"

    MakeInventoryPhysics(inst)

    inst.components.inventoryitem.cangoincontainer = false

    inst.components.equippable.equipslot = EQUIPSLOTS.BODY

    -- Listen to container events
    inst:ListenForEvent("itemget", OnItemGet)
    inst:ListenForEvent("itemlose", OnItemLose)

    -- Backpack functionality
    inst.components.equippable:SetOnEquip(function(inst, owner)
        owner.AnimState:OverrideSymbol("swap_body", "shadow_pouch", "backpack")
        owner.AnimState:Show("BACKPACK")
        inst.components.container:Open(owner)

        inst:DoTaskInTime(0.1, function()
            SetupSpoilageWatching(inst)
        end)
    end)

    inst.components.equippable:SetOnUnequip(function(inst, owner)
        owner.AnimState:ClearOverrideSymbol("swap_body")
        owner.AnimState:Hide("BACKPACK")
        inst.components.container:Close(owner)
    end)

    inst.components.container.canbeopened = true

    -- Reusing Piggy Back's 12 slots to make it work
    inst.components.container:WidgetSetup("piggyback")

    return inst
end

return Prefab("shadow_pouch", SetShadowPouch, assets)
