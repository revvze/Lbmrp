local PLUGIN = PLUGIN

PLUGIN.name = "Simplistic Event System"
PLUGIN.description = "A Simplistic Event System, mainly used to play sound effects or music tracks."
PLUGIN.author = "Riggs Mackay"
PLUGIN.schema = "Any"

ix.util.Include("sv_plugin.lua")

if ( CLIENT ) then
    net.Receive("ixPlaySound", function(len, ply)
        LocalPlayer():EmitSound(tostring(net.ReadString()), tonumber(net.ReadUInt(7)) or 100)
    end)
    
    net.Receive("ixCreateVGUI", function(len, ply)
        vgui.Create(tostring(net.ReadString()))
    end)

    surface.CreateFont("RiggsFontShadow30", {
        font = "Segoe Ui",
        size = 30,
        weight = 1000,
        antialias = true,
        shadow = true,
    })

    surface.CreateFont("RiggsFont28", {
        font = "Segoe Ui",
        size = 28,
        weight = 1000,
        antialias = true,
    })

    surface.CreateFont("RiggsFont18", {
        font = "Segoe Ui",
        size = 18,
        weight = 1000,
        antialias = true,
    })
end

ix.adminSystem = ix.adminSystem or {}
ix.adminSystem.music = ix.adminSystem.music or {}
ix.adminSystem.derma = ix.adminSystem.derma or {}

-- Configuration below.

ix.adminSystem.music = {
    ["SCP Unity"] = {
        {"Objective Complete", "scpunity/music/objective_completed.wav"},
        {"Containment Breach", "scpunity/music/breach_music.mp3"},
        {"Horror Ambience", "scpunity/music/loneliness_music.wav"},
    }
}
