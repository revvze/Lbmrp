function Schema:PlayerSwitchFlashlight(ply)
    if ( ply:GetMoveType() == MOVETYPE_NOCLIP ) then
        return false
    end

    return true
end

function Schema:EntityEmitSound(data)
    local ent = data.Entity
    if not IsValid(ent) or not ent:IsPlayer() then return end

    if ( data.SoundName:find("player/footsteps") ) then
        return false
    end
end

function Schema:GetPlayerPainSound(ply)
    if ( ply:IsResearcher() ) then
        return "bms_vo/npc/scientist_male01/pain"..math.random(1, 20)..".wav"
    elseif ( ply:IsSurvey() ) then
        return "bms_vo/npc/scientist_male01/pain"..math.random(1, 20)..".wav"
	elseif ( ply:IsSecurity() ) then
        return "bms_vo/npc/barneys/pain"..math.random(1, 16)..".wav"
    elseif ( ply:IsHECU() ) then
        return "bms_vo/npc/hecu_grunt/male/hg_hit"..math.random(1, 19)..".wav"
    end
end

function Schema:GetPlayerDeathSound(ply)
    if ( ply:IsResearcher() ) then
        return "bms_vo/npc/scientist_male01/pain"..math.random(1, 20)..".wav"
    elseif ( ply:IsSurvey() ) then
        return "bms_vo/npc/scientist_male01/pain"..math.random(1, 20)..".wav"
    elseif ( ply:IsSecurity() ) then
        return "bms_vo/npc/barneys/pain"..math.random(1, 16)..".wav"
    elseif ( ply:IsHECU() ) then
        return "bms_vo/npc/hecu_grunt/male/hg_hit"..math.random(1, 19)..".wav"
    end
end

function Schema:DoPlayerDeath(ply)
    ply.ixDeathPos = ply:GetPos()
    ply.ixDeathAngles = ply:GetAngles()
    ply:SetRestricted(false)
end

function Schema:PlayerSpawn(ply)
    timer.Simple(1, function()
        for k, v in ipairs(ents.FindByClass("ix_campfire")) do
            v:StopFire()
            v:StartFire()
        end
    end)
end

function Schema:PlayerHurt(ply, attacker, hp, dmg)
    if ( IsValid(attacker) and attacker:IsPlayer() and attacker:Alive() ) then
        local direction = attacker:GetAimVector() * dmg * 10
        direction.z = 0
        ply:SetVelocity(direction)
    end
end

function Schema:PlayerTeamChanged(ply, oldTeam, newTeam)
    local char = ply:GetCharacter()

    char:SetName(char:GetData("originalName", "John Doe"))

    if ( newTeam == FACTION_CITIZEN ) then
        char:SetModel(char:GetData("originalModel", table.Random(ix.faction.Get(newTeam).models)))
    end

    ply:ScreenFade(SCREENFADE.IN, color_black, 1, 1)
end

function Schema:PlayerDeath(ply, inflicter, attacker)
    if not ( ply:IsBot() ) then
        timer.Simple(ix.config.Get("spawnTime") + 0.01, function() ix.util.FactionBecome(ply, FACTION_CITIZEN) end) -- hacky
    end
end

function Schema:PlayerLoadedCharacter(ply, char)
    if not ( ply:IsCitizen() ) then
        ix.util.FactionBecome(ply, FACTION_CITIZEN)
    end
end

function Schema:PreGamemodeLoaded()
    function widgets.PlayerTick()
    end

    hook.Remove("PlayerTick", "TickWidgets")
end

local pickupAbleEntities = {
    ["grenade_helicopter"] = true,
    ["npc_grenade_frag"] = true,
    ["npc_handgrenade"] = true,
    ["ix_container"] = true,
    ["ix_cloth"] = true,
    ["ix_radioied"] = true,
}
function Schema:CanPlayerHoldObject(ply, ent)
    if ( pickupAbleEntities[ent:GetClass()] ) then
        return true
    end
end

function Schema:EntityTakeDamage(ply, dmg)
    if ( IsValid(ply) and ply:IsPlayer() ) then
        if ( dmg:IsDamageType(DMG_CRUSH) ) and not ( IsValid(ply.ixRagdoll) ) then
            return true
        end
    end
end

function Schema:ScalePlayerDamage(ply, hitgroup, dmginfo)
    local attacker = dmginfo:GetAttacker()
    if ( attacker.GetActiveWeapon ) then
        local awep = attacker:GetActiveWeapon()
    end
    if ( hitgroup == HITGROUP_HEAD ) then
        if ( IsValid(awep) ) then
            if ( awep.Primary.HeadshotDamage ) then
                dmginfo:SetDamage(awep.Primary.HeadshotDamage / 2)
            else
                dmginfo:SetDamage(awep.Primary.Damage * 2)
            end
        end
    end
end

local npcHealthValues = {
    ["npc_antlionguard"] = 1000,
    ["npc_antlion"] = 200,
    ["npc_hunter"] = 400,
    ["npc_combine_s"] = 200,
    ["npc_citizen"] = 100,
}
function Schema:PlayerSpawnedNPC(ply, ent)
    ent:SetKeyValue("spawnflags", "16384")
    ent:SetKeyValue("spawnflags", "2097152")
    ent:SetKeyValue("spawnflags", "8192") -- dont drop weapons

    if ( ent.SetCurrentWeaponProficiency ) then
        ent:SetCurrentWeaponProficiency(WEAPON_PROFICIENCY_PERFECT)
    end

    if ( npcHealthValues[ent:GetClass()] ) then
        ent:SetHealth(npcHealthValues[ent:GetClass()])
    end
end

local function DropFunction(ent)
    timer.Simple(0.6, function()
        ent:EmitSound("physics/metal/weapon_impact_hard"..math.random(1,3)..".wav", nil)
    end)

    timer.Simple(60, function()
        if ( IsValid(ent) ) then
            ent:EmitSound("physics/metal/metal_solid_impact_bullet"..math.random(1,4)..".wav", nil, 90)
            ent:Remove()
        end
    end)
end

local lootPools = {
    ["weapon_pistol"] = {"wep_usp", "ammo_pistol", "ammo_pistol"},
    ["weapon_smg1"] = {"wep_mp7", "ammo_smg", "ammo_smg"},
    ["weapon_shotgun"] = {"wep_spas12", "ammo_buckshot", "ammo_buckshot"},
    ["weapon_ar2"] = {"ammo_pulse", "ammo_pulse", "ammo_pulse"},
}

function Schema:GetGameDescription()
    return "Black Mesa Roleplay"
end

function Schema:CanPlayerSpawnContainer()
    return false
end