if game.PlaceId ~= 522527978 then
    game.StarterGui:SetCore("SendNotification", {Title = "Cannot Launch Script", Text = "This script can only be used in Horror Mansion!", Duration = 5})
    return
end

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
local spinning = false
local monsterActive = false

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
screenGui.Name = "HorrorMansionHacks"
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 450, 0, 600)
mainFrame.Position = UDim2.new(0.5, -225, 0.5, -300)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 25)
corner.Parent = mainFrame
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 10, 20)), ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 60))}
gradient.Rotation = 45
gradient.Parent = mainFrame
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(200, 100, 100)
stroke.Thickness = 3
stroke.Transparency = 0.1
stroke.Parent = mainFrame
local glow = Instance.new("ImageLabel")
glow.Image = "rbxassetid://5028857475"
glow.ImageTransparency = 0.5
glow.BackgroundTransparency = 1
glow.Size = UDim2.new(1, 80, 1, 80)
glow.Position = UDim2.new(0, -40, 0, -40)
glow.ZIndex = -1
glow.Parent = mainFrame

local particleEmitter = Instance.new("ParticleEmitter")
particleEmitter.Texture = "rbxassetid://243660947"
particleEmitter.Lifetime = NumberRange.new(0.5, 1)
particleEmitter.Rate = 20
particleEmitter.Speed = NumberRange.new(0.5, 1)
particleEmitter.SpreadAngle = Vector2.new(360, 360)
particleEmitter.Color = ColorSequence.new(Color3.fromRGB(200, 100, 100))
particleEmitter.Size = NumberSequence.new(0.2)
particleEmitter.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.8), NumberSequenceKeypoint.new(1, 1)})
particleEmitter.Parent = mainFrame

local ambientLight = Instance.new("PointLight")
ambientLight.Color = Color3.fromRGB(200, 100, 100)
ambientLight.Brightness = 0.5
ambientLight.Range = 20
ambientLight.Parent = mainFrame
mainFrame.Parent = screenGui

local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 70)
titleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
titleBar.BorderSizePixel = 0
local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 25)
titleCorner.Parent = titleBar
local titleGradient = Instance.new("UIGradient")
titleGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 40)), ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 50, 80))}
titleGradient.Rotation = 90
titleGradient.Parent = titleBar
local titleStroke = Instance.new("UIStroke")
titleStroke.Color = Color3.fromRGB(220, 120, 120)
titleStroke.Thickness = 2
titleStroke.Transparency = 0.3
titleStroke.Parent = titleBar
local titleGlow = Instance.new("ImageLabel")
titleGlow.Image = "rbxassetid://5028857475"
titleGlow.ImageTransparency = 0.6
titleGlow.BackgroundTransparency = 1
titleGlow.Size = UDim2.new(1, 60, 1, 60)
titleGlow.Position = UDim2.new(0, -30, 0, -30)
titleGlow.ZIndex = -1
titleGlow.Parent = titleBar
titleBar.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0.6, 0, 0, 50)
titleLabel.Position = UDim2.new(0, 20, 0, 10)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Horror Mansion Hacks"
titleLabel.TextColor3 = Color3.fromRGB(255, 200, 200)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 28
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
local textStroke = Instance.new("UIStroke")
textStroke.Color = Color3.fromRGB(150, 50, 50)
textStroke.Thickness = 1.5
textStroke.Parent = titleLabel
titleLabel.Parent = titleBar

local minimizeButton = Instance.new("TextButton")
minimizeButton.Size = UDim2.new(0, 50, 0, 50)
minimizeButton.Position = UDim2.new(1, -110, 0, 10)
minimizeButton.Text = "-"
minimizeButton.BackgroundColor3 = Color3.fromRGB(40, 40, 70)
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.TextSize = 30
local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 15)
minCorner.Parent = minimizeButton
minimizeButton.Parent = titleBar

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 50, 0, 50)
closeButton.Position = UDim2.new(1, -55, 0, 10)
closeButton.Text = "X"
closeButton.BackgroundColor3 = Color3.fromRGB(70, 20, 20)
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 30
local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 15)
closeCorner.Parent = closeButton
closeButton.Parent = titleBar

