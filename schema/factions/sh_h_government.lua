FACTION.name = "The Government"
FACTION.description = ""
FACTION.color = Color(0, 31, 127)
FACTION.isDefault = true

FACTION.models = {
    "models/humans/pbmrp/unique/gman_bm_pm.mdl",
}

FACTION.xp = 350

function FACTION:OnCharacterCreated(ply, char)
    char:SetData("originalName", char:GetName())
    char:SetData("originalModel", char:GetModel())
end

FACTION_GOVERNMENT = FACTION.index
