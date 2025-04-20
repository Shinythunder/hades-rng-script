return function(Rayfield, Window)
    local tab = Window:CreateTab("Settings", 4483362458)

    tab:CreateButton({
        Name = "Destroy GUI",
        Callback = function()
            Rayfield:Destroy()
        end,
    })

    local selectedTheme = "Default"

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
            selectedTheme = option[1]
        end,
    })

    tab:CreateButton({
        Name = "Apply Theme",
        Callback = function()
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

            local themeIdentifier = themeMap[selectedTheme]
            if themeIdentifier then
                Window:ModifyTheme(themeIdentifier)
            else
                warn("Invalid theme selected.")
            end
        end,
    })
end
