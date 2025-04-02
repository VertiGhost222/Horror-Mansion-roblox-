local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Variables pour les fonctionnalités
local speedBoostActive = false
local defaultSpeed = 16
local boostedSpeed = 50
local savedPosition = nil
local noClipActive = false
local noClipConnection
local spinning = false
local monsterActive = false

-- Gestion du personnage
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

-- Création du GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "HorrorMansionHacks"
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 500, 0, 620)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -310)
mainFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 15)
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 30)
corner.Parent = mainFrame
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 8, 15)), ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 45))}
gradient.Rotation = 45
gradient.Parent = mainFrame
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(130, 130, 190)
stroke.Thickness = 3
stroke.Transparency = 0.3
stroke.Parent = mainFrame
local shadow = Instance.new("ImageLabel")
shadow.Image = "rbxassetid://1316045217"
shadow.ImageTransparency = 0.4
shadow.BackgroundTransparency = 1
shadow.Size = UDim2.new(1, 80, 1, 80)
shadow.Position = UDim2.new(0, -40, 0, -40)
shadow.ZIndex = -1
shadow.Parent = mainFrame
mainFrame.Parent = screenGui

local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 80)
topBar.BackgroundColor3 = Color3.fromRGB(15, 15, 30)
topBar.BorderSizePixel = 0
local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0, 30)
topCorner.Parent = topBar
local topGradient = Instance.new("UIGradient")
topGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 15, 30)), ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 35, 55))}
topGradient.Rotation = 90
topGradient.Parent = topBar
local topStroke = Instance.new("UIStroke")
topStroke.Color = Color3.fromRGB(150, 150, 210)
topStroke.Thickness = 2
topStroke.Transparency = 0.5
topStroke.Parent = topBar
topBar.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0.7, 0, 1, 0)
titleLabel.Position = UDim2.new(0, 30, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Horror Mansion Hacks"
titleLabel.TextColor3 = Color3.fromRGB(240, 240, 255)
titleLabel.Font = Enum.Font.GothamBlack
titleLabel.TextSize = 30
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
local textStroke = Instance.new("UIStroke")
textStroke.Color = Color3.fromRGB(100, 100, 150)
textStroke.Thickness = 1.5
textStroke.Parent = titleLabel
titleLabel.Parent = topBar

local minimizeButton = Instance.new("TextButton")
minimizeButton.Size = UDim2.new(0, 55, 0, 55)
minimizeButton.Position = UDim2.new(1, -115, 0, 12)
minimizeButton.Text = "-"
minimizeButton.BackgroundColor3 = Color3.fromRGB(35, 35, 65)
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.TextSize = 32
local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 18)
minCorner.Parent = minimizeButton
minimizeButton.Parent = topBar

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 55, 0, 55)
closeButton.Position = UDim2.new(1, -55, 0, 12)
closeButton.Text = "X"
closeButton.BackgroundColor3 = Color3.fromRGB(65, 25, 25)
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 32
local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 18)
closeCorner.Parent = closeButton
closeButton.Parent = topBar

local restoreButton = Instance.new("TextButton")
restoreButton.Size = UDim2.new(0, 90, 0, 90)
restoreButton.Position = UDim2.new(0.5, -45, 0.5, -45)
restoreButton.Text = "+"
restoreButton.BackgroundColor3 = Color3.fromRGB(25, 45, 25)
restoreButton.TextColor3 = Color3.fromRGB(255, 255, 255)
restoreButton.Font = Enum.Font.GothamBold
restoreButton.TextSize = 36
restoreButton.Visible = false
restoreButton.BackgroundTransparency = 1
local restoreCorner = Instance.new("UICorner")
restoreCorner.CornerRadius = UDim.new(0, 45)
restoreCorner.Parent = restoreButton
restoreButton.Parent = screenGui

