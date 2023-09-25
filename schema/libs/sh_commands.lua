ix.command.Add("ChangeRoleplayName", {
    description = "Change your roleplay name, but as a cost of 50 XP.",
    arguments = {
        ix.type.text,
    },
    OnCheckAccess = function(self, ply)
        return ply:GetXP() >= 50
    end,
    OnRun = function(self, ply, newName)
        local char = ply:GetCharacter()
        char:SetName(newName)
        char:SetData("originalName", newName)

        ply:SetXP(ply:GetXP() - 50)
        ply:Notify("You changed your roleplay name to "..newName..".")
    end,
})

ix.command.Add("ForceRoleplayName", {
    description = "Forcefully change a roleplay name of someone.",
    arguments = {
        ix.type.player,
        ix.type.text,
    },
    OnCheckAccess = function(self, ply)
        return ply:IsAdmin()
    end,
    OnRun = function(self, ply, target, newName)
        target:GetCharacter():SetName(newName)
        target:GetCharacter():SetData("originalName", newName)

        ply:Notify("You forced "..target:Nick().." to change their roleplay name to "..newName..".")
        target:Notify("You were forced to change your roleplay name to "..newName..".")
    end,
})

-- SetPermaModel
ix.command.Add("SetPermaModel", {
    description = "Set a player's permanent model.",
    arguments = {
        ix.type.player,
        ix.type.text,
    },
    OnCheckAccess = function(self, ply)
        return ply:IsAdmin()
    end,
    OnRun = function(self, ply, target, newModel)
        target:GetCharacter():SetModel(newModel)
        target:GetCharacter():SetData("originalModel", newModel)

        ply:Notify("You set "..target:Nick().."'s permanent model to "..model..".")
    end,
})

ix.command.Add("discord", {
    description = "Join our Discord Server!",
    OnCanRun = function(_, ply)
        return true
    end,
    OnRun = function(_, ply)
        ply:SendLua([[gui.OpenURL("")]])
    end
})

ix.command.Add("content", {
    description = "Get our Server's Content Pack.",
    OnCanRun = function(_, ply)
        return true
    end,
    OnRun = function(_, ply)
        ply:SendLua([[gui.OpenURL("https://steamcommunity.com/sharedfiles/filedetails/?id=3039779892")]])
    end
})

ix.command.Add("rules", {
    description = "Read our server's rules.",
    OnCanRun = function(_, ply)
        return true
    end,
    OnRun = function(_, ply)
        ply:SendLua([[gui.OpenURL("")]])
    end
})

