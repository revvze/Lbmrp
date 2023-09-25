FACTION.name = "Civilian"
FACTION.description = ""
FACTION.color = Color(160, 160, 160)
FACTION.isDefault = true

FACTION.models = {
    "models/sirgibs/ragdolls/bms_citizens/male_citizen_player.mdl",
}

FACTION.xp = 0

function FACTION:OnCharacterCreated(ply, char)
    char:SetData("originalName", char:GetName())
    char:SetData("originalModel", char:GetModel())
end

FACTION_CITIZEN = FACTION.index
