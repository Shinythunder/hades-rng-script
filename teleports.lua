return function(Rayfield, Window)
    local tab = Window:CreateTab("Teleports", 4483362458)

    -- Quick teleport dropdown
    local selectedLocation = "Koin"

    tab:CreateDropdown({
        Name = "Quick Teleport",
        Options = {"Koin", "Spawn"},
        CurrentOption = {"Koin"},
        MultipleOptions = false,
        Flag = "Dropdown1",
        Callback = function(option)
            selectedLocation = option[1]
        end,
    })

    tab:CreateButton({
        Name = "Teleport",
        Callback = function()
            local coords = {
                ["Koin"] = Vector3.new(-490.24, 20.07, -545.84),
                ["Spawn"] = Vector3.new(-430.94, 43.57, -557.68)
            }

            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local hrp = character:WaitForChild("HumanoidRootPart")
            local position = coords[selectedLocation]

            if position then
                hrp.CFrame = CFrame.new(position)
            else
                warn("No coordinates found for:", selectedLocation)
            end
        end,
    })

   tab:CreateButton({
    Name = "Teleport to Merchant",
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local hrp = character:WaitForChild("HumanoidRootPart")

        local merchant = workspace:FindFirstChild("NPC") and workspace.NPC:FindFirstChild("Merchant")

        if merchant and #merchant:GetDescendants() > 0 then
            for _, part in pairs(merchant:GetDescendants()) do
                if part:IsA("BasePart") then
                    hrp.CFrame = part.CFrame + Vector3.new(0, 3, 0)
                    break
                end
            end
        else
            warn("Merchant is empty or not found.")
        end
    end,
})


tab:CreateToggle({
    Name = "Auto TP to Merchant",
    CurrentValue = false,
    Flag = "AutoTPMerchant",
    Callback = function(Value)
        autoTPMerchant = Value

        if autoTPMerchant then
            task.spawn(function()
                local player = game.Players.LocalPlayer
                local character = player.Character or player.CharacterAdded:Wait()
                local hrp = character:WaitForChild("HumanoidRootPart")

                while autoTPMerchant do
                    local merchant = workspace:FindFirstChild("NPC") and workspace.NPC:FindFirstChild("Merchant")

                    if merchant and #merchant:GetDescendants() > 0 then
                        for _, part in pairs(merchant:GetDescendants()) do
                            if part:IsA("BasePart") then
                                hrp.CFrame = part.CFrame + Vector3.new(0, 3, 0)
                                break
                            end
                        end
                    end

                    task.wait(5)
                end
            end)
        end
    end,
})

end
