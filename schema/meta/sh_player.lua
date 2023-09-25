local PLAYER = FindMetaTable("Player")

function PLAYER:IsCitizen()
    return ( self:Team() == FACTION_CITIZEN )
end

function PLAYER:IsMaintenance()
    return ( self:Team() == FACTION_MAINTENANCE )
end

function PLAYER:IsResearcher()
    return ( self:Team() == FACTION_RESEARCHER )
end

function PLAYER:IsSurvey()
    return ( self:Team() == FACTION_SURVEY )
end

function PLAYER:IsSecurity()
    return ( self:Team() == FACTION_SECURITY )
end

function PLAYER:IsHECU()
    return ( self:Team() == FACTION_HECU )
end

function PLAYER:IsGovernment()
    return ( self:Team() == FACTION_GOVERNMENT )
end

function PLAYER:IsAdministrator()
    return ( self:Team() == FACTION_ADMINISTRATOR )
end

function PLAYER:IsBlackOps()
    return ( self:GetFaction() == FACTION_BLACKOPS )
end

function PLAYER:IsXen()
    return ( self:GetFaction() == FACTION_XEN )
end

local devIDs = {}
devIDs["76561198120282729"] = true -- Larry

function PLAYER:IsDeveloper()
    return ( self:GetUserGroup() == "developer" or devIDs[self:SteamID64()] )
end

function PLAYER:IsDonator()
    return ( self:GetUserGroup() == "donator" or self:IsAdmin() )
end

function PLAYER:SurfacePlaySound(sound)
    net.Start("ixSurfaceSound")
        net.WriteString(sound)
    net.Send(self)
end

function PLAYER:OpenVGUI(panel)
    if not ( isstring(panel) ) then
        ErrorNoHalt("Warning argument is required to be a string! Instead is "..type(panel).."\n")
        return
    end

    if ( SERVER ) then
        net.Start("ixOpenVGUI")
            net.WriteString(panel)
        net.Send(self)
    else
        vgui.Create(panel)
    end
end

net.Receive("ixOpenVGUI", function()
    local panel = net.ReadString()
    if not ( isstring(panel) ) then
        ErrorNoHalt("Warning argument is required to be a string! Instead is "..type(panel).."\n")
        return
    end
    
    vgui.Create(panel)
end)