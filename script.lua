local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

Rayfield:Notify({
    Title = "Script Executed!",
    Content = "Have fun Cheating!",
    Duration = 4.5,
    Image = 4483362458,
})

local Window = Rayfield:CreateWindow({
    Name = "Hade's RNG lag - By ShinyThunder",
    Icon = 0, 
    LoadingTitle = "Loading...",
    LoadingSubtitle = "By ShinyThunder",
    Theme = "Default",
    DisableRayfieldPrompts = true,
    DisableBuildWarnings = true,
    ConfigurationSaving = {
       Enabled = true,
       FolderName = "sbST_Save",
       FileName = "sbSTConfig"
    },
})

local VirtualInputManager = game:GetService("VirtualInputManager")

local tab = Window:CreateTab("Hade's Scripts", 4483362458)

tab:CreateButton({
    Name = "Teleport to All Items",
    Callback = function()

        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local initialPosition = character:WaitForChild("HumanoidRootPart").Position
        local itemsFolder = game.Workspace:FindFirstChild("Items")

        local itemMap = {
            ["rbxassetid://16620005759"] = "Pray",
            ["rbxassetid://13723395774"] = "Gwa Gwa",
            ["rbxassetid://102445605949594"] = "Lunaris",
            ["rbxassetid://11390783129"] = "Maxwell",
        }

        local function simulateKeyPress()
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
            wait(0.1)
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
        end

        if itemsFolder then
            for _, item in pairs(itemsFolder:GetChildren()) do
                if item:IsA("BasePart") and item.Name == "Handle" then
                    local meshId = item.MeshId
                    if meshId and itemMap[meshId] then
                        character:SetPrimaryPartCFrame(item.CFrame)
                        wait(0.5)
                        simulateKeyPress()
                        wait(0.5)
                    end
                end
            end
            character:SetPrimaryPartCFrame(CFrame.new(initialPosition))
        end
    end,
})


local Toggle = tab:CreateToggle({
    Name = "Auto Collect Items",
    CurrentValue = false,
    Flag = "AutoCollectItemsFlag",
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()

        local itemsFolder = game.Workspace:FindFirstChild("Items")

        local itemMap = {
            ["rbxassetid://16620005759"] = "Pray",
            ["rbxassetid://13723395774"] = "Gwa Gwa",
            ["rbxassetid://102445605949594"] = "Lunaris",
            ["rbxassetid://11390783129"] = "Maxwell",
        }

        local function simulateKeyPress()
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
            wait(0.1)
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
        end

        local collecting = false
        local initialPosition

        while true do
            if Value and not collecting then
                collecting = true
                initialPosition = character:WaitForChild("HumanoidRootPart").Position  -- Save initial position
                while Value do
                    if itemsFolder then
                        for _, item in pairs(itemsFolder:GetChildren()) do
                            if item:IsA("BasePart") and item.Name == "Handle" then
                                local meshId = item.MeshId
                                if meshId and itemMap[meshId] then
                                    character:SetPrimaryPartCFrame(item.CFrame)
                                    wait(0.5)
                                    simulateKeyPress()
                                    wait(0.5)
                                end
                            end
                        end
                    end
                    wait(1)  -- Delay between each collection cycle
                end
                character:SetPrimaryPartCFrame(CFrame.new(initialPosition))  -- Return to initial position after collecting
                collecting = false
            end
            wait(0.1)  -- Small wait to prevent the loop from running too fast
        end
    end,
})
