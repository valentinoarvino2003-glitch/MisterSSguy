--[[
    Advanced Roblox Exploit GUI
    Version: 2.1 - Mobile Support
    Features: Player modifications, ESP, script executor, mobile controls
]]

-- ====================================================================================================
-- SERVICES
-- ====================================================================================================
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")

-- ====================================================================================================
-- PLAYER VARIABLES
-- ====================================================================================================
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local camera = Workspace.CurrentCamera

-- ====================================================================================================
-- MOBILE DETECTION
-- ====================================================================================================
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- ====================================================================================================
-- CONFIGURATION / STATE MANAGEMENT
-- ====================================================================================================
local Config = {
    -- General GUI
    GuiVisible = true,
    GuiPosition = UDim2.new(0.5, -200, 0.5, -175),
    GuiMinimized = false,

    -- Player & Movement
    WalkSpeed = 16,
    JumpPower = 50,
    NoclipEnabled = false,
    FlyEnabled = false,
    InfiniteJumpEnabled = false,
    FlySpeed = 20,

    -- Visuals
    PlayerESPEnabled = false,
    ShowPlayerNames = true,
    ShowPlayerHealth = true,
    ShowPlayerBoxes = true,

    -- Keybinds
    ToggleGuiKeybind = Enum.KeyCode.RightControl,

    -- Theme
    AccentColor = Color3.fromRGB(0, 170, 255),
    MainBgColor = Color3.fromRGB(35, 35, 35),
    SecondaryBgColor = Color3.fromRGB(45, 45, 45),
    AccentBgColor = Color3.fromRGB(55, 55, 55),
    TextColor = Color3.fromRGB(255, 255, 255),
    PlaceholderColor = Color3.fromRGB(150, 150, 150),
}

local Toggles = {
    Noclip = false,
    Fly = false,
    InfiniteJump = false,
    PlayerESP = false,
}

local Connections = {
    Noclip = nil,
    InfiniteJump = nil,
    Fly = nil,
    ESP = nil,
    CharacterAdded = nil,
}

local FlyBodyVelocity = nil
local ESPElements = {}

-- ====================================================================================================
-- UTILITY FUNCTIONS
-- ====================================================================================================

local function SendNotification(title, message, duration)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = title,
            Text = message,
            Duration = duration or 5,
        })
    end)
end

local function SafeExecute(code)
    if not code or #code == 0 then
        return false, "No code provided"
    end
    
    local success, result = pcall(function()
        local func, err = loadstring(code)
        if not func then
            return false, err
        end
        return func()
    end)
    
    return success, result
end

local function CleanupConnections()
    for name, connection in pairs(Connections) do
        if connection then
            connection:Disconnect()
            Connections[name] = nil
        end
    end
end

local function CleanupESP()
    for _, element in pairs(ESPElements) do
        if element and element.Parent then
            element:Destroy()
        end
    end
    ESPElements = {}
end

-- ====================================================================================================
-- GUI SETUP
-- ====================================================================================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AdvancedExploitGUI_" .. HttpService:GenerateGUID(false)
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Protection against multiple instances
if playerGui:FindFirstChild("AdvancedExploitGUI") then
    playerGui:FindFirstChild("AdvancedExploitGUI"):Destroy()
end
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 420, 0, 380)
mainFrame.Position = Config.GuiPosition
mainFrame.BackgroundColor3 = Config.MainBgColor
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

-- Add corner rounding
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 8)
mainCorner.Parent = mainFrame

-- Title Bar
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = Config.AccentColor
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 8)
titleCorner.Parent = titleBar

-- Fix corners at bottom of title bar
local titleBarFix = Instance.new("Frame")
titleBarFix.Size = UDim2.new(1, 0, 0, 8)
titleBarFix.Position = UDim2.new(0, 0, 1, -8)
titleBarFix.BackgroundColor3 = Config.AccentColor
titleBarFix.BorderSizePixel = 0
titleBarFix.Parent = titleBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -90, 1, 0)
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Advanced Exploit GUI v2.1"
titleLabel.TextColor3 = Config.TextColor
titleLabel.TextSize = 16
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

-- Minimize Button
local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "MinimizeButton"
minimizeButton.Size = UDim2.new(0, 30, 0, 30)
minimizeButton.Position = UDim2.new(1, -60, 0, 0)
minimizeButton.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
minimizeButton.BorderSizePixel = 0
minimizeButton.Text = "—"
minimizeButton.TextColor3 = Config.TextColor
minimizeButton.TextSize = 18
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.Parent = titleBar

local minimizeCorner = Instance.new("UICorner")
minimizeCorner.CornerRadius = UDim.new(0, 8)
minimizeCorner.Parent = minimizeButton

-- Close Button
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -30, 0, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeButton.BorderSizePixel = 0
closeButton.Text = "✕"
closeButton.TextColor3 = Config.TextColor
closeButton.TextSize = 18
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeButton

-- Tab Frame
local tabFrame = Instance.new("Frame")
tabFrame.Name = "TabFrame"
tabFrame.Size = UDim2.new(1, 0, 0, 35)
tabFrame.Position = UDim2.new(0, 0, 0, 30)
tabFrame.BackgroundColor3 = Config.SecondaryBgColor
tabFrame.BorderSizePixel = 0
tabFrame.Parent = mainFrame

local tabListLayout = Instance.new("UIListLayout")
tabListLayout.FillDirection = Enum.FillDirection.Horizontal
tabListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
tabListLayout.Padding = UDim.new(0, 2)
tabListLayout.Parent = tabFrame

-- Tab Content Frame
local tabContentFrame = Instance.new("Frame")
tabContentFrame.Name = "TabContentFrame"
tabContentFrame.Size = UDim2.new(1, -10, 1, -75)
tabContentFrame.Position = UDim2.new(0, 5, 0, 70)
tabContentFrame.BackgroundTransparency = 1
tabContentFrame.Parent = mainFrame

local currentActiveTab = nil
local activeTabButton = nil

-- ====================================================================================================
-- DRAGGING FUNCTIONALITY (MOBILE & PC COMPATIBLE)
-- ====================================================================================================
local dragging = false
local dragStart = Vector2.new(0, 0)
local startPos = UDim2.new(0, 0, 0, 0)
local dragInput = nil

