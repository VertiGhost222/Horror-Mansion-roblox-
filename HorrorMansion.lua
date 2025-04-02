local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local speedBoostActive = false
local defaultSpeed = 16
local boostedSpeed = 50
local savedPosition = nil
local noClipActive = false
local noClipConnection

LocalPlayer.CharacterAdded:Connect(function(char)
    Character = char
    Humanoid = char:WaitForChild("Humanoid")
    RootPart = char:WaitForChild("HumanoidRootPart")
    if speedBoostActive then
        Humanoid.WalkSpeed = boostedSpeed
    else
        Humanoid.WalkSpeed = defaultSpeed
    end
    if noClipActive then
        noClipConnection = game:GetService("RunService").Stepped:Connect(function()
            for _, part in pairs(Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end)
    end
end)

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CustomHorrorMansionGUI"
screenGui.Parent = LocalPlayer.PlayerGui
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 420, 0, 520)
mainFrame.Position = UDim2.new(0.5, -210, 0.5, -260)
mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame
local shadow = Instance.new("ImageLabel")
shadow.Image = "rbxassetid://1316045217"
shadow.ImageTransparency = 0.7
shadow.BackgroundTransparency = 1
shadow.Size = UDim2.new(1, 40, 1, 40)
shadow.Position = UDim2.new(0, -20, 0, -20)
shadow.ZIndex = -1
shadow.Parent = mainFrame
mainFrame.Parent = screenGui

local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 50)
topBar.BackgroundColor3 = Color3.fromRGB(45, 45, 70)
topBar.BorderSizePixel = 0
local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0, 12)
topCorner.Parent = topBar
topBar.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0.7, 0, 1, 0)
titleLabel.Position = UDim2.new(0, 15, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Horror Mansion - Hacks"
titleLabel.TextColor3 = Color3.fromRGB(220, 220, 255)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 18
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = topBar

local minimizeButton = Instance.new("TextButton")
minimizeButton.Size = UDim2.new(0, 36, 0, 36)
minimizeButton.Position = UDim2.new(1, -86, 0, 7)
minimizeButton.Text = "-"
minimizeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 90)
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.Font = Enum.Font.Gotham
minimizeButton.TextSize = 20
local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 8)
minCorner.Parent = minimizeButton
minimizeButton.Parent = topBar

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 36, 0, 36)
closeButton.Position = UDim2.new(1, -42, 0, 7)
closeButton.Text = "X"
closeButton.BackgroundColor3 = Color3.fromRGB(90, 45, 45)
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Font = Enum.Font.Gotham
closeButton.TextSize = 20
local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeButton
closeButton.Parent = topBar

local restoreButton = Instance.new("TextButton")
restoreButton.Size = UDim2.new(0, 60, 0, 60)
restoreButton.Position = UDim2.new(0.5, -30, 0.5, -30)
restoreButton.Text = "+"
restoreButton.BackgroundColor3 = Color3.fromRGB(45, 70, 45)
restoreButton.TextColor3 = Color3.fromRGB(255, 255, 255)
restoreButton.Font = Enum.Font.Gotham
restoreButton.TextSize = 24
restoreButton.Visible = false
restoreButton.BackgroundTransparency = 1
local restoreCorner = Instance.new("UICorner")
restoreCorner.CornerRadius = UDim.new(0, 30)
restoreCorner.Parent = restoreButton
restoreButton.Parent = screenGui

local tabFrame = Instance.new("Frame")
tabFrame.Size = UDim2.new(0, 130, 1, -50)
tabFrame.Position = UDim2.new(0, 10, 0, 60)
tabFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
tabFrame.BorderSizePixel = 0
local tabCorner = Instance.new("UICorner")
tabCorner.CornerRadius = UDim.new(0, 8)
tabCorner.Parent = tabFrame
tabFrame.Parent = mainFrame

local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(0, 270, 1, -60)
contentFrame.Position = UDim2.new(0, 150, 0, 60)
contentFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
contentFrame.BorderSizePixel = 0
local contentCorner = Instance.new("UICorner")
contentCorner.CornerRadius = UDim.new(0, 8)
contentCorner.Parent = contentFrame
contentFrame.Parent = mainFrame

