local CHAR = ix.meta.character

function CHAR:IsCitizen()
    return ( self:Team() == FACTION_CITIZEN )
end

function CHAR:IsMaintenance()
    return ( self:Team() == FACTION_MAINTENANCE )
end

function CHAR:IsResearcher()
    return ( self:Team() == FACTION_RESEARCHER )
end

function CHAR:IsSurvey()
    return ( self:Team() == FACTION_SURVEY )
end

function CHAR:IsSecurity()
    return ( self:Team() == FACTION_SECURITY )
end

function CHAR:IsHECU()
    return ( self:Team() == FACTION_HECU )
end

function CHAR:IsGovernment()
    return ( self:Team() == FACTION_GOVERNMENT )
end

function CHAR:IsAdministrator()
    return ( self:Team() == FACTION_ADMINISTRATOR )
end

function CHAR:IsBlackOps()
    return ( self:GetFaction() == FACTION_BLACKOPS )
end

function CHAR:IsXen()
    return ( self:GetFaction() == FACTION_XEN )
end

function CHAR:GiveMoney(value)
    self:SetMoney(self:GetMoney() + value)
end