local function updateDrag(input)
    if dragging then
        local delta = Vector2.new(input.Position.X, input.Position.Y) - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = Vector2.new(input.Position.X, input.Position.Y)
        startPos = mainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
                Config.GuiPosition = mainFrame.Position
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
        updateDrag(input)
    end
end)

-- Minimize functionality
local minimizedSize = UDim2.new(0, 420, 0, 30)
local normalSize = UDim2.new(0, 420, 0, 380)

minimizeButton.MouseButton1Click:Connect(function()
    Config.GuiMinimized = not Config.GuiMinimized
    
    if Config.GuiMinimized then
        TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            Size = minimizedSize
        }):Play()
        minimizeButton.Text = "□"
        tabFrame.Visible = false
        tabContentFrame.Visible = false
    else
        TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            Size = normalSize
        }):Play()
        minimizeButton.Text = "—"
        tabFrame.Visible = true
        tabContentFrame.Visible = true
    end
end)

closeButton.MouseButton1Click:Connect(function()
    screenGui.Enabled = false
    Config.GuiVisible = false
    SendNotification("GUI", "Press " .. (isMobile and "the toggle" or Config.ToggleGuiKeybind.Name) .. " to show GUI", 3)
end)

-- PC Keybind toggle
if not isMobile then
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == Config.ToggleGuiKeybind then
            screenGui.Enabled = not screenGui.Enabled
            Config.GuiVisible = screenGui.Enabled
        end
    end)
end

-- ====================================================================================================
-- GUI ELEMENT CREATION HELPERS
-- ====================================================================================================

local function createTab(name)
    local tabContainer = Instance.new("ScrollingFrame")
    tabContainer.Name = name .. "Tab"
    tabContainer.Size = UDim2.new(1, 0, 1, 0)
    tabContainer.BackgroundTransparency = 1
    tabContainer.BorderSizePixel = 0
    tabContainer.ScrollBarThickness = 4
    tabContainer.ScrollBarImageColor3 = Config.AccentColor
    tabContainer.Visible = false
    tabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    tabContainer.Parent = tabContentFrame

    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 8)
    layout.Parent = tabContainer

    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        tabContainer.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
    end)

    local tabButton = Instance.new("TextButton")
    tabButton.Name = name .. "TabButton"
    tabButton.Size = UDim2.new(0, 80, 1, 0)
    tabButton.BackgroundColor3 = Config.SecondaryBgColor
    tabButton.BorderSizePixel = 0
    tabButton.Text = name
    tabButton.TextColor3 = Config.TextColor
    tabButton.TextSize = 14
    tabButton.Font = Enum.Font.Gotham
    tabButton.Parent = tabFrame

    tabButton.MouseButton1Click:Connect(function()
        if currentActiveTab then
            currentActiveTab.Visible = false
        end
        if activeTabButton then
            activeTabButton.BackgroundColor3 = Config.SecondaryBgColor
        end
        
        tabContainer.Visible = true
        currentActiveTab = tabContainer
        tabButton.BackgroundColor3 = Config.AccentColor
        activeTabButton = tabButton
    end)

    return tabContainer, layout, tabButton
end

local function createToggle(parent, text, initialValue, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 35)
    frame.BackgroundColor3 = Config.SecondaryBgColor
    frame.BorderSizePixel = 0
    frame.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = frame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -50, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Text = text
    label.TextColor3 = Config.TextColor
    label.TextSize = 14
    label.Font = Enum.Font.Gotham
    label.Parent = frame

    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(0, 40, 0, 20)
    toggleButton.Position = UDim2.new(1, -45, 0.5, -10)
    toggleButton.BackgroundColor3 = initialValue and Config.AccentColor or Color3.fromRGB(70, 70, 70)
    toggleButton.BorderSizePixel = 0
    toggleButton.Text = ""
    toggleButton.Parent = frame

    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(1, 0)
    toggleCorner.Parent = toggleButton

    local toggleIndicator = Instance.new("Frame")
    toggleIndicator.Size = UDim2.new(0, 16, 0, 16)
    toggleIndicator.Position = initialValue and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
    toggleIndicator.BackgroundColor3 = Config.TextColor
    toggleIndicator.BorderSizePixel = 0
    toggleIndicator.Parent = toggleButton

    local indicatorCorner = Instance.new("UICorner")
    indicatorCorner.CornerRadius = UDim.new(1, 0)
    indicatorCorner.Parent = toggleIndicator

    local value = initialValue

    local function updateToggle()
        local targetPos = value and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
        local targetColor = value and Config.AccentColor or Color3.fromRGB(70, 70, 70)
        
        TweenService:Create(toggleIndicator, TweenInfo.new(0.2), {Position = targetPos}):Play()
        TweenService:Create(toggleButton, TweenInfo.new(0.2), {BackgroundColor3 = targetColor}):Play()
    end

    toggleButton.MouseButton1Click:Connect(function()
        value = not value
        updateToggle()
        callback(value)
    end)

    return function(newValue)
        if newValue ~= nil then
            value = newValue
            updateToggle()
        end
        return value
    end
end

