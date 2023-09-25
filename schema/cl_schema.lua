function ix.util.DrawTexture(material, color, x, y, w, h)
    surface.SetDrawColor(color or color_white)
    surface.SetMaterial(ix.util.GetMaterial(material))
    surface.DrawTexturedRect(x, y, w, h)
end

sound.Add({
    name = "Helix.Rollover",
    channel = CHAN_STATIC,
    volume = 0.1,
    level = 80,
    pitch = 120,
    sound = "ui/ui_hover.wav",
})

sound.Add({
    name = "Helix.Press",
    channel = CHAN_STATIC,
    volume = 0.8,
    level = 80,
    pitch = 100,
    sound = "ui/ui_click.wav"
})

sound.Add({
    name = "Helix.Notify",
    channel = CHAN_STATIC,
    volume = 0.2,
    level = 80,
    pitch = 100,
    sound = "buttons/button19.wav",
})