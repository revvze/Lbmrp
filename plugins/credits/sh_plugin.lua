local PLUGIN = PLUGIN

PLUGIN.name = "Credits"
PLUGIN.description = "Adds a command to roll the credits for all players."
PLUGIN.author = "Riggs.mackay"

PLUGIN.speed = 32 -- How fast the credits roll. (default: 48)
PLUGIN.killTime = 127 -- Time in seconds to wait before killing the credits.
PLUGIN.musicTrack = "bms_music/xen/xen - limitless potential.mp3"
PLUGIN.credits = [[
<font=Font-Elements80>
<color=255,136,0>Black Mesa Roleplay</color>
<font=Font-Elements64>
</font>

<font=Font-Elements32>
Framework Used
</font><font=Font-Elements24>
<color=255,255,255>helixβ</color>
</font>

<font=Font-Elements32>
<color=255,0,0>Managers</color>
</font><font=Font-Elements24>
Larry - Project Manager
Sulfer - Community Manager
</font>

<font=Font-Elements32>
<color=127,0,255>Developers</color>
</font><font=Font-Elements24>
Larry - Lead Developer
Sulfer - Developer
Sulfer - Developer
Riggs - Ex-Developer
</font>

<font=Font-Elements32>
<color=173,102,255>Staff Team</color>
</font><font=Font-Elements24>
Sulfer - Staff Manager
Sulfer - Senior Staff
Sulfer - Staff
Sulfer - Trial Staff
</font>

<font=Font-Elements32>
<color=0,50,200>Event Team</color>
</font><font=Font-Elements24>
Sulfer - Event Director
Sulfer - Senior Gamemaster
Sulfer - Gamemaster
Sulfer - Trial Gamemaster
</font>

<font=Font-Elements32>
<color=255,191,0>Faction Leadership</color>
</font><font=Font-Elements24>
Sulfer - Code Black Operations Unit
Sulfer - Hazardous Environment Combat Unit
Sulfer - Facility Security
Sulfer - Facility Administrator
</font>

<font=Font-Elements32>
<color=0,193,41>Beta Testers</color>
</font><font=Font-Elements24>
Larry
Sulfer
</font>

<font=Font-Elements32>
<color=0,80,17>Alpha Testers</color>
</font><font=Font-Elements24>
Larry
Sulfer
</font>

<font=Font-Elements32>
<color=127,159,255>Helix Framework</color>
</font><font=Font-Elements24>
Alex Grist - Lead Developer, Project Manager
Igor Radovanovic - Lead Developer, UI Designer
Haydawg - Lead Tester
</font>

<font=Font-Elements32>
<color=255,255,0>Special Thanks</color>
</font><font=Font-Elements24>
Luna
Black Tea
Rain GBizzle
Nebulous.cloud
NutScript
</font>

</font><font=Font-Elements24>
Valve Software
Crowbar Collective
Facepunch Studios
Project Black Mesa Roleplay
The Black Mesa Roleplay Community
</font>

<font=Font-Elements64>
Thank You For Playing
</font>
]]

if ( CLIENT ) then
    concommand.Add("ix_credits", function()
        vgui.Create("ixNewCredits")
    end)

    concommand.Add("ix_credits_music", function()
        local credits = vgui.Create("ixNewCredits")
        credits.musicEnabled = true
    end)
end

ix.command.Add("credits", {
    description = "Roll the credits for all players.",
    superAdminOnly = true,
    arguments = {
        bit.bor(ix.type.bool, ix.type.optional),
    },
    OnRun = function(self, ply, bMusic)
        for k, v in pairs(player.GetAll()) do
            if ( bMusic ) then
                v:ConCommand("ix_credits_music")
            else
                v:ConCommand("ix_credits")
            end
        end
    end
})