local function createSlider(parent, text, min, max, initialValue, step, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 55)
    frame.BackgroundColor3 = Config.SecondaryBgColor
    frame.BorderSizePixel = 0
    frame.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = frame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 0, 20)
    label.Position = UDim2.new(0, 10, 0, 5)
    label.BackgroundTransparency = 1
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Text = text .. ": " .. tostring(initialValue)
    label.TextColor3 = Config.TextColor
    label.TextSize = 14
    label.Font = Enum.Font.Gotham
    label.Parent = frame

    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(1, -20, 0, 6)
    sliderFrame.Position = UDim2.new(0, 10, 0, 35)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    sliderFrame.BorderSizePixel = 0
    sliderFrame.Parent = frame

    local sliderCorner = Instance.new("UICorner")
    sliderCorner.CornerRadius = UDim.new(1, 0)
    sliderCorner.Parent = sliderFrame

    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new((initialValue - min) / (max - min), 0, 1, 0)
    sliderFill.BackgroundColor3 = Config.AccentColor
    sliderFill.BorderSizePixel = 0
    sliderFill.Parent = sliderFrame

    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(1, 0)
    fillCorner.Parent = sliderFill

    local sliderHandle = Instance.new("Frame")
    sliderHandle.Size = UDim2.new(0, 16, 0, 16)
    sliderHandle.Position = UDim2.new((initialValue - min) / (max - min), -8, 0.5, -8)
    sliderHandle.BackgroundColor3 = Config.TextColor
    sliderHandle.BorderSizePixel = 0
    sliderHandle.Parent = sliderFrame

    local handleCorner = Instance.new("UICorner")
    handleCorner.CornerRadius = UDim.new(1, 0)
    handleCorner.Parent = sliderHandle

    local value = initialValue
    local draggingSlider = false
    local sliderConnection = nil

    local function updateValue(inputPosition)
        local relativeX = math.clamp(inputPosition.X - sliderFrame.AbsolutePosition.X, 0, sliderFrame.AbsoluteSize.X)
        local percent = relativeX / sliderFrame.AbsoluteSize.X
        value = min + (max - min) * percent
        
        if step then
            value = math.floor(value / step + 0.5) * step
        end
        value = math.clamp(value, min, max)

        sliderFill.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
        sliderHandle.Position = UDim2.new((value - min) / (max - min), -8, 0.5, -8)
        label.Text = text .. ": " .. tostring(math.floor(value * 100) / 100)
        callback(value)
    end

    -- MOBILE & PC COMPATIBLE SLIDER
    sliderFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingSlider = true
            updateValue(input.Position)
            
            -- For touch, continuously update while touching
            sliderConnection = input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    draggingSlider = false
                    if sliderConnection then
                        sliderConnection:Disconnect()
                        sliderConnection = nil
                    end
                end
            end)
        end
    end)

    sliderFrame.InputChanged:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and draggingSlider then
            updateValue(input.Position)
        end
    end)

    -- Additional handler for better mobile support
    UserInputService.TouchMoved:Connect(function(input, gameProcessed)
        if draggingSlider and not gameProcessed then
            updateValue(input.Position)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingSlider = false
            if sliderConnection then
                sliderConnection:Disconnect()
                sliderConnection = nil
            end
        end
    end)

    return function(newValue)
        if newValue ~= nil then
            value = math.clamp(newValue, min, max)
            sliderFill.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
            sliderHandle.Position = UDim2.new((value - min) / (max - min), -8, 0.5, -8)
            label.Text = text .. ": " .. tostring(math.floor(value * 100) / 100)
        end
        return value
    end
end

local function createButton(parent, text, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 35)
    button.BackgroundColor3 = Config.AccentBgColor
    button.BorderSizePixel = 0
    button.Text = text
    button.TextColor3 = Config.TextColor
    button.TextSize = 14
    button.Font = Enum.Font.Gotham
    button.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button

    button.MouseButton1Click:Connect(callback)

    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.15), {BackgroundColor3 = Config.AccentColor}):Play()
    end)

    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.15), {BackgroundColor3 = Config.AccentBgColor}):Play()
    end)

    return button
end

-- ====================================================================================================
-- CHARACTER MANAGEMENT
-- ====================================================================================================

local function onCharacterAdded(character)
    local humanoid = character:WaitForChild("Humanoid", 5)
    if humanoid then
        humanoid.WalkSpeed = Config.WalkSpeed
        humanoid.JumpPower = Config.JumpPower
    end
end

if Connections.CharacterAdded then
    Connections.CharacterAdded:Disconnect()
end
Connections.CharacterAdded = player.CharacterAdded:Connect(onCharacterAdded)

if player.Character then
    onCharacterAdded(player.Character)
end

-- ====================================================================================================
-- TABS & THEIR CONTENT
-- ====================================================================================================

-- 1. PLAYER TAB
local playerTab, playerLayout, playerTabButton = createTab("Player")

createSlider(playerTab, "WalkSpeed", 16, 200, Config.WalkSpeed, 1, function(value)
    Config.WalkSpeed = value
    local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = value
    end
end)

createSlider(playerTab, "JumpPower", 50, 500, Config.JumpPower, 1, function(value)
    Config.JumpPower = value
    local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.JumpPower = value
    end
end)

