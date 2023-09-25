FACTION.name = "Facility Administrator"
FACTION.description = ""
FACTION.color = Color(255, 0, 0)
FACTION.isDefault = true

FACTION.models = {
    "models/humans/pbmrp/unique/breen_bms_pm.mdl",
}

FACTION.xp = 400

function FACTION:OnCharacterCreated(ply, char)
    char:SetData("originalName", char:GetName())
    char:SetData("originalModel", char:GetModel())
    char:GiveFlags("pet")
end

FACTION_ADMIN = FACTION.index
