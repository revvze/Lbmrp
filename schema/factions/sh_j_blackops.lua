FACTION.name = "Code Black Operations Unit"
FACTION.description = ""
FACTION.color = Color(0, 0, 0)
FACTION.isDefault = true
FACTION.bNoPopulate = true

FACTION.models = {
    "models/humans/pbmrp/black_ops_02_pm.mdl",
}

FACTION.xp = 450

function FACTION:OnCharacterCreated(ply, char)
    char:SetData("originalName", char:GetName())
    char:SetData("originalModel", char:GetModel())
    char:GiveFlags("pet")
end

FACTION_BLACKOPS = FACTION.index
