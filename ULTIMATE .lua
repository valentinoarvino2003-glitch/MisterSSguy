--  FUN HUB V1 - ULTIMATE COMPLETE EDITION 
-- Created with EVERY feature included!
-- Mobile & PC Compatible

print(" Loading Fun Hub V1 - Ultimate Complete Edition...")

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- State Management
local State = {
    character = player.Character or player.CharacterAdded:Wait(),
    humanoid = nil,
    hrp = nil,
    walkSpeed = 16,
    jumpPower = 50,
    flySpeed = 50,
    flying = false,
    noClip = false,
    esp = false,
    infiniteJump = false,
    clickTP = false,
    fullbright = false,
    xRay = false,
    rgbCharacter = false,
    rgbTrail = false,
    rgbNametag = false,
    auraEffect = false,
    lightningStrike = false,
    visionMode = "Normal",
    matrixEffect = false,
    glitchEffect = false,
    characterSize = 1,
    speedDisplay = false,
    trails = false,
    guiVisible = true,
    espConnections = {},
    
    -- New features
    portalsEnabled = false,
    ghostClones = false,
    lightningHands = false,
    tornadoActive = false,
    fireTrail = false,
    fireworks = false,
    starPower = false,
    chaosMode = false,
    blackHole = false,
    ultimateFinale = false,
    orangePortal = nil,
    bluePortal = nil,
    cloneTable = {},
    chaosTimer = 0
}

-- Portal Colors
local PORTAL_ORANGE = Color3.fromRGB(255, 100, 0)
local PORTAL_BLUE = Color3.fromRGB(0, 150, 255)

-- Character Update
local function updateCharacter()
    State.character = player.Character
    if State.character then
        State.humanoid = State.character:FindFirstChildOfClass("Humanoid")
        State.hrp = State.character:FindFirstChild("HumanoidRootPart")
    end
end

player.CharacterAdded:Connect(updateCharacter)
updateCharacter()

-- GUI Creation
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FunHubUltimate"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

if gethui then
    ScreenGui.Parent = gethui()
elseif syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
    ScreenGui.Parent = CoreGui
else
    ScreenGui.Parent = CoreGui
end

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 320, 0, 450)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -225)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 35)
TopBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 10)
TopCorner.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -80, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = " FUN HUB V1 - ULTIMATE "
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 2.5)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 18
CloseButton.Font = Enum.Font.GothamBold
CloseButton.BorderSizePixel = 0
CloseButton.Parent = TopBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseButton

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -70, 0, 2.5)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 18
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Parent = TopBar

local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(0, 6)
MinimizeCorner.Parent = MinimizeButton

-- Content Frame (Scrollable)
local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -10, 1, -45)
ContentFrame.Position = UDim2.new(0, 5, 0, 40)
ContentFrame.BackgroundTransparency = 1
ContentFrame.BorderSizePixel = 0
ContentFrame.ScrollBarThickness = 4
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ContentFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ContentFrame.Parent = MainFrame

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContentLayout.Padding = UDim.new(0, 5)
ContentLayout.Parent = ContentFrame

-- Helper Functions
local yOffset = 0

local function CreateSection(name)
    local Section = Instance.new("TextLabel")
    Section.Name = "Section_" .. name
    Section.Size = UDim2.new(1, -10, 0, 25)
    Section.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Section.BorderSizePixel = 0
    Section.Text = name
    Section.TextColor3 = Color3.fromRGB(255, 255, 255)
    Section.TextSize = 12
    Section.Font = Enum.Font.GothamBold
    Section.Parent = ContentFrame
    
    local SectionCorner = Instance.new("UICorner")
    SectionCorner.CornerRadius = UDim.new(0, 6)
    SectionCorner.Parent = Section
    
    return Section
end

local function CreateToggle(name, defaultValue, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Name = "Toggle_" .. name
    ToggleFrame.Size = UDim2.new(1, -10, 0, 30)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Parent = ContentFrame
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 6)
    ToggleCorner.Parent = ToggleFrame
    
    local ToggleLabel = Instance.new("TextLabel")
    ToggleLabel.Size = UDim2.new(1, -50, 1, 0)
    ToggleLabel.Position = UDim2.new(0, 10, 0, 0)
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Text = name
    ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleLabel.TextSize = 11
    ToggleLabel.Font = Enum.Font.Gotham
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    ToggleLabel.Parent = ToggleFrame
    
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Size = UDim2.new(0, 35, 0, 20)
    ToggleButton.Position = UDim2.new(1, -40, 0.5, -10)
    ToggleButton.BackgroundColor3 = defaultValue and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
    ToggleButton.Text = defaultValue and "ON" or "OFF"
    ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleButton.TextSize = 10
    ToggleButton.Font = Enum.Font.GothamBold
    ToggleButton.BorderSizePixel = 0
    ToggleButton.Parent = ToggleFrame
    
    local ToggleButtonCorner = Instance.new("UICorner")
    ToggleButtonCorner.CornerRadius = UDim.new(0, 4)
    ToggleButtonCorner.Parent = ToggleButton
    
    local isEnabled = defaultValue
    
    ToggleButton.MouseButton1Click:Connect(function()
        isEnabled = not isEnabled
        ToggleButton.BackgroundColor3 = isEnabled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
        ToggleButton.Text = isEnabled and "ON" or "OFF"
        callback(isEnabled)
    end)
    
    return {
        SetValue = function(value)
            isEnabled = value
            ToggleButton.BackgroundColor3 = isEnabled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
            ToggleButton.Text = isEnabled and "ON" or "OFF"
        end
    }
end

