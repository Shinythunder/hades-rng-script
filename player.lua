return function(Rayfield, Window)
    local Tab = Window:CreateTab("Player", 4483362458) -- Your icon ID here
local UserInputService = game:GetService("UserInputService")
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local torso = character:WaitForChild("HumanoidRootPart")

local flying = false
local speed = 50
local moveDirection = Vector3.new(0, 0, 0)

-- Function to enable flying
local function startFlying()
    if flying then return end
    flying = true
    humanoid.PlatformStand = true
    torso.Anchored = true
end

-- Function to disable flying
local function stopFlying()
    if not flying then return end
    flying = false
    humanoid.PlatformStand = false
    torso.Anchored = false
end

-- Create a toggle button for flying
local Toggle = Tab:CreateToggle({
   Name = "Fly Toggle",         -- Toggle label
   CurrentValue = false,        -- Initial value (fly off by default)
   Flag = "FlyToggle",          -- Unique identifier for configuration
   Callback = function(Value)
      -- Toggle the flying state based on the toggle value
      if Value then
         startFlying()         -- Start flying when toggle is on
      else
         stopFlying()          -- Stop flying when toggle is off
      end
   end,
})

-- Handle movement while flying
game:GetService("RunService").Heartbeat:Connect(function()
    if flying then
        moveDirection = Vector3.new(
            (UserInputService:IsKeyDown(Enum.KeyCode.A) and -1 or 0) +
            (UserInputService:IsKeyDown(Enum.KeyCode.D) and 1 or 0),
            (UserInputService:IsKeyDown(Enum.KeyCode.Space) and 1 or 0) - 
            (UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) and 1 or 0) +
            (UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) and -1 or 0),
            (UserInputService:IsKeyDown(Enum.KeyCode.W) and 1 or 0) - 
            (UserInputService:IsKeyDown(Enum.KeyCode.S) and 1 or 0)
        ).unit * speed

        -- Apply the movement direction
        torso.Velocity = moveDirection
    end
end)

end
