return function(Rayfield, Window)
    local PlayerTab = Window:CreateTab("Player", 4483362458) -- Your icon ID here

    PlayerTab:CreateSection("Movement")

    local flying = false
    local flightSpeed = 50 -- Default flight speed
    local flightControl = {Forward = 0, Backward = 0, Left = 0, Right = 0, Up = 0, Down = 0}
    local humanoidRootPart

    -- Start flying
    local function startFlying()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        humanoidRootPart = character:WaitForChild("HumanoidRootPart")

        local BodyGyro = Instance.new("BodyGyro")
        BodyGyro.P = 9e4
        BodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        BodyGyro.CFrame = humanoidRootPart.CFrame
        BodyGyro.Name = "FlightGyro"
        BodyGyro.Parent = humanoidRootPart

        local BodyVelocity = Instance.new("BodyVelocity")
        BodyVelocity.Velocity = Vector3.zero
        BodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        BodyVelocity.Name = "FlightVelocity"
        BodyVelocity.Parent = humanoidRootPart

        -- Movement loop
        task.spawn(function()
            while flying and humanoidRootPart and humanoidRootPart:FindFirstChild("FlightVelocity") do
                local camCF = workspace.CurrentCamera.CFrame
                local moveDirection = Vector3.zero

                if flightControl.Forward == 1 then moveDirection += camCF.LookVector end
                if flightControl.Backward == 1 then moveDirection -= camCF.LookVector end
                if flightControl.Left == 1 then moveDirection -= camCF.RightVector end
                if flightControl.Right == 1 then moveDirection += camCF.RightVector end
                if flightControl.Up == 1 then moveDirection += camCF.UpVector end
                if flightControl.Down == 1 then moveDirection -= camCF.UpVector end

                humanoidRootPart.FlightVelocity.Velocity = moveDirection.Unit * flightSpeed
                humanoidRootPart.FlightGyro.CFrame = camCF

                task.wait()
            end
        end)
    end

    -- Stop flying
    local function stopFlying()
        if humanoidRootPart then
            local gyro = humanoidRootPart:FindFirstChild("FlightGyro")
            local velocity = humanoidRootPart:FindFirstChild("FlightVelocity")
            if gyro then gyro:Destroy() end
            if velocity then velocity:Destroy() end
        end
        humanoidRootPart = nil
    end

    -- Toggle for Flight
    PlayerTab:CreateToggle({
        Name = "Flight",
        CurrentValue = false,
        Flag = "FlightToggle",
        Callback = function(Value)
            flying = Value
            if flying then
                startFlying()
            else
                stopFlying()
            end
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

    -- Set up controls (WASD + Space + LeftShift)
    local UserInputService = game:GetService("UserInputService")

    UserInputService.InputBegan:Connect(function(input, processed)
        if processed then return end
        if input.KeyCode == Enum.KeyCode.W then flightControl.Forward = 1 end
        if input.KeyCode == Enum.KeyCode.S then flightControl.Backward = 1 end
        if input.KeyCode == Enum.KeyCode.A then flightControl.Left = 1 end
        if input.KeyCode == Enum.KeyCode.D then flightControl.Right = 1 end
        if input.KeyCode == Enum.KeyCode.Space then flightControl.Up = 1 end
        if input.KeyCode == Enum.KeyCode.LeftShift then flightControl.Down = 1 end
    end)

    UserInputService.InputEnded:Connect(function(input, processed)
        if input.KeyCode == Enum.KeyCode.W then flightControl.Forward = 0 end
        if input.KeyCode == Enum.KeyCode.S then flightControl.Backward = 0 end
        if input.KeyCode == Enum.KeyCode.A then flightControl.Left = 0 end
        if input.KeyCode == Enum.KeyCode.D then flightControl.Right = 0 end
        if input.KeyCode == Enum.KeyCode.Space then flightControl.Up = 0 end
        if input.KeyCode == Enum.KeyCode.LeftShift then flightControl.Down = 0 end
    end)
end