local tabFrame = Instance.new("Frame")
tabFrame.Size = UDim2.new(0, 170, 1, -100)
tabFrame.Position = UDim2.new(0, 10, 0, 90)
tabFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 25)
tabFrame.BorderSizePixel = 0
local tabCorner = Instance.new("UICorner")
tabCorner.CornerRadius = UDim.new(0, 18)
tabCorner.Parent = tabFrame
local tabStroke = Instance.new("UIStroke")
tabStroke.Color = Color3.fromRGB(100, 100, 160)
tabStroke.Thickness = 2
tabStroke.Transparency = 0.4
tabStroke.Parent = tabFrame
tabFrame.Parent = mainFrame

local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(0, 310, 1, -100)
contentFrame.Position = UDim2.new(0, 190, 0, 90)
contentFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 25)
contentFrame.BorderSizePixel = 0
local contentCorner = Instance.new("UICorner")
contentCorner.CornerRadius = UDim.new(0, 18)
contentCorner.Parent = contentFrame
local contentStroke = Instance.new("UIStroke")
contentStroke.Color = Color3.fromRGB(100, 100, 160)
contentStroke.Thickness = 2
contentStroke.Transparency = 0.4
contentStroke.Parent = contentFrame
contentFrame.Parent = mainFrame

local cheatsTabButton = Instance.new("TextButton")
cheatsTabButton.Size = UDim2.new(1, -10, 0, 70)
cheatsTabButton.Position = UDim2.new(0, 5, 0, 10)
cheatsTabButton.Text = "Cheats"
cheatsTabButton.BackgroundColor3 = Color3.fromRGB(25, 25, 45)
cheatsTabButton.TextColor3 = Color3.fromRGB(240, 240, 255)
cheatsTabButton.Font = Enum.Font.GothamSemibold
cheatsTabButton.TextSize = 22
local cheatsTabCorner = Instance.new("UICorner")
cheatsTabCorner.CornerRadius = UDim.new(0, 14)
cheatsTabCorner.Parent = cheatsTabButton
cheatsTabButton.Parent = tabFrame

local teleportTabButton = Instance.new("TextButton")
teleportTabButton.Size = UDim2.new(1, -10, 0, 70)
teleportTabButton.Position = UDim2.new(0, 5, 0, 90)
teleportTabButton.Text = "Teleport"
teleportTabButton.BackgroundColor3 = Color3.fromRGB(15, 15, 35)
teleportTabButton.TextColor3 = Color3.fromRGB(240, 240, 255)
teleportTabButton.Font = Enum.Font.GothamSemibold
teleportTabButton.TextSize = 22
local teleportTabCorner = Instance.new("UICorner")
teleportTabCorner.CornerRadius = UDim.new(0, 14)
teleportTabCorner.Parent = teleportTabButton
teleportTabButton.Parent = tabFrame

local creditsTabButton = Instance.new("TextButton")
creditsTabButton.Size = UDim2.new(1, -10, 0, 70)
creditsTabButton.Position = UDim2.new(0, 5, 0, 170)
creditsTabButton.Text = "Credits"
creditsTabButton.BackgroundColor3 = Color3.fromRGB(15, 15, 35)
creditsTabButton.TextColor3 = Color3.fromRGB(240, 240, 255)
creditsTabButton.Font = Enum.Font.GothamSemibold
creditsTabButton.TextSize = 22
local creditsTabCorner = Instance.new("UICorner")
creditsTabCorner.CornerRadius = UDim.new(0, 14)
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
fullBrightToggle.Size = UDim2.new(1, -20, 0, 70)
fullBrightToggle.Position = UDim2.new(0, 10, 0, 10)
fullBrightToggle.Text = "Full Bright: OFF"
fullBrightToggle.BackgroundColor3 = Color3.fromRGB(25, 25, 45)
fullBrightToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
fullBrightToggle.Font = Enum.Font.Gotham
fullBrightToggle.TextSize = 20
local fbCorner = Instance.new("UICorner")
fbCorner.CornerRadius = UDim.new(0, 14)
fbCorner.Parent = fullBrightToggle
fullBrightToggle.Parent = cheatsContent

