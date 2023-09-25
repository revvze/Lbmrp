FACTION.name = "Research & Development"
FACTION.description = ""
FACTION.color = Color(255, 255, 255)
FACTION.isDefault = true

FACTION.models = {
    "models/humans/pbmrp/scientist_pm.mdl",
}

FACTION.xp = 100

function FACTION:OnCharacterCreated(ply, char)
    char:SetData("originalName", char:GetName())
    char:SetData("originalModel", char:GetModel())
    char:GiveFlags("pet")
end

FACTION_SCIENTIST = FACTION.index
