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

local tab = Window:CreateTab("Hade's Scripts", 4483362458)

tab:CreateButton({
    Name = "Destory GUI",
    Callback = function()
        Rayfield:Destroy()
    end,
})

tab:CreateButton({
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
                    wait(3) -- Delay between scans
                end
            end)
        end
    end,
})

-- Dropdown and teleport button (fixed version)
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
            print("Teleporting to:", selectedLocation, position)
            hrp.CFrame = CFrame.new(position)
        else
            warn("No coordinates found for:", selectedLocation)
        end
    end,
})


local espEnabled = false
local espObjects = {}

tab:CreateToggle({
    Name = "Item ESP",
    CurrentValue = false,
    Flag = "ItemESP",
    Callback = function(Value)
        espEnabled = Value

        -- Clear old ESPs
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

                -- Clean up after toggle off
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
