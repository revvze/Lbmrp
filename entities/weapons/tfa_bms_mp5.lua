SWEP.Gun = ("tfa_bms_mp5")

SWEP.Category				= "TFA Black Mesa" --The category.  Please, just choose something generic or something I've already done if you plan on only doing like one swep..
SWEP.Author				= "The Boot Collective" --Author Tooltip
SWEP.Manufacturer = "Heckler & Koch" --Gun Manufactrer (e.g. Hoeckler and Koch )
SWEP.MuzzleAttachment			= "muzzle"
SWEP.Instructions				= ""
SWEP.ShellEjectAttachment			= "1"
SWEP.PrintName				= "MP5"	
SWEP.Slot				= 2
SWEP.SlotPos				= 1
SWEP.ViewModelFOV			= 76
SWEP.DrawAmmo				= true
SWEP.DrawCrosshair			= true
SWEP.Weight				= 15
SWEP.AutoSwitchTo			= true
SWEP.AutoSwitchFrom			= true
SWEP.HoldType 				= "smg"
SWEP.ViewModelFlip			= false
SWEP.Spawnable				= true
SWEP.UseHands 				= true
SWEP.AdminSpawnable			= true
SWEP.ViewModel			= "models/weapons/tfa_bms/c_bms_mp5.mdl" --Viewmodel path
SWEP.WorldModel			= "models/weapons/tfa_bms/w_mp5_bms.mdl" -- Weapon world model path
SWEP.Base					= "tfa_gun_base"
SWEP.FiresUnderwater = false
SWEP.Secondary.IronFOV			= 70	
SWEP.data 				= {}

SWEP.RunSightsPos = Vector( 0, 0, 0 )
SWEP.RunSightsAng = Vector( 0, 0, 0 )
SWEP.AllowReloadWhileDraw = true
SWEP.AllowReloadWhileHolster = true
SWEP.AllowReloadWhileSprinting = false
SWEP.AllowReloadWhileNearWall = true
SWEP.Primary.Damage		= 25
SWEP.Primary.Sound = Sound("weapon_mp5_bms.1")
SWEP.Primary.RPM			= 575
SWEP.Primary.ClipSize			= 30
SWEP.Primary.DefaultClip		= 120
SWEP.Primary.BaseKick			= 0.1
SWEP.Primary.KickUp				= 0.3
SWEP.Primary.MaxKick 			= 0.3
SWEP.Primary.KickDown			= 0.1
SWEP.Primary.KickHorizontal		= 0.1
SWEP.Primary.Automatic			= true
SWEP.DisableChambering = true
SWEP.Primary.Ammo = "smg1" -- What kind of ammo.  Options, besides custom, include pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, and AirboatGun.
SWEP.Primary.AmmoConsumption = 1 --Ammo consumed per shot
SWEP.Secondary.Ammo			= "SMG1_Grenade"
SWEP.Secondary.Sound		= Sound( "weapon_mp5_bms.grenade" )
SWEP.Primary.Spread		= .02
SWEP.Primary.IronAccuracy = .01
SWEP.SelectiveFire		= false
SWEP.data.ironsights			= 1
SWEP.IronSightsPos = Vector(-3.62, -2.5, 1.3)
SWEP.IronSightsAng = Vector(2, -1.2, 0)

--[[VIEWMODEL BLOWBACK]]--
SWEP.BlowbackEnabled = true --Enable Blowback?
SWEP.BlowbackVector = Vector(0.01,-1.2,0) --Vector to move bone <or root> relative to bone <or view> orientation.
SWEP.BlowbackCurrentRoot = 0 --Amount of blowback currently, for root
SWEP.BlowbackCurrent = 0 --Amount of blowback currently, for bones
SWEP.BlowbackBoneMods = nil --Viewmodel bone mods via SWEP Creation Kit
SWEP.Blowback_Only_Iron = true --Only do blowback on ironsights
SWEP.Blowback_PistolMode = false --Do we recover from blowback when empty?
SWEP.Blowback_Shell_Enabled = false --Shoot shells through blowback animations
SWEP.Blowback_Shell_Effect = "ShellEject"--Which shell effect to use