local restoreButton = Instance.new("TextButton")
restoreButton.Size = UDim2.new(0, 80, 0, 80)
restoreButton.Position = UDim2.new(0.5, -40, 0.5, -40)
restoreButton.Text = "+"
restoreButton.BackgroundColor3 = Color3.fromRGB(30, 50, 30)
restoreButton.TextColor3 = Color3.fromRGB(255, 255, 255)
restoreButton.Font = Enum.Font.GothamBold
restoreButton.TextSize = 35
restoreButton.Visible = false
restoreButton.BackgroundTransparency = 1
local restoreCorner = Instance.new("UICorner")
restoreCorner.CornerRadius = UDim.new(0, 40)
restoreCorner.Parent = restoreButton
restoreButton.Parent = screenGui

local tabFrame = Instance.new("Frame")
tabFrame.Size = UDim2.new(0, 150, 1, -80)
tabFrame.Position = UDim2.new(0, 10, 0, 80)
tabFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 30)
tabFrame.BorderSizePixel = 0
local tabCorner = Instance.new("UICorner")
tabCorner.CornerRadius = UDim.new(0, 15)
tabCorner.Parent = tabFrame
local tabStroke = Instance.new("UIStroke")
tabStroke.Color = Color3.fromRGB(180, 80, 80)
tabStroke.Thickness = 2
tabStroke.Transparency = 0.2
tabStroke.Parent = tabFrame
tabFrame.Parent = mainFrame

local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(0, 280, 1, -80)
contentFrame.Position = UDim2.new(0, 165, 0, 80)
contentFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 30)
contentFrame.BorderSizePixel = 0
local contentCorner = Instance.new("UICorner")
contentCorner.CornerRadius = UDim.new(0, 15)
contentCorner.Parent = contentFrame
local contentStroke = Instance.new("UIStroke")
contentStroke.Color = Color3.fromRGB(180, 80, 80)
contentStroke.Thickness = 2
contentStroke.Transparency = 0.2
contentStroke.Parent = contentFrame
contentFrame.Parent = mainFrame

local cheatsTabButton = Instance.new("TextButton")
cheatsTabButton.Size = UDim2.new(1, -10, 0, 60)
cheatsTabButton.Position = UDim2.new(0, 5, 0, 10)
cheatsTabButton.Text = "Cheats"
cheatsTabButton.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
cheatsTabButton.TextColor3 = Color3.fromRGB(255, 200, 200)
cheatsTabButton.Font = Enum.Font.GothamSemibold
cheatsTabButton.TextSize = 20
local cheatsTabCorner = Instance.new("UICorner")
cheatsTabCorner.CornerRadius = UDim.new(0, 12)
cheatsTabCorner.Parent = cheatsTabButton
cheatsTabButton.Parent = tabFrame

local teleportTabButton = Instance.new("TextButton")
teleportTabButton.Size = UDim2.new(1, -10, 0, 60)
teleportTabButton.Position = UDim2.new(0, 5, 0, 80)
teleportTabButton.Text = "Teleport"
teleportTabButton.BackgroundColor3 = Color3.fromRGB(20, 20, 50)
teleportTabButton.TextColor3 = Color3.fromRGB(255, 200, 200)
teleportTabButton.Font = Enum.Font.GothamSemibold
teleportTabButton.TextSize = 20
local teleportTabCorner = Instance.new("UICorner")
teleportTabCorner.CornerRadius = UDim.new(0, 12)
teleportTabCorner.Parent = teleportTabButton
teleportTabButton.Parent = tabFrame

local othersTabButton = Instance.new("TextButton")
othersTabButton.Size = UDim2.new(1, -10, 0, 60)
othersTabButton.Position = UDim2.new(0, 5, 0, 150)
othersTabButton.Text = "Others"
othersTabButton.BackgroundColor3 = Color3.fromRGB(20, 20, 50)
othersTabButton.TextColor3 = Color3.fromRGB(255, 200, 200)
othersTabButton.Font = Enum.Font.GothamSemibold
othersTabButton.TextSize = 20
local othersTabCorner = Instance.new("UICorner")
othersTabCorner.CornerRadius = UDim.new(0, 12)
othersTabCorner.Parent = othersTabButton
othersTabButton.Parent = tabFrame