local cheatsTabButton = Instance.new("TextButton")
cheatsTabButton.Size = UDim2.new(1, -10, 0, 50)
cheatsTabButton.Position = UDim2.new(0, 5, 0, 5)
cheatsTabButton.Text = "Cheats"
cheatsTabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
cheatsTabButton.TextColor3 = Color3.fromRGB(220, 220, 255)
cheatsTabButton.Font = Enum.Font.GothamSemibold
cheatsTabButton.TextSize = 14
local cheatsTabCorner = Instance.new("UICorner")
cheatsTabCorner.CornerRadius = UDim.new(0, 6)
cheatsTabCorner.Parent = cheatsTabButton
cheatsTabButton.Parent = tabFrame

local teleportTabButton = Instance.new("TextButton")
teleportTabButton.Size = UDim2.new(1, -10, 0, 50)
teleportTabButton.Position = UDim2.new(0, 5, 0, 60)
teleportTabButton.Text = "Teleport"
teleportTabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
teleportTabButton.TextColor3 = Color3.fromRGB(220, 220, 255)
teleportTabButton.Font = Enum.Font.GothamSemibold
teleportTabButton.TextSize = 14
local teleportTabCorner = Instance.new("UICorner")
teleportTabCorner.CornerRadius = UDim.new(0, 6)
teleportTabCorner.Parent = teleportTabButton
teleportTabButton.Parent = tabFrame

local creditsTabButton = Instance.new("TextButton")
creditsTabButton.Size = UDim2.new(1, -10, 0, 50)
creditsTabButton.Position = UDim2.new(0, 5, 0, 115)
creditsTabButton.Text = "Credits"
creditsTabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
creditsTabButton.TextColor3 = Color3.fromRGB(220, 220, 255)
creditsTabButton.Font = Enum.Font.GothamSemibold
creditsTabButton.TextSize = 14
local creditsTabCorner = Instance.new("UICorner")
creditsTabCorner.CornerRadius = UDim.new(0, 6)
creditsTabCorner.Parent = creditsTabButton
creditsTabButton.Parent = tabFrame

local cheatsContent = Instance.new("Frame")
cheatsContent.Size = UDim2.new(1, 0, 1, 0)
cheatsContent.BackgroundTransparency = 1
cheatsContent.Parent = contentFrame

local teleportContent = Instance.new("Frame")
teleportContent.Size = UDim2.new(1, 0, 1, 0)
teleportContent.BackgroundTransparency = 1
teleportContent.Visible = false
teleportContent.Parent = contentFrame

local creditsContent = Instance.new("Frame")
creditsContent.Size = UDim2.new(1, 0, 1, 0)
creditsContent.BackgroundTransparency = 1
creditsContent.Visible = false
creditsContent.Parent = contentFrame

local fullBrightToggle = Instance.new("TextButton")
fullBrightToggle.Size = UDim2.new(1, -20, 0, 50)
fullBrightToggle.Position = UDim2.new(0, 10, 0, 10)
fullBrightToggle.Text = "Full Bright: OFF"
fullBrightToggle.BackgroundColor3 = Color3.fromRGB(45, 45, 70)
fullBrightToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
fullBrightToggle.Font = Enum.Font.Gotham
fullBrightToggle.TextSize = 14
local fbCorner = Instance.new("UICorner")
fbCorner.CornerRadius = UDim.new(0, 6)
fbCorner.Parent = fullBrightToggle
fullBrightToggle.Parent = cheatsContent

local speedBoostToggle = Instance.new("TextButton")
speedBoostToggle.Size = UDim2.new(1, -20, 0, 50)
speedBoostToggle.Position = UDim2.new(0, 10, 0, 65)
speedBoostToggle.Text = "Speed Boost: OFF"
speedBoostToggle.BackgroundColor3 = Color3.fromRGB(45, 45, 70)
speedBoostToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
speedBoostToggle.Font = Enum.Font.Gotham
speedBoostToggle.TextSize = 14
local sbCorner = Instance.new("UICorner")
sbCorner.CornerRadius = UDim.new(0, 6)
sbCorner.Parent = speedBoostToggle
speedBoostToggle.Parent = cheatsContent

