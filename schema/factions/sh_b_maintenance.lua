FACTION.name = "Engineering & Technical Service"
FACTION.description = ""
FACTION.color = Color(255, 200, 0)
FACTION.isDefault = true

FACTION.models = {
    "models/humans/pbmrp/custodian_pm.mdl",
}

FACTION.xp = 50

function FACTION:OnCharacterCreated(ply, char)
    char:SetData("originalName", char:GetName())
    char:SetData("originalModel", char:GetModel())
    char:GiveFlags("pet")
end

FACTION_MAINTENANCE = FACTION.index