local noclipToggle = createToggle(playerTab, "Noclip", Config.NoclipEnabled, function(enabled)
    Toggles.Noclip = enabled
    
    if enabled then
        Connections.Noclip = RunService.Stepped:Connect(function()
            local character = player.Character
            if character then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
        SendNotification("Noclip", "Enabled", 2)
    else
        if Connections.Noclip then
            Connections.Noclip:Disconnect()
            Connections.Noclip = nil
        end
        
        local character = player.Character
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
        SendNotification("Noclip", "Disabled", 2)
    end
end)

local flyToggle = createToggle(playerTab, "Fly", Config.FlyEnabled, function(enabled)
    Toggles.Fly = enabled
    local character = player.Character
    local hrp = character and character:FindFirstChild("HumanoidRootPart")
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")

    if not character or not hrp or not humanoid then
        SendNotification("Fly", "Character not found", 3)
        flyToggle(false)
        return
    end

    if enabled then
        FlyBodyVelocity = Instance.new("BodyVelocity")
        FlyBodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        FlyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
        FlyBodyVelocity.Parent = hrp

        Connections.Fly = RunService.RenderStepped:Connect(function()
            if not hrp or not hrp.Parent then
                flyToggle(false)
                return
            end

            local moveVector = Vector3.new(0, 0, 0)
            local speed = Config.FlySpeed

            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                moveVector = moveVector + (camera.CFrame.LookVector * speed)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                moveVector = moveVector - (camera.CFrame.LookVector * speed)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                moveVector = moveVector - (camera.CFrame.RightVector * speed)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                moveVector = moveVector + (camera.CFrame.RightVector * speed)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                moveVector = moveVector + Vector3.new(0, speed, 0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                moveVector = moveVector - Vector3.new(0, speed, 0)
            end

            FlyBodyVelocity.Velocity = moveVector
            hrp.CFrame = CFrame.new(hrp.Position, hrp.Position + camera.CFrame.LookVector)
        end)
        
        SendNotification("Fly", "Enabled (WASD + Space/Shift)", 2)
    else
        if Connections.Fly then
            Connections.Fly:Disconnect()
            Connections.Fly = nil
        end
        if FlyBodyVelocity then
            FlyBodyVelocity:Destroy()
            FlyBodyVelocity = nil
        end
        SendNotification("Fly", "Disabled", 2)
    end
end)

createSlider(playerTab, "Fly Speed", 1, 100, Config.FlySpeed, 1, function(value)
    Config.FlySpeed = value
end)

createToggle(playerTab, "Infinite Jump", Config.InfiniteJumpEnabled, function(enabled)
    Toggles.InfiniteJump = enabled
    
    if enabled then
        Connections.InfiniteJump = UserInputService.JumpRequest:Connect(function()
            local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
        SendNotification("Infinite Jump", "Enabled", 2)
    else
        if Connections.InfiniteJump then
            Connections.InfiniteJump:Disconnect()
            Connections.InfiniteJump = nil
        end
        SendNotification("Infinite Jump", "Disabled", 2)
    end
end)

createButton(playerTab, "Reset Character", function()
    if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
        player.Character.Humanoid.Health = 0
    end
end)

-- 2. VISUALS TAB
local visualsTab, visualsLayout, visualsTabButton = createTab("Visuals")

local playerESPToggle = createToggle(visualsTab, "Player ESP", Config.PlayerESPEnabled, function(enabled)
    Toggles.PlayerESP = enabled
    
    if enabled then
        Connections.ESP = RunService.RenderStepped:Connect(function()
            CleanupESP()

            for _, targetPlayer in pairs(Players:GetPlayers()) do
                if targetPlayer ~= player and targetPlayer.Character then
                    local char = targetPlayer.Character
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    local head = char:FindFirstChild("Head")
                    local humanoid = char:FindFirstChildOfClass("Humanoid")

                    if hrp and head and humanoid and humanoid.Health > 0 then
                        local screenPos, onScreen = camera:WorldToScreenPoint(hrp.Position)
                        
                        if onScreen then
                            -- Box ESP
                            if Config.ShowPlayerBoxes then
                                local headPos = camera:WorldToScreenPoint(head.Position + Vector3.new(0, 0.5, 0))
                                local legPos = camera:WorldToScreenPoint(hrp.Position - Vector3.new(0, 3, 0))
                                
                                local height = math.abs(headPos.Y - legPos.Y)
                                local width = height / 2

                                local box = Instance.new("Frame")
                                box.Size = UDim2.new(0, width, 0, height)
                                box.Position = UDim2.new(0, screenPos.X - width/2, 0, screenPos.Y - height/2)
                                box.BackgroundTransparency = 1
                                box.BorderSizePixel = 2
                                box.BorderColor3 = Config.AccentColor
                                box.ZIndex = 10
                                box.Parent = screenGui
                                table.insert(ESPElements, box)
                            end

                            -- Name ESP
                            if Config.ShowPlayerNames then
                                local nameLabel = Instance.new("TextLabel")
                                nameLabel.Size = UDim2.new(0, 200, 0, 20)
                                nameLabel.Position = UDim2.new(0, screenPos.X - 100, 0, screenPos.Y - 40)
                                nameLabel.BackgroundTransparency = 1
                                nameLabel.Text = targetPlayer.Name
                                nameLabel.TextColor3 = Config.TextColor
                                nameLabel.TextStrokeTransparency = 0.5
                                nameLabel.TextSize = 14
                                nameLabel.Font = Enum.Font.GothamBold
                                nameLabel.ZIndex = 10
                                nameLabel.Parent = screenGui
                                table.insert(ESPElements, nameLabel)
                            end

                            -- Health Bar ESP
                            if Config.ShowPlayerHealth then
                                local healthPercent = humanoid.Health / humanoid.MaxHealth
                                
                                local healthBarBg = Instance.new("Frame")
                                healthBarBg.Size = UDim2.new(0, 50, 0, 6)
                                healthBarBg.Position = UDim2.new(0, screenPos.X - 25, 0, screenPos.Y + 20)
                                healthBarBg.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                                healthBarBg.BorderSizePixel = 1
                                healthBarBg.BorderColor3 = Color3.fromRGB(0, 0, 0)
                                healthBarBg.ZIndex = 10
                                healthBarBg.Parent = screenGui
                                table.insert(ESPElements, healthBarBg)

                                local healthBarFill = Instance.new("Frame")
                                healthBarFill.Size = UDim2.new(healthPercent, 0, 1, 0)
                                healthBarFill.BackgroundColor3 = Color3.fromRGB(
                                    255 * (1 - healthPercent),
                                    255 * healthPercent,
                                    0
                                )
                                healthBarFill.BorderSizePixel = 0
                                healthBarFill.ZIndex = 11
                                healthBarFill.Parent = healthBarBg
                            end
                        end
                    end
                end
            end
        end)
        SendNotification("ESP", "Enabled", 2)
    else
        if Connections.ESP then
            Connections.ESP:Disconnect()
            Connections.ESP = nil
        end
        CleanupESP()
        SendNotification("ESP", "Disabled", 2)
    end
end)

createToggle(visualsTab, "Show Names", Config.ShowPlayerNames, function(enabled)
    Config.ShowPlayerNames = enabled
end)

createToggle(visualsTab, "Show Health", Config.ShowPlayerHealth, function(enabled)
    Config.ShowPlayerHealth = enabled
end)

createToggle(visualsTab, "Show Boxes", Config.ShowPlayerBoxes, function(enabled)
    Config.ShowPlayerBoxes = enabled
end)

createButton(visualsTab, "Fullbright", function()
    local lighting = game:GetService("Lighting")
    lighting.Ambient = Color3.new(1, 1, 1)
    lighting.Brightness = 2
    lighting.ClockTime = 14
    lighting.FogEnd = 100000
    lighting.GlobalShadows = false
    lighting.OutdoorAmbient = Color3.new(0.5, 0.5, 0.5)
    SendNotification("Fullbright", "Applied", 2)
end)

-- 3. PLAYERS TAB
local playersTab, playersLayout, playersTabButton = createTab("Players")

local playerListScrollFrame = Instance.new("ScrollingFrame")
playerListScrollFrame.Size = UDim2.new(1, 0, 1, 0)
playerListScrollFrame.BackgroundTransparency = 1
playerListScrollFrame.BorderSizePixel = 0
playerListScrollFrame.ScrollBarThickness = 4
playerListScrollFrame.ScrollBarImageColor3 = Config.AccentColor
playerListScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
playerListScrollFrame.Parent = playersTab

local playerListLayout = Instance.new("UIListLayout")
playerListLayout.SortOrder = Enum.SortOrder.Name
playerListLayout.Padding = UDim.new(0, 8)
playerListLayout.Parent = playerListScrollFrame

playerListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    playerListScrollFrame.CanvasSize = UDim2.new(0, 0, 0, playerListLayout.AbsoluteContentSize.Y + 10)
end)

local function createPlayerCard(targetPlayer)
    local card = Instance.new("Frame")
    card.Name = targetPlayer.Name
    card.Size = UDim2.new(1, 0, 0, 70)
    card.BackgroundColor3 = Config.SecondaryBgColor
    card.BorderSizePixel = 0
    card.Parent = playerListScrollFrame

    local cardCorner = Instance.new("UICorner")
    cardCorner.CornerRadius = UDim.new(0, 6)
    cardCorner.Parent = card

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, -10, 0, 20)
    nameLabel.Position = UDim2.new(0, 10, 0, 5)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.Text = targetPlayer.Name
    nameLabel.TextColor3 = Config.TextColor
    nameLabel.TextSize = 14
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.Parent = card

    local healthLabel = Instance.new("TextLabel")
    healthLabel.Size = UDim2.new(1, -10, 0, 15)
    healthLabel.Position = UDim2.new(0, 10, 0, 25)
    healthLabel.BackgroundTransparency = 1
    healthLabel.TextXAlignment = Enum.TextXAlignment.Left
    healthLabel.Text = "Health: Loading..."
    healthLabel.TextColor3 = Config.PlaceholderColor
    healthLabel.TextSize = 12
    healthLabel.Font = Enum.Font.Gotham
    healthLabel.Parent = card

    local updateConnection
    updateConnection = RunService.Heartbeat:Connect(function()
        if not targetPlayer or not targetPlayer.Parent then
            updateConnection:Disconnect()
            return
        end
        
        local char = targetPlayer.Character
        local humanoid = char and char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            healthLabel.Text = string.format("Health: %d/%d", 
                math.floor(humanoid.Health), 
                math.floor(humanoid.MaxHealth)
            )
        end
    end)

    local buttonsFrame = Instance.new("Frame")
    buttonsFrame.Size = UDim2.new(1, -10, 0, 25)
    buttonsFrame.Position = UDim2.new(0, 10, 0, 40)
    buttonsFrame.BackgroundTransparency = 1
    buttonsFrame.Parent = card

    local buttonsLayout = Instance.new("UIListLayout")
    buttonsLayout.FillDirection = Enum.FillDirection.Horizontal
    buttonsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    buttonsLayout.Padding = UDim.new(0, 5)
    buttonsLayout.Parent = buttonsFrame

    local function createActionButton(text, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 85, 1, 0)
        btn.BackgroundColor3 = Config.AccentBgColor
        btn.BorderSizePixel = 0
        btn.Text = text
        btn.TextColor3 = Config.TextColor
        btn.TextSize = 12
        btn.Font = Enum.Font.Gotham
        btn.Parent = buttonsFrame

        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 4)
        btnCorner.Parent = btn

        btn.MouseButton1Click:Connect(function()
            callback(targetPlayer)
        end)

        btn.MouseEnter:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Config.AccentColor}):Play()
        end)

        btn.MouseLeave:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Config.AccentBgColor}):Play()
        end)

        return btn
    end

    createActionButton("Teleport", function(p)
        if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and 
           player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
            SendNotification("Teleport", "Teleported to " .. p.Name, 2)
        else
            SendNotification("Error", "Character not found", 3)
        end
    end)

    createActionButton("View", function(p)
        if p.Character and p.Character:FindFirstChild("Humanoid") then
            camera.CameraSubject = p.Character.Humanoid
            SendNotification("Camera", "Viewing " .. p.Name, 2)
        end
    end)

    createActionButton("Reset View", function()
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            camera.CameraSubject = player.Character.Humanoid
            SendNotification("Camera", "Reset to self", 2)
        end
    end)

    return card
