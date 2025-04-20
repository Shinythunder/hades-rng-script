return function(Rayfield, Window)
    local tab = Window:CreateTab("Settings", 4483362458)

    tab:CreateButton({
        Name = "Destroy GUI",
        Callback = function()
            Rayfield:Destroy()
        end,
    })

    tab:CreateInput({
        Name = "Webhook URL",
        CurrentValue = "",
        PlaceholderText = "Enter your Webhook URL",
        RemoveTextAfterFocusLost = false,
        Flag = "WebhookInput",
        Callback = function(Text)
            _G.WebhookURL = Text  -- Store globally so other files can access
            print("Webhook URL set to: " .. _G.WebhookURL)
        end,
    })
end
