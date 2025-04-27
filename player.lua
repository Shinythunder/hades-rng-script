return function(Rayfield, Window)
    local PlayerTab = Window:CreateTab("Player", 0) -- Optional: set an icon ID

    PlayerTab:CreateSection("Movement")

    local flying = false
    local flightSpeed = 50 -- default flight speed

    -- Function to enable/disable flight
    local function toggleFlight()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

        if not flying then
            flying = true

            local bodyGyro = Instance.new("BodyGyro")
            bodyGyro.P = 9e4
            bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
            bodyGyro.CFrame = humanoidRootPart.CFrame
            bodyGyro.Parent = humanoidRootPart

            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.Velocity = Vector3.zero
            bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
            bodyVelocity.Parent = humanoidRootPart

            -- Flight movement
            task.spawn(function()
                while flying do
                    bodyGyro.CFrame = workspace.CurrentCamera.CFrame
                    bodyVelocity.Velocity = workspace.CurrentCamera.CFrame.LookVector * flightSpeed
                    task.wait()
                end
            end)

        else
            flying = false
            for _, v in pairs(humanoidRootPart:GetChildren()) do
                if v:IsA("BodyGyro") or v:IsA("BodyVelocity") then
                    v:Destroy()
                end
            end
        end
    end

    -- Flight Button
    PlayerTab:CreateButton({
        Name = "Toggle Flight",
        Callback = function()
            toggleFlight()
        end,
    })

    -- Flight Speed Slider
    PlayerTab:CreateSlider({
        Name = "Flight Speed",
        Range = {10, 500},
        Increment = 5,
        Suffix = "Speed",
        CurrentValue = flightSpeed,
        Callback = function(Value)
            flightSpeed = Value
        end,
    })
end
