SWEP.Base				= "tfa_3dscoped_base"
SWEP.Category				= "TFA Black Mesa" --The category.  Please, just choose something generic or something I've already done if you plan on only doing like one swep..
SWEP.Manufacturer = nil --Gun Manufactrer (e.g. Hoeckler and Koch )
SWEP.Author				= "The Boot Collective" --Author Tooltip
SWEP.Contact				= "" --Contact Info Tooltip
SWEP.Purpose				= "" --Purpose Tooltip
SWEP.Instructions				= "" --Instructions Tooltip
SWEP.Spawnable				= true --Can you, as a normal user, spawn this?
SWEP.AdminSpawnable			= true --Can an adminstrator spawn this?  Does not tie into your admin mod necessarily, unless its coded to allow for GMod's default ranks somewhere in its code.  Evolve and ULX should work, but try to use weapon restriction rather than these.
SWEP.DrawCrosshair			= true		-- Draw the crosshair?
SWEP.DrawCrosshairIS = false --Draw the crosshair in ironsights?
SWEP.PrintName				= "RPG"		-- Weapon name (Shown on HUD)
SWEP.Slot				= 4				-- Slot in the weapon selection menu.  Subtract 1, as this starts at 0.
SWEP.SlotPos				= 73			-- Position in the slot
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.Weight				= 30			-- This controls how "good" the weapon is for autopickup.
SWEP.Type = "Launcher"

--[[WEAPON HANDLING]]--
SWEP.Primary.Sound = Sound("weapon_rpg_bms.1") -- This is the sound of the weapon, when you shoot.
SWEP.Primary.SilencedSound = nil -- This is the sound of the weapon, when silenced.
SWEP.Primary.Damage = 129 -- Damage, in standard damage points.
SWEP.Primary.NumShots = 1 --The number of shots the weapon fires.  SWEP.Shotgun is NOT required for this to be >1.
SWEP.Primary.Automatic = false -- Automatic/Semi Auto
SWEP.Primary.RPM = 140 -- This is in Rounds Per Minute / RPM

SWEP.Primary.Projectile = "tfa_bms_rocket"
SWEP.Primary.ProjectileVelocity = 300 -- 76 meters to inches * 4/3 ( 16 / 12 hammer to inches )

--Miscelaneous Sounds
SWEP.IronInSound = nil --Sound to play when ironsighting in?  nil for default
SWEP.IronOutSound = nil --Sound to play when ironsighting out?  nil for default

--Silencing
SWEP.CanBeSilenced = false --Can we silence?  Requires animations.
SWEP.Silenced = false --Silenced by default?

-- Selective Fire Stuff
SWEP.SelectiveFire = false --Allow selecting your firemode?
SWEP.DisableBurstFire = false --Only auto/single?
SWEP.OnlyBurstFire = false --No auto, only burst/single?
SWEP.DefaultFireMode = "" --Default to auto or whatev
SWEP.FireModeName = "Single" --Change to a text value to override it

--Ammo Related
SWEP.Primary.ClipSize = 1 -- This is the size of a clip
SWEP.Primary.DefaultClip = 50 -- This is the number of bullets the gun gives you, counting a clip as defined directly above.
SWEP.Primary.Ammo = "RPG_Round" -- What kind of ammo.  Options, besides custom, include pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, and AirboatGun.
SWEP.Primary.AmmoConsumption = 1 --Ammo consumed per shot
--Pistol, buckshot, and slam like to ricochet. Use AirboatGun for a light metal peircing shotgun pellets
SWEP.DisableChambering = true --Disable round-in-the-chamber
SWEP.FiresUnderwater = false

--Recoil Related
SWEP.Primary.KickUp = 0.8 -- This is the maximum upwards recoil (rise)
SWEP.Primary.KickDown = 0.5 -- This is the maximum downwards recoil (skeet)
SWEP.Primary.KickHorizontal = 0.2  -- This is the maximum sideways recoil (no real term)
SWEP.Primary.StaticRecoilFactor = 0.3 --Amount of recoil to directly apply to EyeAngles.  Enter what fraction or percentage (in decimal form) you want.  This is also affected by a convar that defaults to 0.5.

--Firing Cone Related
SWEP.Primary.Spread = .05 --This is hip-fire acuracy.  Less is more (1 is horribly awful, .0001 is close to perfect)
SWEP.Primary.IronAccuracy = .0035 -- Ironsight accuracy, should be the same for shotguns

