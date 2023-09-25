local PLUGIN = PLUGIN

PLUGIN.name = "Loot Library"
PLUGIN.description = ""
PLUGIN.author = "Reece™"

ix.loot = ix.loot or {}
ix.loot.containers = ix.loot.containers or {}

CAMI.RegisterPrivilege({
    Name = "Helix - Manage Loot Containers",
    MinAccess = "admin"
})

local defaultloottable = {
    "glass",
    "cloth",

}

local defaultrareloottable = {
    "pipe",
    "book",
    "paper",
    "wound_splint",
}

ix.loot.containers = {
    ["lootable"] = {
        name = "Lootable",
        description = "You might find something useful.",
        model = "models/hunter/blocks/cube075x075x075.mdl",
        skin = 0,
        delay = 300, -- time in seconds before it can be looted again
        lootTime = {2}, -- can be a table for random time, example: lootTime = {2, 5, 7, 8, 10},
        maxItems = {1}, -- how many items can be in the container
        items = defaultloottable,
        rareItems = defaultrareloottable,
    },

}

properties.Add("loot_setclass", {
    MenuLabel = "Set Loot Class",
    MenuIcon = "icon16/wrench.png",
    Order = 5,

    Filter = function(self, ent, ply)
        if not ( IsValid(ent) and ent:GetClass() == "ix_loot_container" ) then
            return false
        end

        return CAMI.PlayerHasAccess(ply, "Helix - Manage Loot Containers", nil)
    end,

    Action = function(self, ent)
    end,

    LootClassSet = function(self, ent, class)
        self:MsgStart()
            net.WriteEntity(ent)
            net.WriteString(class)
        self:MsgEnd()
    end,

    MenuOpen = function(self, option, ent, trace)
        local subMenu = option:AddSubMenu()

        for k, v in SortedPairs(ix.loot.containers) do
            subMenu:AddOption(v.name.." ("..k..")", function()
                self:LootClassSet(ent, k)
            end)
        end
    end,

    Receive = function(self, len, ply)
        local ent = net.ReadEntity()

        if not ( IsValid(ent) ) then
            return
        end

        if not ( self:Filter(ent, ply) ) then
            return
        end

        local class = net.ReadString()
        local loot = ix.loot.containers[class]

        // safety check, just to make sure if it really exists in both realms.
        if not ( class or loot ) then
            ply:Notify("You did not specify a valid container class!")
            return
        end

        ent:SetContainerClass(tostring(class))
        ent:SetModel(loot.model)
        ent:SetSkin(loot.skin or 0)
        ent:PhysicsInit(SOLID_VPHYSICS)
        ent:SetSolid(SOLID_VPHYSICS)
        ent:SetUseType(SIMPLE_USE)
        ent:DropToFloor()

        PLUGIN:SaveLootContainers()
    end
})

ix.util.Include("cl_plugin.lua")
ix.util.Include("sv_plugin.lua")