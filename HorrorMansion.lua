-- Horror Mansion GUI for Roblox - Created by VertiGhost
-- Date: 02/04/2025

-- Charger la bibliothèque Kavo UI
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Horror Mansion - Hacks by VertiGhost", "Ocean") -- Thème bleu "Ocean"

-- Services et variables
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

-- Mettre à jour le personnage lors de la réapparition
LocalPlayer.CharacterAdded:Connect(function(char)
    Character = char
    Humanoid = char:WaitForChild("Humanoid")
    RootPart = char:WaitForChild("HumanoidRootPart")
end)

-- Onglet Cheats
local CheatsTab = Window:NewTab("Cheats")
local CheatsSection = CheatsTab:NewSection("Enhancements")

-- Toggle Full Bright
CheatsSection:NewToggle("Full Bright", "See everything clearly", function(state)
    if state then
        Lighting.Ambient = Color3.new(1, 1, 1)
        Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
    else
        Lighting.Ambient = Color3.new(0, 0, 0)
        Lighting.OutdoorAmbient = Color3.new(0, 0, 0)
    end
end)

-- Slider Walk Speed
CheatsSection:NewSlider("Walk Speed", "Adjust your speed", 100, 16, function(value)
    Humanoid.WalkSpeed = value
end)

-- Bouton Speed Boost
CheatsSection:NewButton("Speed Boost", "Temporarily increase speed for 5 seconds", function()
    local originalSpeed = Humanoid.WalkSpeed
    Humanoid.WalkSpeed = 50
    wait(5)
    Humanoid.WalkSpeed = originalSpeed
end)

-- Bouton Heal
CheatsSection:NewButton("Heal", "Restore health to maximum", function()
    Humanoid.Health = Humanoid.MaxHealth
end)

-- Onglet Teleport
local TeleportTab = Window:NewTab("Teleport")
local TeleportSection = TeleportTab:NewSection("Quick Travel")
local savedPosition = nil

-- Bouton Save Position
TeleportSection:NewButton("Save Position", "Save your current location", function()
    savedPosition = RootPart.CFrame
end)

-- Bouton Teleport to Saved
TeleportSection:NewButton("Teleport to Saved", "Go back to saved location", function()
    if savedPosition then
        RootPart.CFrame = savedPosition
    else
        warn("No position saved!")
    end
end)

-- Onglet Credits
local CreditsTab = Window:NewTab("Credits")
local CreditsSection = CreditsTab:NewSection("Information")
CreditsSection:NewLabel("Created by VertiGhost")
CreditsSection:NewLabel("Version: 1.0 - 02/04/2025")
CreditsSection:NewLabel("For Horror Mansion")

-- Notification de bienvenue
Library:MakeNotification({
    Name = "Welcome",
    Content = "Horror Mansion GUI by VertiGhost loaded successfully!",
    Image = "rbxassetid://4483345998",
    Time = 5
})

-- Message dans la console
print("Horror Mansion GUI by VertiGhost loaded successfully!")
