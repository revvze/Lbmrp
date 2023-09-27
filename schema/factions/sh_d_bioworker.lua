FACTION.name = "Biohazardous Personnel"
FACTION.description = ""
FACTION.color = Color(127, 255, 159)
FACTION.isDefault = true

FACTION.models = {
    "models/humans/pbmrp/scientist_pm.mdl",
}

FACTION.xp = 150

function FACTION:OnCharacterCreated(ply, char)
    char:SetData("originalName", char:GetName())
    char:SetData("originalModel", char:GetModel())
    char:GiveFlags("pet")
end

FACTION_BIOWORKER = FACTION.index
