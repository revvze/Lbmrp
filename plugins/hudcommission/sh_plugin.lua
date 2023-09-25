
local PLUGIN = PLUGIN

PLUGIN.name = "Custom Bars"
PLUGIN.description = "Adds specific, Clockwork-style bars to Helix."
PLUGIN.author = "pedro.santos53"

ix.option.Add("showPercentagesOnBar", ix.type.bool, true, {
	category = "appearance",
	phrase = "Show percentage values on bars.",
	description = "Whether or not to show the percentage values on the bars."
})

-- Stamina plugin boilerplate
-- Needed to properly order the bars as desired
-- This changes both how stamina regen works clientside and serverside, so be wary.
do
	local function CalcStaminaChange(client)
		local character = client:GetCharacter()

		if (!character or client:GetMoveType() == MOVETYPE_NOCLIP) then
			return 0
		end

		local runSpeed

		if (SERVER) then
			runSpeed = ix.config.Get("runSpeed") + character:GetAttribute("stm", 0)

			if (client:WaterLevel() > 1) then
				runSpeed = runSpeed * 0.775
			end
		end

		local walkSpeed = ix.config.Get("walkSpeed")
		local maxAttributes = ix.config.Get("maxAttributes", 100)
		local offset

		if (client:KeyDown(IN_SPEED) and client:GetVelocity():LengthSqr() >= (walkSpeed * walkSpeed)) then
			-- characters could have attribute values greater than max if the config was changed
			offset = -ix.config.Get("staminaDrain", 1) + math.min(character:GetAttribute("end", 0), maxAttributes) / 100
		else
			offset = client:Crouching() and ix.config.Get("staminaCrouchRegeneration", 2) or ix.config.Get("staminaRegeneration", 1.75)
		end

		offset = hook.Run("AdjustStaminaOffset", client, offset) or offset

		if (CLIENT) then
			return offset -- for the client we need to return the estimated stamina change
		else
			local current = client:GetLocalVar("stm", 0)
			local value = math.Clamp(current + offset, 0, 100)

			if (current != value) then
				client:SetLocalVar("stm", value)

				if (value == 0 and !client:GetNetVar("brth", false)) then
					client:SetRunSpeed(walkSpeed)
					client:SetNetVar("brth", true)

					character:UpdateAttrib("end", 0.1)
					character:UpdateAttrib("stm", 0.01)

					hook.Run("PlayerStaminaLost", client)
				elseif (value >= 50 and client:GetNetVar("brth", false)) then
					client:SetRunSpeed(runSpeed)
					client:SetNetVar("brth", nil)

					hook.Run("PlayerStaminaGained", client)
				end
			end
		end
	end

	if SERVER then
		function PLUGIN:PostPlayerLoadout(client)
			local uniqueID = "ixStam" .. client:SteamID()

			timer.Create(uniqueID, 0.25, 0, function()
				if (!IsValid(client)) then
					timer.Remove(uniqueID)
					return
				end

				CalcStaminaChange(client)
			end)
		end
	else
		local predictedStamina = 100

		function PLUGIN:Think()
			local offset = CalcStaminaChange(LocalPlayer())
			-- the server check it every 0.25 sec, here we check it every [FrameTime()] seconds
			offset = math.Remap(FrameTime(), 0, 0.25, 0, offset)

			if (offset != 0) then
				predictedStamina = math.Clamp(predictedStamina + offset, 0, 100)
			end
		end

		function PLUGIN:OnLocalVarSet(key, var)
			if (key != "stm") then return end
			if (math.abs(predictedStamina - var) > 5) then
				predictedStamina = var
			end
		end

		do -- Create default bars
			local function BetterBarRemove(identifier)
				local bar = ix.bar.Get(identifier)

				if bar then
					for k, v in ipairs(ix.bar.list) do
						if v.identifier == identifier then
							table.remove(ix.bar.list, k)
							break
						end
					end

					if (IsValid(ix.gui.bars)) then
						ix.gui.bars:RemoveBar(bar.panel)
					end
				end

				if !ix.bar.list or #ix.bar.list <= 0 then
					ix.bar.list = {}
				end
			end

			function PLUGIN:InitializedPlugins()
				local bBilwinNeeds = ix.plugin.Get("needs")
				local bPedroHunger = ix.plugin.Get("hunger")

				BetterBarRemove("health")
				BetterBarRemove("armor")
				BetterBarRemove("stm")

				if bBilwinNeeds then
					BetterBarRemove("saturation")
					BetterBarRemove("satiety")
				end

				if bPedroHunger then
					BetterBarRemove("hunger")
				end

				-- Health
				ix.bar.Add(function()
					local client = LocalPlayer()
					local health = client:Health()
					local maxHealth = client:GetMaxHealth()
					if ix.option.Get("showPercentagesOnBar", false) then
						return math.max(health / maxHealth, 0), math.Round(health / maxHealth, 2) * 100 .. "%"
					else
						return math.max(health / maxHealth, 0)
					end
				end, Color(200, 50, 40), nil, "health")

				ix.bar.Add(function()
					if ix.option.Get("showPercentagesOnBar", false) then
						return predictedStamina / 100, math.Round(predictedStamina) .. "%"
					else
						return predictedStamina / 100
					end
				end, Color(93,161,76), nil, "stm")

				-- Armor
				ix.bar.Add(function()
					local client = LocalPlayer()
					local armor = client:Armor()
					local maxArmor = client:GetMaxArmor()
					if ix.option.Get("showPercentagesOnBar", false) then
						return math.min(armor / maxArmor, 1), math.Round(armor / maxArmor, 2) * 100 .. "%"
					else
						return math.min(armor / maxArmor, 1)
					end
				end, Color(76, 81, 97), nil, "armor")

				if bBilwinNeeds then
					-- Hunger
					ix.bar.Add( function()
						return math.max(LocalPlayer():GetLocalVar("satiety", 0) / 100, 0), math.Round(LocalPlayer():GetLocalVar("satiety", 0)) .. "%"
					end, Color(203, 151, 0 ), nil, "satiety", "hudSatiety")

					-- Thirst
					ix.bar.Add( function()
						return math.max(LocalPlayer():GetLocalVar("saturation", 0) / 100, 0), math.Round(LocalPlayer():GetLocalVar("saturation", 0)) .. "%"
					end, Color(68, 106, 205 ), nil, "saturation", "hudSaturation")
				end

				if bPedroHunger then
					-- Hunger
					ix.bar.Add( function()
						local client = LocalPlayer()
						local character = IsValid(client) and client:GetCharacter()
						if (!character) then return 0 end

						if ix.option.Get("showPercentagesOnBar", false) then
							return math.max(character:GetHunger() / character:GetMaxHunger(), 0), (math.Round(character:GetHunger() / character:GetMaxHunger(), 2) * 100) .. "%"
						else
							return math.max(character:GetHunger() / character:GetMaxHunger(), 0)
						end
					end, Color( 226, 169, 13), nil, "hunger")
				end
			end
		end
	end
end