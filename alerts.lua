
-- Biome and rarity configuration
local biomesRarity = {
    ["Nightmare"] = "1/250",
    ["Void"] = "1/300",
    ["Paranoia"] = "NO CHANCE LISTED",
    ["Corecility"] = "NO CHANCE LISTED"
}

-- Function to send webhook alert
local function sendWebhook(biomeName, rarity)
    local HttpService = game:GetService("HttpService")

    -- Webhook URL loaded from settings (stored globally by settings.lua)
    local webhookURL = _G.WebhookURL or "https://discord.com/api/webhooks/YOUR_WEBHOOK_URL"  -- Default URL if not set

    local embed = {
        ["title"] = "Rare Biome Spawned!",
        ["description"] = "A rare biome has spawned: " .. biomeName .. " with a rarity of " .. rarity,
        ["color"] = 0xFF0000,  -- Red color for the embed
        ["footer"] = {
            ["text"] = "Roblox Biomes"
        }
    }

    local data = {
        ["embeds"] = {embed}
    }

    local jsonData = HttpService:JSONEncode(data)

    local success, response = pcall(function()
        return HttpService:PostAsync(webhookURL, jsonData, Enum.HttpContentType.ApplicationJson)
    end)

    if success then
        print("Webhook sent successfully!")
    else
        warn("Failed to send webhook:", response)
    end
end

-- Check for rare biomes and send alerts based on toggle
local function checkRareBiome()
    -- Only send alerts if the toggle is enabled
    if not _G.RareBiomeAlertEnabled then
        return
    end

    local playerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    local mainFrame = playerGui:WaitForChild("Main"):WaitForChild("Infos"):WaitForChild("Frame")
    local biomeFrame = mainFrame:WaitForChild("Biome")
    local biomeCountLabel = biomeFrame:WaitForChild("Count")

    local biomeName = biomeCountLabel.Text

    -- Check if the biome name exists in the biomesRarity table
    if biomesRarity[biomeName] then
        local rarity = biomesRarity[biomeName]
        sendWebhook(biomeName, rarity)
    end
end

-- Create the "Alerts" tab for toggling Rare Biome Alert
local alertTab = Window:CreateTab("Alerts", 4483362458)

-- Toggle for Rare Biome Alert
alertTab:CreateToggle({
    Name = "Rare Biome Alert",
    CurrentValue = false,  -- Default is off
    Callback = function(enabled)
        -- Store the toggle state globally
        _G.RareBiomeAlertEnabled = enabled
    end,
})

-- Run the biome check periodically (you can adjust the interval as needed)
while true do
    checkRareBiome()
    wait(10)  -- Adjust the check interval as needed
end
end
