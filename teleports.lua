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

    -- Teleport to Merchant (single)
    tab:CreateButton({
        Name = "Teleport to Merchant",
        Callback = function()
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local hrp = character:WaitForChild("HumanoidRootPart")

            local npcFolder = workspace:FindFirstChild("NPC")
            local merchant = npcFolder and npcFolder:FindFirstChild("Merchant")

            if merchant then
                local targetCFrame

                if merchant:IsA("Model") then
                    if merchant.PrimaryPart then
                        targetCFrame = merchant.PrimaryPart.CFrame
                    else
                        for _, part in pairs(merchant:GetDescendants()) do
                            if part:IsA("BasePart") then
                                targetCFrame = part.CFrame
                                break
                            end
                        end
                    end
                end

                if targetCFrame then
                    hrp.CFrame = targetCFrame + Vector3.new(0, 3, 0)
                else
                    warn("No valid part found in Merchant model.")
                end
            else
                warn("Merchant not found in workspace.NPC.")
            end
        end,
    })

    -- Auto TP to Merchant
    local autoTPMerchant = false

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
                        local npcFolder = workspace:FindFirstChild("NPC")
                        local merchant = npcFolder and npcFolder:FindFirstChild("Merchant")

                        if merchant then
                            local targetCFrame

                            if merchant:IsA("Model") then
                                if merchant.PrimaryPart then
                                    targetCFrame = merchant.PrimaryPart.CFrame
                                else
                                    for _, part in pairs(merchant:GetDescendants()) do
                                        if part:IsA("BasePart") then
                                            targetCFrame = part.CFrame
                                            break
                                        end
                                    end
                                end
                            end

                            if targetCFrame then
                                hrp.CFrame = targetCFrame + Vector3.new(0, 3, 0)
                            end
                        end

                        wait(5)
                    end
                end)
            end
        end,
    })
end
