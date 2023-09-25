surface.CreateFont("BMRPTitleFont", {
    font = "Arial",
    size = ScreenScale(30),
    antialias = true,
    shadow = true,
})

surface.CreateFont("BMRPChatFont1", {
    font = "MinionPro-Regular",
    size = math.max(ScreenScale(7), 17) * ix.option.Get("chatFontScale", 1),
    extended = true,
    weight = 600,
    antialias = true
})

surface.CreateFont("BMRPChatFont2", {
    font = "Mailart Rubberstamp",
    size = math.max(ScreenScale(7), 17) * ix.option.Get("chatFontScale", 1),
    extended = true,
    weight = 600,
    antialias = true
})

surface.CreateFont("BroadcastFont", {
    font = "Cambria",
    size = 20,
    weight = 800,
    antialias = true,
    shadow = true,
    italic = true,
})

surface.CreateFont("ixChatFont", {
    font = "Roboto",
    size = math.max(ScreenScale(7), 17) * ix.option.Get("chatFontScale", 1),
    extended = true,
    weight = 600,
    antialias = true
})

surface.CreateFont("ixWhisperChatFont", {
    font = "Roboto",
    size = math.max(ScreenScale(7), 17) * ix.option.Get("chatFontScale", 1) - 4,
    extended = true,
    weight = 600,
    antialias = true
})

surface.CreateFont("ixYellChatFont", {
    font = "Roboto",
    size = math.max(ScreenScale(7), 17) * ix.option.Get("chatFontScale", 1) + 4,
    extended = true,
    weight = 600,
    antialias = true
})

for i = 10, 80 do
    surface.CreateFont("Font-Elements"..tostring(i), {
        font = "Arial",
        size = i,
        weight = 800,
        italic = false,
        antialias = true,
        shadow = false,
    })

    surface.CreateFont("Font-Elements"..tostring(i).."-Shadow", {
        font = "Arial",
        size = i,
        weight = 800,
        italic = false,
        antialias = true,
        shadow = true,
    })

    surface.CreateFont("Font-Elements"..tostring(i).."-Italic", {
        font = "Arial",
        size = i,
        weight = 800,
        italic = true,
        antialias = true,
        shadow = false,
    })

    surface.CreateFont("Font-Elements"..tostring(i).."-Light", {
        font = "Arial",
        size = i,
        weight = 100,
        italic = false,
        antialias = true,
        shadow = false,
    })
end