local noClipToggle = Instance.new("TextButton")
noClipToggle.Size = UDim2.new(1, -20, 0, 50)
noClipToggle.Position = UDim2.new(0, 10, 0, 120)
noClipToggle.Text = "NoClip: OFF"
noClipToggle.BackgroundColor3 = Color3.fromRGB(45, 45, 70)
noClipToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
noClipToggle.Font = Enum.Font.Gotham
noClipToggle.TextSize = 14
local ncCorner = Instance.new("UICorner")
ncCorner.CornerRadius = UDim.new(0, 6)
ncCorner.Parent = noClipToggle
noClipToggle.Parent = cheatsContent

local savePositionButton = Instance.new("TextButton")
savePositionButton.Size = UDim2.new(1, -20, 0, 50)
savePositionButton.Position = UDim2.new(0, 10, 0, 10)
savePositionButton.Text = "Save Position"
savePositionButton.BackgroundColor3 = Color3.fromRGB(45, 45, 70)
savePositionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
savePositionButton.Font = Enum.Font.Gotham
savePositionButton.TextSize = 14
local spCorner = Instance.new("UICorner")
spCorner.CornerRadius = UDim.new(0, 6)
spCorner.Parent = savePositionButton
savePositionButton.Parent = teleportContent

local teleportToSavedButton = Instance.new("TextButton")
teleportToSavedButton.Size = UDim2.new(1, -20, 0, 50)
teleportToSavedButton.Position = UDim2.new(0, 10, 0, 65)
teleportToSavedButton.Text = "Teleport to Saved"
teleportToSavedButton.BackgroundColor3 = Color3.fromRGB(45, 45, 70)
teleportToSavedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
teleportToSavedButton.Font = Enum.Font.Gotham
teleportToSavedButton.TextSize = 14
local tsCorner = Instance.new("UICorner")
tsCorner.CornerRadius = UDim.new(0, 6)
tsCorner.Parent = teleportToSavedButton
teleportToSavedButton.Parent = teleportContent

local creditsLabel1 = Instance.new("TextLabel")
creditsLabel1.Size = UDim2.new(1, -20, 0, 40)
creditsLabel1.Position = UDim2.new(0, 10, 0, 10)
creditsLabel1.BackgroundTransparency = 1
creditsLabel1.Text = "Created by VertiGhost"
creditsLabel1.TextColor3 = Color3.fromRGB(220, 220, 255)
creditsLabel1.Font = Enum.Font.Gotham
creditsLabel1.TextSize = 14
creditsLabel1.Parent = creditsContent

local creditsLabel2 = Instance.new("TextLabel")
creditsLabel2.Size = UDim2.new(1, -20, 0, 40)
creditsLabel2.Position = UDim2.new(0, 10, 0, 50)
creditsLabel2.BackgroundTransparency = 1
creditsLabel2.Text = "Version: 1.0 - 02/04/2025"
creditsLabel2.TextColor3 = Color3.fromRGB(220, 220, 255)
creditsLabel2.Font = Enum.Font.Gotham
creditsLabel2.TextSize = 14
creditsLabel2.Parent = creditsContent

local creditsLabel3 = Instance.new("TextLabel")
creditsLabel3.Size = UDim2.new(1, -20, 0, 40)
creditsLabel3.Position = UDim2.new(0, 10, 0, 90)
creditsLabel3.BackgroundTransparency = 1
creditsLabel3.Text = "For Horror Mansion"
creditsLabel3.TextColor3 = Color3.fromRGB(220, 220, 255)
creditsLabel3.Font = Enum.Font.Gotham
creditsLabel3.TextSize = 14
creditsLabel3.Parent = creditsContent

local function createHoverAnimation(button)
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(65, 65, 100)}):Play()
    end)
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {
            BackgroundColor3 = button.BackgroundColor3 == Color3.fromRGB(50, 50, 80) and Color3.fromRGB(50, 50, 80) or Color3.fromRGB(45, 45, 70)
        }):Play()
    end)
