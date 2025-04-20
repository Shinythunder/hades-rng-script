return function(Rayfield, Window)
    local tab = Window:CreateTab("Settings", 4483362458)

    tab:CreateButton({
        Name = "Destroy GUI",
        Callback = function()
            Rayfield:Destroy()
        end,
    })

local Input = Tab:CreateInput({
   Name = "Webhook URL",
   CurrentValue = "",  -- Default value is empty
   PlaceholderText = "Enter your Webhook URL",
   RemoveTextAfterFocusLost = false,
   Flag = "WebhookInput",  -- You can use this flag to store the input value
   Callback = function(Text)
      -- This will store the value entered in the text box
      webhookURL = Text
      print("Webhook URL: " .. webhookURL)  -- Print the webhook URL to the output for debugging
   end,
})

    
end
