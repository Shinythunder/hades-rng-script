return function(Rayfield, Window)
    local tab = Window:CreateTab("Settings", 4483362458)

    tab:CreateButton({
        Name = "Destroy GUI",
        Callback = function()
            Rayfield:Destroy()
        end,
    })

    tab:CreateDropdown({
        Name = "Themes",
        Options = {
            "Default",
            "Amber Glow",
            "Amethyst",
            "Bloom",
            "Dark Blue",
            "Green",
            "Light",
            "Ocean",
            "Serenity"
        },
        CurrentOption = {"Default"},
        MultipleOptions = false,
        Flag = "ThemeSelector",
        Callback = function(option)
            local themeMap = {
                ["Default"] = "Default",
                ["Amber Glow"] = "AmberGlow",
                ["Amethyst"] = "Amethyst",
                ["Bloom"] = "Bloom",
                ["Dark Blue"] = "DarkBlue",
                ["Green"] = "Green",
                ["Light"] = "Light",
                ["Ocean"] = "Ocean",
                ["Serenity"] = "Serenity",
            }

            local themeIdentifier = themeMap[option[1]]
            if themeIdentifier then
                Window:ModifyTheme(themeIdentifier)
            end
        end,
    })
end