local function CreateSlider(name, min, max, defaultValue, callback)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Name = "Slider_" .. name
    SliderFrame.Size = UDim2.new(1, -10, 0, 45)
    SliderFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    SliderFrame.BorderSizePixel = 0
    SliderFrame.Parent = ContentFrame
    
    local SliderCorner = Instance.new("UICorner")
    SliderCorner.CornerRadius = UDim.new(0, 6)
    SliderCorner.Parent = SliderFrame
    
    local SliderLabel = Instance.new("TextLabel")
    SliderLabel.Size = UDim2.new(1, -10, 0, 15)
    SliderLabel.Position = UDim2.new(0, 5, 0, 5)
    SliderLabel.BackgroundTransparency = 1
    SliderLabel.Text = name .. ": " .. defaultValue
    SliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    SliderLabel.TextSize = 11
    SliderLabel.Font = Enum.Font.Gotham
    SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
    SliderLabel.Parent = SliderFrame
    
    local SliderBar = Instance.new("Frame")
    SliderBar.Size = UDim2.new(1, -20, 0, 8)
    SliderBar.Position = UDim2.new(0, 10, 0, 28)
    SliderBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    SliderBar.BorderSizePixel = 0
    SliderBar.Parent = SliderFrame
    
    local SliderBarCorner = Instance.new("UICorner")
    SliderBarCorner.CornerRadius = UDim.new(0, 4)
    SliderBarCorner.Parent = SliderBar
    
    local SliderFill = Instance.new("Frame")
    SliderFill.Size = UDim2.new((defaultValue - min) / (max - min), 0, 1, 0)
    SliderFill.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
    SliderFill.BorderSizePixel = 0
    SliderFill.Parent = SliderBar
    
    local SliderFillCorner = Instance.new("UICorner")
    SliderFillCorner.CornerRadius = UDim.new(0, 4)
    SliderFillCorner.Parent = SliderFill
    
    local SliderButton = Instance.new("TextButton")
    SliderButton.Size = UDim2.new(0, 15, 0, 15)
    SliderButton.Position = UDim2.new((defaultValue - min) / (max - min), -7.5, 0.5, -7.5)
    SliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SliderButton.Text = ""
    SliderButton.BorderSizePixel = 0
    SliderButton.Parent = SliderBar
    
    local SliderButtonCorner = Instance.new("UICorner")
    SliderButtonCorner.CornerRadius = UDim.new(1, 0)
    SliderButtonCorner.Parent = SliderButton
    
    local dragging = false
    
    SliderButton.MouseButton1Down:Connect(function()
        dragging = true
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    SliderBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)
    
    RunService.RenderStepped:Connect(function()
        if dragging then
            local mousePos = UserInputService:GetMouseLocation().X
            local barPos = SliderBar.AbsolutePosition.X
            local barSize = SliderBar.AbsoluteSize.X
            local relativePos = math.clamp((mousePos - barPos) / barSize, 0, 1)
            local value = math.floor(min + (max - min) * relativePos)
            
            SliderFill.Size = UDim2.new(relativePos, 0, 1, 0)
            SliderButton.Position = UDim2.new(relativePos, -7.5, 0.5, -7.5)
            SliderLabel.Text = name .. ": " .. value
            
            callback(value)
        end
    end)
    
    return SliderFrame
end

local function CreateButton(name, callback)
    local Button = Instance.new("TextButton")
    Button.Name = "Button_" .. name
    Button.Size = UDim2.new(1, -10, 0, 30)
    Button.BackgroundColor3 = Color3.fromRGB(50, 120, 200)
    Button.Text = name
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 11
    Button.Font = Enum.Font.GothamBold
    Button.BorderSizePixel = 0
    Button.Parent = ContentFrame
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 6)
    ButtonCorner.Parent = Button
    
    Button.MouseButton1Click:Connect(callback)
    
    Button.MouseEnter:Connect(function()
        Button.BackgroundColor3 = Color3.fromRGB(70, 140, 220)
    end)
    
    Button.MouseLeave:Connect(function()
        Button.BackgroundColor3 = Color3.fromRGB(50, 120, 200)
    end)
    
    return Button
end

-- GUI Sections
CreateSection(" MOVEMENT")

local FlyToggle = CreateToggle("Flight Mode (Press F)", false, function(value)
    State.flying = value
    print("Flying:", value)
end)

CreateSlider("Flight Speed", 10, 200, 50, function(value)
    State.flySpeed = value
    print("Fly Speed:", value)
end)

CreateSlider("Walk Speed", 16, 200, 16, function(value)
    State.walkSpeed = value
    if State.humanoid then
        State.humanoid.WalkSpeed = value
    end
    print("Walk Speed:", value)
end)

CreateSlider("Jump Power", 50, 500, 50, function(value)
    State.jumpPower = value
    if State.humanoid then
        State.humanoid.JumpPower = value
    end
    print("Jump Power:", value)
end)

CreateToggle("No Clip", false, function(value)
    State.noClip = value
    print("NoClip:", value)
end)

CreateToggle("Infinite Jump", false, function(value)
    State.infiniteJump = value
    print("Infinite Jump:", value)
end)

CreateSection(" VISION")

CreateToggle("ESP (Players)", false, function(value)
    State.esp = value
    
    if not value then
        for _, connection in pairs(State.espConnections) do
            connection:Disconnect()
        end
        State.espConnections = {}
        
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("Head") then
                local existing = player.Character.Head:FindFirstChild("ESPGui")
                if existing then
                    existing:Destroy()
                end
            end
        end
    end
    
    print("ESP:", value)
end)

CreateToggle("Fullbright", false, function(value)
    State.fullbright = value
    
    if value then
        game:GetService("Lighting").Brightness = 2
        game:GetService("Lighting").ClockTime = 14
        game:GetService("Lighting").FogEnd = 100000
        game:GetService("Lighting").GlobalShadows = false
        game:GetService("Lighting").OutdoorAmbient = Color3.fromRGB(128, 128, 128)
    else
        game:GetService("Lighting").Brightness = 1
        game:GetService("Lighting").ClockTime = 12
        game:GetService("Lighting").FogEnd = 100000
        game:GetService("Lighting").GlobalShadows = true
        game:GetService("Lighting").OutdoorAmbient = Color3.fromRGB(70, 70, 70)
    end
    
    print("Fullbright:", value)
end)

CreateToggle("X-Ray Vision", false, function(value)
    State.xRay = value
    
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and not obj.Parent:FindFirstChildOfClass("Humanoid") then
            if value then
                obj.LocalTransparencyModifier = 0.7
            else
                obj.LocalTransparencyModifier = 0
            end
        end
    end
    
    print("X-Ray:", value)
end)

CreateButton(" Night Vision", function()
    State.visionMode = "Night"
    local lighting = game:GetService("Lighting")
    lighting.Ambient = Color3.fromRGB(0, 255, 0)
    lighting.OutdoorAmbient = Color3.fromRGB(0, 255, 0)
    lighting.ColorShift_Bottom = Color3.fromRGB(0, 255, 0)
    lighting.ColorShift_Top = Color3.fromRGB(0, 255, 0)
    print(" Night Vision ON!")
end)

CreateButton(" Thermal Vision", function()
    State.visionMode = "Thermal"
    
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character then
            for _, part in pairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Material = Enum.Material.Neon
                    part.Color = Color3.fromRGB(255, 100, 0)
                end
            end
        end
    end
    
    print(" Thermal Vision ON!")
end)

CreateButton(" Normal Vision", function()
    State.visionMode = "Normal"
    local lighting = game:GetService("Lighting")
    lighting.Ambient = Color3.fromRGB(70, 70, 70)
    lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70)
    lighting.ColorShift_Bottom = Color3.fromRGB(0, 0, 0)
    lighting.ColorShift_Top = Color3.fromRGB(0, 0, 0)
    print(" Normal Vision restored!")
end)

CreateSection(" RGB EFFECTS")