--Unless you can do this manually, autodetect it.  If you decide to manually do these, uncomment this block and remove this line.
SWEP.Primary.SpreadMultiplierMax = 7--How far the spread can expand when you shoot. Example val: 2.5
SWEP.Primary.SpreadIncrement = 3 --What percentage of the modifier is added on, per shot.  Example val: 1/3.5
SWEP.Primary.SpreadRecovery = 7--How much the spread recovers, per second. Example val: 3

--Range Related
SWEP.Primary.Range = 5400 * 0.3046875 * 16 -- The distance the bullet can travel in source units.  Set to -1 to autodetect based on damage/rpm.
SWEP.Primary.RangeFalloff = 0.4 -- The percentage of the range the bullet damage starts to fall off at.  Set to 0.8, for example, to start falling off after 80% of the range.

--Penetration Related
SWEP.MaxPenetrationCounter = 0 --The maximum number of ricochets.  To prevent stack overflows.

--Misc
SWEP.IronRecoilMultiplier = 0.5 --Multiply recoil by this factor when we're in ironsights.  This is proportional, not inversely.
SWEP.CrouchAccuracyMultiplier = 0.5 --Less is more.  Accuracy * 0.5 = Twice as accurate, Accuracy * 0.1 = Ten times as accurate

--Movespeed
SWEP.MoveSpeed = 0.8 --Multiply the player's movespeed by this.
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.8 --Multiply the player's movespeed by this when sighting.

--[[VIEWMODEL]]--
SWEP.ViewModel			= "models/weapons/tfa_bms/c_bms_rpg.mdl" --Viewmodel path
SWEP.ViewModelFOV			= 75		-- This controls how big the viewmodel looks.  Less is more.
SWEP.ViewModelFlip			= false		-- Set this to true for CSS models, or false for everything else (with a righthanded viewmodel.)
SWEP.UseHands = true --Use gmod c_arms system.

--[[WORLDMODEL]]--
SWEP.WorldModel			= "models/weapons/tfa_bms/w_rpg_bms.mdl" -- Weapon world model path
SWEP.HoldType = "rpg" -- This is how others view you carrying the weapon. Options include:
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive
-- You're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles
SWEP.Offset = {
	Pos = {
		Up = 0.5,
		Right = 0.5,
		Forward = 2
	},
	Ang = {
		Up = -1,
		Right = 0,
		Forward = 178
	},
	Scale = 1
} --Procedural world model animation, defaulted for CS:S purposes.
SWEP.ThirdPersonReloadDisable = false --Disable third person reload?  True disables.

--[[SPRINTING]]--

SWEP.RunSightsPos = Vector(0, 0, 0)
SWEP.RunSightsAng = Vector(0, 0, 0)
--SWEP.RunSightsAng = Vector(-11.869, -17.129, 16.056)

--[[IRONSIGHTS]]--
SWEP.data = {}
SWEP.data.ironsights = 1 --Enable Ironsights
SWEP.Secondary.IronFOV = 40 -- How much you 'zoom' in. Less is more!  Don't have this be <= 0.  A good value for ironsights is like 70.
SWEP.IronSightsPos = Vector(-5.9, 0, -0.148) --Change this, using SWEP Creation Kit preferably
SWEP.IronSightsAng = Vector(0, -2.23, 0)
--[[INSPECTION]]--
SWEP.InspectPos = nil--Vector(0,0,0) --Replace with a vector, in style of ironsights position, to be used for inspection
SWEP.InspectAng = nil--Vector(0,0,0) --Replace with a vector, in style of ironsights angle, to be used for inspection

--[[VIEWMODEL ANIMATION HANDLING]]--
SWEP.AllowViewAttachment = false --Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.

SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_HYBRID
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0.0 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.0 --Start an idle this far early into the end of another animation

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

--[[EFFECTS]]--

--Attachments
SWEP.MuzzleAttachment			= "muzzle" 		-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellAttachment			= "rocket" 		-- Should be "2" for CSS models or "shell" for hl2 models
SWEP.MuzzleFlashEnabled = false --Enable muzzle flash
SWEP.MuzzleAttachmentRaw = nil --This will override whatever string you gave.  This is the raw attachment number.  This is overridden or created when a gun makes a muzzle event.
SWEP.AutoDetectMuzzleAttachment = false --For multi-barrel weapons, detect the proper attachment?
SWEP.MuzzleFlashEffect = "tfa_muzzleflash_rifle" --Change to a string of your muzzle flash effect.  Copy/paste one of the existing from the base.
SWEP.SmokeParticle = "" --Smoke particle (ID within the PCF), defaults to something else based on holdtype; "" to disable
SWEP.EjectionSmokeEnabled = true --Disable automatic ejection smoke

