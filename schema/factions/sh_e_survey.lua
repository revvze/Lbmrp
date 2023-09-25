FACTION.name = "Survey Exploration Team"
FACTION.description = ""
FACTION.color = Color(255, 136, 0)
FACTION.isDefault = true

FACTION.models = {
    "models/humans/pbmrp/scientist_pm.mdl",
}

FACTION.xp = 200

function FACTION:OnCharacterCreated(ply, char)
    char:SetData("originalName", char:GetName())
    char:SetData("originalModel", char:GetModel())
    char:GiveFlags("pet")
end

FACTION_SURVEY = FACTION.index
