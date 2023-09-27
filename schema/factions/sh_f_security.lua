FACTION.name = "Security Force"
FACTION.description = ""
FACTION.color = Color(0, 63, 255)
FACTION.isDefault = true

FACTION.models = {
    "models/humans/pbmrp/guard_pm.mdl",
}

FACTION.xp = 250

function FACTION:OnCharacterCreated(ply, char)
    char:SetData("originalName", char:GetName())
    char:SetData("originalModel", char:GetModel())
    char:GiveFlags("pet")
end

FACTION_SECURITY = FACTION.index