local creditsTabButton = Instance.new("TextButton")
creditsTabButton.Size = UDim2.new(1, -10, 0, 60)
creditsTabButton.Position = UDim2.new(0, 5, 0, 220)
creditsTabButton.Text = "Credits"
creditsTabButton.BackgroundColor3 = Color3.fromRGB(20, 20, 50)
creditsTabButton.TextColor3 = Color3.fromRGB(255, 200, 200)
creditsTabButton.Font = Enum.Font.GothamSemibold
creditsTabButton.TextSize = 20
local creditsTabCorner = Instance.new("UICorner")
creditsTabCorner.CornerRadius = UDim.new(0, 12)
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

local othersContent = Instance.new("Frame")
othersContent.Size = UDim2.new(1, 0, 1, 0)
othersContent.BackgroundTransparency = 1
othersContent.Visible = false
othersContent.Parent = contentFrame

local creditsContent = Instance.new("Frame")
creditsContent.Size = UDim2.new(1, 0, 1, 0)
creditsContent.BackgroundTransparency = 1
creditsContent.Visible = false
creditsContent.Parent = contentFrame

local fullBrightToggle = Instance.new("TextButton")
fullBrightToggle.Size = UDim2.new(1, -20, 0, 60)
fullBrightToggle.Position = UDim2.new(0, 10, 0, 10)
fullBrightToggle.Text = "Full Bright: OFF"
fullBrightToggle.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
fullBrightToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
fullBrightToggle.Font = Enum.Font.Gotham
fullBrightToggle.TextSize = 20
local fbCorner = Instance.new("UICorner")
fbCorner.CornerRadius = UDim.new(0, 12)
fbCorner.Parent = fullBrightToggle
fullBrightToggle.Parent = cheatsContent

local speedBoostToggle = Instance.new("TextButton")
speedBoostToggle.Size = UDim2.new(1, -20, 0, 60)
speedBoostToggle.Position = UDim2.new(0, 10, 0, 80)
speedBoostToggle.Text = "Speed Boost: OFF"
speedBoostToggle.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
speedBoostToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
speedBoostToggle.Font = Enum.Font.Gotham
speedBoostToggle.TextSize = 20
local sbCorner = Instance.new("UICorner")
sbCorner.CornerRadius = UDim.new(0, 12)
sbCorner.Parent = speedBoostToggle
speedBoostToggle.Parent = cheatsContent

local noClipToggle = Instance.new("TextButton")
noClipToggle.Size = UDim2.new(1, -20, 0, 60)
noClipToggle.Position = UDim2.new(0, 10, 0, 150)
noClipToggle.Text = "NoClip: OFF"
noClipToggle.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
noClipToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
noClipToggle.Font = Enum.Font.Gotham
noClipToggle.TextSize = 20
local ncCorner = Instance.new("UICorner")
ncCorner.CornerRadius = UDim.new(0, 12)
ncCorner.Parent = noClipToggle
noClipToggle.Parent = cheatsContent

local randomSpinButton = Instance.new("TextButton")
randomSpinButton.Size = UDim2.new(1, -20, 0, 60)
randomSpinButton.Position = UDim2.new(0, 10, 0, 220)
randomSpinButton.Text = "Random Spin"
randomSpinButton.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
randomSpinButton.TextColor3 = Color3.fromRGB(255, 255, 255)
randomSpinButton.Font = Enum.Font.Gotham
randomSpinButton.TextSize = 20
local rsCorner = Instance.new("UICorner")
rsCorner.CornerRadius = UDim.new(0, 12)
rsCorner.Parent = randomSpinButton
randomSpinButton.Parent = cheatsContent

local fakeMonsterSpawnButton = Instance.new("TextButton")
fakeMonsterSpawnButton.Size = UDim2.new(1, -20, 0, 60)
fakeMonsterSpawnButton.Position = UDim2.new(0, 10, 0, 10)
fakeMonsterSpawnButton.Text = "Fake Monster Spawn"
fakeMonsterSpawnButton.BackgroundColor3 = Color3.fromRGB(50, 20, 20)
fakeMonsterSpawnButton.TextColor3 = Color3.fromRGB(255, 255, 255)
fakeMonsterSpawnButton.Font = Enum.Font.GothamBold
fakeMonsterSpawnButton.TextSize = 20
local fmCorner = Instance.new("UICorner")
fmCorner.CornerRadius = UDim.new(0, 12)
fmCorner.Parent = fakeMonsterSpawnButton
fakeMonsterSpawnButton.Parent = othersContent

