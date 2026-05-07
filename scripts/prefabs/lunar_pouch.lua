-- Item details:
-- Better backpack with 8 slots, not flammable, food spoils 50 % slower, user gains 2 sanity per minute

local assets = {
    Asset("ATLAS", "images/lunar_pouch.xml"),
    Asset("IMAGE", "images/lunar_pouch.tex"),
    Asset("ATLAS", "images/inventoryimages/lunar_pouch_smol.xml"),
    Asset("IMAGE", "images/inventoryimages/lunar_pouch_smol.tex"),
    Asset("ANIM", "anim/lunar_pouch.zip")
}

local function SetLunarPouch()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("lunar_pouch")
    inst.AnimState:SetBuild("lunar_pouch")
    inst.AnimState:PlayAnimation("idle")

    inst.AnimState:SetScale(1.5, 1.5, 1.5)

    inst:AddTag("lunar_pouch")
    inst:AddTag("backpack")  -- This makes it behave like other backpacks
    inst:AddTag("fridge")    -- This makes food spoil slower
    inst:AddTag("nocool")    -- Ice still melts, thermal stones don't freeze, etc
    inst:AddTag("insulated") -- Hot food stays hot, thermal stones maintain better temp

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")
    inst:AddComponent("equippable")
    inst:AddComponent("container")
    inst:AddComponent("inventoryitem")

    -- Inventory item setup
    inst.components.inventoryitem.imagename = "lunar_pouch_smol"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/lunar_pouch_smol.xml"

    MakeInventoryPhysics(inst)

    inst.components.inventoryitem.cangoincontainer = false

    inst.components.equippable.dapperness = 0.033 -- +2 sanity per minute

    inst.components.equippable.equipslot = EQUIPSLOTS.BODY

    -- Backpack functionality
    inst.components.equippable:SetOnEquip(function(inst, owner)
        owner.AnimState:OverrideSymbol("swap_body", "lunar_pouch", "backpack")
        owner.AnimState:Show("BACKPACK")
        inst.components.container:Open(owner)
    end)

    inst.components.equippable:SetOnUnequip(function(inst, owner)
        owner.AnimState:ClearOverrideSymbol("swap_body")
        owner.AnimState:Hide("BACKPACK")
        inst.components.container:Close(owner)
    end)

    inst.components.container.canbeopened = true

    -- Reusing Backpack's 8 slots to make it work
    inst.components.container:WidgetSetup("backpack")

    return inst
end

return Prefab("lunar_pouch", SetLunarPouch, assets)
