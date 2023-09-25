--[[---------------------------------------------------------------------------
    Initializing Original Chat Classes
---------------------------------------------------------------------------]]--

function Schema:InitializedChatClasses()
    ix.chat.Register("ic", {
        format = " \"%s\"",
        indicator = "chatTalking",
        font = "BMRPChatFont1",
        GetColor = function(self, speaker, text)
            if (LocalPlayer():GetEyeTrace().Entity == speaker) then
                return ix.config.Get("chatListenColor")
            end

            return ix.config.Get("chatColor")
        end,
        OnChatAdd = function(self, speaker, text, anonymous, info)
            local color = self:GetColor(speaker, text, info)
            local name = anonymous and L"someone" or hook.Run("GetCharacterName", speaker, "ic") or (IsValid(speaker) and speaker:Name() or "Console")

            -- to you - inspired by willard networks
            local lookingAt = speaker:GetEyeTraceNoCursor().Entity == LocalPlayer()

            chat.AddText(team.GetColor(speaker:Team()), name, color, " says", lookingAt and " to you" or "", string.format(self.format, text))
        end,
        CanHear = ix.config.Get("chatRange", 280)
    })

    ix.chat.Register("w", {
        format = " \"%s\"",
        indicator = "chatWhispering",
        font = "BMRPChatFont1",
        description = "@cmdW",
        prefix = {"/W", "/Whisper"},
        OnChatAdd = function(self, speaker, text, anonymous, info)
            local color = Color(0, 150, 255)
            local name = anonymous and L"someone" or hook.Run("GetCharacterName", speaker, "w") or (IsValid(speaker) and speaker:Name() or "Console")

            -- to you - inspired by willard networks
            local lookingAt = speaker:GetEyeTraceNoCursor().Entity == LocalPlayer()

            chat.AddText(team.GetColor(speaker:Team()), name, color, " whispers", lookingAt and " to you" or "", string.format(self.format, text))
        end,
        CanHear = ix.config.Get("chatRange", 280) * 0.5
    })

    -- Yelling out loud.
    ix.chat.Register("y", {
        format = " \"%s\"",
        indicator = "chatYelling",
        font = "BMRPChatFont1",
        description = "@cmdY",
        prefix = {"/Y", "/Yell"},
        OnChatAdd = function(self, speaker, text, anonymous, info)
            local color = Color(250, 100, 0)
            local name = anonymous and L"someone" or hook.Run("GetCharacterName", speaker, "y") or (IsValid(speaker) and speaker:Name() or "Console")
            
            if ( speaker.ixBandanaEquipped ) then
                name = "Masked Person"
            end

            -- to you - inspired by willard networks
            local lookingAt = speaker:GetEyeTraceNoCursor().Entity == LocalPlayer()

            chat.AddText(team.GetColor(speaker:Team()), name, color, " yells", lookingAt and " at you" or "", string.format(self.format, text))
        end,
        CanHear = ix.config.Get("chatRange", 280) * 2
    })

    -- Out of char.
    ix.chat.Register("ooc", {
        CanSay = function(self, speaker, text)
            if not ( ix.config.Get("allowGlobalOOC") ) then
                speaker:NotifyLocalized("Global OOC is disabled.")
                return false
            else
                local delay = ix.config.Get("oocDelay", 10)

                -- Only need to check the time if they have spoken in OOC chat before.
                if ( delay > 0 and speaker.ixLastOOC ) then
                    local lastOOC = CurTime() - speaker.ixLastOOC

                    -- Use this method of checking time in case the oocDelay config changes.
                    if ( lastOOC <= delay and not CAMI.PlayerHasAccess(speaker, "Helix - Bypass OOC Timer", nil) ) then
                        speaker:NotifyLocalized("oocDelay", delay - math.ceil(lastOOC))

                        return false
                    end
                end

                -- Save the last time they spoke in OOC.
                speaker.ixLastOOC = CurTime()
            end
        end,
        OnChatAdd = function(self, speaker, text)
            if not ( IsValid(speaker) ) then return end

            local icon = "icon16/user.png"
            local label = "Member"
            local color = Color(240, 240, 240)
            
            if ( speaker:IsSuperAdmin() ) then -- Super Admins
                icon = "icon16/ruby.png"
                label = "Management"
                color = Color(230, 20, 20)
            elseif ( speaker:IsAdmin() ) then -- Admins
                icon = "icon16/shield_add.png"
                label = "Staff"
                color = Color(25, 83, 219)
            end

            icon = Material(hook.Run("GetPlayerIcon", speaker) or icon)

            chat.AddText(icon, Color(175, 0, 0), "[OOC] ", color, speaker:SteamName(), color_white, ": "..text)
        end,
        prefix = {"//", "/OOC"},
        description = "@cmdOOC",
        noSpaceAfter = true
    })

    -- Local out of char.
    ix.chat.Register("looc", {
        CanSay = function(self, speaker, text)
            local delay = ix.config.Get("loocDelay", 0)

            -- Only need to check the time if they have spoken in LOOC chat before.
            if ( delay > 0 and speaker.ixLastLOOC ) then
                local lastLOOC = CurTime() - speaker.ixLastLOOC

                -- Use this method of checking time in case the oocDelay config changes.
                if ( lastLOOC <= delay and not CAMI.PlayerHasAccess(speaker, "Helix - Bypass OOC Timer", nil) ) then
                    speaker:NotifyLocalized("loocDelay", delay - math.ceil(lastLOOC))

                    return false
                end
            end

            -- Save the last time they spoke in LOOC.
            speaker.ixLastLOOC = CurTime()
        end,
        OnChatAdd = function(self, speaker, text)
            if not ( IsValid(speaker) ) then return end

            local icon = "icon16/user.png"
            local label = "Member"
            local color = Color(240, 240, 240)
            
            if ( speaker:IsSuperAdmin() ) then -- Super Admins
                icon = "icon16/ruby.png"
                label = "Higher Management"
                color = Color(230, 20, 20)
            elseif ( speaker:IsAdmin() ) then -- Admins
                icon = "icon16/shield_add.png"
                label = "Moderator"
                color = Color(25, 83, 219)
            elseif ( speaker:IsDonator() ) then -- Donators
                icon = "icon16/coins.png"
                label = "Donator"
                color = Color(200, 170, 0)
            end

            icon = Material(hook.Run("GetPlayerIcon", speaker) or icon)

            local name = speaker:Nick()

            chat.AddText(icon, Color(175, 0, 0), "[LOOC] ", color, speaker:SteamName(), team.GetColor(speaker:Team()), " ("..name..")", color_white, ": "..text)
        end,
        CanHear = ix.config.Get("chatRange", 280),
        prefix = {".//", "[[", "/LOOC"},
        description = "@cmdLOOC",
        noSpaceAfter = true
    })
end