end

local function updatePlayerList()
    for _, child in pairs(playerListScrollFrame:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end

    for _, p in pairs(Players:GetPlayers()) do
        if p ~= player then
            createPlayerCard(p)
        end
    end
end

Players.PlayerAdded:Connect(updatePlayerList)
Players.PlayerRemoving:Connect(updatePlayerList)
updatePlayerList()

-- 4. SCRIPTS TAB
local scriptsTab, scriptsLayout, scriptsTabButton = createTab("Scripts")

local consoleFrame = Instance.new("Frame")
consoleFrame.Size = UDim2.new(1, 0, 0.6, 0)
consoleFrame.BackgroundColor3 = Config.SecondaryBgColor
consoleFrame.BorderSizePixel = 0
consoleFrame.Parent = scriptsTab

local consoleCorner = Instance.new("UICorner")
consoleCorner.CornerRadius = UDim.new(0, 6)
consoleCorner.Parent = consoleFrame

local consoleLabel = Instance.new("TextLabel")
consoleLabel.Size = UDim2.new(1, -10, 0, 20)
consoleLabel.Position = UDim2.new(0, 5, 0, 0)
consoleLabel.BackgroundTransparency = 1
consoleLabel.TextXAlignment = Enum.TextXAlignment.Left
consoleLabel.Text = "Console Output"
consoleLabel.TextColor3 = Config.TextColor
consoleLabel.TextSize = 14
consoleLabel.Font = Enum.Font.GothamBold
consoleLabel.Parent = consoleFrame

local consoleScroll = Instance.new("ScrollingFrame")
consoleScroll.Size = UDim2.new(1, -10, 1, -25)
consoleScroll.Position = UDim2.new(0, 5, 0, 25)
consoleScroll.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
consoleScroll.BorderSizePixel = 0
consoleScroll.ScrollBarThickness = 4
consoleScroll.ScrollBarImageColor3 = Config.AccentColor
consoleScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
consoleScroll.Parent = consoleFrame

local consoleScrollCorner = Instance.new("UICorner")
consoleScrollCorner.CornerRadius = UDim.new(0, 4)
consoleScrollCorner.Parent = consoleScroll

local consoleOutput = Instance.new("TextLabel")
consoleOutput.Size = UDim2.new(1, -10, 1, 0)
consoleOutput.Position = UDim2.new(0, 5, 0, 0)
consoleOutput.BackgroundTransparency = 1
consoleOutput.TextXAlignment = Enum.TextXAlignment.Left
consoleOutput.TextYAlignment = Enum.TextYAlignment.Top
consoleOutput.Text = "> Console initialized\n"
consoleOutput.TextColor3 = Config.TextColor
consoleOutput.TextSize = 12
consoleOutput.Font = Enum.Font.Code
consoleOutput.TextWrapped = true
consoleOutput.Parent = consoleScroll

local function appendConsole(text, prefix)
    prefix = prefix or ">"
    local timestamp = os.date("%H:%M:%S")
    consoleOutput.Text = consoleOutput.Text .. string.format("[%s] %s %s\n", timestamp, prefix, text)
    consoleScroll.CanvasPosition = Vector2.new(0, consoleOutput.TextBounds.Y)
end

local scriptInputFrame = Instance.new("Frame")
scriptInputFrame.Size = UDim2.new(1, 0, 0.3, -10)
scriptInputFrame.Position = UDim2.new(0, 0, 0.6, 10)
scriptInputFrame.BackgroundColor3 = Config.SecondaryBgColor
scriptInputFrame.BorderSizePixel = 0
scriptInputFrame.Parent = scriptsTab

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 6)
inputCorner.Parent = scriptInputFrame

