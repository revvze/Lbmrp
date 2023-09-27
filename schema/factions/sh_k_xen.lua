FACTION.name = "Xen Life Form (WIP)"
FACTION.description = ""
FACTION.color = Color(127, 0, 255)
FACTION.isDefault = true

FACTION.models = {
    "models/ultrashacklesvort/vortigaunt_injured.mdl",
}

FACTION.xp = 500

function FACTION:OnCharacterCreated(ply, char)
    char:SetData("originalName", char:GetName())
    char:SetData("originalModel", char:GetModel())
end

FACTION_XEN = FACTION.index
