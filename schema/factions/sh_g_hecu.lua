FACTION.name = "Hazardous Environment Combat Unit"
FACTION.description = ""
FACTION.color = Color(0, 127, 31)
FACTION.isDefault = true

FACTION.models = {
    "models/humans/pbmrp/marine_02_pm.mdl",
}

FACTION.xp = 300

function FACTION:OnCharacterCreated(ply, char)
    char:SetData("originalName", char:GetName())
    char:SetData("originalModel", char:GetModel())
    char:GiveFlags("pet")
end

FACTION_HECU = FACTION.index