local scriptInputLabel = Instance.new("TextLabel")
scriptInputLabel.Size = UDim2.new(1, -10, 0, 20)
scriptInputLabel.Position = UDim2.new(0, 5, 0, 0)
scriptInputLabel.BackgroundTransparency = 1
scriptInputLabel.TextXAlignment = Enum.TextXAlignment.Left
scriptInputLabel.Text = "Script Input"
scriptInputLabel.TextColor3 = Config.TextColor
scriptInputLabel.TextSize = 14
scriptInputLabel.Font = Enum.Font.GothamBold
scriptInputLabel.Parent = scriptInputFrame

local scriptInput = Instance.new("TextBox")
scriptInput.Size = UDim2.new(1, -10, 1, -25)
scriptInput.Position = UDim2.new(0, 5, 0, 25)
scriptInput.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
scriptInput.BorderSizePixel = 0
scriptInput.TextColor3 = Config.TextColor
scriptInput.PlaceholderText = "Enter Lua code here..."
scriptInput.PlaceholderColor3 = Config.PlaceholderColor
scriptInput.TextXAlignment = Enum.TextXAlignment.Left
scriptInput.TextYAlignment = Enum.TextYAlignment.Top
scriptInput.MultiLine = true
scriptInput.ClearTextOnFocus = false
scriptInput.Font = Enum.Font.Code
scriptInput.TextSize = 12
scriptInput.Text = ""
scriptInput.Parent = scriptInputFrame

local inputBoxCorner = Instance.new("UICorner")
inputBoxCorner.CornerRadius = UDim.new(0, 4)
inputBoxCorner.Parent = scriptInput

local buttonFrame = Instance.new("Frame")
buttonFrame.Size = UDim2.new(1, 0, 0, 35)
buttonFrame.Position = UDim2.new(0, 0, 1, -40)
buttonFrame.BackgroundTransparency = 1
buttonFrame.Parent = scriptsTab

local buttonLayout = Instance.new("UIListLayout")
buttonLayout.FillDirection = Enum.FillDirection.Horizontal
buttonLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
buttonLayout.Padding = UDim.new(0, 10)
buttonLayout.Parent = buttonFrame

local executeButton = Instance.new("TextButton")
executeButton.Size = UDim2.new(0, 120, 1, 0)
executeButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
executeButton.BorderSizePixel = 0
executeButton.Text = "Execute"
executeButton.TextColor3 = Config.TextColor
executeButton.TextSize = 14
executeButton.Font = Enum.Font.GothamBold
executeButton.Parent = buttonFrame

local executeCorner = Instance.new("UICorner")
executeCorner.CornerRadius = UDim.new(0, 6)
executeCorner.Parent = executeButton

executeButton.MouseButton1Click:Connect(function()
    local code = scriptInput.Text
    if code and #code > 0 then
        appendConsole("Executing script...", "[EXEC]")
        local success, result = SafeExecute(code)
        if success then
            appendConsole("Script executed successfully", "[SUCCESS]")
            if result then
                appendConsole(tostring(result), "[RESULT]")
            end
        else
            appendConsole("Error: " .. tostring(result), "[ERROR]")
        end
    else
        appendConsole("No code to execute", "[WARN]")
    end
end)

local clearButton = Instance.new("TextButton")
clearButton.Size = UDim2.new(0, 120, 1, 0)
clearButton.BackgroundColor3 = Config.AccentBgColor
clearButton.BorderSizePixel = 0
clearButton.Text = "Clear"
clearButton.TextColor3 = Config.TextColor
clearButton.TextSize = 14
clearButton.Font = Enum.Font.GothamBold
clearButton.Parent = buttonFrame

local clearCorner = Instance.new("UICorner")
clearCorner.CornerRadius = UDim.new(0, 6)
clearCorner.Parent = clearButton

clearButton.MouseButton1Click:Connect(function()
    scriptInput.Text = ""
    appendConsole("Input cleared", "[INFO]")
end)

clearButton.MouseEnter:Connect(function()
    TweenService:Create(clearButton, TweenInfo.new(0.15), {BackgroundColor3 = Config.AccentColor}):Play()
end)

clearButton.MouseLeave:Connect(function()
    TweenService:Create(clearButton, TweenInfo.new(0.15), {BackgroundColor3 = Config.AccentBgColor}):Play()
end)

-- 5. SETTINGS TAB
local settingsTab, settingsLayout, settingsTabButton = createTab("Settings")

createButton(settingsTab, "Destroy GUI", function()
    CleanupConnections()
    CleanupESP()
    screenGui:Destroy()
    SendNotification("GUI", "GUI destroyed", 2)
end)

createButton(settingsTab, "Reset All Settings", function()
    Config = {
        GuiVisible = true,
        GuiPosition = UDim2.new(0.5, -200, 0.5, -175),
        GuiMinimized = false,
        WalkSpeed = 16,
        JumpPower = 50,
        NoclipEnabled = false,
        FlyEnabled = false,
        InfiniteJumpEnabled = false,
        FlySpeed = 20,
        PlayerESPEnabled = false,
        ShowPlayerNames = true,
        ShowPlayerHealth = true,
        ShowPlayerBoxes = true,
        ToggleGuiKeybind = Enum.KeyCode.RightControl,
        AccentColor = Color3.fromRGB(0, 170, 255),
        MainBgColor = Color3.fromRGB(35, 35, 35),
        SecondaryBgColor = Color3.fromRGB(45, 45, 45),
        AccentBgColor = Color3.fromRGB(55, 55, 55),
        TextColor = Color3.fromRGB(255, 255, 255),
        PlaceholderColor = Color3.fromRGB(150, 150, 150),
    }
    SendNotification("Settings", "All settings reset to default", 3)
end)

