local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
Rayfield:Notify({
    Title = "Script Executed!",
    Content = "Have fun Cheating!",
    Duration = 4.5,
    Image = 4483362458,
})


local Window = Rayfield:CreateWindow({
    Name = "Hade's RNG Scripts - By ShinyThunder",
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

-- Tabs
local itemsTab = Window:CreateTab("Items", 4483362458)
local teleportsTab = Window:CreateTab("Teleports", 4483362458)
local settingsTab = Window:CreateTab("Settings", 4483362458)

-- SETTINGS TAB
settingsTab:CreateButton({
    Name = "Destroy GUI",
    Callback = function()
        Rayfield:Destroy()
    end,
})

-- ITEMS TAB
local autoCollectEnabled = false
itemsTab:CreateToggle({
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
                            if item:IsA("BasePart") and item.Name == "Handle" then
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

local espEnabled = false
local espObjects = {}

itemsTab:CreateToggle({
    Name = "Item ESP",
    CurrentValue = false,
    Flag = "ItemESP",
    Callback = function(Value)
        espEnabled = Value

        for _, obj in ipairs(espObjects) do
            if obj and obj.Parent then
                obj:Destroy()
            end
        end
        espObjects = {}

        if espEnabled then
            task.spawn(function()
                while espEnabled do
                    local itemsFolder = workspace:FindFirstChild("Items") and workspace.Items:FindFirstChild("Main")
                    if itemsFolder then
                        for _, item in pairs(itemsFolder:GetChildren()) do
                            if item:IsA("BasePart") and item.Name == "Handle" and not item:FindFirstChild("ItemESP") then
                                local billboard = Instance.new("BillboardGui")
                                billboard.Name = "ItemESP"
                                billboard.Adornee = item
                                billboard.Size = UDim2.new(0, 100, 0, 20)
                                billboard.AlwaysOnTop = true
                                billboard.StudsOffset = Vector3.new(0, 2, 0)

                                local label = Instance.new("TextLabel", billboard)
                                label.Size = UDim2.new(1, 0, 1, 0)
                                label.Text = "[Item]"
                                label.BackgroundTransparency = 1
                                label.TextColor3 = Color3.fromRGB(255, 255, 0)
                                label.TextStrokeTransparency = 0.5
                                label.Font = Enum.Font.SourceSansBold
                                label.TextScaled = true

                                billboard.Parent = item
                                table.insert(espObjects, billboard)
                            end
                        end
                    end
                    wait(1.5)
                end

                for _, obj in ipairs(espObjects) do
                    if obj and obj.Parent then
                        obj:Destroy()
                    end
                end
                espObjects = {}
            end)
        end
    end,
})

-- TELEPORTS TAB

-- Quick Teleport Dropdown + Button
local selectedLocation = "Koin"

teleportsTab:CreateDropdown({
    Name = "Quick Teleport",
    Options = {"Koin", "Spawn"},
    CurrentOption = {"Koin"},
    MultipleOptions = false,
    Flag = "Dropdown1",
    Callback = function(option)
        selectedLocation = option[1]
    end,
})

teleportsTab:CreateButton({
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

-- Auto TP to Merchant Toggle
-- Auto TP to Merchant Toggle
local autoTPMerchant = false

teleportsTab:CreateToggle({
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
                                -- Use first BasePart if PrimaryPart is not set
                                for _, part in pairs(merchant:GetDescendants()) do
                                    if part:IsA("BasePart") then
                                        targetCFrame = part.CFrame
                                        break
                                    end
                                end
                            end
                        end

                        if targetCFrame then
                            hrp.CFrame = targetCFrame + Vector3.new(0, 3, 0) -- offset so you don't get stuck
                        end
                    end

                    wait(5)
                end
            end)
        end
    end,
})

-- Auto TP to Merchant Toggle
local autoTPMerchant = false

teleportsTab:CreateToggle({
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
                                -- Use first BasePart if PrimaryPart is not set
                                for _, part in pairs(merchant:GetDescendants()) do
                                    if part:IsA("BasePart") then
                                        targetCFrame = part.CFrame
                                        break
                                    end
                                end
                            end
                        end

                        if targetCFrame then
                            hrp.CFrame = targetCFrame + Vector3.new(0, 3, 0) -- offset so you don't get stuck
                        end
                    end

                    wait(5)
                end
            end)
        end
    end,
})



-- Optional: TP to all items could go under Items or Teleports. Placing under Items here:
itemsTab:CreateButton({
    Name = "Teleport to All Items",
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

        local itemsFolder = game.Workspace:FindFirstChild("Items") and game.Workspace.Items:FindFirstChild("Main")

        if itemsFolder then
            for _, item in pairs(itemsFolder:GetChildren()) do
                if item:IsA("BasePart") and item.Name == "Handle" then
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