DEFINE_BASECLASS( "tfa_gun_base" )

local reloadfix = 1
local canglf = 1
local clik = 1
local up = 0

function SWEP:Think(...)
	
	local nsfac = self:GetNW2Int("FireCount") + 1

	if self:GetStatus() == TFA.GetStatus("idle") then
		if not self.LastIdleTime then
			self.LastIdleTime = CurTime()
		elseif CurTime() > self.LastIdleTime + 0.1 then
			self:SetNW2Int("FireCount",0)
		end
	else
		self.LastIdleTime = nil
	end
	
	return BaseClass.Think(self,...)
end

function SWEP:CanSecondaryAttack()
	
	if self:Ammo2() < 1 then
		if not self.HasPlayedEmptyClick then
			self:EmitSound("Weapon_SMG1.Empty")

			self.HasPlayedEmptyClick = true
		end
		return false
	end
	
	if self.FiresUnderwater == false and self:GetOwner():WaterLevel() >= 3 then
		self:SetNextSecondaryFire(CurTime() + 0.5)
		self:EmitSound("Weapon_SMG1.Empty")
		return false
	else
		return true
	end
end


function SWEP:AltAttack()
	
	local vecSrc = self.Owner:GetShootPos();
	local Forward = self.Owner:EyeAngles():Forward()
	local Right = self.Owner:EyeAngles():Right()
	local Up = self.Owner:EyeAngles():Up()
	
	local	vecThrow;
	// Don't autoaim on grenade tosses
	vecThrow = self.Owner:GetAimVector()* 1000.0;
	
	if CurTime() > self:GetNextSecondaryFire() and self:CanSecondaryAttack() and self:Ammo2() > 0 and TFA.Enum.ReadyStatus[self:GetStatus()] and not self:GetSprinting() then
		if SERVER then
			local ent = ents.Create( "bms_smg_grenade" )
			if (self:GetIronSights())then
				ent:SetPos(self.Owner:EyePos() + ( self.Owner:GetAimVector() * 16 ))
			else
				ent:SetPos( self.Owner:GetShootPos() + Forward * 7 + Right * 6 + Up * -12 );
			end
			ent:SetAngles( self.Owner:EyeAngles() )
			ent:Spawn()
			ent:Activate()
			if (self:GetIronSights()) then
				ent:GetPhysicsObject():SetVelocity( Forward*1200.0 );
				ent:GetPhysicsObject():AddAngleVelocity( Vector( -400, 400, 0 ) );
			else
				ent:GetPhysicsObject():SetVelocity(self.Owner:GetAimVector()*1000)
				ent:GetPhysicsObject():AddAngleVelocity( Vector( -400, 400, 0 ) );
			end
			ent:SetOwner(self.Owner)
		end

		self:SendViewModelAnim(ACT_VM_SECONDARYATTACK)
		self:SetNextSecondaryFire(CurTime() + 1.0)
		self.Owner:SetAmmo(self.Owner:GetAmmoCount(self.Secondary.Ammo) - 1, self.Secondary.Ammo)
		self:EmitSound(self.Secondary.Sound)
	end
end


SWEP.SprintAnimation = {
	["in"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "idletosprint", --Number for act, String/Number for sequence
		["transition"] = true
	}, --Inward transition
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "sprintidle1", --Number for act, String/Number for sequence
		["is_idle"] = true
	},--looping animation
	["out"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "sprinttoidle", --Number for act, String/Number for sequence
		["transition"] = true
	} --Outward transition
}

SWEP.Attachments = {
	[1] = { offset = { 0, 0 }, atts = { "am_match", "am_magnum", "am_gib" }, order = 3 },

}
SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_ANI -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Walk_Mode = TFA.Enum.LOCOMOTION_HYBRID -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0 --Start an idle this far early into the end of another animation
SWEP.SprintBobMult = 0