CreateToggle("RGB Character", false, function(value)
    State.rgbCharacter = value
    print("RGB Character:", value)
end)

CreateToggle("RGB Trail Ultimate", false, function(value)
    State.rgbTrail = value
    print("RGB Trail:", value)
end)

CreateToggle("RGB Nametag", false, function(value)
    State.rgbNametag = value
    
    if value then
        local BillboardGui = Instance.new("BillboardGui")
        BillboardGui.Name = "RGBNametag"
        BillboardGui.Size = UDim2.new(0, 200, 0, 50)
        BillboardGui.StudsOffset = Vector3.new(0, 3, 0)
        BillboardGui.AlwaysOnTop = true
        BillboardGui.Parent = State.character and State.character:FindFirstChild("Head") or nil
        
        local NameLabel = Instance.new("TextLabel")
        NameLabel.Size = UDim2.new(1, 0, 1, 0)
        NameLabel.BackgroundTransparency = 1
        NameLabel.Text = player.Name
        NameLabel.TextSize = 20
        NameLabel.Font = Enum.Font.GothamBold
        NameLabel.TextStrokeTransparency = 0
        NameLabel.Parent = BillboardGui
        
        spawn(function()
            while State.rgbNametag and BillboardGui.Parent do
                NameLabel.TextColor3 = Color3.fromHSV(tick() % 5 / 5, 1, 1)
                wait(0.05)
            end
        end)
    else
        if State.character and State.character:FindFirstChild("Head") then
            local existing = State.character.Head:FindFirstChild("RGBNametag")
            if existing then
                existing:Destroy()
            end
        end
    end
end)

CreateSection(" ANIME EFFECTS")

CreateToggle("Super Saiyan Aura", false, function(value)
    State.auraEffect = value
    print("Aura Effect:", value)
end)

CreateToggle("Lightning Strikes", false, function(value)
    State.lightningStrike = value
    print("Lightning Strikes:", value)
end)

spawn(function()
    while true do
        if State.auraEffect and State.hrp then
            local aura = Instance.new("Part")
            aura.Size = Vector3.new(6, 6, 6)
            aura.Position = State.hrp.Position
            aura.Anchored = true
            aura.CanCollide = false
            aura.Material = Enum.Material.Neon
            aura.Color = Color3.fromRGB(255, 255, 0)
            aura.Transparency = 0.7
            aura.Shape = Enum.PartType.Ball
            aura.Parent = workspace
            
            local light = Instance.new("PointLight")
            light.Color = Color3.fromRGB(255, 255, 0)
            light.Brightness = 5
            light.Range = 20
            light.Parent = aura
            
            game:GetService("Debris"):AddItem(aura, 0.1)
        end
        
        if State.lightningStrike and State.auraEffect and State.hrp then
            if math.random(1, 30) == 1 then
                local lightning = Instance.new("Part")
                lightning.Size = Vector3.new(0.5, 50, 0.5)
                lightning.Position = State.hrp.Position + Vector3.new(math.random(-10, 10), 25, math.random(-10, 10))
                lightning.Anchored = true
                lightning.CanCollide = false
                lightning.Material = Enum.Material.Neon
                lightning.Color = Color3.fromRGB(255, 255, 255)
                lightning.Transparency = 0.3
                lightning.Parent = workspace
                
                game:GetService("Debris"):AddItem(lightning, 0.1)
            end
        end
        wait(0.1)
    end
end)

CreateSection(" SCREEN EFFECTS")

CreateToggle("Matrix Effect", false, function(value)
    State.matrixEffect = value
    
    if value then
        local MatrixGui = Instance.new("ScreenGui")
        MatrixGui.Name = "MatrixEffect"
        MatrixGui.Parent = CoreGui
        
        for i = 1, 20 do
            local MatrixLabel = Instance.new("TextLabel")
            MatrixLabel.Size = UDim2.new(0, 50, 1, 0)
            MatrixLabel.Position = UDim2.new(0, math.random(0, 1000), 0, -500)
            MatrixLabel.BackgroundTransparency = 1
            MatrixLabel.Text = string.rep("01\n", 100)
            MatrixLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
            MatrixLabel.TextSize = 12
            MatrixLabel.Font = Enum.Font.Code
            MatrixLabel.TextTransparency = 0.5
            MatrixLabel.Parent = MatrixGui
            
            spawn(function()
                while MatrixGui.Parent do
                    MatrixLabel.Position = MatrixLabel.Position + UDim2.new(0, 0, 0, 2)
                    if MatrixLabel.Position.Y.Offset > 1000 then
                        MatrixLabel.Position = UDim2.new(0, math.random(0, 1000), 0, -500)
                    end
                    wait(0.03)
                end
            end)
        end
    else
        local existing = CoreGui:FindFirstChild("MatrixEffect")
        if existing then existing:Destroy() end
    end
end)

CreateToggle("Screen Glitch", false, function(value)
    if value then
        spawn(function()
            while State.glitchEffect do
                local GlitchFrame = Instance.new("Frame")
                GlitchFrame.Size = UDim2.new(math.random(10, 50) / 100, 0, math.random(1, 10) / 100, 0)
                GlitchFrame.Position = UDim2.new(math.random(0, 100) / 100, 0, math.random(0, 100) / 100, 0)
                GlitchFrame.BackgroundColor3 = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
                GlitchFrame.BorderSizePixel = 0
                GlitchFrame.BackgroundTransparency = 0.7
                GlitchFrame.Parent = ScreenGui
                
                game:GetService("Debris"):AddItem(GlitchFrame, 0.1)
                
                wait(0.2)
            end
        end)
    end
end)

CreateSection(" CHARACTER MORPH")

CreateSlider("Character Size", 1, 10, 1, function(value)
    State.characterSize = value
    
    if State.character and State.humanoid then
        local scale = State.humanoid:FindFirstChild("BodyHeightScale")
        local widthScale = State.humanoid:FindFirstChild("BodyWidthScale")
        
        if scale then
            scale.Value = value
        end
        if widthScale then
            widthScale.Value = value
        end
        
        print("Character size:", value)
    end
end)

