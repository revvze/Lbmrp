SWEP.Category				= "TFA Black Mesa"
SWEP.Author				= "The Boot Collective"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.PrintName				= "Crowbar"		-- Weapon name (Shown on HUD)
SWEP.Slot				= 0				-- Slot in the weapon selection menu
SWEP.SlotPos				= 27			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= true		-- set false if you want no crosshair
SWEP.Weight				= 30			-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "melee"		-- how others view you carrying the weapon
SWEP.Primary.Sound = "weapon_crowbar_bms.Hit"-- Sound("Weapon_Knife.Slash") --Sounds
SWEP.KnifeShink = "Weapon_Crowbar.Melee_Hit"--"Weapon_Knife.HitWall" --Sounds
SWEP.KnifeSlash = "Weapon_Crowbar.Melee_Hit"--"Weapon_Knife.Hit" --Sounds
SWEP.KnifeStab = "weapon_crowbar_bms.Hit"--"Weapon_Knife.Slash" --Sounds
SWEP.Primary.Sound_Miss = Sound("Weapon_Crowbar.Melee_Hit")
SWEP.Primary.RPM = 200 --Primary Slashs per minute
SWEP.Primary.Delay = 0.0 --Delay for hull (primary)
SWEP.Secondary.Delay = 0.0 --Delay for hull (secondary)
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Ammo = nil
SWEP.DamageType = DMG_CLUB

function SWEP:ThrowKnife()
return false
end

SWEP.VMPos = Vector(1,-1,-1)
SWEP.VMAng = Vector(0, 0, 0)

-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.SlashTable = {"attack1_miss", "attack3_miss", "attack2_miss"} --Table of possible hull sequences
SWEP.StabTable = {"attack1_hit", "attack3_hit", "attack2_hit"} --Table of possible hull sequences
SWEP.StabMissTable = {"attack1_miss", "attack3_miss", "attack2_miss"} --Table of possible hull sequences

SWEP.Primary.Length = 50
SWEP.Secondary.Length = 55 

SWEP.Primary.Damage = 35
SWEP.Secondary.Damage = 55

SWEP.ViewModelFlip			= false
SWEP.ViewModelFOV		= 80
SWEP.ViewModel				= "models/weapons/tfa_bms/c_bms_crowbar.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/tfa_bms/w_crowbar_bms.mdl"	-- Weapon world model
SWEP.ShowWorldModel			= true
SWEP.Base				= "tfa_knife_base"
SWEP.Spawnable				= true
SWEP.UseHands = true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = true
SWEP.MuzzleFlashEffect = "" --No muzzle
SWEP.DoMuzzleFlash = false --No muzzle

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

SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_HYBRID
SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_ANI -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0 --Start an idle this far early into the end of another animation
SWEP.SprintBobMult = 0

DEFINE_BASECLASS(SWEP.Base)

local tracedata = {}

function SWEP:DoImpactEffect(tr, dmgtype)
	if tr.HitSky then return true end
	local ib = self.BashBase and IsValid(self) and self:GetBashing()
	local dmginfo = DamageInfo()
	dmginfo:SetDamageType(dmgtype)

	if ib and self.Secondary.BashDamageType == DMG_GENERIC then return true end
	if ib then return end

	if self.ImpactDecal and self.ImpactDecal ~= "" then
		util.Decal(self.ImpactDecal, tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
		return true
	end
end

function SWEP:PrimaryAttack()
	if not self:CanAttack() then return end

	local ow, gsp, ea, fw, tr

	ow = self:GetOwner()
	gsp = ow:GetShootPos()
	ea = ow:EyeAngles()
	fw = ea:Forward()
	tracedata.start = gsp
	tracedata.endpos = gsp + fw * self.Primary.Length
	tracedata.filter = ow

	tr = BaseClass.GetSlashTrace(self,tracedata, fw)
	
	if self:GetNextPrimaryFire() < CurTime() and self:GetOwner():IsPlayer() and not self:GetOwner():KeyDown(IN_RELOAD) then
		self.SlashCounter = self.SlashCounter + 1

		if self.SlashCounter > #self.SlashTable then
			self.SlashCounter = 1
		end

		if tr.Hit then
			self:SendViewModelSeq(self.StabTable[self.SlashCounter])
		else
			self:SendViewModelSeq(self.SlashTable[self.SlashCounter])
		end

		self:GetOwner():SetAnimation(PLAYER_ATTACK1)
		self:SetNextPrimaryFire(CurTime() + 1 / (self.Primary.RPM / 60))
		self:SetNextSecondaryFire(CurTime() + 1 / (self.Primary.RPM / 60))
		self:SetStatus(TFA.Enum.STATUS_RELOADING)
		self:SetStatusEnd(CurTime() + self.Primary.Delay)
	end
end

function SWEP:SecondaryAttack()
return false
end

local hudcolor = Color(255, 80, 0, 191)
if killicon and killicon.Add then
    killicon.Add("tfa_bms_crowbar", "bms/vgui/icons/tfa_bms_crowbar", hudcolor)
end