local infinityYieldButton = Instance.new("TextButton")
infinityYieldButton.Size = UDim2.new(1, -20, 0, 60)
infinityYieldButton.Position = UDim2.new(0, 10, 0, 80)
infinityYieldButton.Text = "Infinity Yield"
infinityYieldButton.BackgroundColor3 = Color3.fromRGB(50, 20, 20)
infinityYieldButton.TextColor3 = Color3.fromRGB(255, 255, 255)
infinityYieldButton.Font = Enum.Font.GothamBold
infinityYieldButton.TextSize = 20
local iyCorner = Instance.new("UICorner")
iyCorner.CornerRadius = UDim.new(0, 12)
iyCorner.Parent = infinityYieldButton
infinityYieldButton.Parent = othersContent

local savePositionButton = Instance.new("TextButton")
savePositionButton.Size = UDim2.new(1, -20, 0, 60)
savePositionButton.Position = UDim2.new(0, 10, 0, 10)
savePositionButton.Text = "Save Position"
savePositionButton.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
savePositionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
savePositionButton.Font = Enum.Font.Gotham
savePositionButton.TextSize = 20
local spCorner = Instance.new("UICorner")
spCorner.CornerRadius = UDim.new(0, 12)
spCorner.Parent = savePositionButton
savePositionButton.Parent = teleportContent

local teleportToSavedButton = Instance.new("TextButton")
teleportToSavedButton.Size = UDim2.new(1, -20, 0, 60)
teleportToSavedButton.Position = UDim2.new(0, 10, 0, 80)
teleportToSavedButton.Text = "Teleport to Saved"
teleportToSavedButton.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
teleportToSavedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
teleportToSavedButton.Font = Enum.Font.Gotham
teleportToSavedButton.TextSize = 20
local tsCornerTeleport = Instance.new("UICorner")
tsCornerTeleport.CornerRadius = UDim.new(0, 12)
tsCornerTeleport.Parent = teleportToSavedButton
teleportToSavedButton.Parent = teleportContent

local creditsLabel1 = Instance.new("TextLabel")
creditsLabel1.Size = UDim2.new(1, -20, 0, 50)
creditsLabel1.Position = UDim2.new(0, 10, 0, 20)
creditsLabel1.BackgroundTransparency = 1
creditsLabel1.Text = "Created by VertiGhost"
creditsLabel1.TextColor3 = Color3.fromRGB(255, 200, 200)
creditsLabel1.Font = Enum.Font.Gotham
creditsLabel1.TextSize = 18
creditsLabel1.Parent = creditsContent

local creditsLabel2 = Instance.new("TextLabel")
creditsLabel2.Size = UDim2.new(1, -20, 0, 50)
creditsLabel2.Position = UDim2.new(0, 10, 0, 80)
creditsLabel2.BackgroundTransparency = 1
creditsLabel2.Text = "Version: 1.0 - 04/02/2025"
creditsLabel2.TextColor3 = Color3.fromRGB(255, 200, 200)
creditsLabel2.Font = Enum.Font.Gotham
creditsLabel2.TextSize = 18
creditsLabel2.Parent = creditsContent

local creditsLabel3 = Instance.new("TextLabel")
creditsLabel3.Size = UDim2.new(1, -20, 0, 50)
creditsLabel3.Position = UDim2.new(0, 10, 0, 140)
creditsLabel3.BackgroundTransparency = 1
creditsLabel3.Text = "For Horror Mansion"
creditsLabel3.TextColor3 = Color3.fromRGB(255, 200, 200)
creditsLabel3.Font = Enum.Font.Gotham
creditsLabel3.TextSize = 18
creditsLabel3.Parent = creditsContent

local function createHoverAnimation(button)
    local originalSize = button.Size
    local originalColor = button.BackgroundColor3
    button.MouseEnter:Connect(function()
        local hoverTween = TweenService:Create(button, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(100, 100, 130), Size = UDim2.new(originalSize.X.Scale, originalSize.X.Offset + 15, originalSize.Y.Scale, originalSize.Y.Offset + 10)})
        hoverTween:Play()
        local hoverGlow = Instance.new("ImageLabel")
        hoverGlow.Image = "rbxassetid://5028857475"
        hoverGlow.ImageTransparency = 0.6
        hoverGlow.BackgroundTransparency = 1
        hoverGlow.Size = UDim2.new(1, 40, 1, 40)
        hoverGlow.Position = UDim2.new(0, -20, 0, -20)
        hoverGlow.ZIndex = button.ZIndex - 1
        hoverGlow.Parent = button
        spawn(function()
            wait(0.1)
            TweenService:Create(hoverGlow, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {ImageTransparency = 1}):Play()
            wait(0.5)
            hoverGlow:Destroy()
        end)
    end)
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {BackgroundColor3 = originalColor, Size = originalSize}):Play()
    end)