CreateButton("Become GIANT! ", function()
    if State.character then
        for _, part in pairs(State.character:GetDescendants()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                part.Size = part.Size * 3
            end
        end
        print(" You are now GIANT!")
    end
end)

CreateButton("Become TINY! ", function()
    if State.character then
        for _, part in pairs(State.character:GetDescendants()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                part.Size = part.Size * 0.3
            end
        end
        print(" You are now TINY!")
    end
end)

CreateButton("Restore Normal Size", function()
    if State.character then
        player.Character = nil
        player.Character = State.character
        print(" Size restored! (rejoin if broken)")
    end
end)

CreateSection(" RGB GUI THEME")

CreateToggle("RGB GUI Background", false, function(value)
    if value then
        spawn(function()
            while value do
                MainFrame.BackgroundColor3 = Color3.fromHSV(tick() % 5 / 5, 0.3, 0.2)
                TopBar.BackgroundColor3 = Color3.fromHSV(tick() % 5 / 5, 0.5, 0.3)
                wait(0.05)
            end
            MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            TopBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        end)
    end
end)

CreateSection(" VISUAL DISPLAY")

CreateToggle("Speed Display", false, function(value)
    State.speedDisplay = value
end)

CreateToggle("Trails", false, function(value)
    State.trails = value
end)

--  NEW ULTIMATE FEATURES 

CreateSection(" REALITY BREAKING")

CreateToggle(" Portal Gun", false, function(value)
    State.portalsEnabled = value
    
    if value then
        print(" Portal Gun activated! Click to place portals!")
        print("LEFT CLICK = Orange Portal | RIGHT CLICK = Blue Portal")
    else
        if State.orangePortal then State.orangePortal:Destroy() end
        if State.bluePortal then State.bluePortal:Destroy() end
        State.orangePortal = nil
        State.bluePortal = nil
        print(" Portals destroyed!")
    end
end)

CreateButton("Clear All Portals", function()
    if State.orangePortal then State.orangePortal:Destroy() end
    if State.bluePortal then State.bluePortal:Destroy() end
    State.orangePortal = nil
    State.bluePortal = nil
    print(" All portals cleared!")
end)

local function createPortal(position, color, isOrange)
    local portal = Instance.new("Part")
    portal.Name = isOrange and "OrangePortal" or "BluePortal"
    portal.Size = Vector3.new(6, 10, 0.5)
    portal.Position = position
    portal.Anchored = true
    portal.CanCollide = false
    portal.Material = Enum.Material.Neon
    portal.Color = color
    portal.Transparency = 0.3
    portal.Parent = workspace
    
    local light = Instance.new("PointLight")
    light.Color = color
    light.Brightness = 5
    light.Range = 20
    light.Parent = portal
    
    local particles = Instance.new("ParticleEmitter")
    particles.Texture = "rbxasset://textures/particles/sparkles_main.dds"
    particles.Rate = 50
    particles.Lifetime = NumberRange.new(1, 2)
    particles.Speed = NumberRange.new(5, 10)
    particles.SpreadAngle = Vector2.new(180, 180)
    particles.Color = ColorSequence.new(color)
    particles.LightEmission = 1
    particles.Parent = portal
    
    spawn(function()
        while portal.Parent do
            portal.CFrame = portal.CFrame * CFrame.Angles(0, math.rad(2), 0)
            wait()
        end
    end)
    
    return portal
end

mouse.Button1Down:Connect(function()
    if State.portalsEnabled and mouse.Target then
        local hitPos = mouse.Hit.Position
        
        if State.orangePortal then
            State.orangePortal:Destroy()
        end
        
        State.orangePortal = createPortal(hitPos + Vector3.new(0, 5, 0), PORTAL_ORANGE, true)
        print(" Orange portal placed!")
    end
end)

mouse.Button2Down:Connect(function()
    if State.portalsEnabled and mouse.Target then
        local hitPos = mouse.Hit.Position
        
        if State.bluePortal then
            State.bluePortal:Destroy()
        end
        
        State.bluePortal = createPortal(hitPos + Vector3.new(0, 5, 0), PORTAL_BLUE, false)
        print(" Blue portal placed!")
    end
end)

spawn(function()
    while true do
        if State.portalsEnabled and State.orangePortal and State.bluePortal and State.hrp then
            local distToOrange = (State.hrp.Position - State.orangePortal.Position).Magnitude
            if distToOrange < 5 then
                for i = 1, 10 do
                    local effect = Instance.new("Part")
                    effect.Size = Vector3.new(1, 1, 1)
                    effect.Position = State.hrp.Position
                    effect.Anchored = true
                    effect.CanCollide = false
                    effect.Material = Enum.Material.Neon
                    effect.Color = PORTAL_ORANGE
                    effect.Transparency = 0.5
                    effect.Shape = Enum.PartType.Ball
                    effect.Parent = workspace
                    
                    spawn(function()
                        for j = 1, 10 do
                            effect.Size = effect.Size + Vector3.new(0.5, 0.5, 0.5)
                            effect.Transparency = effect.Transparency + 0.05
                            wait(0.05)
                        end
                        effect:Destroy()
                    end)
                end
                
                State.hrp.CFrame = CFrame.new(State.bluePortal.Position + Vector3.new(0, 3, 0))
                print(" *PORTAL SOUND* WHOOSH!")
                wait(1)
            end
            
            local distToBlue = (State.hrp.Position - State.bluePortal.Position).Magnitude
            if distToBlue < 5 then
                for i = 1, 10 do
                    local effect = Instance.new("Part")
                    effect.Size = Vector3.new(1, 1, 1)
                    effect.Position = State.hrp.Position
                    effect.Anchored = true
                    effect.CanCollide = false
                    effect.Material = Enum.Material.Neon
                    effect.Color = PORTAL_BLUE
                    effect.Transparency = 0.5
                    effect.Shape = Enum.PartType.Ball
                    effect.Parent = workspace
                    
                    spawn(function()
                        for j = 1, 10 do
                            effect.Size = effect.Size + Vector3.new(0.5, 0.5, 0.5)
                            effect.Transparency = effect.Transparency + 0.05
                            wait(0.05)
                        end
                        effect:Destroy()
                    end)
                end
                
                State.hrp.CFrame = CFrame.new(State.orangePortal.Position + Vector3.new(0, 3, 0))
                print(" *PORTAL SOUND* WHOOSH!")
                wait(1)
            end
        end
        wait(0.1)
    end
end)

CreateSection(" CLONE ARMY")

CreateToggle(" Ghost Clone Army (10 Clones)", false, function(value)
    State.ghostClones = value
    
    if not value then
        for _, clone in pairs(State.cloneTable) do
            if clone then clone:Destroy() end
        end
        State.cloneTable = {}
        print(" Clones destroyed!")
    else
        print(" Ghost Clone Army activated!")
    end
end)

local clonePositions = {}
local maxCloneHistory = 50

spawn(function()
    while true do
        if State.ghostClones and State.character and State.hrp then
            table.insert(clonePositions, 1, {
                pos = State.hrp.Position,
                cf = State.hrp.CFrame
            })
            
            if #clonePositions > maxCloneHistory then
                table.remove(clonePositions)
            end
            
            for i = 1, 10 do
                local delay = i * 5
                
                if clonePositions[delay] then
                    if not State.cloneTable[i] then
                        local clone = State.character:Clone()
                        clone.Name = "GhostClone" .. i
                        
                        for _, part in pairs(clone:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.Transparency = 0.7
                                part.Material = Enum.Material.Neon
                                part.CanCollide = false
                                part.Anchored = false
                                part.Color = Color3.fromHSV((i / 10), 1, 1)
                            end
                            if part:IsA("Decal") or part:IsA("Face") then
                                part:Destroy()
                            end
                        end
                        
                        for _, script in pairs(clone:GetDescendants()) do
                            if script:IsA("Script") or script:IsA("LocalScript") then
                                script:Destroy()
                            end
                        end
                        
                        clone.Parent = workspace
                        State.cloneTable[i] = clone
                    end
                    
                    if State.cloneTable[i] and State.cloneTable[i]:FindFirstChild("HumanoidRootPart") then
                        State.cloneTable[i].HumanoidRootPart.CFrame = clonePositions[delay].cf
                    end
                end
            end
        else
            for _, clone in pairs(State.cloneTable) do
                if clone then clone:Destroy() end
            end
            State.cloneTable = {}
            clonePositions = {}
        end
        wait(0.1)
    end
end)

CreateSection(" POWER EFFECTS")

CreateToggle(" Lightning Hands", false, function(value)
    State.lightningHands = value
    print(" Lightning Hands:", value and "ON" or "OFF")
end)

spawn(function()
    while true do
        if State.lightningHands and State.character then
            local leftHand = State.character:FindFirstChild("Left Arm") or State.character:FindFirstChild("LeftHand")
            local rightHand = State.character:FindFirstChild("Right Arm") or State.character:FindFirstChild("RightHand")
            
            if leftHand and rightHand then
                local nearestPlayer = nil
                local nearestDist = 50
                
                for _, plr in pairs(Players:GetPlayers()) do
                    if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                        local dist = (plr.Character.HumanoidRootPart.Position - State.hrp.Position).Magnitude
                        if dist < nearestDist then
                            nearestDist = dist
                            nearestPlayer = plr
                        end
                    end
                end
                
                if nearestPlayer and (nearestPlayer.Character:FindFirstChild("Torso") or nearestPlayer.Character:FindFirstChild("UpperTorso")) then
                    local targetPart = nearestPlayer.Character:FindFirstChild("Torso") or nearestPlayer.Character:FindFirstChild("UpperTorso")
                    
                    local lightning = Instance.new("Part")
                    lightning.Size = Vector3.new(0.2, (leftHand.Position - targetPart.Position).Magnitude, 0.2)
                    lightning.Position = (leftHand.Position + targetPart.Position) / 2
                    lightning.CFrame = CFrame.new(lightning.Position, targetPart.Position)
                    lightning.Anchored = true
                    lightning.CanCollide = false
                    lightning.Material = Enum.Material.Neon
                    lightning.Color = Color3.fromRGB(135, 206, 250)
                    lightning.Transparency = 0.3
                    lightning.Parent = workspace
                    
                    local light = Instance.new("PointLight")
                    light.Color = Color3.fromRGB(135, 206, 250)
                    light.Brightness = 10
                    light.Range = 20
                    light.Parent = lightning
                    
                    game:GetService("Debris"):AddItem(lightning, 0.1)
                end
                
                local lightning2 = Instance.new("Part")
                lightning2.Size = Vector3.new(0.2, (leftHand.Position - rightHand.Position).Magnitude, 0.2)
                lightning2.Position = (leftHand.Position + rightHand.Position) / 2
                lightning2.CFrame = CFrame.new(lightning2.Position, rightHand.Position)
                lightning2.Anchored = true
                lightning2.CanCollide = false
                lightning2.Material = Enum.Material.Neon
                lightning2.Color = Color3.fromRGB(255, 255, 255)
                lightning2.Transparency = 0.2
                lightning2.Parent = workspace
                
                spawn(function()
                    for i = 1, 5 do
                        lightning2.Transparency = math.random(0, 80) / 100
                        lightning2.Color = Color3.fromRGB(
                            math.random(200, 255),
                            math.random(200, 255),
                            math.random(200, 255)
                        )
                        wait(0.02)
                    end
                    lightning2:Destroy()
                end)
            end
        end
        wait(0.2)
    end
end)

CreateToggle(" Tornado Around You", false, function(value)
    State.tornadoActive = value
    print(" Tornado:", value and "ACTIVE" or "OFF")
end)

spawn(function()
    while true do
        if State.tornadoActive and State.hrp then
            for i = 1, 8 do
                local angle = (i / 8) * math.pi * 2
                local radius = 5
                local height = math.sin(tick() * 2 + i) * 3
                
                local tornPart = Instance.new("Part")
                tornPart.Size = Vector3.new(1, 2, 1)
                tornPart.Position = State.hrp.Position + Vector3.new(
                    math.cos(angle + tick() * 2) * radius,
                    height,
                    math.sin(angle + tick() * 2) * radius
                )
                tornPart.Anchored = true
                tornPart.CanCollide = false
                tornPart.Material = Enum.Material.Neon
                tornPart.Color = Color3.fromRGB(200, 200, 200)
                tornPart.Transparency = 0.5
                tornPart.Parent = workspace
                
                game:GetService("Debris"):AddItem(tornPart, 0.1)
            end
            
            if math.random(1, 2) == 1 then
                local debris = Instance.new("Part")
                debris.Size = Vector3.new(
                    math.random(1, 3),
                    math.random(1, 3),
                    math.random(1, 3)
                )
                debris.Position = State.hrp.Position + Vector3.new(
                    math.random(-10, 10),
                    math.random(0, 10),
                    math.random(-10, 10)
                )
                debris.Anchored = false
                debris.CanCollide = false
                debris.Material = Enum.Material.Neon
                debris.Color = Color3.fromRGB(
                    math.random(100, 255),
                    math.random(100, 255),
                    math.random(100, 255)
                )
                debris.Parent = workspace
                
                local spin = Instance.new("BodyAngularVelocity")
                spin.AngularVelocity = Vector3.new(
                    math.random(-10, 10),
                    math.random(-10, 10),
                    math.random(-10, 10)
                )
                spin.MaxTorque = Vector3.new(5000, 5000, 5000)
                spin.Parent = debris
                
                game:GetService("Debris"):AddItem(debris, 3)
            end
        end
        wait(0.05)
    end
end)

CreateSection(" TRAIL EFFECTS")

CreateToggle(" Fire Trail (Extreme)", false, function(value)
    State.fireTrail = value
    print(" Fire Trail:", value and "BURNING" or "OFF")
end)

spawn(function()
    while true do
        if State.fireTrail and State.hrp then
            local fire = Instance.new("Part")
            fire.Size = Vector3.new(6, 1, 6)
            fire.Position = State.hrp.Position - Vector3.new(0, 3, 0)
            fire.Anchored = true
            fire.CanCollide = false
            fire.Material = Enum.Material.Neon
            fire.Color = Color3.fromRGB(255, math.random(50, 150), 0)
            fire.Transparency = 0.4
            fire.Parent = workspace
            
            local smoke = Instance.new("Part")
            smoke.Size = Vector3.new(4, 8, 4)
            smoke.Position = State.hrp.Position + Vector3.new(0, 4, 0)
            smoke.Anchored = true
            smoke.CanCollide = false
            smoke.Material = Enum.Material.ForceField
            smoke.Color = Color3.fromRGB(50, 50, 50)
            smoke.Transparency = 0.7
            smoke.Parent = workspace
            
            for i = 1, 3 do
                local wave = Instance.new("Part")
                wave.Size = Vector3.new(2, 0.1, 2)
                wave.Position = fire.Position + Vector3.new(0, i, 0)
                wave.Anchored = true
                wave.CanCollide = false
                wave.Material = Enum.Material.ForceField
                wave.Color = Color3.fromRGB(255, 200, 0)
                wave.Transparency = 0.8
                wave.Parent = workspace
                
                game:GetService("Debris"):AddItem(wave, 0.5)
            end
            
            game:GetService("Debris"):AddItem(fire, 2)
            game:GetService("Debris"):AddItem(smoke, 3)
        end
        wait(0.3)
    end
end)

CreateSection(" SPECIAL POWERS")

CreateToggle(" Auto Fireworks", false, function(value)
    State.fireworks = value
    print(" Fireworks:", value and "LAUNCHING" or "OFF")
end)

spawn(function()
    while true do
        if State.fireworks and State.hrp then
            local firework = Instance.new("Part")
            firework.Size = Vector3.new(1, 1, 1)
            firework.Position = State.hrp.Position + Vector3.new(
                math.random(-20, 20),
                20,
                math.random(-20, 20)
            )
            firework.Anchored = true
            firework.CanCollide = false
            firework.Material = Enum.Material.Neon
            firework.Color = Color3.fromRGB(
                math.random(0, 255),
                math.random(0, 255),
                math.random(0, 255)
            )
            firework.Shape = Enum.PartType.Ball
            firework.Parent = workspace
            
            local light = Instance.new("PointLight")
            light.Color = firework.Color
            light.Brightness = 10
            light.Range = 30
            light.Parent = firework
            
            for i = 1, 20 do
                local spark = Instance.new("Part")
                spark.Size = Vector3.new(0.5, 0.5, 0.5)
                spark.Position = firework.Position
                spark.Anchored = false
                spark.CanCollide = false
                spark.Material = Enum.Material.Neon
                spark.Color = firework.Color
                spark.Shape = Enum.PartType.Ball
                spark.Parent = workspace
                
                local bv = Instance.new("BodyVelocity")
                bv.Velocity = Vector3.new(
                    math.random(-30, 30),
                    math.random(-30, 30),
                    math.random(-30, 30)
                )
                bv.MaxForce = Vector3.new(5000, 5000, 5000)
                bv.Parent = spark
                
                game:GetService("Debris"):AddItem(spark, 2)
            end
            
            game:GetService("Debris"):AddItem(firework, 0.5)
        end
        wait(1)
    end
end)

CreateToggle(" Star Power (Invincible)", false, function(value)
    State.starPower = value
    print(" Star Power:", value and "INVINCIBLE!" or "OFF")
end)

spawn(function()
    while true do
        if State.starPower and State.character then
            if State.humanoid and State.humanoid.Health < State.humanoid.MaxHealth then
                State.humanoid.Health = State.humanoid.MaxHealth
            end
            
            local shield = Instance.new("Part")
            shield.Size = Vector3.new(8, 8, 8)
            shield.Position = State.hrp.Position
            shield.Anchored = true
            shield.CanCollide = false
            shield.Material = Enum.Material.ForceField
            shield.Color = Color3.fromHSV((tick() * 2) % 1, 0.5, 1)
            shield.Transparency = 0.8
            shield.Shape = Enum.PartType.Ball
            shield.Parent = workspace
            
            game:GetService("Debris"):AddItem(shield, 0.1)
        end
        wait(0.1)
    end
end)

CreateSection(" CHAOS MODE")

CreateToggle(" Chaos Randomizer", false, function(value)
    State.chaosMode = value
    print(" Chaos Mode:", value and "ACTIVATED!" or "OFF")
end)

spawn(function()
    while true do
        if State.chaosMode and State.hrp and State.humanoid then
            local effect = math.random(1, 5)
            
            if effect == 1 then
                State.hrp.CFrame = State.hrp.CFrame + Vector3.new(
                    math.random(-20, 20),
                    math.random(-10, 10),
                    math.random(-20, 20)
                )
                print(" Random Teleport!")
            elseif effect == 2 then
                for _, part in pairs(State.character:GetDescendants()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                        part.Size = part.Size * math.random(50, 200) / 100
                    end
                end
                print(" Random Size Change!")
            elseif effect == 3 then
                State.humanoid.WalkSpeed = math.random(50, 150)
                print(" Random Speed Boost!")
            elseif effect == 4 then
                for _, part in pairs(State.character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.Color = Color3.fromRGB(
                            math.random(0, 255),
                            math.random(0, 255),
                            math.random(0, 255)
                        )
                    end
                end
                print(" Random Colors!")
            else
                State.humanoid.JumpPower = math.random(100, 300)
                State.humanoid.Jump = true
                print(" Random Super Jump!")
            end
        end
        wait(5)
    end
end)

CreateToggle(" Black Hole Effect", false, function(value)
    State.blackHole = value
    print(" Black Hole:", value and "ACTIVE!" or "OFF")
end)

spawn(function()
    while true do
        if State.blackHole and State.hrp then
            local hole = Instance.new("Part")
            hole.Size = Vector3.new(8, 8, 8)
            hole.Position = State.hrp.Position
            hole.Anchored = true
            hole.CanCollide = false
            hole.Material = Enum.Material.Neon
            hole.Color = Color3.fromRGB(0, 0, 0)
            hole.Transparency = 0.3
            hole.Shape = Enum.PartType.Ball
            hole.Parent = workspace
            
            spawn(function()
                for i = 1, 10 do
                    hole.Size = hole.Size + Vector3.new(0.5, 0.5, 0.5)
                    hole.Transparency = hole.Transparency + 0.07
                    hole.CFrame = hole.CFrame * CFrame.Angles(
                        math.rad(10),
                        math.rad(10),
                        math.rad(10)
                    )
                    wait(0.05)
                end
                hole:Destroy()
            end)
            
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and obj.Name ~= "HumanoidRootPart" and not obj.Anchored then
                    local distance = (obj.Position - State.hrp.Position).Magnitude
                    
                    if distance < 20 and distance > 3 then
                        local bv = obj:FindFirstChild("BlackHoleForce")
                        if not bv then
                            bv = Instance.new("BodyVelocity")
                            bv.Name = "BlackHoleForce"
                            bv.MaxForce = Vector3.new(1000, 1000, 1000)
                            bv.Parent = obj
                        end
                        
                        local direction = (State.hrp.Position - obj.Position).Unit
                        local force = 50 / distance
                        bv.Velocity = direction * force
                        
                        game:GetService("Debris"):AddItem(bv, 0.2)
                    end
                end
            end
        end
        wait(0.3)
    end
end)

CreateSection(" ULTIMATE MODE")

CreateButton(" ULTIMATE FINALE (ALL AT ONCE!)", function()
    State.ultimateFinale = not State.ultimateFinale
    
    if State.ultimateFinale then
        State.portalsEnabled = true
        State.ghostClones = true
        State.lightningHands = true
        State.tornadoActive = true
        State.fireTrail = true
        State.fireworks = true
        State.starPower = true
        State.blackHole = true
        State.rgbCharacter = true
        State.rgbTrail = true
        State.auraEffect = true
        State.lightningStrike = true
        
        print("")
        print(" ULTIMATE FINALE ACTIVATED! ")
        print(" ALL EFFECTS ARE NOW ACTIVE! ")
        print(" YOU ARE NOW AN UNSTOPPABLE GOD! ")
        print(" REALITY ITSELF BENDS TO YOUR WILL! ")
        print("")
    else
        State.portalsEnabled = false
        State.ghostClones = false
        State.lightningHands = false
        State.tornadoActive = false
        State.fireTrail = false
        State.fireworks = false
        State.starPower = false
        State.blackHole = false
        State.rgbCharacter = false
        State.rgbTrail = false
        State.auraEffect = false
        State.lightningStrike = false
        
        print(" Ultimate Finale deactivated - Effects stopped")
    end
end)

spawn(function()
    while true do
        if State.ultimateFinale then
            if workspace.CurrentCamera then
                workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame * CFrame.Angles(
                    math.rad(math.random(-1, 1)),
                    math.rad(math.random(-1, 1)),
                    math.rad(math.random(-1, 1))
                )
            end
            
            local screenEffect = Instance.new("Frame")
            screenEffect.Size = UDim2.new(1, 20, 1, 20)
            screenEffect.Position = UDim2.new(0, -10, 0, -10)
            screenEffect.BackgroundColor3 = Color3.fromHSV((tick() * 3) % 1, 1, 1)
            screenEffect.BackgroundTransparency = 0.7
            screenEffect.BorderSizePixel = 0
            screenEffect.ZIndex = 1000
            screenEffect.Parent = ScreenGui
            
            spawn(function()
                local tween = TweenService:Create(
                    screenEffect,
                    TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true),
                    {BackgroundTransparency = 0.9}
                )
                tween:Play()
                wait(2)
                screenEffect:Destroy()
            end)
        end
        wait(2)
    end
end)

CreateSection(" TELEPORT")

CreateToggle("Click Teleport", false, function(value)
    State.clickTP = value
    print("Click TP:", value)
end)

CreateButton("Teleport to Random Player", function()
    local players = Players:GetPlayers()
    if #players > 1 then
        local randomPlayer = players[math.random(1, #players)]
        if randomPlayer ~= player and randomPlayer.Character and randomPlayer.Character:FindFirstChild("HumanoidRootPart") then
            if State.hrp then
                State.hrp.CFrame = randomPlayer.Character.HumanoidRootPart.CFrame
                print(" Teleported to:", randomPlayer.Name)
            end
        end
    end
end)

-- Click TP Handler
mouse.Button1Down:Connect(function()
    if State.clickTP and not State.portalsEnabled and mouse.Target then
        if State.hrp then
            State.hrp.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0, 3, 0))
        end
    end
end)

-- Flight System
local flyConnection
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.F then
        State.flying = not State.flying
        FlyToggle.SetValue(State.flying)
        
        if State.flying then
            local bg = Instance.new("BodyGyro")
            bg.P = 9e4
            bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
            bg.cframe = State.hrp.CFrame
            bg.Parent = State.hrp
            
            local bv = Instance.new("BodyVelocity")
            bv.velocity = Vector3.new(0, 0.1, 0)
            bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
            bv.Parent = State.hrp
            
            flyConnection = RunService.Heartbeat:Connect(function()
                if State.flying and State.hrp then
                    local cam = workspace.CurrentCamera
                    bg.cframe = cam.CFrame
                    
                    local speed = State.flySpeed
                    local moveDirection = Vector3.new(0, 0, 0)
                    
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                        moveDirection = moveDirection + (cam.CFrame.LookVector)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                        moveDirection = moveDirection - (cam.CFrame.LookVector)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                        moveDirection = moveDirection - (cam.CFrame.RightVector)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                        moveDirection = moveDirection + (cam.CFrame.RightVector)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                        moveDirection = moveDirection + Vector3.new(0, 1, 0)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                        moveDirection = moveDirection - Vector3.new(0, 1, 0)
                    end
                    
                    bv.velocity = moveDirection.Unit * speed
                else
                    if bg then bg:Destroy() end
                    if bv then bv:Destroy() end
                    if flyConnection then flyConnection:Disconnect() end
                end
            end)
        else
            if flyConnection then
                flyConnection:Disconnect()
            end
            for _, obj in pairs(State.hrp:GetChildren()) do
                if obj:IsA("BodyGyro") or obj:IsA("BodyVelocity") then
                    obj:Destroy()
                end
            end
        end
    end
end)

-- NoClip System
RunService.Stepped:Connect(function()
    if State.noClip and State.character then
        for _, part in pairs(State.character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- Infinite Jump
UserInputService.JumpRequest:Connect(function()
    if State.infiniteJump and State.humanoid then
        State.humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- ESP System
local function createESP(player)
    if not player.Character or not player.Character:FindFirstChild("Head") then return end
    
    local head = player.Character.Head
    local existing = head:FindFirstChild("ESPGui")
    if existing then existing:Destroy() end
    
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESPGui"
    billboard.Adornee = head
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = head
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = player.Name
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextStrokeTransparency = 0
    nameLabel.TextSize = 14
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.Parent = billboard
    
    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distLabel.Position = UDim2.new(0, 0, 0.5, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
    distLabel.TextStrokeTransparency = 0
    distLabel.TextSize = 12
    distLabel.Font = Enum.Font.Gotham
    distLabel.Parent = billboard
    
    local connection = RunService.RenderStepped:Connect(function()
        if State.esp and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and State.hrp then
            local distance = (player.Character.HumanoidRootPart.Position - State.hrp.Position).Magnitude
            distLabel.Text = math.floor(distance) .. " studs"
        else
            billboard:Destroy()
            connection:Disconnect()
        end
    end)
    
    table.insert(State.espConnections, connection)
end

spawn(function()
    while true do
        if State.esp then
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= Players.LocalPlayer then
                    createESP(player)
                end
            end
        end
        wait(2)
    end
end)

-- RGB Character Effect
spawn(function()
    while true do
        if State.rgbCharacter and State.character then
            for _, part in pairs(State.character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
                    part.Material = Enum.Material.Neon
                end
            end
        end
        wait(0.1)
    end
end)

-- RGB Trail Effect
spawn(function()
    while true do
        if State.rgbTrail and State.hrp then
            for i = 1, 5 do
                local trail = Instance.new("Part")
                trail.Size = Vector3.new(2, 2, 2)
                trail.Position = State.hrp.Position - Vector3.new(0, 2, 0)
                trail.Anchored = true
                trail.CanCollide = false
                trail.Material = Enum.Material.Neon
                trail.Color = Color3.fromHSV((tick() + i * 0.1) % 5 / 5, 1, 1)
                trail.Transparency = 0.5
                trail.Shape = Enum.PartType.Ball
                trail.Parent = workspace
                
                spawn(function()
                    for j = 1, 20 do
                        trail.Size = trail.Size - Vector3.new(0.1, 0.1, 0.1)
                        trail.Transparency = trail.Transparency + 0.025
                        wait(0.05)
                    end
                    trail:Destroy()
                end)
            end
        end
        wait(0.2)
    end
end)

-- Speed Display
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Name = "SpeedDisplay"
SpeedLabel.Size = UDim2.new(0, 200, 0, 40)
SpeedLabel.Position = UDim2.new(0.5, -100, 0, 10)
SpeedLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
SpeedLabel.BackgroundTransparency = 0.5
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedLabel.TextSize = 18
SpeedLabel.Font = Enum.Font.GothamBold
SpeedLabel.Visible = false
SpeedLabel.Parent = ScreenGui

local SpeedCorner = Instance.new("UICorner")
SpeedCorner.CornerRadius = UDim.new(0, 8)
SpeedCorner.Parent = SpeedLabel

spawn(function()
    local lastPos = State.hrp and State.hrp.Position or Vector3.new(0, 0, 0)
    
    while true do
        if State.speedDisplay and State.hrp then
            local currentPos = State.hrp.Position
            local speed = (currentPos - lastPos).Magnitude / 0.1
            SpeedLabel.Text = " Speed: " .. math.floor(speed) .. " studs/s"
            SpeedLabel.Visible = true
            lastPos = currentPos
        else
            SpeedLabel.Visible = false
        end
        wait(0.1)
    end
end)

-- Trails Effect
spawn(function()
    while true do
        if State.trails and State.hrp then
            local trail = Instance.new("Part")
            trail.Size = Vector3.new(2, 5, 1)
            trail.Position = State.hrp.Position
            trail.Anchored = true
            trail.CanCollide = false
            trail.Material = Enum.Material.Neon
            trail.Color = Color3.fromRGB(
                math.random(100, 255),
                math.random(100, 255),
                math.random(100, 255)
            )
            trail.Transparency = 0.5
            trail.Parent = workspace
            
            spawn(function()
                for i = 1, 20 do
                    trail.Transparency = trail.Transparency + 0.025
                    wait(0.05)
                end
                trail:Destroy()
            end)
        end
        wait(0.1)
    end
end)

-- GUI Toggle
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    print(" Fun Hub closed!")
end)

MinimizeButton.MouseButton1Click:Connect(function()
    State.guiVisible = not State.guiVisible
    ContentFrame.Visible = State.guiVisible
    MainFrame.Size = State.guiVisible and UDim2.new(0, 320, 0, 450) or UDim2.new(0, 320, 0, 35)
    MinimizeButton.Text = State.guiVisible and "-" or "+"
end)

-- Update Character on Respawn
player.CharacterAdded:Connect(function(char)
    wait(0.5)
    updateCharacter()
    print(" Character respawned - Hub active!")
end)

-- Humanoid Update Loop
RunService.Heartbeat:Connect(function()
    if State.humanoid then
        State.humanoid.WalkSpeed = State.walkSpeed
        State.humanoid.JumpPower = State.jumpPower
    end
end)

-- Final Print Statements
print("")
print("")
print(" FUN HUB V1 - ULTIMATE COMPLETE EDITION ")
print("")
print("")
print(" SUCCESSFULLY LOADED!")
print("")
print(" TOTAL FEATURES: 50+")
print("")
print(" MOVEMENT FEATURES:")
print(" Flight Mode (Press F)")
print(" Custom Walk Speed")
print(" Custom Jump Power")
print(" No Clip")
print(" Infinite Jump")
print(" Click Teleport")
print("")
print(" VISION FEATURES:")
print(" ESP (Players)")
print(" Fullbright")
print(" X-Ray Vision")
print(" Night Vision")
print(" Thermal Vision")
print("")
print(" RGB EFFECTS:")
print(" RGB Character")
print(" RGB Trail Ultimate")
print(" RGB Nametag")
print(" RGB GUI Theme")
print("")
print(" ANIME EFFECTS:")
print(" Super Saiyan Aura")
print(" Lightning Strikes")
print("")
print(" SCREEN EFFECTS:")
print(" Matrix Effect")
print(" Screen Glitch")
print("")
print(" CHARACTER MORPH:")
print(" Custom Size Slider")
print(" Become Giant")
print(" Become Tiny")
print("")
print(" VISUAL DISPLAY:")
print(" Speed Display")
print(" Custom Trails")
print("")
print(" ULTIMATE INSANE FEATURES:")
print("  Portal Gun (LEFT/RIGHT CLICK!)")
print("  Ghost Clone Army (10 rainbow clones!)")
print("  Lightning Hands (Zap nearby players!)")
print("  Tornado Spawner (Spinning vortex!)")
print("  Fire Trail Inferno (Leave flames!)")
print("  Firework Launcher (Explosive effects!)")
print("  Star Power Mode (Invincible rainbow!)")
print("  Chaos Randomizer (Random every 5s!)")
print("  Black Hole Creator (Swirling void!)")
print("  ULTIMATE FINALE (ALL AT ONCE!)")
print("")
print(" PORTAL GUN CONTROLS:")
print("- LEFT CLICK = Orange Portal")
print("- RIGHT CLICK = Blue Portal")
print("- Walk through portals to teleport!")
print("")
print(" CHAOS MODE EFFECTS:")
print("- Random teleport")
print("- Random size change")
print("- Random speed boost")
print("- Random colors")
print("- Random super jump")
print("")
print(" YOU ARE NOW BEYOND LEGENDARY! ")
print(" REALITY-BENDING POWERS UNLOCKED! ")
print(" ULTIMATE GOD MODE ACTIVATED! ")
print("")
print("")