local speedBoostToggle = Instance.new("TextButton")
speedBoostToggle.Size = UDim2.new(1, -20, 0, 70)
speedBoostToggle.Position = UDim2.new(0, 10, 0, 90)
speedBoostToggle.Text = "Speed Boost: OFF"
speedBoostToggle.BackgroundColor3 = Color3.fromRGB(25, 25, 45)
speedBoostToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
speedBoostToggle.Font = Enum.Font.Gotham
speedBoostToggle.TextSize = 20
local sbCorner = Instance.new("UICorner")
sbCorner.CornerRadius = UDim.new(0, 14)
sbCorner.Parent = speedBoostToggle
speedBoostToggle.Parent = cheatsContent

local noClipToggle = Instance.new("TextButton")
noClipToggle.Size = UDim2.new(1, -20, 0, 70)
noClipToggle.Position = UDim2.new(0, 10, 0, 170)
noClipToggle.Text = "NoClip: OFF"
noClipToggle.BackgroundColor3 = Color3.fromRGB(25, 25, 45)
noClipToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
noClipToggle.Font = Enum.Font.Gotham
noClipToggle.TextSize = 20
local ncCorner = Instance.new("UICorner")
ncCorner.CornerRadius = UDim.new(0, 14)
ncCorner.Parent = noClipToggle
noClipToggle.Parent = cheatsContent

local randomSpinButton = Instance.new("TextButton")
randomSpinButton.Size = UDim2.new(1, -20, 0, 70)
randomSpinButton.Position = UDim2.new(0, 10, 0, 250)
randomSpinButton.Text = "Random Spin"
randomSpinButton.BackgroundColor3 = Color3.fromRGB(25, 25, 45)
randomSpinButton.TextColor3 = Color3.fromRGB(255, 255, 255)
randomSpinButton.Font = Enum.Font.Gotham
randomSpinButton.TextSize = 20
local rsCorner = Instance.new("UICorner")
rsCorner.CornerRadius = UDim.new(0, 14)
rsCorner.Parent = randomSpinButton
randomSpinButton.Parent = cheatsContent

local fakeMonsterSpawnButton = Instance.new("TextButton")
fakeMonsterSpawnButton.Size = UDim2.new(1, -20, 0, 70)
fakeMonsterSpawnButton.Position = UDim2.new(0, 10, 0, 330)
fakeMonsterSpawnButton.Text = "Fake Monster Spawn"
fakeMonsterSpawnButton.BackgroundColor3 = Color3.fromRGB(50, 20, 20)
fakeMonsterSpawnButton.TextColor3 = Color3.fromRGB(255, 255, 255)
fakeMonsterSpawnButton.Font = Enum.Font.GothamBold
fakeMonsterSpawnButton.TextSize = 20
local fmCorner = Instance.new("UICorner")
fmCorner.CornerRadius = UDim.new(0, 14)
fmCorner.Parent = fakeMonsterSpawnButton
fakeMonsterSpawnButton.Parent = cheatsContent

local savePositionButton = Instance.new("TextButton")
savePositionButton.Size = UDim2.new(1, -20, 0, 70)
savePositionButton.Position = UDim2.new(0, 10, 0, 10)
savePositionButton.Text = "Save Position"
savePositionButton.BackgroundColor3 = Color3.fromRGB(25, 25, 45)
savePositionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
savePositionButton.Font = Enum.Font.Gotham
savePositionButton.TextSize = 20
local spCorner = Instance.new("UICorner")
spCorner.CornerRadius = UDim.new(0, 14)
spCorner.Parent = savePositionButton
savePositionButton.Parent = teleportContent