end

createHoverAnimation(cheatsTabButton)
createHoverAnimation(teleportTabButton)
createHoverAnimation(othersTabButton)
createHoverAnimation(creditsTabButton)
createHoverAnimation(fullBrightToggle)
createHoverAnimation(speedBoostToggle)
createHoverAnimation(noClipToggle)
createHoverAnimation(randomSpinButton)
createHoverAnimation(fakeMonsterSpawnButton)
createHoverAnimation(infinityYieldButton)
createHoverAnimation(savePositionButton)
createHoverAnimation(teleportToSavedButton)
createHoverAnimation(minimizeButton)
createHoverAnimation(closeButton)
createHoverAnimation(restoreButton)

local function createTabTransition(content)
    return function()
        content.Position = UDim2.new(0, 50, 0, 0)
        content.Visible = true
        TweenService:Create(content, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, 0)}):Play()
        cheatsContent.Visible = (content == cheatsContent)
        teleportContent.Visible = (content == teleportContent)
        othersContent.Visible = (content == othersContent)
        creditsContent.Visible = (content == creditsContent)
        cheatsTabButton.BackgroundColor3 = (content == cheatsContent) and Color3.fromRGB(30, 30, 60) or Color3.fromRGB(20, 20, 50)
        teleportTabButton.BackgroundColor3 = (content == teleportContent) and Color3.fromRGB(30, 30, 60) or Color3.fromRGB(20, 20, 50)
        othersTabButton.BackgroundColor3 = (content == othersContent) and Color3.fromRGB(30, 30, 60) or Color3.fromRGB(20, 20, 50)
        creditsTabButton.BackgroundColor3 = (content == creditsContent) and Color3.fromRGB(30, 30, 60) or Color3.fromRGB(20, 20, 50)
    end
end

cheatsTabButton.MouseButton1Click:Connect(createTabTransition(cheatsContent))
teleportTabButton.MouseButton1Click:Connect(createTabTransition(teleportContent))
othersTabButton.MouseButton1Click:Connect(createTabTransition(othersContent))
creditsTabButton.MouseButton1Click:Connect(createTabTransition(creditsContent))

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

randomSpinButton.MouseButton1Click:Connect(function()
    if not spinning and RootPart then
        spinning = true
        randomSpinButton.Text = "Spinning..."
        local spinTime = 3
        local startTime = tick()
        local connection
        connection = game:GetService("RunService").RenderStepped:Connect(function()
            if tick() - startTime < spinTime and RootPart then
                local randomAngle = math.rad(math.random(0, 360))
                RootPart.CFrame = RootPart.CFrame * CFrame.Angles(0, randomAngle, 0)
            else
                connection:Disconnect()
                spinning = false
                randomSpinButton.Text = "Random Spin"
            end
        end)
    end
end)

