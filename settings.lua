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
            -- Define the correct theme identifiers
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

            -- Debug: Print out the selected theme
            print("Selected theme: " .. selectedTheme)
            
            -- Check if the theme identifier exists in the map
            if themeIdentifier then
                -- Apply the theme
                pcall(function()
                    Window:ModifyTheme(themeIdentifier)
                end)
            else
                -- If not, warn the user
                warn("Invalid theme selected: " .. selectedTheme)
            end
        end,
    })
end
