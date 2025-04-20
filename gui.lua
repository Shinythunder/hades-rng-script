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

-- Load each category script
loadstring(game:HttpGet(""))()(Rayfield, Window)
loadstring(game:HttpGet(""))()(Rayfield, Window)
loadstring(game:HttpGet(""))()(Rayfield, Window)
