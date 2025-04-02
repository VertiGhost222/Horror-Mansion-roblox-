-- Horror Mansion GUI for Roblox - Created by VertiGhost
-- Date: 02/04/2025

-- Load Kavo UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Horror Mansion - Hacks by VertiGhost", "Ocean") -- Blue "Ocean" theme

-- Services and variables
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

-- Update character on respawn
LocalPlayer.CharacterAdded:Connect(function(char)
    Character = char
    Humanoid = char:WaitForChild("Humanoid")
    RootPart = char:WaitForChild("HumanoidRootPart")
end)

-- Cheats Tab
local CheatsTab = Window:NewTab("Cheats")
local CheatsSection = CheatsTab:NewSection("Enhancements")

-- Full Bright Toggle
CheatsSection:NewToggle("Full Bright", "See everything clearly", function(state)
    if state then
        Lighting.Ambient = Color3.new(1, 1, 1)
        Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
    else
        Lighting.Ambient = Color3.new(0, 0, 0)
        Lighting.OutdoorAmbient = Color3.new(0, 0, 0)
    end
end)

-- Walk Speed Toggle and Slider (Improved for Mobile)
local customSpeedEnabled = false
local customSpeedValue = 16 -- Default speed

CheatsSection:NewToggle("Custom Speed", "Force a stable walk speed", function(state)
    customSpeedEnabled = state
    if state then
        -- Start a loop to enforce the speed
        spawn(function()
            while customSpeedEnabled and Humanoid do
                if Humanoid.WalkSpeed ~= customSpeedValue then
                    Humanoid.WalkSpeed = customSpeedValue
                end
                wait(0.1) -- Check every 0.1 seconds
            end
        end)
    else
        -- Reset to default speed when disabled
        Humanoid.WalkSpeed = 16
    end
end)

CheatsSection:NewSlider("Walk Speed", "Adjust your speed (use with Custom Speed toggle)", 100, 16, function(value)
    customSpeedValue = value
    if customSpeedEnabled then
        Humanoid.WalkSpeed = value
    end
end)

-- Speed Boost Button
CheatsSection:NewButton("Speed Boost", "Temporarily increase speed for 5 seconds", function()
    local originalSpeed = customSpeedEnabled and customSpeedValue or Humanoid.WalkSpeed
    Humanoid.WalkSpeed = 50
    wait(5)
    Humanoid.WalkSpeed = originalSpeed
end)

-- Heal Button
CheatsSection:NewButton("Heal", "Restore health to maximum", function()
    Humanoid.Health = Humanoid.MaxHealth
end)

-- Teleport Tab
local TeleportTab = Window:NewTab("Teleport")
local TeleportSection = TeleportTab:NewSection("Quick Travel")
local savedPosition = nil

-- Save Position Button
TeleportSection:NewButton("Save Position", "Save your current location", function()
    savedPosition = RootPart.CFrame
end)

-- Teleport to Saved Position Button
TeleportSection:NewButton("Teleport to Saved", "Go back to saved location", function()
    if savedPosition then
        RootPart.CFrame = savedPosition
    else
        warn("No position saved!")
    end
end)

-- Credits Tab
local CreditsTab = Window:NewTab("Credits")
local CreditsSection = CreditsTab:NewSection("Information")
CreditsSection:NewLabel("Created by VertiGhost")
CreditsSection:NewLabel("Version: 1.0 - 02/04/2025")
CreditsSection:NewLabel("For Horror Mansion")

-- Welcome Notification
Library:MakeNotification({
    Name = "Welcome",
    Content = "Horror Mansion GUI by VertiGhost loaded successfully!",
    Image = "rbxassetid://4483345998",
    Time = 5
})

-- Console Message
print("Horror Mansion GUI by VertiGhost loaded successfully!")