-- Mobile Toggle Button (only shows on mobile)
if isMobile then
    local mobileToggleButton = Instance.new("TextButton")
    mobileToggleButton.Name = "MobileToggle"
    mobileToggleButton.Size = UDim2.new(0, 60, 0, 60)
    mobileToggleButton.Position = UDim2.new(1, -70, 0, 10)
    mobileToggleButton.BackgroundColor3 = Config.AccentColor
    mobileToggleButton.BorderSizePixel = 0
    mobileToggleButton.Text = "≡"
    mobileToggleButton.TextColor3 = Config.TextColor
    mobileToggleButton.TextSize = 32
    mobileToggleButton.Font = Enum.Font.GothamBold
    mobileToggleButton.ZIndex = 1000
    mobileToggleButton.Parent = screenGui

    local mobileToggleCorner = Instance.new("UICorner")
    mobileToggleCorner.CornerRadius = UDim.new(1, 0)
    mobileToggleCorner.Parent = mobileToggleButton

    -- Make mobile button draggable too
    local mobileDragging = false
    local mobileDragStart = Vector2.new(0, 0)
    local mobileStartPos = UDim2.new(0, 0, 0, 0)

    mobileToggleButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            mobileDragging = true
            mobileDragStart = Vector2.new(input.Position.X, input.Position.Y)
            mobileStartPos = mobileToggleButton.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    mobileDragging = false
                end
            end)
        end
    end)

    mobileToggleButton.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch and mobileDragging then
            local delta = Vector2.new(input.Position.X, input.Position.Y) - mobileDragStart
            mobileToggleButton.Position = UDim2.new(
                mobileStartPos.X.Scale, mobileStartPos.X.Offset + delta.X,
                mobileStartPos.Y.Scale, mobileStartPos.Y.Offset + delta.Y
            )
        end
    end)

    mobileToggleButton.MouseButton1Click:Connect(function()
        if not mobileDragging then
            screenGui.Enabled = not screenGui.Enabled
            Config.GuiVisible = screenGui.Enabled
            if screenGui.Enabled then
                mainFrame.Visible = true
            end
        end
    end)

    -- Hide main frame when closing, keep mobile button visible
    local originalCloseFunction = closeButton.MouseButton1Click
    closeButton.MouseButton1Click:Connect(function()
        mainFrame.Visible = false
        Config.GuiVisible = false
    end)

    -- Show main frame when opening via mobile button
    SendNotification("Mobile Controls", "Drag the toggle button to move it", 5)
end

local deviceLabel = Instance.new("TextLabel")
deviceLabel.Size = UDim2.new(1, 0, 0, 40)
deviceLabel.BackgroundColor3 = Config.SecondaryBgColor
deviceLabel.BorderSizePixel = 0
deviceLabel.Text = "Device: " .. (isMobile and "Mobile (Touch)" or "PC (Keyboard)")
deviceLabel.TextColor3 = Config.TextColor
deviceLabel.TextSize = 14
deviceLabel.Font = Enum.Font.Gotham
deviceLabel.Parent = settingsTab

local deviceCorner = Instance.new("UICorner")
deviceCorner.CornerRadius = UDim.new(0, 6)
deviceCorner.Parent = deviceLabel

local creditsLabel = Instance.new("TextLabel")
creditsLabel.Size = UDim2.new(1, 0, 0, 60)
creditsLabel.BackgroundColor3 = Config.SecondaryBgColor
creditsLabel.BorderSizePixel = 0
creditsLabel.Text = "Advanced Exploit GUI v2.1\nMobile & PC Support\nMade with ❤️"
creditsLabel.TextColor3 = Config.TextColor
creditsLabel.TextSize = 14
creditsLabel.Font = Enum.Font.Gotham
creditsLabel.Parent = settingsTab

local creditsCorner = Instance.new("UICorner")
creditsCorner.CornerRadius = UDim.new(0, 6)
creditsCorner.Parent = creditsLabel

-- Mobile-specific instructions
if isMobile then
    local mobileInstructions = Instance.new("TextLabel")
    mobileInstructions.Size = UDim2.new(1, 0, 0, 100)
    mobileInstructions.BackgroundColor3 = Config.SecondaryBgColor
    mobileInstructions.BorderSizePixel = 0
    mobileInstructions.Text = "📱 MOBILE CONTROLS:\n\n• Drag title bar to move GUI\n• Tap sliders to adjust values\n• Use floating button to toggle GUI\n• Long press on sliders for precision"
    mobileInstructions.TextColor3 = Config.TextColor
    mobileInstructions.TextSize = 12
    mobileInstructions.Font = Enum.Font.Gotham
    mobileInstructions.TextWrapped = true
    mobileInstructions.TextYAlignment = Enum.TextYAlignment.Top
    mobileInstructions.Parent = settingsTab

    local mobileInstructionsCorner = Instance.new("UICorner")
    mobileInstructionsCorner.CornerRadius = UDim.new(0, 6)
    mobileInstructionsCorner.Parent = mobileInstructions

    local mobilePadding = Instance.new("UIPadding")
    mobilePadding.PaddingLeft = UDim.new(0, 10)
    mobilePadding.PaddingRight = UDim.new(0, 10)
    mobilePadding.PaddingTop = UDim.new(0, 10)
    mobilePadding.PaddingBottom = UDim.new(0, 10)
    mobilePadding.Parent = mobileInstructions
end

