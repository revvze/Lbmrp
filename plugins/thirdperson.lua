local Entity = Entity
local FindMetaTable = FindMetaTable
local FrameTime = FrameTime
local IsValid = IsValid
local Lerp = Lerp
local LerpAngle = LerpAngle
local LerpVector = LerpVector
local LocalPlayer = LocalPlayer
local Vector = Vector
local concommand_Add = concommand.Add
local hook_Run = hook.Run
local ix = ix
local util_TraceHull = util.TraceHull

local PLUGIN = PLUGIN

PLUGIN.name = "Thirdperson"
PLUGIN.author = "Riggs"
PLUGIN.description = "Enables third person camera usage, with many extras than the original."

ix.config.Add("thirdperson", true, "Allow Thirdperson in the server.", nil, {
	category = "server"
})

ix.config.ForceSet("thirdperson", true)

ix.lang.AddTable("english", {
	optThirdpersonFOV = "Camera field of view",
	optThirdpersonSmoothPosition = "Enable smooth position third person",
	optThirdpersonSmoothAngle = "Enable smooth angle third person",
	optFirstpersonEnabled = "Enable immersive first person",
})

if ( CLIENT ) then
	local function isHidden()
		return !ix.config.Get("thirdperson")
	end

	ix.option.Add("thirdpersonEnabled", ix.type.bool, false, {
		category = "thirdperson",
		hidden = isHidden,
		OnChanged = function(oldValue, value)
			hook_Run("ThirdPersonToggled", oldValue, value)
		end
	})

	ix.option.Add("thirdpersonVertical", ix.type.number, 5, {
		category = "thirdperson", min = 0, max = 30,
		hidden = isHidden
	})

	ix.option.Add("thirdpersonHorizontal", ix.type.number, 20, {
		category = "thirdperson", min = -30, max = 30,
		hidden = isHidden
	})

	ix.option.Add("thirdpersonDistance", ix.type.number, 75, {
		category = "thirdperson", min = 0, max = 100,
		hidden = isHidden
	})

	ix.option.Add("thirdpersonFOV", ix.type.number, 85, {
		category = "thirdperson", min = 50, max = 120,
		hidden = isHidden
	})

	ix.option.Add("thirdpersonSmoothPosition", ix.type.bool, true, {
		category = "thirdperson",
		hidden = isHidden
	})

	ix.option.Add("thirdpersonSmoothAngle", ix.type.bool, true, {
		category = "thirdperson",
		hidden = isHidden
	})

	ix.option.Add("firstpersonEnabled", ix.type.bool, false, {
		category = "thirdperson",
		OnChanged = function(oldValue, value)
			hook_Run("FirstPersonToggled", oldValue, value)
		end
	})

	concommand_Add("ix_togglethirdperson", function()
		local bEnabled = !ix.option.Get("thirdpersonEnabled", false)

		ix.option.Set("thirdpersonEnabled", bEnabled)
	end)

	concommand_Add("ix_togglefirstperson", function()
		local bEnabled = !ix.option.Get("firstpersonEnabled", false)

		ix.option.Set("firstpersonEnabled", bEnabled)
	end)

	local function isAllowed()
		return ix.config.Get("thirdperson")
	end

	local playerMeta = FindMetaTable("Player")
	local traceMin = Vector(-4, -4, -4)
	local traceMax = Vector(4, 4, 4)

	function playerMeta:CanOverrideView()
		local entity = Entity(self:GetLocalVar("ragdoll", 0))

		local charMenu = ix.gui.characterMenu
		if ( IsValid(charMenu) and !charMenu:IsClosing() and charMenu:IsVisible() ) then
			local charSettings = charMenu.settingsCharacterPanel
			if ( charSettings and charSettings.category and string.lower(charSettings.category) == "thirdperson" ) then
				return true
			end

			return false
		end

		if ( IsValid(ix.gui.menu) and ix.gui.menu:GetCharacterOverview() ) then
			return false
		end

		if ( SCENES_PLAYING ) then
			return false
		end

		if ( ix.option.Get("thirdpersonEnabled", false) and
			!IsValid(self:GetVehicle()) and
			isAllowed() and
			IsValid(self) and
			self:GetCharacter() and
			!self:GetNetVar("actEnterAngle") and
			self:GetMoveType() != MOVETYPE_NOCLIP and
			!IsValid(entity) and
			LocalPlayer():Alive() ) then
			return true
		end
	end

	function playerMeta:CanOverrideFirstView()
		local entity = Entity(self:GetLocalVar("ragdoll", 0))

		local charMenu = ix.gui.characterMenu
		if ( IsValid(charMenu) and !charMenu:IsClosing() and charMenu:IsVisible() ) then
			return false
		end

		if ( IsValid(ix.gui.menu) and ix.gui.menu:GetCharacterOverview() ) then
			return false
		end

		if ( SCENES_PLAYING ) then
			return false
		end

		if ( ix.option.Get("firstpersonEnabled", false) and
			!IsValid(self:GetVehicle()) and
			isAllowed() and
			IsValid(self) and
			self:GetCharacter() and
			!self:GetNetVar("actEnterAngle") and
			self:GetMoveType() != MOVETYPE_NOCLIP and
			!IsValid(entity) and
			LocalPlayer():Alive() ) then
			return true
		end
	end

	local view, traceData, traceData2, aimOrigin, crouchFactor, ft, curAng, owner
	local clmp = math.Clamp
	crouchFactor = 0

	local lerpOrigin
	local lerpAngles
	function PLUGIN:CalcView(ply, origin, angles, fov)
		ft = FrameTime()

		if ( ply:CanOverrideView() and LocalPlayer():GetViewEntity() == LocalPlayer() ) then
			local bNoclip = LocalPlayer():GetMoveType() == MOVETYPE_NOCLIP

			if ( ( ply:OnGround() and ply:KeyDown(IN_DUCK) ) or ply:Crouching() ) then
				crouchFactor = Lerp(ft*5, crouchFactor, 1)
			else
				crouchFactor = Lerp(ft*5, crouchFactor, 0)
			end

			local pos = ply
			local filter = {ply}
			if IsValid(ply:GetNW2Entity("DrGBasePossessing")) then
				pos = ply:GetNW2Entity("DrGBasePossessing")
				table.insert(filter, ply:GetNW2Entity("DrGBasePossessing"))
			end

			curAng = ply:EyeAngles()
			view = {}
			traceData = {}
			traceData.start = 	pos:GetPos() + ply:GetViewOffset() +
								curAng:Up() * ix.option.Get("thirdpersonVertical", 20) +
								curAng:Right() * ix.option.Get("thirdpersonHorizontal", 5) -
								ply:GetViewOffsetDucked() * 0.5 * crouchFactor
			traceData.endpos = traceData.start - curAng:Forward() * ix.option.Get("thirdpersonDistance", 75)
			traceData.filter = filter
			traceData.ignoreworld = bNoclip
			traceData.mins = traceMin
			traceData.maxs = traceMax

			local hitpos = util_TraceHull(traceData).HitPos

			if not ( lerpOrigin ) then
				lerpOrigin = hitpos
			end

			if not ( lerpAngles ) then
				lerpAngles = curAng
			end

			if ( ix.option.Get("thirdpersonSmoothPosition") ) then
				lerpOrigin = LerpVector(ft * 8, lerpOrigin, hitpos)
			else
				lerpOrigin = hitpos
			end

			if ( ix.option.Get("thirdpersonSmoothAngle") ) then
				lerpAngles = LerpAngle(ft * 8, lerpAngles, curAng)
			else
				lerpAngles = curAng
			end

			view.origin = lerpOrigin
			view.angles = lerpAngles
			view.fov = ix.option.Get("thirdpersonFOV")

			return view
		else
			lerpOrigin = origin
			lerpAngles = angles
			
			if ( ply:CanOverrideFirstView() ) then
				if not ( ply:LookupBone("ValveBiped.Bip01_Head1") ) then
					return
				end
		
				local headBone = ply:GetAttachment(ply:LookupAttachment("eyes"))
				headBone.Pos = headBone.Pos + headBone.Ang:Forward() * 3
		
				return {
					origin = headBone.Pos or origin,
					angles = angles,
					fov = fov,
					drawviewer = true,
				}
			end
		end
	end

	function PLUGIN:CreateMove(cmd)
	end

	function PLUGIN:InputMouseApply(cmd, x, y, ang)
	end

	function PLUGIN:PlayerSwitchWeapon( ply, oldWeapon, newWeapon )
	end

	function PLUGIN:ShouldDrawLocalPlayer()
		if ( LocalPlayer():GetViewEntity() == LocalPlayer() and not IsValid(LocalPlayer():GetVehicle()) ) then
			return LocalPlayer():CanOverrideView()
		end
	end

	function PLUGIN:PrePlayerDraw(ply, flags)
		local client = LocalPlayer()
		if not ( client:CanOverrideView() ) then
			return
		end

		if ( ply == client ) then
			return
		end

		local trace = util_TraceHull({
			start = client:EyePos(),
			endpos = ply:EyePos(),
			mask = MASK_SHOT,
		})

		ply:DrawShadow(true)

		if ( ( trace and not IsValid(trace.Entity) and trace.Entity:IsPlayer() ) or not ply:IsLineOfSightClear(client) ) then
			ply:DrawShadow(false)
			return true
		end
	end
end