local teleportToSavedButton = Instance.new("TextButton")
teleportToSavedButton.Size = UDim2.new(1, -20, 0, 70)
teleportToSavedButton.Position = UDim2.new(0, 10, 0, 90)
teleportToSavedButton.Text = "Teleport to Saved"
teleportToSavedButton.BackgroundColor3 = Color3.fromRGB(25, 25, 45)
teleportToSavedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
teleportToSavedButton.Font = Enum.Font.Gotham
teleportToSavedButton.TextSize = 20
local tsCorner = Instance.new("UICorner")
tsCorner.CornerRadius = UDim.new(0, 14)
tsCorner.Parent = teleportToSavedButton
teleportToSavedButton.Parent = teleportContent

local creditsLabel1 = Instance.new("TextLabel")
creditsLabel1.Size = UDim2.new(1, -20, 0, 50)
creditsLabel1.Position = UDim2.new(0, 10, 0, 20)
creditsLabel1.BackgroundTransparency = 1
creditsLabel1.Text = "Created by VertiGhost"
creditsLabel1.TextColor3 = Color3.fromRGB(240, 240, 255)
creditsLabel1.Font = Enum.Font.Gotham
creditsLabel1.TextSize = 18
creditsLabel1.Parent = creditsContent

local creditsLabel2 = Instance.new("TextLabel")
creditsLabel2.Size = UDim2.new(1, -20, 0, 50)
creditsLabel2.Position = UDim2.new(0, 10, 0, 80)
creditsLabel2.BackgroundTransparency = 1
creditsLabel2.Text = "Version: 1.0 - 04/02/2025"
creditsLabel2.TextColor3 = Color3.fromRGB(240, 240, 255)
creditsLabel2.Font = Enum.Font.Gotham
creditsLabel2.TextSize = 18
creditsLabel2.Parent = creditsContent

local creditsLabel3 = Instance.new("TextLabel")
creditsLabel3.Size = UDim2.new(1, -20, 0, 50)
creditsLabel3.Position = UDim2.new(0, 10, 0, 140)
creditsLabel3.BackgroundTransparency = 1
creditsLabel3.Text = "For Horror Mansion"
creditsLabel3.TextColor3 = Color3.fromRGB(240, 240, 255)
creditsLabel3.Font = Enum.Font.Gotham
creditsLabel3.TextSize = 18
creditsLabel3.Parent = creditsContent

-- Animations améliorées pour les boutons
local function createHoverAnimation(button)
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            BackgroundColor3 = Color3.fromRGB(60, 60, 90),
            Size = button.Size + UDim2.new(0, 10, 0, 10)
        }):Play()
    end)
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            BackgroundColor3 = button == fakeMonsterSpawnButton and Color3.fromRGB(50, 20, 20) or (button == cheatsTabButton and Color3.fromRGB(25, 25, 45) or Color3.fromRGB(15, 15, 35)),
            Size = button.Size - UDim2.new(0, 10, 0, 10)
        }):Play()
    end)
end

createHoverAnimation(cheatsTabButton)
createHoverAnimation(teleportTabButton)
createHoverAnimation(creditsTabButton)
createHoverAnimation(fullBrightToggle)
createHoverAnimation(speedBoostToggle)
createHoverAnimation(noClipToggle)
createHoverAnimation(randomSpinButton)
createHoverAnimation(fakeMonsterSpawnButton)
createHoverAnimation(savePositionButton)
createHoverAnimation(teleportToSavedButton)
createHoverAnimation(minimizeButton)
createHoverAnimation(closeButton)
createHoverAnimation(restoreButton)

-- Gestion des onglets
cheatsTabButton.MouseButton1Click:Connect(function()
    TweenService:Create(cheatsContent, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, 0)}):Play()
    cheatsContent.Visible = true
    teleportContent.Visible = false
    creditsContent.Visible = false
    cheatsTabButton.BackgroundColor3 = Color3.fromRGB(25, 25, 45)
    teleportTabButton.BackgroundColor3 = Color3.fromRGB(15, 15, 35)
    creditsTabButton.BackgroundColor3 = Color3.fromRGB(15, 15, 35)
