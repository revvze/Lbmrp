// MISC
SWEP.Base					= "tfa_bms_nade_base"
SWEP.Category				= "TFA Black Mesa"
SWEP.Author					= "The Boot Collective"
SWEP.PrintName				= "Frag Grenade"
SWEP.Slot					= 4
SWEP.SlotPos				= 99
SWEP.DrawAmmo				= true
SWEP.DrawCrosshair			= false
SWEP.Weight					= 2
SWEP.AutoSwitchTo				= true
SWEP.AutoSwitchFrom			= true
SWEP.HoldType 				= "grenade"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.Sprint_Mode 				= TFA.Enum.LOCOMOTION_ANI

// VIEWMODEL
SWEP.ViewModelFOV				= 75
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/tfa_bms/c_bms_grenade.mdl"

// WORLDMODEL
SWEP.WorldModel				= "models/weapons/tfa_bms/w_grenade_bms.mdl"
SWEP.ShowWorldModel			= true

// NADE STUFF
SWEP.Primary.RPM				= 30
SWEP.Primary.ClipSize			= 1
SWEP.Primary.DefaultClip		= 1
SWEP.Primary.Automatic			= false
SWEP.Primary.Ammo				= "grenade"
SWEP.Primary.Round 			= ("tfa_bms_thrownfrag")
SWEP.Velocity = 950
SWEP.Velocity_Underhand = 650
SWEP.Delay = 0.15
SWEP.DelayCooked = 0
SWEP.Delay_Underhand = 0.25
SWEP.CookStartDelay = 0
SWEP.UnderhandEnabled = true
SWEP.CookingEnabled = false
SWEP.CookTimer = 2.5
SWEP.NadeAngleModifier = Angle( 0, 0, -70 )
SWEP.NadeAngleModifierUnderhand = Angle( 0, 0, 84 )
SWEP.AllowSprintAttack = true

SWEP.SprintAnimation = {
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ,
		["value"] = "sprintidle1",
		["is_idle"] = true
	}
}

SWEP.InspectPos 				= Vector(4, -3.619, -0.787)
SWEP.InspectAng 				= Vector(22.386, 34.417, 5)

SWEP.EventTable = {
	[ACT_VM_THROW] = {
		{ ["time"] = 0, ["type"] = "lua", ["value"] = function(wep,vm)
			if wep and vm then
				wep.Bodygroups_V[1] = 1
			end
		end, ["client"] = true, ["server"] = true }
	},
	[ACT_VM_RELEASE] = {
		{ ["time"] = 0, ["type"] = "lua", ["value"] = function(wep,vm)
			if wep and vm then
				wep.Bodygroups_V[1] = 1
			end
		end, ["client"] = true, ["server"] = true }
	},
	[ACT_VM_DRAW] = {
		{ ["time"] = 0, ["type"] = "lua", ["value"] = function(wep,vm)
			if wep and vm then
				wep.Bodygroups_V[1] = 0
			end
		end, ["client"] = true, ["server"] = true }
	},
	[ACT_VM_DRAW_DEPLOYED] = {
		{ ["time"] = 0, ["type"] = "lua", ["value"] = function(wep,vm)
			if wep and vm then
				wep.Bodygroups_V[1] = 0
			end
		end, ["client"] = true, ["server"] = true }
	}
}