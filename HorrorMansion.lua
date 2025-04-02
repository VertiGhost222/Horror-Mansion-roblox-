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

-- Création de l'événement pour le faux monstre
local monsterSpawnEvent = ReplicatedStorage:FindFirstChild("FakeMonsterSpawnEvent")
if not monsterSpawnEvent then
    monsterSpawnEvent = Instance.new("RemoteEvent")
    monsterSpawnEvent.Name = "FakeMonsterSpawnEvent"
    monsterSpawnEvent.Parent = ReplicatedStorage
end

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

local randomSpinButton = Instance.new("TextButton")
randomSpinButton.Size = UDim2.new(1, -20, 0, 50)
randomSpinButton.Position = UDim2.new(0, 10, 0, 175)
randomSpinButton.Text = "Random Spin"
randomSpinButton.BackgroundColor3 = Color3.fromRGB(45, 45, 70)
randomSpinButton.TextColor3 = Color3.fromRGB(255, 255, 255)
randomSpinButton.Font = Enum.Font.Gotham
randomSpinButton.TextSize = 14
local rsCorner = Instance.new("UICorner")
rsCorner.CornerRadius = UDim.new(0, 6)
rsCorner.Parent = randomSpinButton
randomSpinButton.Parent = cheatsContent

local fakeMonsterSpawnButton = Instance.new("TextButton")
fakeMonsterSpawnButton.Size = UDim2.new(1, -20, 0, 50)
fakeMonsterSpawnButton.Position = UDim2.new(0, 10, 0, 230)
fakeMonsterSpawnButton.Text = "Fake Monster Spawn"
fakeMonsterSpawnButton.BackgroundColor3 = Color3.fromRGB(45, 45, 70)
fakeMonsterSpawnButton.TextColor3 = Color3.fromRGB(255, 255, 255)
fakeMonsterSpawnButton.Font = Enum.Font.Gotham
fakeMonsterSpawnButton.TextSize = 14
local fmCorner = Instance.new("UICorner")
fmCorner.CornerRadius = UDim.new(0, 6)
fmCorner.Parent = fakeMonsterSpawnButton
fakeMonsterSpawnButton.Parent = cheatsContent

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
creditsLabel1.Text = "Créé par VertiGhost"
creditsLabel1.TextColor3 = Color3.fromRGB(220, 220, 255)
creditsLabel1.Font = Enum.Font.Gotham
creditsLabel1.TextSize = 14
creditsLabel1.Parent = creditsContent

local creditsLabel2 = Instance.new("TextLabel")
creditsLabel2.Size = UDim2.new(1, -20, 0, 40)
creditsLabel2.Position = UDim2.new(0, 10, 0, 50)
creditsLabel2.BackgroundTransparency = 1
creditsLabel2.Text = "Version : 1.0 - 04/02/2025" -- Format américain MM/DD/YYYY
creditsLabel2.TextColor3 = Color3.fromRGB(220, 220, 255)
creditsLabel2.Font = Enum.Font.Gotham
creditsLabel2.TextSize = 14
creditsLabel2.Parent = creditsContent

local creditsLabel3 = Instance.new("TextLabel")
creditsLabel3.Size = UDim2.new(1, -20, 0, 40)
creditsLabel3.Position = UDim2.new(0, 10, 0, 90)
creditsLabel3.BackgroundTransparency = 1
creditsLabel3.Text = "Pour Horror Mansion"
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
createHoverAnimation(randomSpinButton)
createHoverAnimation(fakeMonsterSpawnButton)
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
        fakeMonsterSpawnButton.Text = "Invocation..."
        monsterSpawnEvent:FireServer(RootPart.Position)
        wait(4) -- Cooldown plus long pour l'effet
        monsterActive = false
        fakeMonsterSpawnButton.Text = "Fake Monster Spawn"
    end
end)

-- Effet du faux monstre côté client
monsterSpawnEvent.OnClientEvent:Connect(function(position)
    -- Création du modèle du monstre
    local monster = Instance.new("Model")
    local body = Instance.new("Part")
    body.Size = Vector3.new(3, 5, 2) -- Plus grand pour être visible
    body.Anchored = false
    body.CanCollide = true
    body.Color = Color3.fromRGB(40, 20, 20) -- Couleur sombre et menaçante
    body.Material = Enum.Material.Rock
    body.Position = position + Vector3.new(0, 2.5, 0)
    body.Parent = monster
    local head = Instance.new("Part")
    head.Size = Vector3.new(2, 2, 2)
    head.Anchored = false
    head.CanCollide = true
    head.Color = Color3.fromRGB(40, 20, 20)
    head.Material = Enum.Material.Rock
    head.Position = position + Vector3.new(0, 6, 0)
    head.Parent = monster

    -- Ajout d'une texture effrayante
    local decal = Instance.new("Decal")
    decal.Texture = "rbxassetid://143913013" -- Visage fantomatique
    decal.Face = Enum.NormalId.Front
    decal.Parent = head

    -- Ajout d'un effet de lumière rouge
    local light = Instance.new("PointLight")
    light.Color = Color3.fromRGB(255, 0, 0)
    light.Brightness = 2
    light.Range = 10
    light.Parent = head

    -- Ajout d'un Humanoid pour le mouvement
    local humanoid = Instance.new("Humanoid")
    humanoid.WalkSpeed = 10
    humanoid.Parent = monster
    monster.PrimaryPart = body
    monster.Parent = Workspace

    -- Simulation de mouvement
    spawn(function()
        humanoid:MoveTo(position + Vector3.new(math.random(-7, 7), 0, math.random(-7, 7)))
        wait(3) -- Le monstre reste plus longtemps
        local fadeTween = TweenService:Create(body, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {Transparency = 1})
        local headFadeTween = TweenService:Create(head, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {Transparency = 1})
        fadeTween:Play()
        headFadeTween:Play()
        wait(0.5)
        monster:Destroy()
    end)
end)

savePositionButton.MouseButton1Click:Connect(function()
    savedPosition = RootPart.CFrame
end)

teleportToSavedButton.MouseButton1Click:Connect(function()
    if savedPosition then
        RootPart.CFrame = savedPosition
    else
        warn("Aucune position sauvegardée !")
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