fakeMonsterSpawnButton.MouseButton1Click:Connect(function()
    if not monsterActive and RootPart then
        monsterActive = true
        fakeMonsterSpawnButton.Text = "Spawning..."
        local spawnPosition = RootPart.Position + (RootPart.CFrame.LookVector * 5) + Vector3.new(0, 1.5, 0)
        local monster = Instance.new("Model")
        monster.Name = "FakeMonster"

        local body = Instance.new("Part")
        body.Size = Vector3.new(3, 2, 5)
        body.Color = Color3.fromRGB(50, 30, 20)
        body.Material = Enum.Material.Fabric
        body.Position = spawnPosition
        body.Parent = monster

        local head = Instance.new("Part")
        head.Size = Vector3.new(1.5, 1.2, 2)
        head.Color = Color3.fromRGB(50, 30, 20)
        head.Material = Enum.Material.Fabric
        head.Position = spawnPosition + Vector3.new(0, 1.5, 2)
        head.Parent = monster

        local leftEar = Instance.new("Part")
        leftEar.Size = Vector3.new(0.5, 1, 0.3)
        leftEar.Color = Color3.fromRGB(50, 30, 20)
        leftEar.Material = Enum.Material.Fabric
        leftEar.Position = spawnPosition + Vector3.new(-0.7, 2.2, 2)
        leftEar.Parent = monster

        local rightEar = Instance.new("Part")
        rightEar.Size = Vector3.new(0.5, 1, 0.3)
        rightEar.Color = Color3.fromRGB(50, 30, 20)
        rightEar.Material = Enum.Material.Fabric
        rightEar.Position = spawnPosition + Vector3.new(0.7, 2.2, 2)
        rightEar.Parent = monster

        local leftEye = Instance.new("Part")
        leftEye.Size = Vector3.new(0.3, 0.3, 0.3)
        leftEye.Color = Color3.fromRGB(255, 255, 0)
        leftEye.Material = Enum.Material.Neon
        leftEye.Position = spawnPosition + Vector3.new(-0.4, 1.5, 2.8)
        leftEye.Parent = monster

        local rightEye = Instance.new("Part")
        rightEye.Size = Vector3.new(0.3, 0.3, 0.3)
        rightEye.Color = Color3.fromRGB(255, 255, 0)
        rightEye.Material = Enum.Material.Neon
        rightEye.Position = spawnPosition + Vector3.new(0.4, 1.5, 2.8)
        rightEye.Parent = monster

        local leftFrontLeg = Instance.new("Part")
        leftFrontLeg.Size = Vector3.new(0.8, 2, 0.8)
        leftFrontLeg.Color = Color3.fromRGB(50, 30, 20)
        leftFrontLeg.Material = Enum.Material.Fabric
        leftFrontLeg.Position = spawnPosition + Vector3.new(-1, -0.5, 1.5)
        leftFrontLeg.Parent = monster

        local rightFrontLeg = Instance.new("Part")
        rightFrontLeg.Size = Vector3.new(0.8, 2, 0.8)
        rightFrontLeg.Color = Color3.fromRGB(50, 30, 20)
        rightFrontLeg.Material = Enum.Material.Fabric
        rightFrontLeg.Position = spawnPosition + Vector3.new(1, -0.5, 1.5)
        rightFrontLeg.Parent = monster

        local leftBackLeg = Instance.new("Part")
        leftBackLeg.Size = Vector3.new(0.8, 2, 0.8)
        leftBackLeg.Color = Color3.fromRGB(50, 30, 20)
        leftBackLeg.Material = Enum.Material.Fabric
        leftBackLeg.Position = spawnPosition + Vector3.new(-1, -0.5, -1.5)
        leftBackLeg.Parent = monster

        local rightBackLeg = Instance.new("Part")
        rightBackLeg.Size = Vector3.new(0.8, 2, 0.8)
        rightBackLeg.Color = Color3.fromRGB(50, 30, 20)
        rightBackLeg.Material = Enum.Material.Fabric
        rightBackLeg.Position = spawnPosition + Vector3.new(1, -0.5, -1.5)
        rightBackLeg.Parent = monster

        local tail = Instance.new("Part")
        tail.Size = Vector3.new(0.4, 0.4, 2)
        tail.Color = Color3.fromRGB(50, 30, 20)
        tail.Material = Enum.Material.Fabric
        tail.Position = spawnPosition + Vector3.new(0, 1, -3)
        tail.Parent = monster

        local leftFang = Instance.new("Part")
        leftFang.Size = Vector3.new(0.2, 0.5, 0.2)
        leftFang.Color = Color3.fromRGB(255, 255, 255)
        leftFang.Material = Enum.Material.Neon
        leftFang.Position = spawnPosition + Vector3.new(-0.3, 1, 3)
        leftFang.Parent = monster

        local rightFang = Instance.new("Part")
        rightFang.Size = Vector3.new(0.2, 0.5, 0.2)
        rightFang.Color = Color3.fromRGB(255, 255, 255)
        rightFang.Material = Enum.Material.Neon
        rightFang.Position = spawnPosition + Vector3.new(0.3, 1, 3)
        rightFang.Parent = monster

        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://9119707206"
        sound.Volume = 2
        sound.Pitch = 0.8
        sound.Parent = body
        sound:Play()

        monster.Parent = Workspace
        wait(5)
        local fadeTween = TweenService:Create(body, TweenInfo.new(0.8), {Transparency = 1})
        local headFade = TweenService:Create(head, TweenInfo.new(0.8), {Transparency = 1})
        local leftEarFade = TweenService:Create(leftEar, TweenInfo.new(0.8), {Transparency = 1})
        local rightEarFade = TweenService:Create(rightEar, TweenInfo.new(0.8), {Transparency = 1})
        local leftEyeFade = TweenService:Create(leftEye, TweenInfo.new(0.8), {Transparency = 1})
        local rightEyeFade = TweenService:Create(rightEye, TweenInfo.new(0.8), {Transparency = 1})
        local leftFrontLegFade = TweenService:Create(leftFrontLeg, TweenInfo.new(0.8), {Transparency = 1})
        local rightFrontLegFade = TweenService:Create(rightFrontLeg, TweenInfo.new(0.8), {Transparency = 1})
        local leftBackLegFade = TweenService:Create(leftBackLeg, TweenInfo.new(0.8), {Transparency = 1})
        local rightBackLegFade = TweenService:Create(rightBackLeg, TweenInfo.new(0.8), {Transparency = 1})
        local tailFade = TweenService:Create(tail, TweenInfo.new(0.8), {Transparency = 1})
        local leftFangFade = TweenService:Create(leftFang, TweenInfo.new(0.8), {Transparency = 1})
        local rightFangFade = TweenService:Create(rightFang, TweenInfo.new(0.8), {Transparency = 1})
        fadeTween:Play()
        headFade:Play()
        leftEarFade:Play()
        rightEarFade:Play()
        leftEyeFade:Play()
        rightEyeFade:Play()
        leftFrontLegFade:Play()
        rightFrontLegFade:Play()
        leftBackLegFade:Play()
        rightBackLegFade:Play()
        tailFade:Play()
        leftFangFade:Play()
        rightFangFade:Play()
        wait(0.8)
        monster:Destroy()
        monsterActive = false
        fakeMonsterSpawnButton.Text = "Fake Monster Spawn"
    end
end)