SWEP.Bodygroups_V = {
	[1] = 0
}

local hudcolor = Color(255, 80, 0, 191)
if killicon and killicon.Add then
    killicon.Add("tfa_bms_rpg", "bms/vgui/icons/tfa_bms_rpg", hudcolor)
end

DEFINE_BASECLASS( SWEP.Base )

SWEP.Animations = { --Override this after SWEP:Initialize, for example, in attachments
	["draw_first"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_DRAW_DEPLOYED
	},
	["draw"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_DRAW
	},
	["draw_empty"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "draw1_empty",
		["enabled"] = true
	},
	["draw_silenced"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_DRAW_SILENCED
	},
	["shoot1"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_PRIMARYATTACK
	},
	["shoot1_last"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_PRIMARYATTACK_EMPTY
	},
	["shoot1_empty"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_DRYFIRE
	},
	["shoot1_silenced"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_PRIMARYATTACK_SILENCED
	},
	["shoot1_silenced_empty"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_DRYFIRE_SILENCED or 0
	},
	["shoot1_is"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_PRIMARYATTACK_1
	},
	["shoot2"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_SECONDARYATTACK
	},
	["shoot2_last"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_SECONDARYATTACK_EMPTY
	},
	["shoot2_empty"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_DRYFIRE
	},
	["shoot2_silenced"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_SECONDARYATTACK_SILENCED
	},
	["idle"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_IDLE
	},
	["idle_empty"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "idle_unloaded",
		["enabled"] = true
	},
	["idle_silenced"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_IDLE_SILENCED
	},
	["reload"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_RELOAD
	},
	["reload_empty"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_RELOAD_EMPTY
	},
	["reload_silenced"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_RELOAD_SILENCED
	},
	["reload_shotgun_start"] = {
		["type"] = TFA.Enum.ANIMATION_ACT,
		["value"] = ACT_SHOTGUN_RELOAD_START
	},
	["reload_shotgun_finish"] = {
		["type"] = TFA.Enum.ANIMATION_ACT,
		["value"] = ACT_SHOTGUN_RELOAD_FINISH
	},
	["holster"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_HOLSTER
	},
	["holster_empty"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "holster_empty",
		["enabled"] = true
	}
}

SWEP.EnableScreen = false

SWEP.EventTable = {
	[ACT_VM_RELOAD] = {
		{ ["time"] = 10 / 30, ["type"] = "lua", ["value"] = function(wep,vm)
			wep.Bodygroups_V = {
				[1] = 1
			}
			wep:ProcessBodygroups()
		end, ["client"] = true, ["server"] = true }
	},
	[ACT_VM_DRAW_DEPLOYED] = {
		{ ["time"] = 110 / 30, ["type"] = "lua", ["value"] = function(wep,vm)
			wep.Bodygroups_V = {
				[1] = 1
			}
			wep:ProcessBodygroups()
		end, ["client"] = true, ["server"] = true },
		{ ["time"] = 95 / 30, ["type"] = "lua", ["value"] = function(wep,vm)
			wep.EnableScreen = true
		end, ["client"] = true, ["server"] = true }
	},
	[ACT_VM_DRAW] = {
		{ ["time"] = 0, ["type"] = "lua", ["value"] = function(wep,vm)
			if not wep.EnableScreen then
				wep.EnableScreen = true
				wep.AlphaFade = 255
			end
		end, ["client"] = true, ["server"] = true }
	},
	[ACT_VM_HOLSTER] = {
		{ ["time"] = 0, ["type"] = "lua", ["value"] = function(wep,vm)
			if not wep.EnableScreen then
				wep.EnableScreen = true
				wep.AlphaFade = 255
			end
		end, ["client"] = true, ["server"] = true }
	},
	[ACT_VM_PRIMARYATTACK] = {
		{ ["time"] = 5 / 30, ["type"] = "lua", ["value"] = function(wep,vm)
			wep.Bodygroups_V = {
				[1] = 0
			}
			wep:ProcessBodygroups()
		end, ["client"] = true, ["server"] = true }
	},
}