end)

teleportTabButton.MouseButton1Click:Connect(function()
    TweenService:Create(teleportContent, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, 0)}):Play()
    cheatsContent.Visible = false
    teleportContent.Visible = true
    creditsContent.Visible = false
    cheatsTabButton.BackgroundColor3 = Color3.fromRGB(15, 15, 35)
    teleportTabButton.BackgroundColor3 = Color3.fromRGB(25, 25, 45)
    creditsTabButton.BackgroundColor3 = Color3.fromRGB(15, 15, 35)
end)

creditsTabButton.MouseButton1Click:Connect(function()
    TweenService:Create(creditsContent, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, 0)}):Play()
    cheatsContent.Visible = false
    teleportContent.Visible = false
    creditsContent.Visible = true
    cheatsTabButton.BackgroundColor3 = Color3.fromRGB(15, 15, 35)
    teleportTabButton.BackgroundColor3 = Color3.fromRGB(15, 15, 35)
    creditsTabButton.BackgroundColor3 = Color3.fromRGB(25, 25, 45)
end)

-- Fonctionnalités
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

-- Fake Monster Spawn amélioré
fakeMonsterSpawnButton.MouseButton1Click:Connect(function()
    if not monsterActive and RootPart then
        monsterActive = true
        fakeMonsterSpawnButton.Text = "Spawning..."
        local spawnPosition = RootPart.Position + (RootPart.CFrame.LookVector * 5)

        -- Tentative de synchronisation avec un RemoteEvent fictif
        local monsterEvent = Instance.new("RemoteEvent")
        monsterEvent.Name = "FakeMonsterSpawnEvent"
        monsterEvent.Parent = ReplicatedStorage

        local function spawnMonster(position)
            local monster = Instance.new("Model")
            monster.Name = "FakeMonster"

            -- Corps plus détaillé
            local body = Instance.new("Part")
            body.Size = Vector3.new(2.5, 6.5, 1.8)
            body.Anchored = false
            body.CanCollide = true
            body.Color = Color3.fromRGB(10, 10, 10)
            body.Material = Enum.Material.CorrodedMetal
            body.Position = position + Vector3.new(0, 3.25, 0)
            body.Parent = monster

            -- Bras gauche
            local leftArm = Instance.new("Part")
            leftArm.Size = Vector3.new(1, 3, 1)
            leftArm.Anchored = false
            leftArm.CanCollide = true
            leftArm.Color = Color3.fromRGB(10, 10, 10)
            leftArm.Material = Enum.Material.CorrodedMetal
            leftArm.Position = position + Vector3.new(-1.5, 4.5, 0)
            leftArm.Parent = monster

            -- Bras droit
            local rightArm = Instance.new("Part")
            rightArm.Size = Vector3.new(1, 3, 1)
            rightArm.Anchored = false
            rightArm.CanCollide = true
            rightArm.Color = Color3.fromRGB(10, 10, 10)
            rightArm.Material = Enum.Material.CorrodedMetal
            rightArm.Position = position + Vector3.new(1.5, 4.5, 0)
            rightArm.Parent = monster

            -- Tête avec détails
            local head = Instance.new("Part")
            head.Size = Vector3.new(1.5, 1.5, 1.5)
            head.Anchored = false
            head.CanCollide = true
            head.Color = Color3.fromRGB(10, 10, 10)
            head.Material = Enum.Material.CorrodedMetal
            head.Position = position + Vector3.new(0, 6.5, 0)
            head.Parent = monster

            -- Yeux rouges réalistes
            local leftEye = Instance.new("Part")
            leftEye.Size = Vector3.new(0.3, 0.3, 0.3)
            leftEye.Anchored = false
            leftEye.CanCollide = false
            leftEye.Color = Color3.fromRGB(255, 0, 0)
            leftEye.Material = Enum.Material.Neon
            leftEye.Position = position + Vector3.new(-0.3, 6.5, 0.6)
            leftEye.Parent = monster

            local rightEye = Instance.new("Part")
            rightEye.Size = Vector3.new(0.3, 0.3, 0.3)
            rightEye.Anchored = false
            rightEye.CanCollide = false
            rightEye.Color = Color3.fromRGB(255, 0, 0)
            rightEye.Material = Enum.Material.Neon
            rightEye.Position = position + Vector3.new(0.3, 6.5, 0.6)
            rightEye.Parent = monster

            -- Aura lumineuse
            local aura = Instance.new("PointLight")
            aura.Color = Color3.fromRGB(255, 0, 0)
            aura.Brightness = 2.5
            aura.Range = 12
            aura.Parent = head

            -- Son effrayant
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://9119707206"
            sound.Volume = 2
            sound.Pitch = 0.9
            sound.Parent = body
            sound:Play()

            -- Animation de marche
            local humanoid = Instance.new("Humanoid")
            humanoid.WalkSpeed = 14
            humanoid.Parent = monster
            monster.PrimaryPart = body
            monster.Parent = Workspace

            -- Comportement réaliste
            spawn(function()
                for i = 1, 6 do
                    humanoid:MoveTo(position + Vector3.new(math.random(-12, 12), 0, math.random(-12, 12)))
                    wait(1)
                end
                local fadeTween = TweenService:Create(body, TweenInfo.new(0.7), {Transparency = 1})
                local leftArmFade = TweenService:Create(leftArm, TweenInfo.new(0.7), {Transparency = 1})
                local rightArmFade = TweenService:Create(rightArm, TweenInfo.new(0.7), {Transparency = 1})
                local headFade = TweenService:Create(head, TweenInfo.new(0.7), {Transparency = 1})
                local leftEyeFade = TweenService:Create(leftEye, TweenInfo.new(0.7), {Transparency = 1})
                local rightEyeFade = TweenService:Create(rightEye, TweenInfo.new(0.7), {Transparency = 1})
                fadeTween:Play()
                leftArmFade:Play()
                rightArmFade:Play()
                headFade:Play()
                leftEyeFade:Play()
                rightEyeFade:Play()
                wait(0.7)
                monster:Destroy()
            end)
        end

        -- Tentative de rendre visible pour tous
        monsterEvent:FireServer(spawnPosition)
        spawnMonster(spawnPosition)

        wait(7)
        monsterActive = false
        fakeMonsterSpawnButton.Text = "Fake Monster Spawn"
    end
end)