infinityYieldButton.MouseButton1Click:Connect(function()
    infinityYieldButton.Text = "Loading Infinity Yield..."
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
    wait(2)
    infinityYieldButton.Text = "Infinity Yield"
end)

savePositionButton.MouseButton1Click:Connect(function()
    if RootPart then
        savedPosition = RootPart.CFrame
        print("Position sauvegardée : ", RootPart.Position)
    end
end)

teleportToSavedButton.MouseButton1Click:Connect(function()
    if savedPosition and RootPart then
        RootPart.CFrame = savedPosition
        print("Téléporté à la position sauvegardée : ", RootPart.Position)
    end
end)

minimizeButton.MouseButton1Click:Connect(function()
    particleEmitter.Enabled = false
    local tween = TweenService:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1})
    tween:Play()
    tween.Completed:Connect(function()
        mainFrame.Visible = false
        restoreButton.Visible = true
        TweenService:Create(restoreButton, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {BackgroundTransparency = 0, Size = UDim2.new(0, 80, 0, 80)}):Play()
    end)
end)

restoreButton.MouseButton1Click:Connect(function()
    local tween = TweenService:Create(restoreButton, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1, Size = UDim2.new(0, 0, 0, 0)})
    tween:Play()
    tween.Completed:Connect(function()
        restoreButton.Visible = false
        mainFrame.Visible = true
        particleEmitter.Enabled = true
        TweenService:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 450, 0, 600), BackgroundTransparency = 0}):Play()
    end)
end)

closeButton.MouseButton1Click:Connect(function()
    local tween = TweenService:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1})
    tween:Play()
    tween.Completed:Connect(function()
        screenGui:Destroy()
    end)
end)

local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

titleBar.InputBegan:Connect(function(input)
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

titleBar.InputChanged:Connect(function(input)
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
mainFrame.BackgroundTransparency = 1
mainFrame.Visible = true
local openTween = TweenService:Create(mainFrame, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 450, 0, 600), BackgroundTransparency = 0})
openTween:Play()
spawn(function()
    wait(0.2)
    particleEmitter.Enabled = true
end)

local glowTween = TweenService:Create(glow, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {ImageTransparency = 0.7, Size = UDim2.new(1, 100, 1, 100)})
glowTween:Play()

local titlePulse = TweenService:Create(titleGlow, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {ImageTransparency = 0.8, Size = UDim2.new(1, 80, 1, 80)})
titlePulse:Play()
