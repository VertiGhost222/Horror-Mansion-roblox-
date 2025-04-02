local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Horror Mansion - Hacks by VertiGhost", "Ocean")

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

local speedBoostActive = false
local defaultSpeed = 16
local boostedSpeed = 50

LocalPlayer.CharacterAdded:Connect(function(char)
    Character = char
    Humanoid = char:WaitForChild("Humanoid")
    RootPart = char:WaitForChild("HumanoidRootPart")
    if speedBoostActive then
        Humanoid.WalkSpeed = boostedSpeed
    else
        Humanoid.WalkSpeed = defaultSpeed
    end
end)

local CheatsTab = Window:NewTab("Cheats")
local CheatsSection = CheatsTab:NewSection("Enhancements")

CheatsSection:NewToggle("Full Bright", "See everything clearly", function(state)
    if state then
        Lighting.Ambient = Color3.new(1, 1, 1)
        Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
    else
        Lighting.Ambient = Color3.new(0, 0, 0)
        Lighting.OutdoorAmbient = Color3.new(0, 0, 0)
    end
end)

CheatsSection:NewToggle("Speed Boost", "Increase speed until you die or respawn", function(state)
    speedBoostActive = state
    if state then
        if Humanoid then
            Humanoid.WalkSpeed = boostedSpeed
        end
    else
        if Humanoid then
            Humanoid.WalkSpeed = defaultSpeed
        end
    end
end)

CheatsSection:NewButton("Heal", "Restore health to maximum", function()
    Humanoid.Health = Humanoid.MaxHealth
end)

local TeleportTab = Window:NewTab("Teleport")
local TeleportSection = TeleportTab:NewSection("Quick Travel")
local savedPosition = nil

TeleportSection:NewButton("Save Position", "Save your current location", function()
    savedPosition = RootPart.CFrame
end)

TeleportSection:NewButton("Teleport to Saved", "Go back to saved location", function()
    if savedPosition then
        RootPart.CFrame = savedPosition
    else
        warn("No position saved!")
    end
end)

local CreditsTab = Window:NewTab("Credits")
local CreditsSection = CreditsTab:NewSection("Information")
CreditsSection:NewLabel("Created by VertiGhost")
CreditsSection:NewLabel("Version: 1.0 - 02/04/2025")
CreditsSection:NewLabel("For Horror Mansion")

Library:MakeNotification({
    Name = "Welcome",
    Content = "Horror Mansion GUI by VertiGhost loaded successfully!",
    Image = "rbxassetid://4483345998",
    Time = 5
})

print("Horror Mansion GUI by VertiGhost loaded successfully!")

local UserInputService = game:GetService("UserInputService")
local screenGui = LocalPlayer.PlayerGui:WaitForChild("Kavo UI")
local mainFrame = screenGui.MainFrame

mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)

local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

mainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

local minimizeButton = Instance.new("TextButton")
minimizeButton.Size = UDim2.new(0, 30, 0, 30)
minimizeButton.Position = UDim2.new(1, -60, 0, 0)
minimizeButton.Text = "-"
minimizeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.Parent = mainFrame

local restoreButton = Instance.new("TextButton")
restoreButton.Size = UDim2.new(0, 50, 0, 50)
restoreButton.Position = UDim2.new(0.5, 0, 0.5, 0)
restoreButton.Text = "+"
restoreButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
restoreButton.TextColor3 = Color3.fromRGB(255, 255, 255)
restoreButton.Visible = false
restoreButton.Parent = screenGui

minimizeButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    restoreButton.Visible = true
end)

restoreButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    restoreButton.Visible = false
end)
