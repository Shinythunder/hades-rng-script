\return function(Rayfield, Window)
    local tab = Window:CreateTab("Settings", 4483362458)

    tab:CreateButton({
        Name = "Destroy GUI",
        Callback = function()
            Rayfield:Destroy()
        end,
    })

    local selectedTheme = "Default"

    -- Dropdown for selecting the theme
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

    -- Button to apply the selected theme
    tab:CreateButton({
        Name = "Apply Theme",
        Callback = function()
            -- Theme Map
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

            -- Fetch the theme identifier based on selection
            local themeIdentifier = themeMap[selectedTheme]

            -- Debug: Print out the selected theme
            print("Selected theme: " .. selectedTheme)

            -- Ensure the theme identifier is valid
            if themeIdentifier then
                -- Try applying the theme
                local success, err = pcall(function()
                    Window:ModifyTheme(themeIdentifier)
                end)

                -- If there was an error, print it
                if not success then
                    warn("Failed to apply theme: " .. err)
                end
            else
                warn("Invalid theme selected: " .. selectedTheme)
            end
        end,
    })
end
