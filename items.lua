return function(Rayfield, Window)
    local tab = Window:CreateTab("Items", 4483362458)

    -- Auto collect toggle
    local autoCollectEnabled = false

    tab:CreateToggle({
        Name = "Auto Collect Items",
        CurrentValue = false,
        Flag = "AutoCollectToggle",
        Callback = function(Value)
            autoCollectEnabled = Value

            if autoCollectEnabled then
                task.spawn(function()
                    local player = game.Players.LocalPlayer
                    local character = player.Character or player.CharacterAdded:Wait()
                    local hrp = character:WaitForChild("HumanoidRootPart")
                    local VirtualInputManager = game:GetService("VirtualInputManager")
                    local initialPosition = hrp.Position

                    local function simulateKeyPress()
                        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
                        wait(0.1)
                        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
                    end

                    while autoCollectEnabled do
                        local itemsFolder = workspace:FindFirstChild("Items") and workspace.Items:FindFirstChild("Main")
                        if itemsFolder then
                            for _, item in pairs(itemsFolder:GetChildren()) do
                                if not autoCollectEnabled then break end
                                if item.Name ~= "Locations" and item:IsA("BasePart") and item.Name == "Handle" then
                                    character:SetPrimaryPartCFrame(item.CFrame)
                                    wait(0.5)
                                    simulateKeyPress()
                                    wait(0.5)
                                end
                            end
                            character:SetPrimaryPartCFrame(CFrame.new(initialPosition))
                        end
                        wait(3)
                    end
                end)
            end
        end,
    })

    tab:CreateButton({
        Name = "Grab All Items",
        Callback = function()
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local initialPosition = character:WaitForChild("HumanoidRootPart").Position
            local VirtualInputManager = game:GetService("VirtualInputManager")

            local function simulateKeyPress()
                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
                wait(0.1)
                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
            end

            local itemsFolder = workspace:FindFirstChild("Items") and workspace.Items:FindFirstChild("Main")

            if itemsFolder then
                for _, item in pairs(itemsFolder:GetChildren()) do
                    if item.Name ~= "Locations" and item:IsA("BasePart") and item.Name == "Handle" then
                        character:SetPrimaryPartCFrame(item.CFrame)
                        wait(0.5)
                        simulateKeyPress()
                        wait(0.5)
                    end
                end
                character:SetPrimaryPartCFrame(CFrame.new(initialPosition))
            end
        end,
    })
end