savePositionButton.MouseButton1Click:Connect(function()
    savedPosition = RootPart.CFrame
end)

teleportToSavedButton.MouseButton1Click:Connect(function()
    if savedPosition then
        RootPart.CFrame = savedPosition
    end
end)

-- Animations du GUI
minimizeButton.MouseButton1Click:Connect(function()
    TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1}):Play()
    wait(0.4)
    mainFrame.Visible = false
    restoreButton.Visible = true
    TweenService:Create(restoreButton, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {BackgroundTransparency = 0, Size = UDim2.new(0, 90, 0, 90)}):Play()
end)

restoreButton.MouseButton1Click:Connect(function()
    TweenService:Create(restoreButton, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {BackgroundTransparency = 1, Size = UDim2.new(0, 0, 0, 0)}):Play()
    wait(0.4)
    restoreButton.Visible = false
    mainFrame.Visible = true
    TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 500, 0, 620), BackgroundTransparency = 0}):Play()
end)

closeButton.MouseButton1Click:Connect(function()
    TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1}):Play()
    wait(0.4)
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

-- Animation d'ouverture
mainFrame.Size = UDim2.new(0, 0, 0, 0)
mainFrame.BackgroundTransparency = 1
mainFrame.Visible = true
TweenService:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 500, 0, 620), BackgroundTransparency = 0}):Play()