end

createHoverAnimation(cheatsTabButton)
createHoverAnimation(teleportTabButton)
createHoverAnimation(creditsTabButton)
createHoverAnimation(fullBrightToggle)
createHoverAnimation(speedBoostToggle)
createHoverAnimation(noClipToggle)
createHoverAnimation(savePositionButton)
createHoverAnimation(teleportToSavedButton)
createHoverAnimation(minimizeButton)
createHoverAnimation(closeButton)
createHoverAnimation(restoreButton)

cheatsTabButton.MouseButton1Click:Connect(function()
    cheatsContent.Visible = true
    teleportContent.Visible = false
    creditsContent.Visible = false
    cheatsTabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
    teleportTabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    creditsTabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
end)

teleportTabButton.MouseButton1Click:Connect(function()
    cheatsContent.Visible = false
    teleportContent.Visible = true
    creditsContent.Visible = false
    cheatsTabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    teleportTabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
    creditsTabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
end)

creditsTabButton.MouseButton1Click:Connect(function()
    cheatsContent.Visible = false
    teleportContent.Visible = false
    creditsContent.Visible = true
    cheatsTabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    teleportTabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    creditsTabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
end)

fullBrightToggle.MouseButton1Click:Connect(function()
    local state = not (Lighting.Ambient == Color3.new(1, 1, 1))
    if state then
        Lighting.Ambient = Color3.new(1, 1, 1)
        Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
        fullBrightToggle.Text = "Full Bright: ON"
    else
        Lighting.Ambient = Color3.new(0, 0, 0)
        Lighting.OutdoorAmbient = Color3.new(0, 0, 0)
        fullBrightToggle.Text = "Full Bright: OFF"
    end
end)

speedBoostToggle.MouseButton1Click:Connect(function()
    speedBoostActive = not speedBoostActive
    if speedBoostActive then
        if Humanoid then
            Humanoid.WalkSpeed = boostedSpeed
        end
        speedBoostToggle.Text = "Speed Boost: ON"
    else
        if Humanoid then
            Humanoid.WalkSpeed = defaultSpeed
        end
        speedBoostToggle.Text = "Speed Boost: OFF"
    end
end)

noClipToggle.MouseButton1Click:Connect(function()
    noClipActive = not noClipActive
    if noClipActive then
        noClipConnection = game:GetService("RunService").Stepped:Connect(function()
            for _, part in pairs(Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end)
        noClipToggle.Text = "NoClip: ON"
    else
        if noClipConnection then
            noClipConnection:Disconnect()
        end
        for _, part in pairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
        noClipToggle.Text = "NoClip: OFF"
    end
end)

savePositionButton.MouseButton1Click:Connect(function()
    savedPosition = RootPart.CFrame
end)

teleportToSavedButton.MouseButton1Click:Connect(function()
    if savedPosition then
        RootPart.CFrame = savedPosition
    else
        warn("No position saved!")
    end
end)

minimizeButton.MouseButton1Click:Connect(function()
    TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1}):Play()
    wait(0.3)
    mainFrame.Visible = false
    restoreButton.Visible = true
    TweenService:Create(restoreButton, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {BackgroundTransparency = 0, Size = UDim2.new(0, 60, 0, 60)}):Play()
end)

restoreButton.MouseButton1Click:Connect(function()
    TweenService:Create(restoreButton, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1, Size = UDim2.new(0, 0, 0, 0)}):Play()
    wait(0.3)
    restoreButton.Visible = false
    mainFrame.Visible = true
    TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = UDim2.new(0, 420, 0, 520), BackgroundTransparency = 0}):Play()
end)

closeButton.MouseButton1Click:Connect(function()
    TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1}):Play()
    wait(0.3)
    screenGui:Destroy()
end)

local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

topBar.InputBegan:Connect(function(input)
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

topBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

mainFrame.Size = UDim2.new(0, 0, 0, 0)
mainFrame.Visible = true
TweenService:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = UDim2.new(0, 420, 0, 520), BackgroundTransparency = 0}):Play()
