function Schema:CanDrive(ply, ent)
    return false
end

function Schema:OnEntityCreated(ent)
    if ( IsValid(ent) ) then
        if ( ent:GetClass() == "prop_door_rotating" ) then
            ent:DrawShadow(false)
        elseif ( ent:GetClass() == "prop_ragdoll" ) then
            ent:SetCollisionGroup(COLLISION_GROUP_WORLD)
        end
    end
end

function Schema:OnPlayerHitGround(ply)
    local vel = ply:GetVelocity()
    ply:SetVelocity(Vector(- ( vel.x * 0.4 ), - ( vel.y * 0.4 ), 0))
end

function Schema:IsCharacterRecognized()
    return true
end

function Schema:CanPlayerUseBusiness(ply)
    return true
end

function Schema:CanPlayerJoinClass()
    return false
end