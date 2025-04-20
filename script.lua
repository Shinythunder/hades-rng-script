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
