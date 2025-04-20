return function(Rayfield, Window)
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

-- Rare Biome definitions
local biomesRarity = {
    ["Nightmare"] = "1/250",
    ["Void"] = "1/300",
    ["Paranoia"] = "NO CHANCE LISTED",
    ["Corecility"] = "NO CHANCE LISTED"
}

-- Send webhook with biome info
local function sendWebhook(biomeName, rarity)
    local webhookURL = _G.WebhookURL or "https://discord.com/api/webhooks/YOUR_WEBHOOK_URL"

    local embed = {
        ["title"] = "Rare Biome Spawned!",
        ["description"] = "A rare biome has spawned: " .. biomeName .. " with a rarity of " .. rarity,
        ["color"] = 0xFF0000,
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

-- Check if a rare biome is active and send alert
local function checkRareBiome()
    if not _G.RareBiomeAlertEnabled then return end

    local player = Players.LocalPlayer
    local gui = player:WaitForChild("PlayerGui")
    local biomeCountLabel = gui:WaitForChild("Main"):WaitForChild("Infos"):WaitForChild("Frame")
        :WaitForChild("Biome"):WaitForChild("Count")

    local biomeName = biomeCountLabel.Text

    if biomesRarity[biomeName] then
        local rarity = biomesRarity[biomeName]
        sendWebhook(biomeName, rarity)
    end
end

-- Create Alerts tab
local alertTab = Window:CreateTab("Alerts", 4483362458)

-- Toggle to enable/disable alerts
alertTab:CreateToggle({
    Name = "Rare Biome Alert",
    CurrentValue = false,
    Callback = function(enabled)
        _G.RareBiomeAlertEnabled = enabled
    end,
})

-- Button to test the webhook
alertTab:CreateButton({
    Name = "Test Webhook",
    Callback = function()
        sendWebhook("Void", "1/300")
    end,
})

-- Run biome check in background
coroutine.wrap(function()
    while true do
        checkRareBiome()
        wait(10)
    end
end)()
end