SWEP.VElements = {
	["rtcircle"] = { type = "Model", model = "models/rtcircle.mdl", bone = "V_RPG", rel = "", pos = Vector(3.17, -7.34, 1.7425), angle = Angle(0, 90, 0), size = Vector(0.21, 0.21, 0.21), color = Color(255, 255, 255, 255), surpresslightning = false, material = "!tfa_rtmaterial", skin = 0, bodygroup = {} },
	["rpg_screen"] = { type = "Quad", bone = "Screen_Frame", rel = "", pos = Vector(3.2, -0.601, -3), angle = Angle(180, 0, -105), size = 0.0075, draw_func = nil},
	["laser_beam"] = { type = "Model", model = "models/tfa/lbeam.mdl", bone = "V_RPG", rel = "", pos = Vector(3.099, 9, -1.601), angle = Angle(0, -90, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.LaserSightAttachment = 2

function SWEP:ShootBullet(damage, recoil, num_bullets, aimcone, disablericochet, bulletoverride)
	if not IsFirstTimePredicted() and not game.SinglePlayer() then return end
	num_bullets = num_bullets or 1
	aimcone = aimcone or 0

	if SERVER then
		local ent = ents.Create(self:GetStat("Primary.Projectile"))
		local dir
		local ang = self:GetOwner():EyeAngles()
		ang:RotateAroundAxis(ang:Right(), -aimcone / 2 + math.Rand(0, aimcone))
		ang:RotateAroundAxis(ang:Up(), -aimcone / 2 + math.Rand(0, aimcone))
		dir = ang:Forward()
		local mzpos = self:GetMuzzlePos()
		if self:GetIronSights() then
			ent:SetPos( self.Owner:GetShootPos() + ( self.Owner:GetAngles():Forward() * 4 ) )
		else
			ent:SetPos(self:GetOwner():GetShootPos() + ( self.Owner:GetRight() * 6 )  + ( self.Owner:GetUp() * 2 ))
		end
		ent:SetOwner( self:GetOwner() )
		ent:SetAngles(self:GetOwner():EyeAngles() - Angle(3, 0, 0))
		ent.damage = self:GetStat("Primary.Damage")
		ent.mydamage = self:GetStat("Primary.Damage")

		ent:Spawn()
		ent:SetVelocity(dir * self:GetStat("Primary.ProjectileVelocity"))
		local phys = ent:GetPhysicsObject()

		if IsValid(phys) then
			phys:SetVelocity(dir * self:GetStat("Primary.ProjectileVelocity"))
		end

		ent:SetOwner(self:GetOwner())
		ent:SetCreator(self:GetOwner())
	end
end

function SWEP:UpdateScopeType( force )
	if self:Do3DScope() then
		self.Scoped = false
		self.Scoped_3D = true

		if not self.Secondary.ScopeZoom_Backup then
			self.Secondary.ScopeZoom_Backup = self.Secondary.ScopeZoom
		end

		if self.Secondary.ScopeZoom and self.Secondary.ScopeZoom > 0 then
			if CLIENT then
				self.RTScopeFOV = 90 / self.Secondary.ScopeZoom * ( self.Secondary.ScopeScreenScale or 0.392592592592592 )
			end
			self.Secondary.IronFOV_Backup = self.Secondary.IronFOV
			self.Secondary.IronFOV = 70
			if CLIENT then
				self.IronSightsSensitivity = self:Get3DSensitivity( )
			end
			self.Secondary.ScopeZoom = nil
		end
	else
		self.Scoped = true
		self.Scoped_3D = false

		if self.Secondary.ScopeZoom_Backup then
			self.Secondary.ScopeZoom = self.Secondary.ScopeZoom_Backup
		else
			self.Secondary.ScopeZoom = 4
		end
		self.BoltAction = true

		self.Secondary.IronFOV = 90 / self.Secondary.ScopeZoom
		self.IronSightsSensitivity = 1
	end
end

local flipcv
local cd = {}
local crosscol = Color(255, 255, 255, 255)
SWEP.RTOpaque = true
SWEP.RTMaterialOverride = -1
SWEP.ScopeReticule_Scale = {1.4, 1.4}
local cv_cc_r = GetConVar("cl_tfa_hud_crosshair_color_r")
local cv_cc_g = GetConVar("cl_tfa_hud_crosshair_color_g")
local cv_cc_b = GetConVar("cl_tfa_hud_crosshair_color_b")
local cv_cc_a = GetConVar("cl_tfa_hud_crosshair_color_a")

SWEP.defaultscrvec = Vector()

SWEP.RTCode = function(self, rt, scrw, scrh)
	local rttw = ScrW()
	local rtth = ScrH()
	if not self:VMIV() then return end
	if not self.myshadowmask then
		self.myshadowmask = surface.GetTextureID(self.ScopeShadow or "vgui/scope_shadowmask_test")
	end

	if not self.myreticule then
		self.myreticule = Material(self.ScopeReticule or "bms/scopes/rpg_ret")
	end

	if not flipcv then
		flipcv = GetConVar("cl_tfa_viewmodel_flip")
	end

	local vm = self.OwnerViewModel

	if not self.LastOwnerPos then
		self.LastOwnerPos = self:GetOwner():GetShootPos()
	end

	local owoff = self:GetOwner():GetShootPos() - self.LastOwnerPos
	self.LastOwnerPos = self:GetOwner():GetShootPos()
	local scrpos

	self.defaultscrvec.x = scrw / 2
	self.defaultscrvec.y = scrh / 2
	scrpos = self.defaultscrvec


	scrpos.x = scrpos.x - scrw / 2 + self.ScopeOverlayTransforms[1]
	scrpos.y = scrpos.y - scrh / 2 + self.ScopeOverlayTransforms[2]
	scrpos.x = scrpos.x / scrw * 1920
	scrpos.y = scrpos.y / scrw * 1920
	scrpos.x = math.Clamp(scrpos.x, -1024, 1024)
	scrpos.y = math.Clamp(scrpos.y, -1024, 1024)
	--scrpos.x = scrpos.x * ( 2 - self.IronSightsProgress*1 )
	--scrpos.y = scrpos.y * ( 2 - self.IronSightsProgress*1 )
	scrpos.x = scrpos.x * self.ScopeOverlayTransformMultiplier
	scrpos.y = scrpos.y * self.ScopeOverlayTransformMultiplier

	if not self.scrpos then
		self.scrpos = scrpos
	end

	self.scrpos.x = math.Approach(self.scrpos.x, scrpos.x, (scrpos.x - self.scrpos.x) * FrameTime() * 10)
	self.scrpos.y = math.Approach(self.scrpos.y, scrpos.y, (scrpos.y - self.scrpos.y) * FrameTime() * 10)
	scrpos = self.scrpos
	render.OverrideAlphaWriteEnable(true, true)
	surface.SetDrawColor(color_white)
	surface.DrawRect(-512, -512, 1024, 1024)
	render.OverrideAlphaWriteEnable(true, true)
	local ang = EyeAngles()
	if self.RTScopeAttachment and self.RTScopeAttachment > 0 then
		local AngPos = vm:GetAttachment( self.RTScopeAttachment )

		if AngPos then
			ang = AngPos.Ang

			if flipcv:GetBool() then
				ang.y = -ang.y
			end

			for k, v in pairs(self.ScopeAngleTransforms) do
				if v[1] == "P" then
					ang:RotateAroundAxis(ang:Right(), v[2])
				elseif v[1] == "Y" then
					ang:RotateAroundAxis(ang:Up(), v[2])
				elseif v[1] == "R" then
					ang:RotateAroundAxis(ang:Forward(), v[2])
				end
			end
		end
	end

	cd.angles = ang
	cd.origin = self:GetOwner():GetShootPos()

	if not self.RTScopeOffset then
		self.RTScopeOffset = {0, 0}
	end

	if not self.RTScopeScale then
		self.RTScopeScale = {1, 1}
	end

	local rtow, rtoh = self.RTScopeOffset[1], self.RTScopeOffset[2]
	local rtw, rth = rttw * self.RTScopeScale[1], rtth * self.RTScopeScale[2]
	cd.x = 0
	cd.y = 0
	cd.w = rtw
	cd.h = rth
	cd.fov = self.RTScopeFOV
	cd.drawviewmodel = false
	cd.drawhud = false
	render.Clear(0, 0, 0, 255, true, true)
	render.SetScissorRect(0 + rtow, 0 + rtoh, rtw + rtow, rth + rtoh, true)

	if self.IronSightsProgress > 0.01 and self.Scoped_3D then
		render.RenderView(cd)
	end

	render.SetScissorRect(0, 0, rtw, rth, false)
	render.OverrideAlphaWriteEnable(false, true)
	cam.Start2D()
		draw.NoTexture()
		surface.SetTexture(self.myshadowmask)
		surface.SetDrawColor(color_white)

		if self:Do3DScopeOverlay() then
			surface.DrawTexturedRect(scrpos.x + rtow - rtw / 2, scrpos.y + rtoh - rth / 2, rtw * 2, rth * 2)
		end

		if self.ScopeReticule_CrossCol then
			crosscol.r = cv_cc_r:GetFloat()
			crosscol.g = cv_cc_g:GetFloat()
			crosscol.b = cv_cc_b:GetFloat()
			crosscol.a = cv_cc_a:GetFloat()
			surface.SetDrawColor(crosscol)
		end

		surface.SetMaterial(self.myreticule)
		local tmpborderw = rtw * (1 - self.ScopeReticule_Scale[1]) / 2
		local tmpborderh = rth * (1 - self.ScopeReticule_Scale[2]) / 2
		surface.DrawTexturedRect(rtow + tmpborderw, rtoh + tmpborderh, rtw - tmpborderw * 2, rth - tmpborderh * 2)
		surface.SetDrawColor(color_black)
		draw.NoTexture()

		if self:Do3DScopeOverlay() then
			surface.DrawRect(scrpos.x - 2048 + rtow, -1024 + rtoh, 2048, 2048)
			surface.DrawRect(scrpos.x + rtw + rtow, -1024 + rtoh, 2048, 2048)
			surface.DrawRect(-1024 + rtow, scrpos.y - 2048 + rtoh, 2048, 2048)
			surface.DrawRect(-1024 + rtow, scrpos.y + rth + rtoh, 2048, 2048)
		end

		surface.SetDrawColor(ColorAlpha(color_black, 255 - 255 * (math.Clamp(self.IronSightsProgress - 0.75, 0, 0.25) * 4)))
		surface.DrawRect(-1024 + rtow, -1024 + rtoh, 2048, 2048)

	cam.End2D()
end

SWEP.BatteryMaterial = Material( "bms/models/weapons/v_rpg/battery.png", "smooth" )

function SWEP:Think()

	self.TwitchAmount = math.random( -20, 20 )

	BaseClass.Think( self )
end

SWEP.TwitchMultipler = 0

function SWEP:Initialize()
	self.AlphaFade = 0
	self.TwitchMultipler = 0
	self.TwitchAmount = 0
	if CLIENT then
		self.VElements["rpg_screen"].draw_func = function( weapon )
			if self.EnableScreen then
				self.AlphaFade = math.Approach( self.AlphaFade, 255, FrameTime() * 200)
				if self.Owner:WaterLevel() != 3 then
					self.TwitchMultipler = math.Approach( self.TwitchMultipler, 0, FrameTime())
				else
					self.TwitchMultipler = math.Approach( self.TwitchMultipler, 1, FrameTime())
				end
				draw.SimpleText( "Ammo: " .. self:Clip1() .. "/" .. self.Owner:GetAmmoCount( self:GetPrimaryAmmoType() ), "BlackMesa_RPG_Screen", -120 + ( self.TwitchAmount * self.TwitchMultipler ), -118, Color( 173, 252, 135, self.AlphaFade ) )
				draw.SimpleText( "Distance: " .. math.Round( self.Owner:GetPos():Distance( self.Owner:GetEyeTrace().HitPos ) / 53 ) .. "m", "BlackMesa_RPG_Screen", -120, -88 + ( self.TwitchAmount * self.TwitchMultipler ), Color( 173, 252, 135, self.AlphaFade ) )
				draw.SimpleText( "Time: " .. math.Round( math.Round( self.Owner:GetPos():Distance( self.Owner:GetEyeTrace().HitPos ) ) / 1750 , 2 ) .. "s", "BlackMesa_RPG_Screen", -120, -58 - ( self.TwitchAmount * self.TwitchMultipler ), Color( 173, 252, 135, self.AlphaFade ) )
				draw.SimpleText( "Drop: " .. math.Round( math.Round( self.Owner:GetPos():Distance( self.Owner:GetEyeTrace().HitPos ) ) / 1750 ) .. "m", "BlackMesa_RPG_Screen", -120 - ( self.TwitchAmount * self.TwitchMultipler ), -28, Color( 173, 252, 135, self.AlphaFade ) )
				surface.SetDrawColor( 255, 255, 255, self.AlphaFade )
				surface.SetMaterial( self.BatteryMaterial )
				surface.DrawTexturedRect( 115 - ( self.TwitchAmount / 2 * self.TwitchMultipler ), -100 + ( self.TwitchAmount * self.TwitchMultipler ), 256 / 4, 128 / 4 )
			end
		end
	end
	BaseClass.Initialize(self)
end