-- ====================================================================================================
-- MOBILE FLY CONTROLS
-- ====================================================================================================
if isMobile then
    local flyControlsFrame = Instance.new("Frame")
    flyControlsFrame.Name = "FlyControls"
    flyControlsFrame.Size = UDim2.new(0, 200, 0, 150)
    flyControlsFrame.Position = UDim2.new(0, 10, 1, -160)
    flyControlsFrame.BackgroundColor3 = Config.MainBgColor
    flyControlsFrame.BackgroundTransparency = 0.3
    flyControlsFrame.BorderSizePixel = 0
    flyControlsFrame.Visible = false
    flyControlsFrame.ZIndex = 100
    flyControlsFrame.Parent = screenGui

    local flyControlsCorner = Instance.new("UICorner")
    flyControlsCorner.CornerRadius = UDim.new(0, 8)
    flyControlsCorner.Parent = flyControlsFrame

    local function createFlyButton(text, position, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 60, 0, 60)
        btn.Position = position
        btn.BackgroundColor3 = Config.AccentBgColor
        btn.BorderSizePixel = 0
        btn.Text = text
        btn.TextColor3 = Config.TextColor
        btn.TextSize = 20
        btn.Font = Enum.Font.GothamBold
        btn.ZIndex = 101
        btn.Parent = flyControlsFrame

        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 8)
        btnCorner.Parent = btn

        local pressing = false

        btn.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch then
                pressing = true
                btn.BackgroundColor3 = Config.AccentColor
                callback(true)
            end
        end)

        btn.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch then
                pressing = false
                btn.BackgroundColor3 = Config.AccentBgColor
                callback(false)
            end
        end)

        return btn
    end

    -- Directional buttons
    local flyForward = false
    local flyBackward = false
    local flyLeft = false
    local flyRight = false
    local flyUp = false
    local flyDown = false

    createFlyButton("▲", UDim2.new(0.5, -30, 0, 10), function(pressing)
        flyForward = pressing
    end)

    createFlyButton("▼", UDim2.new(0.5, -30, 1, -70), function(pressing)
        flyBackward = pressing
    end)

    createFlyButton("◀", UDim2.new(0, 10, 0.5, -30), function(pressing)
        flyLeft = pressing
    end)

    createFlyButton("▶", UDim2.new(1, -70, 0.5, -30), function(pressing)
        flyRight = pressing
    end)

    -- Up/Down controls
    local upDownFrame = Instance.new("Frame")
    upDownFrame.Size = UDim2.new(0, 70, 0, 150)
    upDownFrame.Position = UDim2.new(1, -80, 1, -160)
    upDownFrame.BackgroundColor3 = Config.MainBgColor
    upDownFrame.BackgroundTransparency = 0.3
    upDownFrame.BorderSizePixel = 0
    upDownFrame.Visible = false
    upDownFrame.ZIndex = 100
    upDownFrame.Parent = screenGui

    local upDownCorner = Instance.new("UICorner")
    upDownCorner.CornerRadius = UDim.new(0, 8)
    upDownCorner.Parent = upDownFrame

    createFlyButton("↑", UDim2.new(0, 5, 0, 5), function(pressing)
        flyUp = pressing
    end).Parent = upDownFrame

    createFlyButton("↓", UDim2.new(0, 5, 1, -65), function(pressing)
        flyDown = pressing
    end).Parent = upDownFrame

    -- Update fly toggle to show/hide mobile controls
    local originalFlyToggle = flyToggle
    flyToggle = createToggle(playerTab, "Fly", Config.FlyEnabled, function(enabled)
        originalFlyToggle(enabled)
        flyControlsFrame.Visible = enabled
        upDownFrame.Visible = enabled
        
        if enabled then
            -- Mobile fly control loop
            if Connections.Fly then
                Connections.Fly:Disconnect()
            end

            local character = player.Character
            local hrp = character and character:FindFirstChild("HumanoidRootPart")
            
            if not hrp then
                SendNotification("Fly", "Character not found", 3)
                return
            end

            FlyBodyVelocity = Instance.new("BodyVelocity")
            FlyBodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
            FlyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
            FlyBodyVelocity.Parent = hrp

            Connections.Fly = RunService.RenderStepped:Connect(function()
                if not hrp or not hrp.Parent then
                    flyToggle(false)
                    return
                end

                local moveVector = Vector3.new(0, 0, 0)
                local speed = Config.FlySpeed

                -- Mobile controls
                if flyForward then
                    moveVector = moveVector + (camera.CFrame.LookVector * speed)
                end
                if flyBackward then
                    moveVector = moveVector - (camera.CFrame.LookVector * speed)
                end
                if flyLeft then
                    moveVector = moveVector - (camera.CFrame.RightVector * speed)
                end
                if flyRight then
                    moveVector = moveVector + (camera.CFrame.RightVector * speed)
                end
                if flyUp then
                    moveVector = moveVector + Vector3.new(0, speed, 0)
                end
                if flyDown then
                    moveVector = moveVector - Vector3.new(0, speed, 0)
                end

                -- PC controls (still work)
                if not isMobile then
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                        moveVector = moveVector + (camera.CFrame.LookVector * speed)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                        moveVector = moveVector - (camera.CFrame.LookVector * speed)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                        moveVector = moveVector - (camera.CFrame.RightVector * speed)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                        moveVector = moveVector + (camera.CFrame.RightVector * speed)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                        moveVector = moveVector + Vector3.new(0, speed, 0)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                        moveVector = moveVector - Vector3.new(0, speed, 0)
                    end
                end

                FlyBodyVelocity.Velocity = moveVector
                hrp.CFrame = CFrame.new(hrp.Position, hrp.Position + camera.CFrame.LookVector)
            end)
            
            SendNotification("Fly", "Enabled - Use on-screen controls", 2)
        else
            flyControlsFrame.Visible = false
            upDownFrame.Visible = false
        end
    end)
end

-- ====================================================================================================
-- INITIALIZATION
-- ====================================================================================================

-- Activate first tab
playerTabButton.MouseButton1Click:Fire()

-- Welcome message
if isMobile then
    SendNotification("GUI Loaded", "Mobile mode - Use floating button to toggle", 5)
else
    SendNotification("GUI Loaded", "Press " .. Config.ToggleGuiKeybind.Name .. " to toggle", 5)
end

appendConsole("Advanced Exploit GUI v2.1 loaded successfully!", "[INIT]")
appendConsole("Device: " .. (isMobile and "Mobile" or "PC"), "[INFO]")

print("=== Advanced Exploit GUI v2.1 ===")
print("Successfully initialized!")
print("Device: " .. (isMobile and "Mobile (Touch Enabled)" or "PC (Keyboard/Mouse)"))
if isMobile then
    print("Mobile controls enabled - use on-screen buttons")
else
    print("Toggle GUI: " .. Config.ToggleGuiKeybind.Name)
end

