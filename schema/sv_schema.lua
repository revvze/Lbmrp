util.AddNetworkString("ixSurfaceSound")
util.AddNetworkString("ixOpenVGUI")
util.AddNetworkString("ixPlayerDeathFactionChange")

function Schema:GiveWeapons(ply, weapons)
    for i, weapon in ipairs(weapons) do
        ply:Give(weapon)
    end
end