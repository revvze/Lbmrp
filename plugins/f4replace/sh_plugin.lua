local PLUGIN = PLUGIN

PLUGIN.name = "F4 Menu Replace"
PLUGIN.description = "Replaces the TAB key for the Tab Menu to the F4 key."
PLUGIN.author = "Larry"
PLUGIN.schema = "Any"

function PLUGIN:ScoreboardShow()
    return false
end

ix.util.Include("cl_plugin.lua")