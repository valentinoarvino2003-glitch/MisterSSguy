local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "ConTab Universal HUB (Credit to @MisterSSguy for helping out)",
   LoadingTitle = "I wonder how it felt to be sister hong? (lol) ",
   LoadingSubtitle = "by Connet and Tabex",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "MyScriptConfig",
      FileName = "MyScriptConfig"
   },
   Discord = {
      Enabled = false,
      Invite = "theinvitelinkisexpired", 
      RememberJoins = true 
   },
   KeySystem = true,
   KeySettings = {
      Title = "ConTab Universal HUB (Make with love)",
      Subtitle = "Key System (of course)",
      Note = "Key > TABX2006",
      FileName = "ConTabKey",
      SaveKey = true, 
      GrabKeyFromSite = false, 
      Key = {"TABX2006"} 
   }
})

-- Create Tabs
local Tab1 = Window:CreateTab("Main", 4483362458) 
local Tab2 = Window:CreateTab("Player", 4483362458)
local Tab3 = Window:CreateTab("Scripts", 4483362458)
local Tab4 = Window:CreateTab("HUBS", 4483362458)
local Tab5 = Window:CreateTab("Our scripts and HUB", 4483362458)
local Tab6 = Window:CreateTab("Game Specific (Scripts and Hubs)", 4483362458)
local Tab7 = Window:CreateTab("Admin scripts", 4483362458)
local Tab8 = Window:CreateTab("settings", 4483362458)

-- Main Tab Sections
-- ═══════════════════════════════════════
-- TAB 1: Main
-- ═══════════════════════════════════════

local Section1_1 = Tab1:CreateSection("Welcome to ConTab Universal HUB!")

local Paragraph1 = Tab1:CreateParagraph({
   Title = "Welcome!",
   Content = "Thank you for using ConTab Universal HUB! This GUI includes various scripts, admin commands, and game-specific tools. Use the tabs above to navigate."
})

local Section1_2 = Tab1:CreateSection("How to Use")

local Paragraph2 = Tab1:CreateParagraph({
   Title = "Navigation",
   Content = "• Player Tab: Speed, Jump, Fly, ESP, etc.\n• Scripts Tab: Universal tools\n• HUBS Tab: Universal hubs\n• Game Specific: Scripts for specific games\n• Admin Scripts: Admin commands\n• Settings: Configure and destroy GUI"
})

local Section1_3 = Tab1:CreateSection("Credits")

local Paragraph3 = Tab1:CreateParagraph({
   Title = "Made by",
   Content = "ConTab Universal HUB made by Connet and Tabex\nSpecial thanks to @MisterSSguy for helping out!\n\nGUI Framework: Rayfield by Sirius"
})

local Button1 = Tab1:CreateButton({
   Name = "Join Discord Server",
   Callback = function()
      Rayfield:Notify({
         Title = "Discord",
         Content = "Discord invite copied to clipboard!",
         Duration = 3,
         Image = 4483362458,
      })
      setclipboard("https://discord.gg/kUNmK55Bj") -- Change this to your actual Discord invite
   end,
})

-- ═══════════════════════════════════════
-- TAB 2: Player
-- ═══════════════════════════════════════

local Section2_1 = Tab2:CreateSection("Movement")

local Slider1 = Tab2:CreateSlider({
   Name = "Walk Speed",
   Range = {16, 500},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "WalkSpeedSlider",
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
      Rayfield:Notify({
         Title = "Walk Speed",
         Content = "Walk speed set to " .. Value,
         Duration = 2,
         Image = 4483362458,
      })
   end,
})

local Slider2 = Tab2:CreateSlider({
   Name = "Jump Power",
   Range = {50, 500},
   Increment = 1,
   Suffix = "Power",
   CurrentValue = 50,
   Flag = "JumpPowerSlider",
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
      Rayfield:Notify({
         Title = "Jump Power",
         Content = "Jump power set to " .. Value,
         Duration = 2,
         Image = 4483362458,
      })
   end,
})

local Button2_1 = Tab2:CreateButton({
   Name = "Fly (X to toggle)",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
      Rayfield:Notify({
         Title = "Fly",
         Content = "Fly script loaded! Press X to toggle",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Button2_2 = Tab2:CreateButton({
   Name = "NoClip (E to toggle)",
   Callback = function()
      loadstring(game:HttpGet("https://pastebin.com/raw/hwyj65XB"))()
      Rayfield:Notify({
         Title = "NoClip",
         Content = "NoClip loaded! Press E to toggle",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Toggle2_1 = Tab2:CreateToggle({
   Name = "Infinite Jump",
   CurrentValue = false,
   Flag = "InfiniteJumpToggle",
   Callback = function(Value)
      _G.InfiniteJump = Value
      local InfiniteJumpEnabled = Value
      game:GetService("UserInputService").JumpRequest:connect(function()
         if InfiniteJumpEnabled then
            game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
         end
      end)
      Rayfield:Notify({
         Title = "Infinite Jump",
         Content = Value and "Enabled" or "Disabled",
         Duration = 2,
         Image = 4483362458,
      })
   end,
})

local Section2_2 = Tab2:CreateSection("Visual")

local Button2_3 = Tab2:CreateButton({
   Name = "ESP (See players through walls)",
   Callback = function()
      loadstring(game:HttpGet("https://pastebin.com/raw/6270hLJR"))()
      Rayfield:Notify({
         Title = "ESP",
         Content = "ESP loaded successfully!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Toggle2_2 = Tab2:CreateToggle({
   Name = "FullBright",
   CurrentValue = false,
   Flag = "FullBrightToggle",
   Callback = function(Value)
      if Value then
         game:GetService("Lighting").Ambient = Color3.new(1, 1, 1)
         game:GetService("Lighting").ColorShift_Bottom = Color3.new(1, 1, 1)
         game:GetService("Lighting").ColorShift_Top = Color3.new(1, 1, 1)
      else
         game:GetService("Lighting").Ambient = Color3.new(0, 0, 0)
         game:GetService("Lighting").ColorShift_Bottom = Color3.new(0, 0, 0)
         game:GetService("Lighting").ColorShift_Top = Color3.new(0, 0, 0)
      end
      Rayfield:Notify({
         Title = "FullBright",
         Content = Value and "Enabled" or "Disabled",
         Duration = 2,
         Image = 4483362458,
      })
   end,
})

-- ═══════════════════════════════════════
-- TAB 3: Scripts
-- ═══════════════════════════════════════

local Section3_1 = Tab3:CreateSection("Universal Tools")

local Button3_1 = Tab3:CreateButton({
   Name = "Infinite Yield FE",
   Callback = function()
      loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
      Rayfield:Notify({
         Title = "Infinite Yield",
         Content = "Infinite Yield loaded successfully!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Button3_2 = Tab3:CreateButton({
   Name = "Dark Dex V3",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.lua", true))()
      Rayfield:Notify({
         Title = "Dark Dex V3",
         Content = "Dark Dex V3 loaded successfully!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Button3_3 = Tab3:CreateButton({
   Name = "XVC Universal",
   Callback = function()
      loadstring(game:HttpGet("https://pastebin.com/raw/Piw5bqGq"))()
      Rayfield:Notify({
         Title = "XVC Universal",
         Content = "XVC Universal loaded successfully!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Button3_4 = Tab3:CreateButton({
   Name = "Simple Spy",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/depthso/Sigma-Spy/refs/heads/main/Main.lua"))()
      Rayfield:Notify({
         Title = "Simple Spy",
         Content = "Simple Spy loaded successfully!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Button3_5 = Tab3:CreateButton({
   Name = "Hydroxide",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/Upbolt/Hydroxide/revision/init.lua"))()
      Rayfield:Notify({
         Title = "Hydroxide",
         Content = "Hydroxide loaded successfully!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Button3_6 = Tab3:CreateButton({
   Name = "Universal Game Unlocker",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/GithubMagical/Roblox-Egor/refs/heads/main/lua%20v2", true))()
      Rayfield:Notify({
         Title = "Game Unlocker",
         Content = "Universal Game Unlocker loaded!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Button3_7 = Tab3:CreateButton({
   Name = "Egor Script",
   Callback = function()
      loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Roblox-Egor-58292"))()
      Rayfield:Notify({
         Title = "Egor Script",
         Content = "Egor Script loaded!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Section3_2 = Tab3:CreateSection("Utility Scripts")

local Button3_8 = Tab3:CreateButton({
   Name = "Anti AFK",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/AntiAFK.lua"))()
      Rayfield:Notify({
         Title = "Anti AFK",
         Content = "Anti AFK enabled successfully!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Button3_9 = Tab3:CreateButton({
   Name = "FPS Booster",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/FPS%20Boost.lua"))()
      Rayfield:Notify({
         Title = "FPS Booster",
         Content = "FPS Booster loaded successfully!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Button3_10 = Tab3:CreateButton({
   Name = "Auto Clicker",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/autoclicker.lua"))()
      Rayfield:Notify({
         Title = "Auto Clicker",
         Content = "Auto Clicker loaded successfully!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Button3_11 = Tab3:CreateButton({
   Name = "Server Hop",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/serverhop.lua"))()
      Rayfield:Notify({
         Title = "Server Hop",
         Content = "Server Hop script loaded!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Section3_3 = Tab3:CreateSection("Animation Scripts")

local Button3_12 = Tab3:CreateButton({
   Name = "Nameless Animations",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/FilteringEnabled/NamelessAnimation/main/source.lua"))()
      Rayfield:Notify({
         Title = "Nameless Animations",
         Content = "Nameless Animations loaded!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Button3_13 = Tab3:CreateButton({
   Name = "FE Animations GUI",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/GamingScripter/Animation-Hub/main/Animation%20Gui", true))()
      Rayfield:Notify({
         Title = "FE Animations GUI",
         Content = "FE Animations GUI loaded!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Button3_14 = Tab3:CreateButton({
   Name = "Emote Hub",
   Callback = function()
      loadstring(game:HttpGet("https://angelical.me/ak.lua"))()
      Rayfield:Notify({
         Title = "Emote Hub",
         Content = "Emote Hub loaded!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Section3_4 = Tab3:CreateSection("Chat & Fun")

local Button3_15 = Tab3:CreateButton({
   Name = "Chat Spy",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/Lucasfin000/SpyChat/main/main.lua"))()
      Rayfield:Notify({
         Title = "Chat Spy",
         Content = "Chat Spy loaded! See private messages",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Button3_16 = Tab3:CreateButton({
   Name = "Keyboard Script (Mobile)",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt"))()
      Rayfield:Notify({
         Title = "Mobile Keyboard",
         Content = "Mobile keyboard loaded!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Button3_17 = Tab3:CreateButton({
   Name = "Inventory Viewer (Does they have a dildo?)",
   Callback = function()
      loadstring(game:HttpGet("https://pastebin.com/raw/gQNchhrC"))()
      Rayfield:Notify({
         Title = "Inventory Viewer",
         Content = "Inventory Viewer loaded!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Button3_18 = Tab3:CreateButton({
   Name = "FE Katana Script",
   Callback = function()
      loadstring(game:HttpGet("https://pastebin.com/raw/NTNHKeMZ", true))()
      Rayfield:Notify({
         Title = "FE Katana Script",
         Content = "FE Katana Script",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Button3_19 = Tab3:CreateButton({
   Name = "FE Ragdoll (Lie down so player can bang you!)",
   Callback = function()
      loadstring(game:HttpGet('https://raw.githubusercontent.com/shakk-code/fe-ragdoll-script/refs/heads/main/script.lua', true))()
      Rayfield:Notify({
         Title = "FE Ragdoll",
         Content = "FE Ragdoll",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Button3_20 = Tab3:CreateButton({
   Name = "Click Teleport (Make by us!)",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/TaNsIn-SuNdAn/SuNdAn-Video-Roblox-Script/refs/heads/main/ClickTp.lua"))()
      Rayfield:Notify({
         Title = "Click Teleport",
         Content = "Click Teleport",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Button3_21 = Tab3:CreateButton({
   Name = "FE blackhole script",
   Callback = function()
      loadstring(game:HttpGet("https://pastefy.app/QH9EnqU3/raw"))()
      Rayfield:Notify({
         Title = "FE blackhole script",
         Content = "FE blackhole script",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Button3_22 = Tab3:CreateButton({
   Name = "Minecraft script",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/ZynixMoz/SkyeMoz/refs/heads/main/MozCraft/Main"))()
      Rayfield:Notify({
         Title = "Minecraft script",
         Content = "Minecraft script loaded succesfully!!!!!!!! ",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Button3_23 = Tab3:CreateButton({
   Name = "Free PS scripts", 
   Callback = function() 
      loadstring(game:HttpGet("https://gist.githubusercontent.com/Tesker-103/ed48b3ae8120b0c040584b661cbda063/raw/210408b3f107dc740a4c9b832bfa647f92aa25d1/FreePrivateServerGUI"))()
      Rayfield:Notify({
         Title = "Free PS scripts",
         Content = "For brookie", 
         Duration = 3, 
         Image = 4483362458 
      }) 
  end,
})

local Button3_24 = Tab3:CreateButton({
   Name = "FE invisibility", 
   Callback = function() 
      
--!strict

-- Configuration
local CONFIG = {
	TOGGLE_KEY = Enum.KeyCode.X,
	DEFAULT_SPEED = 16,
	BOOSTED_SPEED = 48,
	SOUND_ID = "rbxassetid://942127495",
	INVISIBILITY_POSITION = Vector3.new(-25.95, 84, 3537.55),
	NOTIFICATION_DURATION = 3,
	-- UI Colors
	BACKGROUND_COLOR = Color3.fromRGB(25, 25, 25),
	ACCENT_COLOR = Color3.fromRGB(45, 45, 45),
	PRIMARY_COLOR = Color3.fromRGB(0, 170, 255),
	SUCCESS_COLOR = Color3.fromRGB(46, 204, 113),
	DANGER_COLOR = Color3.fromRGB(231, 76, 60),
	WARNING_COLOR = Color3.fromRGB(241, 196, 15),
	TEXT_COLOR = Color3.fromRGB(255, 255, 255),
	SECONDARY_TEXT_COLOR = Color3.fromRGB(189, 195, 199),
}

-- Types
type PlayerState = {
	isInvisible: boolean,
	isSpeedBoosted: boolean,
	originalSpeed: number,
}

-- Services
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Variables
local player = Players.LocalPlayer
local playerState: PlayerState = {
	isInvisible = false,
	isSpeedBoosted = false,
	originalSpeed = CONFIG.DEFAULT_SPEED,
}

-- GUI Elements
local screenGui: ScreenGui
local mainFrame: Frame
local toggleButton: TextButton
local speedButton: TextButton
local closeButton: TextButton
local signatureLabel: TextLabel
local sound: Sound

-- Utility Functions
local function createNotification(title: string, text: string): ()
	StarterGui:SetCore("SendNotification", {
		Title = title,
		Text = text,
		Duration = CONFIG.NOTIFICATION_DURATION,
	})
end

local function setCharacterTransparency(character: Model, transparency: number): ()
	for _, descendant in character:GetDescendants() do
		if descendant:IsA("BasePart") or descendant:IsA("Decal") then
			descendant.Transparency = transparency
		end
	end
end

local function getHumanoid(): Humanoid?
	local character = player.Character
	if not character then
		return nil
	end
	return character:FindFirstChild("Humanoid") :: Humanoid?
end

local function getHumanoidRootPart(): BasePart?
	local character = player.Character
	if not character then
		return nil
	end
	return character:FindFirstChild("HumanoidRootPart") :: BasePart?
end

local function playSound(): ()
	if sound then
		sound:Play()
	end
end

-- Core Functions
local function toggleInvisibility(): ()
	if not player.Character then
		warn("Character not found")
		return
	end

	playerState.isInvisible = not playerState.isInvisible
	playSound()

	if playerState.isInvisible then
		local humanoidRootPart = getHumanoidRootPart()
		if not humanoidRootPart then
			warn("HumanoidRootPart not found")
			return
		end

		local savedPosition = humanoidRootPart.CFrame

		-- Move to invisibility position
		player.Character:MoveTo(CONFIG.INVISIBILITY_POSITION)
		task.wait(0.15)

		-- Create invisible seat
		local seat = Instance.new("Seat")
		seat.Name = "invischair"
		seat.Anchored = false
		seat.CanCollide = false
		seat.Transparency = 1
		seat.Position = CONFIG.INVISIBILITY_POSITION
		seat.Parent = workspace

		-- Weld seat to character
		local weld = Instance.new("Weld")
		weld.Part0 = seat
		weld.Part1 = player.Character:FindFirstChild("Torso") or player.Character:FindFirstChild("UpperTorso")
		weld.Parent = seat

		task.wait()
		seat.CFrame = savedPosition

		-- Set character transparency
		setCharacterTransparency(player.Character, 0.5)

		-- Update button appearance
		toggleButton.BackgroundColor3 = CONFIG.SUCCESS_COLOR
		toggleButton.Text = "VISIBLE"
		if _G.statusLabel then
			_G.statusLabel.Text = "Invisible Mode Active"
			_G.statusLabel.TextColor3 = CONFIG.SUCCESS_COLOR
		end

		createNotification("Invisibility ON", "You are now invisible")
	else
		-- Remove invisible chair
		local invisChair = workspace:FindFirstChild("invischair")
		if invisChair then
			invisChair:Destroy()
		end

		-- Restore character visibility
		if player.Character then
			setCharacterTransparency(player.Character, 0)
		end

		-- Update button appearance
		toggleButton.BackgroundColor3 = CONFIG.PRIMARY_COLOR
		toggleButton.Text = "INVISIBLE"
		if _G.statusLabel then
			_G.statusLabel.Text = "Visible Mode Active"
			_G.statusLabel.TextColor3 = CONFIG.SECONDARY_TEXT_COLOR
		end

		createNotification("Invisibility OFF", "You are now visible")
	end
end

local function toggleSpeedBoost(): ()
	local humanoid = getHumanoid()
	if not humanoid then
		warn("Humanoid not found")
		return
	end

	playerState.isSpeedBoosted = not playerState.isSpeedBoosted
	playSound()

	if playerState.isSpeedBoosted then
		humanoid.WalkSpeed = CONFIG.BOOSTED_SPEED
		speedButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
		speedButton.Text = "SPEED ON"
		createNotification("Speed Boost ON", `Speed: {CONFIG.BOOSTED_SPEED}`)
	else
		humanoid.WalkSpeed = playerState.originalSpeed
		speedButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		speedButton.Text = "SPEED BOOST"
		createNotification("Speed Boost OFF", `Speed: {playerState.originalSpeed}`)
	end
end

local function resetPlayerState(): ()
	playerState.isInvisible = false
	playerState.isSpeedBoosted = false

	-- Reset button appearances
	if toggleButton then
		toggleButton.BackgroundColor3 = CONFIG.PRIMARY_COLOR
		toggleButton.Text = "INVISIBLE"
	end

	if speedButton then
		speedButton.BackgroundColor3 = CONFIG.DANGER_COLOR
		speedButton.Text = "SPEED BOOST"
	end

	-- Reset status
	if _G.statusLabel then
		_G.statusLabel.Text = "Ready"
		_G.statusLabel.TextColor3 = CONFIG.SECONDARY_TEXT_COLOR
	end
end

-- GUI Creation
local function createGUI(): ()
	-- Main ScreenGui
	screenGui = Instance.new("ScreenGui")
	screenGui.Name = "InvisibilityGUI"
	screenGui.ResetOnSpawn = false
	screenGui.Parent = player:WaitForChild("PlayerGui")

	-- Main Frame
	mainFrame = Instance.new("Frame")
	mainFrame.Name = "MainFrame"
	mainFrame.Size = UDim2.new(0, 160, 0, 180)
	mainFrame.Position = UDim2.new(0.5, -80, 0.5, -90)
	mainFrame.BackgroundColor3 = CONFIG.BACKGROUND_COLOR
	mainFrame.BorderSizePixel = 0
	mainFrame.Active = true
	mainFrame.Draggable = true
	mainFrame.Parent = screenGui

	-- Add corner rounding and shadow effect
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 12)
	corner.Parent = mainFrame

	-- Add stroke for better definition
	local stroke = Instance.new("UIStroke")
	stroke.Color = CONFIG.ACCENT_COLOR
	stroke.Thickness = 2
	stroke.Parent = mainFrame

	-- Title Label
	local titleLabel = Instance.new("TextLabel")
	titleLabel.Name = "TitleLabel"
	titleLabel.Size = UDim2.new(1, -20, 0, 25)
	titleLabel.Position = UDim2.new(0, 10, 0, 10)
	titleLabel.Text = "INVISIBILITY TOOL"
	titleLabel.BackgroundTransparency = 1
	titleLabel.TextColor3 = CONFIG.TEXT_COLOR
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.TextSize = 12
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.Parent = mainFrame

	-- Toggle Button
	toggleButton = Instance.new("TextButton")
	toggleButton.Name = "ToggleButton"
	toggleButton.Size = UDim2.new(1, -20, 0, 35)
	toggleButton.Position = UDim2.new(0, 10, 0, 45)
	toggleButton.Text = "INVISIBLE"
	toggleButton.BackgroundColor3 = CONFIG.PRIMARY_COLOR
	toggleButton.TextColor3 = CONFIG.TEXT_COLOR
	toggleButton.Font = Enum.Font.GothamBold
	toggleButton.TextScaled = true
	toggleButton.BorderSizePixel = 0
	toggleButton.Parent = mainFrame

	local toggleCorner = Instance.new("UICorner")
	toggleCorner.CornerRadius = UDim.new(0, 8)
	toggleCorner.Parent = toggleButton

	-- Add hover effect for toggle button
	local toggleStroke = Instance.new("UIStroke")
	toggleStroke.Color = Color3.fromRGB(255, 255, 255)
	toggleStroke.Thickness = 0
	toggleStroke.Transparency = 0.8
	toggleStroke.Parent = toggleButton

	-- Speed Button
	speedButton = Instance.new("TextButton")
	speedButton.Name = "SpeedButton"
	speedButton.Size = UDim2.new(1, -20, 0, 35)
	speedButton.Position = UDim2.new(0, 10, 0, 90)
	speedButton.Text = "SPEED BOOST"
	speedButton.BackgroundColor3 = CONFIG.DANGER_COLOR
	speedButton.TextColor3 = CONFIG.TEXT_COLOR
	speedButton.Font = Enum.Font.GothamBold
	speedButton.TextScaled = true
	speedButton.BorderSizePixel = 0
	speedButton.Parent = mainFrame

	local speedCorner = Instance.new("UICorner")
	speedCorner.CornerRadius = UDim.new(0, 8)
	speedCorner.Parent = speedButton

	-- Add hover effect for speed button
	local speedStroke = Instance.new("UIStroke")
	speedStroke.Color = Color3.fromRGB(255, 255, 255)
	speedStroke.Thickness = 0
	speedStroke.Transparency = 0.8
	speedStroke.Parent = speedButton

	-- Close Button
	closeButton = Instance.new("TextButton")
	closeButton.Name = "CloseButton"
	closeButton.Size = UDim2.new(0, 25, 0, 25)
	closeButton.Position = UDim2.new(1, -30, 0, 5)
	closeButton.Text = "×"
	closeButton.BackgroundColor3 = CONFIG.DANGER_COLOR
	closeButton.TextColor3 = CONFIG.TEXT_COLOR
	closeButton.Font = Enum.Font.GothamBold
	closeButton.TextSize = 16
	closeButton.BorderSizePixel = 0
	closeButton.Parent = mainFrame

	local closeCorner = Instance.new("UICorner")
	closeCorner.CornerRadius = UDim.new(0, 6)
	closeCorner.Parent = closeButton

	-- Status Indicator
	local statusFrame = Instance.new("Frame")
	statusFrame.Name = "StatusFrame"
	statusFrame.Size = UDim2.new(1, -20, 0, 20)
	statusFrame.Position = UDim2.new(0, 10, 0, 135)
	statusFrame.BackgroundColor3 = CONFIG.ACCENT_COLOR
	statusFrame.BorderSizePixel = 0
	statusFrame.Parent = mainFrame

	local statusCorner = Instance.new("UICorner")
	statusCorner.CornerRadius = UDim.new(0, 6)
	statusCorner.Parent = statusFrame

	local statusLabel = Instance.new("TextLabel")
	statusLabel.Name = "StatusLabel"
	statusLabel.Size = UDim2.new(1, -10, 1, 0)
	statusLabel.Position = UDim2.new(0, 5, 0, 0)
	statusLabel.Text = "Ready"
	statusLabel.BackgroundTransparency = 1
	statusLabel.TextColor3 = CONFIG.SECONDARY_TEXT_COLOR
	statusLabel.Font = Enum.Font.Gotham
	statusLabel.TextSize = 10
	statusLabel.TextXAlignment = Enum.TextXAlignment.Left
	statusLabel.Parent = statusFrame

	-- Signature Label
	signatureLabel = Instance.new("TextLabel")
	signatureLabel.Name = "SignatureLabel"
	signatureLabel.Size = UDim2.new(1, -20, 0, 15)
	signatureLabel.Position = UDim2.new(0, 10, 1, -20)
	signatureLabel.Text = "By: xXHaNdEROXx TG@MK14CFG"
	signatureLabel.BackgroundTransparency = 1
	signatureLabel.TextColor3 = CONFIG.SECONDARY_TEXT_COLOR
	signatureLabel.Font = Enum.Font.Gotham
	signatureLabel.TextSize = 8
	signatureLabel.TextTransparency = 0.5
	signatureLabel.TextXAlignment = Enum.TextXAlignment.Center
	signatureLabel.Parent = mainFrame

	-- Sound
	sound = Instance.new("Sound")
	sound.Name = "ToggleSound"
	sound.SoundId = CONFIG.SOUND_ID
	sound.Volume = 0.5
	sound.Parent = screenGui

	-- Store status label for updates
	_G.statusLabel = statusLabel
end

-- Event Connections
local function connectEvents(): ()
	-- Button connections
	toggleButton.MouseButton1Click:Connect(toggleInvisibility)
	speedButton.MouseButton1Click:Connect(toggleSpeedBoost)
	closeButton.MouseButton1Click:Connect(function()
		screenGui.Enabled = false
	end)

	-- Keyboard input
	UserInputService.InputBegan:Connect(function(input: InputObject, gameProcessed: boolean)
		if gameProcessed then
			return
		end

		if input.KeyCode == CONFIG.TOGGLE_KEY then
			toggleInvisibility()
		end
	end)

	-- Character respawn handling
	player.CharacterAdded:Connect(function(character: Model)
		resetPlayerState()

		local humanoid = character:WaitForChild("Humanoid") :: Humanoid
		playerState.originalSpeed = humanoid.WalkSpeed
		humanoid.WalkSpeed = CONFIG.DEFAULT_SPEED

		-- Clean up any existing invisible chairs
		local invisChair = workspace:FindFirstChild("invischair")
		if invisChair then
			invisChair:Destroy()
		end
	end)

	-- Handle player leaving
	Players.PlayerRemoving:Connect(function(leavingPlayer: Player)
		if leavingPlayer == player then
			local invisChair = workspace:FindFirstChild("invischair")
			if invisChair then
				invisChair:Destroy()
			end
		end
	end)
end

-- Initialize
local function initialize(): ()
	-- Wait for character to load
	if not player.Character then
		player.CharacterAdded:Wait()
	end

	-- Store original speed
	local humanoid = getHumanoid()
	if humanoid then
		playerState.originalSpeed = humanoid.WalkSpeed
	end

	-- Create GUI and connect events
	createGUI()
	connectEvents()

	print("Enhanced Invisibility Script loaded successfully!")
end

-- Start the script
initialize()
      Rayfield:Notify({
         Title = "FE invisibility",
         Content = "FE invisibility script has loaded to your ass", 
         Duration = 3, 
         Image = 4483362458 
      }) 
  end,
})

local Section3_5 = Tab3:CreateSection("ServerSide GUI or Script (Copy to clipboard only and executed in suported game)")

local Button3_25 = Tab3:CreateButton({
   Name = "Project fuckin Sonic",
   Callback = function()
      Rayfield:Notify({
         Title = "Project fuckin Sonic",
         Content = "Project fuckin Sonic script copied to clipboard!",
         Duration = 3,
         Image = 4483362458,
      })
      setclipboard('require(5104783290).projectreptilev3leaklolz("urname")') -- Change this to your actual Discord invite
   end,
})

local Button3_26 = Tab3:CreateButton({
   Name = "Polara SS script",
   Callback = function()
      Rayfield:Notify({
         Title = "Polara SS script",
         Content = "Polara SS script copied to clipboard!",
         Duration = 3,
         Image = 4483362458,
      })
      setclipboard('require(123255432303221):Pload("Name")') -- Change this to your actual Discord invite
   end,
})

local Button3_27 = Tab3:CreateButton({
   Name = "Happy SS script",
   Callback = function()
      Rayfield:Notify({
         Title = "Happy SS script",
         Content = "Happy SS script copied to clipboard!",
         Duration = 3,
         Image = 4483362458,
      })
      setclipboard('require(78790302691160):Hload("Your-username")')
   end,
})

-- ═══════════════════════════════════════
-- TAB 4: HUBS
-- ═══════════════════════════════════════

local Section4_1 = Tab4:CreateSection("Universal Hubs")

local Button4_1 = Tab4:CreateButton({
   Name = "Owl Hub",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/CriShoux/OwlHub/master/OwlHub.txt"))()
      Rayfield:Notify({
         Title = "Owl Hub",
         Content = "Owl Hub loaded successfully!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Button4_2 = Tab4:CreateButton({
   Name = "YunusLol1545 GUI",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/yunus154524/YunusLo1545-HUB/refs/heads/main/YunusLo1545%20HUB"))()
      Rayfield:Notify({
         Title = "YunusLol1545 GUI",
         Content = "YunusLol1545 GU loaded!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Button4_3 = Tab4:CreateButton({
   Name = "Orca Hub",
   Callback = function()
      loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/richie0866/orca/master/public/latest.lua"))()
      Rayfield:Notify({
         Title = "Orca Hub",
         Content = "Orca Universal Hub loaded!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Button4_4 = Tab4:CreateButton({
   Name = "Pendulum Hub",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/Pend00/PendulumHubMain/main/Main.lua"))()
      Rayfield:Notify({
         Title = "Pendulum Hub",
         Content = "Pendulum Universal Hub loaded!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Button4_5 = Tab4:CreateButton({
   Name = "Rob Visual (Mized with Fe and client) Hubs",
   Callback = function()
      loadstring(game:HttpGet("https://pastebin.com/raw/KSvbtcPE"))()
      Rayfield:Notify({
         Title = "Rob Visual Hubs",
         Content = "Rob Visual Hubs loaded for all games!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Section4_2 = Tab4:CreateSection("FE GUIS")

local Button4_6 = Tab4:CreateButton({
   Name = "Sky Hub",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/SkyHub.txt"))()
      Rayfield:Notify({
         Title = "Sky Hub",
         Content = "Sky Hub loaded successfully!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Button4_7 = Tab4:CreateButton({
   Name = "Arosia FE GUI",
   Callback = function()
      loadstring(Game:GetObjects("rbxassetid://1255908305")[1].Source)()
      Rayfield:Notify({
         Title = "Arosia FE GUI",
         Content = "Arosia FE GUI loaded successfully!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Button4_7b = Tab4:CreateButton({
   Name = "FE Trolling GUI",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/FE%20Trolling%20GUI.luau"))()
      Rayfield:Notify({
         Title = "FE Trolling GUI",
         Content = "FE Trolling GUI loaded successfully!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Section4_3 = Tab4:CreateSection("Additional Universal Hubs")

local Button4_8 = Tab4:CreateButton({
   Name = "Lascko's SB GUI",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/lukee5644/lukee5644/refs/heads/main/Lascko's%20SB%20gui",true))()
      Rayfield:Notify({
         Title = "Lascko's SB GUI",
         Content = "Lascko's SB GUI loaded successfully!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Button4_9 = Tab4:CreateButton({
   Name = "Universal Hub Script",
   Callback = function()
      loadstring(game:HttpGet("https://pastebin.com/raw/AZ2AXiay"))()
      Rayfield:Notify({
         Title = "Universal Hub",
         Content = "Universal Hub script loaded!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Button4_10 = Tab4:CreateButton({
   Name = "Ez Hub",
   Callback = function()
      loadstring(game:HttpGet("https://obj.wearedevs.net/2/scripts/Ez%20Hub.lua"))()
      Rayfield:Notify({
         Title = "Ez Hub",
         Content = "Ez Hub loaded successfully!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Button4_11 = Tab4:CreateButton({
   Name = "Solara Hub v3",
   Callback = function()
      loadstring(game:HttpGet("https://obj.wearedevs.net/2/scripts/Solara%20Hub%20v3.lua"))()
      Rayfield:Notify({
         Title = "Solara Hub v3",
         Content = "Solara Hub v3 loaded! (Has key system)",
         Duration = 4,
         Image = 4483362458,
      })
   end,
})

local Button4_12 = Tab4:CreateButton({
   Name = "Coolkid GUI v1",
   Callback = function()
      loadstring(game:HttpGet("https://obj.wearedevs.net/205803/scripts/Coolkid%20gui%20v1.lua"))()
      Rayfield:Notify({
         Title = "Coolkid GUI v1",
         Content = "Coolkid GUI v1 loaded successfully!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Button4_13 = Tab4:CreateButton({
   Name = "KRware Script Hub",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/KRWareHub/KRWare/refs/heads/main/KRWare%20Hub%20Loader.lua"))()
      Rayfield:Notify({
         Title = "KRware Script Hub",
         Content = "KRware Script Hub loaded successfully!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Button4_14 = Tab4:CreateButton({
   Name = "FE Transalator GUI",
   Callback = function()
      
--[[
    All-in-One Chat Translator with UI (Compact & Searchable Version)
    - Translates outgoing messages to a selected language or into a "Jumble" mode.
    - Translates incoming messages into English.
    - Features a compact, draggable, and collapsible UI with 100 languages
      visually separated by category.
    - NEW: Includes a search bar to instantly filter the language list.
--]]

-- Wait for the game to be fully loaded.
if not game:IsLoaded() then game.Loaded:Wait() end
repeat task.wait(.06) until game:GetService("Players").LocalPlayer

-- Services
local Http = game:GetService("HttpService")
local Players = game:GetService("Players")
local TCS = game:GetService("TextChatService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local LP = Players.LocalPlayer

-- Translator State
local isTranslatorActive = false -- Translator is disabled by default.
local isJumbleActive = false -- Jumble mode is disabled by default.
local yourLanguage = "en" -- Language for incoming messages.
local targetLanguage = nil -- Target language for your outgoing messages (starts as none).

-- A structured array of tables,
-- This new structure allows us. to build the UI in a specific order.
local languageCategories = {
    {
        Name = "Global & Constructed",
        Languages = {
            ["English (USA/UK)"] = "en",
            ["Esperanto (Global)"] = "eo",
            ["Latin (Global)"] = "la"
        }
    },
    {
        Name = "African Languages",
        Languages = {
            ["Afrikaans (South Africa)"] = "af",
            ["Amharic (Ethiopia)"] = "am",
            ["Hausa (Nigeria)"] = "ha",
            ["Igbo (Nigeria)"] = "ig",
            ["Malagasy (Madagascar)"] = "mg",
            ["Sesotho (Lesotho)"] = "st",
            ["Shona (Zimbabwe)"] = "sn",
            ["Somali (Somalia)"] = "so",
            ["Swahili (Tanzania/Kenya)"] = "sw",
            ["Xhosa (South Africa)"] = "xh",
            ["Yoruba (Nigeria)"] = "yo",
            ["Zulu (South Africa)"] = "zu"
        }
    },
    {
        Name = "Asian Languages",
        Languages = {
            ["Armenian (Armenia)"] = "hy",
            ["Azerbaijani (Azerbaijan)"] = "az",
            ["Bengali (Bangladesh)"] = "bn",
            ["Burmese (Myanmar)"] = "my",
            ["Chinese (China)"] = "zh-cn",
            ["Georgian (Georgia)"] = "ka",
            ["Gujarati (India)"] = "gu",
            ["Hindi (India)"] = "hi",
            ["Hmong (China/Vietnam)"] = "hmn",
            ["Indonesian (Indonesia)"] = "id",
            ["Japanese (Japan)"] = "ja",
            ["Javanese (Indonesia)"] = "jw",
            ["Kannada (India)"] = "kn",
            ["Kazakh (Kazakhstan)"] = "kk",
            ["Khmer (Cambodia)"] = "km",
            ["Korean (South Korea)"] = "ko",
            ["Kurdish (Kurdistan)"] = "ku",
            ["Kyrgyz (Kyrgyzstan)"] = "ky",
            ["Lao (Laos)"] = "lo",
            ["Malay (Malaysia)"] = "ms",
            ["Malayalam (India)"] = "ml",
            ["Marathi (India)"] = "mr",
            ["Mongolian (Mongolia)"] = "mn",
            ["Nepali (Nepal)"] = "ne",
            ["Pashto (Afghanistan)"] = "ps",
            ["Punjabi (India/Pakistan)"] = "pa",
            ["Sindhi (Pakistan)"] = "sd",
            ["Sinhala (Sri Lanka)"] = "si",
            ["Sundanese (Indonesia)"] = "su",
            ["Tajik (Tajikistan)"] = "tg",
            ["Tamil (India/Sri Lanka)"] = "ta",
            ["Telugu (India)"] = "te",
            ["Thai (Thailand)"] = "th",
            ["Urdu (Pakistan/India)"] = "ur",
            ["Uzbek (Uzbekistan)"] = "uz",
            ["Vietnamese (Vietnam)"] = "vi"
        }
    },
    {
        Name = "European Languages",
        Languages = {
            ["Albanian (Albania)"] = "sq",
            ["Basque (Spain/France)"] = "eu",
            ["Belarusian (Belarus)"] = "be",
            ["Bosnian (Bosnia)"] = "bs",
            ["Bulgarian (Bulgaria)"] = "bg",
            ["Catalan (Spain)"] = "ca",
            ["Corsican (France)"] = "co",
            ["Croatian (Croatia)"] = "hr",
            ["Czech (Czechia)"] = "cs",
            ["Danish (Denmark)"] = "da",
            ["Dutch (Netherlands)"] = "nl",
            ["Estonian (Estonia)"] = "et",
            ["Finnish (Finland)"] = "fi",
            ["French (France/Canada)"] = "fr",
            ["Frisian (Netherlands)"] = "fy",
            ["Galician (Spain)"] = "gl",
            ["German (Germany)"] = "de",
            ["Greek (Greece)"] = "el",
            ["Hungarian (Hungary)"] = "hu",
            ["Icelandic (Iceland)"] = "is",
            ["Irish (Ireland)"] = "ga",
            ["Italian (Italy)"] = "it",
            ["Latvian (Latvia)"] = "lv",
            ["Lithuanian (Lithuania)"] = "lt",
            ["Luxembourgish (Luxembourg)"] = "lb",
            ["Macedonian (N. Macedonia)"] = "mk",
            ["Maltese (Malta)"] = "mt",
            ["Norwegian (Norway)"] = "no",
            ["Polish (Poland)"] = "pl",
            ["Portuguese (Portugal/Brazil)"] = "pt",
            ["Romanian (Romania)"] = "ro",
            ["Russian (Russia)"] = "ru",
            ["Scots Gaelic (Scotland)"] = "gd",
            ["Serbian (Serbia)"] = "sr",
            ["Slovak (Slovakia)"] = "sk",
            ["Slovenian (Slovenia)"] = "sl",
            ["Spanish (Spain/Mexico)"] = "es",
            ["Swedish (Sweden)"] = "sv",
            ["Ukrainian (Ukraine)"] = "uk",
            ["Welsh (Wales)"] = "cy"
        }
    },
    {
        Name = "Middle Eastern Languages",
        Languages = {
            ["Arabic (Saudi Arabia)"] = "ar",
            ["Hebrew (Israel)"] = "iw",
            ["Persian (Iran)"] = "fa",
            ["Turkish (Turkey)"] = "tr",
            ["Yiddish (Israel/USA)"] = "yi"
        }
    },
    {
        Name = "North & Central American",
        Languages = {
            ["Haitian Creole (Haiti)"] = "ht"
        }
    },
    {
        Name = "Oceanian Languages",
        Languages = {
            ["Cebuano (Philippines)"] = "ceb",
            ["Filipino (Philippines)"] = "tl",
            ["Hawaiian (USA)"] = "haw",
            ["Maori (New Zealand)"] = "mi",
            ["Samoan (Samoa)"] = "sm"
        }
    }
}

-- Create flat tables for the existing logic to use.
-- 'languages' maps the full name "Language (Country)" to its code "lg".
-- 'langCodesArray' is just a list of all codes for Jumble mode.
local languages = {}
local langCodesArray = {}

for _, categoryData in ipairs(languageCategories) do
    for langName, langCode in pairs(categoryData.Languages) do
        languages[langName] = langCode
        table.insert(langCodesArray, langCode)
    end
end

--region Translation API Functions
-- This section handles the connection to the translation service.

local gv -- Google consent value.
local function req(opt)
	local fn = (syn and syn.request) or (http and http.request) or http_request or request
	if fn then return fn(opt) end
	return Http:RequestAsync(opt)
end

local function consent(body)
	local t = {}
	for tag in body:gmatch('<input type="hidden" name=".-" value=".-">') do
		local k, v = tag:match('<input type="hidden" name="(.-)" value="(.-)">')
		t[k] = v
	end
	gv = t.v or ""
end

local function got(url, method, body)
	method = method or "GET"
	local res = req({Url = url, Method = method, Headers = {cookie = "CONSENT=YES+" .. (gv or "")}, Body = body})
	local b = res.Body or res.body or ""
	if type(b) ~= "string" then b = tostring(b) end
	if b:match("https://consent.google.com/s") then
		consent(b)
		res = req({Url = url, Method = "GET", Headers = {cookie = "CONSENT=YES+" .. (gv or "")}})
	end
	return res
end

local function q(data)
	local s = ""
	for k, v in pairs(data) do
		if type(v) == "table" then
			for _, vv in pairs(v) do s ..= "&" .. Http:UrlEncode(k) .. "=" .. Http:UrlEncode(vv) end
		else
			s ..= "&" .. Http:UrlEncode(k) .. "=" .. Http:UrlEncode(v)
		end
	end
	return s:sub(2)
end

local jE = function(x) return Http:JSONEncode(x) end
local jD = function(x) return Http:JSONDecode(x) end

local rpc = "MkEWBc"
local root = "https://translate.google.com/"
local exec = "https://translate.google.com/_/TranslateWebserverUi/data/batchexecute"

local fsid, bl, rid = nil, nil, math.random(1000, 9999)
do
	local b = (got(root).Body or "")
	fsid = b:match('"FdrFJe":"(.-)"')
	bl = b:match('"cfb2h":"(.-)"')
end

local function translate(txt, tgt, src)
	rid += 10000
	src = src or "auto"
	local data = {{txt, src, tgt, true}, {nil}}
	local freq = {{{rpc, jE(data), nil, "generic"}}}
	local url = exec .. "?" .. q{rpcids = rpc, ["f.sid"] = fsid, bl = bl, hl = "en", _reqID = rid - 10000, rt = "c"}
	local body = q{["f.req"] = jE(freq)}
	local res = got(url, "POST", body)
	local ok, out = pcall(function()
		local arr = jD((res.Body or ""):match("%[.-%]\n"))
		return jD(arr[1][3])
	end)
	if not ok then return nil end
	return out[2][1][1][6][1][1]
end

local function translateInfo(txt, tgt, src)
	rid += 10000
	src = src or "auto"
	local data = {{txt, src, tgt, true}, {nil}}
	local freq = {{{rpc, jE(data), nil, "generic"}}}
	local url = exec .. "?" .. q{rpcids = rpc, ["f.sid"] = fsid, bl = bl, hl = "en", _reqID = rid - 10000, rt = "c"}
	local body = q{["f.req"] = jE(freq)}
	local res = got(url, "POST", body)
	local ok, out = pcall(function()
		local arr = jD((res.Body or ""):match("%[.-%]\n"))
		return jD(arr[1][3])
	end)
	if not ok or not out then return nil, nil end
	return out[2][1][1][6][1][1], out[3]
end

--endregion

--region Chat Helper Functions
-- This section manages sending messages and interacting with the chat UI.

local function sys(msg)
	local chans = TCS:WaitForChild("TextChannels", 60)
	if not chans then return end
	local c = chans:FindFirstChild("RBXSystem") or chans:FindFirstChild("RBXGeneral") or chans:GetChildren()[1]
	if c and c.DisplaySystemMessage then
		c:DisplaySystemMessage(msg)
	end
end

local function defaultChannel()
	return TCS.TextChannels:FindFirstChild("RBXGeneral") or TCS.TextChannels:FindFirstChild("General") or TCS.TextChannels:FindFirstChild("RBXSystem")
end

local function sendChat(text)
	task.spawn(function()
		local chan = defaultChannel()
		if chan then
			chan:SendAsync(text)
		end
	end)
end

-- This function intercepts your outgoing chat messages to perform translation.
local function handleOutgoing(rawMessage)
	-- Ignore commands (e.g., /w, /team).
	if rawMessage:sub(1, 1) == "/" then return false end

	-- Jumble mode is for fun. It translates each word separately into a random language.
	-- This mode intentionally breaks grammar and punctuation.
	if isJumbleActive then
		local words = {}
		for word in rawMessage:gmatch("%S+") do
			table.insert(words, word)
		end
		
		local translatedWords = {}
		for _, word in ipairs(words) do
			local randomLangCode = langCodesArray[math.random(#langCodesArray)]
			local translatedWord = translate(word, randomLangCode, "auto") or word
			table.insert(translatedWords, translatedWord)
		end
		
		sendChat(table.concat(translatedWords, " "))
		return true

	-- Standard translator mode.
	elseif isTranslatorActive and targetLanguage then
		-- The entire message (rawMessage) is sent to the translation function.
		-- This provides context, allowing the API to handle grammar, word order, and
		-- punctuation correctly, resulting in a much more natural and accurate translation.
		local translatedText = translate(rawMessage, targetLanguage, "auto") or rawMessage
		sendChat(translatedText)
		return true
	end

	-- If the translator is off, the message is sent normally.
	return false
end

--endregion

--region UI Creation
-- This section creates the graphical user interface.

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TranslatorUI"
screenGui.Parent = CoreGui
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Parent = screenGui
mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
mainFrame.BorderColor3 = Color3.fromRGB(80, 80, 80)
mainFrame.BorderSizePixel = 1
mainFrame.Position = UDim2.new(0, 20, 0, 20)
mainFrame.Size = UDim2.new(0, 280, 0, 30)
mainFrame.ClipsDescendants = true
mainFrame.Active = true
mainFrame.Draggable = true

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.Parent = mainFrame
titleLabel.BackgroundTransparency = 1
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.Size = UDim2.new(0, 100, 0, 30)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.Text = "Translator"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 16
titleLabel.TextXAlignment = Enum.TextXAlignment.Left

local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Parent = mainFrame
toggleButton.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
toggleButton.Size = UDim2.new(0, 25, 0, 20)
toggleButton.Position = UDim2.new(1, -30, 0.5, -10)
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.Text = "[+]"
toggleButton.TextColor3 = Color3.fromRGB(200, 200, 200)
toggleButton.TextSize = 16
toggleButton.ZIndex = 2

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Name = "ScrollFrame"
scrollFrame.Parent = mainFrame
scrollFrame.BackgroundTransparency = 1
scrollFrame.Position = UDim2.new(0, 0, 0, 30)
scrollFrame.Size = UDim2.new(1, 0, 1, -30)
scrollFrame.Visible = false
scrollFrame.ZIndex = 1
scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(120, 120, 120)
scrollFrame.ScrollBarThickness = 6
scrollFrame.BorderSizePixel = 0

local listLayout = Instance.new("UIListLayout")
listLayout.Parent = scrollFrame
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Padding = UDim.new(0, 5)

local controlFrame = Instance.new("Frame")
controlFrame.Name = "ControlFrame"
controlFrame.Parent = scrollFrame
controlFrame.BackgroundTransparency = 1
controlFrame.Size = UDim2.new(1, 0, 0, 30) -- Height for one row of buttons
controlFrame.AutomaticSize = Enum.AutomaticSize.Y
controlFrame.LayoutOrder = 1 -- Place this at the top.

local controlGrid = Instance.new("UIGridLayout")
controlGrid.Parent = controlFrame
controlGrid.CellPadding = UDim2.new(0, 5, 0, 5)
controlGrid.CellSize = UDim2.new(0, 85, 0, 25)
controlGrid.StartCorner = Enum.StartCorner.TopLeft
controlGrid.HorizontalAlignment = Enum.HorizontalAlignment.Center
controlGrid.SortOrder = Enum.SortOrder.LayoutOrder

local stopButton = Instance.new("TextButton")
stopButton.Name = "StopButton"
stopButton.Parent = controlFrame
stopButton.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
stopButton.BorderColor3 = Color3.fromRGB(80, 80, 80)
stopButton.Font = Enum.Font.SourceSansBold
stopButton.Text = "Stop"
stopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
stopButton.TextSize = 14
stopButton.LayoutOrder = 1 -- First item in this grid.

local jumbleButton = Instance.new("TextButton")
jumbleButton.Name = "JumbleButton"
jumbleButton.Parent = controlFrame
jumbleButton.BackgroundColor3 = Color3.fromRGB(120, 60, 180) -- A unique purple color.
jumbleButton.BorderColor3 = Color3.fromRGB(80, 80, 80)
jumbleButton.Font = Enum.Font.SourceSansBold
jumbleButton.Text = "Jumble"
jumbleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
jumbleButton.TextSize = 14
jumbleButton.LayoutOrder = 2 -- Second item in this grid.

-- NEW: Add a search bar
local searchBoxFrame = Instance.new("Frame")
searchBoxFrame.Name = "SearchBoxFrame"
searchBoxFrame.Parent = scrollFrame
searchBoxFrame.BackgroundTransparency = 1
searchBoxFrame.Size = UDim2.new(1, -10, 0, 25)
searchBoxFrame.Position = UDim2.new(0, 5, 0, 0)
searchBoxFrame.LayoutOrder = 2 -- Place it after controls.

local searchBoxLabel = Instance.new("TextLabel")
searchBoxLabel.Name = "SearchLabel"
searchBoxLabel.Parent = searchBoxFrame
searchBoxLabel.BackgroundTransparency = 1
searchBoxLabel.Size = UDim2.new(0, 60, 1, 0)
searchBoxLabel.Font = Enum.Font.SourceSans
searchBoxLabel.Text = "Search: "
searchBoxLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
searchBoxLabel.TextSize = 14
searchBoxLabel.TextXAlignment = Enum.TextXAlignment.Left

local searchBox = Instance.new("TextBox")
searchBox.Name = "SearchBox"
searchBox.Parent = searchBoxFrame
searchBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
searchBox.BorderColor3 = Color3.fromRGB(80, 80, 80)
searchBox.Position = UDim2.new(0, 60, 0, 0)
searchBox.Size = UDim2.new(1, -65, 1, 0)
searchBox.Font = Enum.Font.SourceSans
searchBox.Text = ""
searchBox.TextColor3 = Color3.fromRGB(240, 240, 240)
searchBox.TextSize = 14
searchBox.PlaceholderText = "Type to filter..."
searchBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
searchBox.ClearTextOnFocus = false

-- This table will store all button instances for the click logic.
local langButtons = {}
-- NEW: This table stores UI elements by category for filtering.
local categoryElements = {}
local categoryLayoutOrder = 3 -- Start after the control frame and search bar.

-- CHANGE: Loop through the new 'languageCategories' array to build the UI.
for _, categoryData in ipairs(languageCategories) do
    
    -- 1. Create the Category Header (e.g., "Asian Languages")
    local headerLabel = Instance.new("TextLabel")
    headerLabel.Name = categoryData.Name .. "Header"
    headerLabel.Parent = scrollFrame
    headerLabel.BackgroundTransparency = 1
    headerLabel.Size = UDim2.new(1, -10, 0, 20)
    headerLabel.Position = UDim2.new(0, 5, 0, 0)
    headerLabel.Font = Enum.Font.SourceSansBold
    headerLabel.Text = categoryData.Name
    headerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    headerLabel.TextSize = 16
    headerLabel.TextXAlignment = Enum.TextXAlignment.Left
    headerLabel.LayoutOrder = categoryLayoutOrder
    categoryLayoutOrder += 1
    
    -- 2. Create a container Frame for this category's buttons
    local buttonContainer = Instance.new("Frame")
    buttonContainer.Name = categoryData.Name .. "Container"
    buttonContainer.Parent = scrollFrame
    buttonContainer.BackgroundTransparency = 1
    buttonContainer.Size = UDim2.new(1, 0, 0, 50) -- Height will be set by AutomaticSize
    buttonContainer.AutomaticSize = Enum.AutomaticSize.Y
    buttonContainer.LayoutOrder = categoryLayoutOrder
    categoryLayoutOrder += 1
    
    -- 3. Add a UIGridLayout to this specific container
    local gridLayout = Instance.new("UIGridLayout")
    gridLayout.Parent = buttonContainer
    gridLayout.CellPadding = UDim2.new(0, 5, 0, 5)
    gridLayout.CellSize = UDim2.new(0, 85, 0, 25)
    gridLayout.StartCorner = Enum.StartCorner.TopLeft
    gridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    gridLayout.SortOrder = Enum.SortOrder.Name -- Sort alphabetically within the category.
    
    -- 4. Get, sort, and create the buttons for this category
    local sortedLangNames = {}
    for langName in pairs(categoryData.Languages) do
        table.insert(sortedLangNames, langName)
    end
    table.sort(sortedLangNames)
    
    -- NEW: Store buttons locally for this category
    local categoryButtons = {}
    for _, langName in ipairs(sortedLangNames) do
        local button = Instance.new("TextButton")
        button.Name = langName
        button.Parent = buttonContainer
        button.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
        button.BorderColor3 = Color3.fromRGB(80, 80, 80)
        button.Font = Enum.Font.SourceSans
        button.Text = langName
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.TextSize = 12
        langButtons[langName] = button -- Add to the master list for click logic.
        categoryButtons[langName] = button -- NEW: Add to local list for filter logic.
    end
    
    -- NEW: Add the category's UI elements to the filter table
    table.insert(categoryElements, {
        header = headerLabel,
        container = buttonContainer,
        buttons = categoryButtons
    })
end

--endregion

--region UI Logic

-- NEW: Function to filter the list based on search text
local function updateFilter(searchText)
    local searchTextLower = string.lower(searchText)
    
    -- If search is empty, show everything
    if searchTextLower == "" then
        for _, category in ipairs(categoryElements) do
            category.header.Visible = true
            category.container.Visible = true
            for _, button in pairs(category.buttons) do
                button.Visible = true
            end
        end
        return
    end
    
    -- If search has text, filter
    for _, category in ipairs(categoryElements) do
        local anyButtonVisible = false
        
        -- Check each button in this category
        for langName, button in pairs(category.buttons) do
            local langNameLower = string.lower(langName)
            if string.find(langNameLower, searchTextLower) then
                button.Visible = true
                anyButtonVisible = true
            else
                button.Visible = false
            end
        end
        
        -- Show/hide the category header and container
        category.header.Visible = anyButtonVisible
        category.container.Visible = anyButtonVisible
    end
end

local isExpanded = false
toggleButton.MouseButton1Click:Connect(function()
    isExpanded = not isExpanded
    scrollFrame.Visible = isExpanded
    if isExpanded then
        toggleButton.Text = "[-]"
        mainFrame.Size = UDim2.new(0, 280, 0, 300)
        -- NEW: Reset the filter when opening
        searchBox.Text = ""
        updateFilter("") 
    else
        toggleButton.Text = "[+]"
        mainFrame.Size = UDim2.new(0, 280, 0, 30)
    end
end)

local function resetButtonColors()
    for _, button in pairs(langButtons) do
        button.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
    end
    stopButton.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
    jumbleButton.BackgroundColor3 = Color3.fromRGB(120, 60, 180)
end

-- This logic works perfectly with no changes, since we still
-- populated the 'langButtons' and 'languages' tables.
for langName, button in pairs(langButtons) do
    button.MouseButton1Click:Connect(function()
        resetButtonColors()
        button.BackgroundColor3 = Color3.fromRGB(70, 115, 190)
        isTranslatorActive = true
        isJumbleActive = false -- Deactivate Jumble mode.
        targetLanguage = languages[langName]
        sys("[TR] Translator enabled. Language set to " .. langName .. ".")
    end)
end

stopButton.MouseButton1Click:Connect(function()
    resetButtonColors()
    isTranslatorActive = false
    isJumbleActive = false -- Deactivate Jumble mode.
    targetLanguage = nil
    sys("[TR] Auto-translation DISABLED.")
end)

jumbleButton.MouseButton1Click:Connect(function()
    resetButtonColors()
    jumbleButton.BackgroundColor3 = Color3.fromRGB(160, 90, 220) -- Highlight color.
    isTranslatorActive = false
    isJumbleActive = true
    targetLanguage = nil
    sys("[TR] Jumble mode ENABLED. Have fun!")
end)

-- NEW: Connect the search box to the filter function
searchBox.Changed:Connect(function()
    updateFilter(searchBox.Text)
end)

--endregion

--region Main Logic
-- This section hooks into the chat system.

task.spawn(function()
	repeat task.wait() until CoreGui:FindFirstChild("ExperienceChat")
	local experienceChat = CoreGui:WaitForChild("ExperienceChat")
	local appLayout = experienceChat:WaitForChild("appLayout")
	local chatInputBar = appLayout:WaitForChild("chatInputBar")
	local background = chatInputBar:WaitForChild("Background")
	local container = background:WaitForChild("Container")
	local textContainer = container:WaitForChild("TextContainer")
	local textBoxContainer = textContainer:WaitForChild("TextBoxContainer")
	local textBox = textBoxContainer:WaitForChild("TextBox")
	local sendButton = container:WaitForChild("SendButton")

	local function onSend()
		local messageText = textBox.Text
		if messageText == "" then return end
		textBox.Text = ""
		-- The handleOutgoing function will decide if the message needs translation.
		if not handleOutgoing(messageText) then
			-- If not translated, send the original message.
			sendChat(messageText)
		end
	end

	textBox.FocusLost:Connect(function(enterPressed)
		if enterPressed then onSend() end
	end)
	sendButton.MouseButton1Click:Connect(onSend)
end)

TCS.MessageReceived:Connect(function(msg)
	-- Don't translate your own messages or system messages.
	if not msg.TextSource or msg.TextSource.UserId == LP.UserId then return end
	local userId = msg.TextSource.UserId
	local player = Players:GetPlayerByUserId(userId)
	local displayName = player and player.DisplayName or tostring(userId)
	local userName = player and player.Name or tostring(userId)
	local nameString = (displayName == userName) and ("@" .. userName) or (displayName .. " (@" .. userName .. ")")
	
	-- Translate the incoming message into English.
	local text, detectedLang = translateInfo(msg.Text, yourLanguage, "auto")

	-- Display the translated message if the translation is different from the original.
	if text and text ~= "" and text ~= msg.Text then
		local langTag = detectedLang and detectedLang ~= "" and detectedLang:upper() or "AUTO"
		sys("(" .. langTag .. ") [" .. nameString .. "]: " .. text)
	end
end)

sys("[TR] Compact Translator UI loaded.")
sys("[TR] Click the [+] icon on the top-left bar to select a language.")

--MEME
      Rayfield:Notify({
         Title = "FE Transalator GUI",
         Content = "FE Transalator GUI loaded successfully!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Button4_15 = Tab4:CreateButton({
   Name = "Altair Script Hub",
   Callback = function()
      loadstring(game:HttpGet("https://pastefy.app/MxnvA12M/raw"))()
      Rayfield:Notify({
         Title = "Altair Script Hub",
         Content = "Altair Script Hub loaded successfully!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Section4_4 = Tab4:CreateSection("Keys system! Forget about Solara... ")

local Button4_16 = Tab4:CreateButton({
   Name = "Forge Script Hub",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/Skzuppy/forge-hub/main/loader.lua"))()
      Rayfield:Notify({
         Title = "Forge Script Hub",
         Content = "Forge Script Hub loaded successfully!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Button4_17 = Tab4:CreateButton({
   Name = "Xenith Script Hub",
   Callback = function()
      loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/d7be76c234d46ce6770101fded39760c.lua"))()
      Rayfield:Notify({
         Title = "Xenith Script Hub",
         Content = "Xenith Script Hub loaded successfully!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

-- ═══════════════════════════════════════
-- TAB 5: Our scripts and HUB
-- ═══════════════════════════════════════

local Section5_1 = Tab5:CreateSection("Custom ConTab Scripts")

local Button5_1 = Tab5:CreateButton({
   Name = "ConTab Custom Script",
   Callback = function()
      loadstring(game:HttpGet("https://pastebin.com/raw/13L3mMDb"))()
      Rayfield:Notify({
         Title = "ConTab Script",
         Content = "Custom script loaded successfully!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Button5_2 = Tab5:CreateButton({
   Name = "Ultimate Hubs (Made by MisterSSguy)",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/valentinoarvino2003-glitch/MisterSSguy/refs/heads/main/ULTIMATE%20.lua"))() 
      Rayfield:Notify({
         Title = "Ultimate gay hubs",
         Content = "Ultimate hubs is still in development!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Section5_2 = Tab5:CreateSection("About Our Scripts")

local Paragraph5_1 = Tab5:CreateParagraph({
   Title = "Our Mission",
   Content = "ConTab aims to provide quality scripts and tools for the Roblox community. We're constantly working on new features and improvements!"
})

-- ═══════════════════════════════════════
-- TAB 6: Game Specific (Scripts and Hubs)
-- ═══════════════════════════════════════

local Section6_1 = Tab6:CreateSection("Universal Scripts")

local Button6_1 = Tab6:CreateButton({
   Name = "Void Hub",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/VoidzyScripter/VoidHub-/main/Script"))()
      Rayfield:Notify({
         Title = "Void Hub",
         Content = "Void Hub loaded successfully!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Section6_2 = Tab6:CreateSection("Arsenal Scripts")

local Button6_2 = Tab6:CreateButton({
   Name = "TbaoHub Arsenal",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/tbao143/thaibao/main/TbaoHubArsenal"))()
      Rayfield:Notify({
         Title = "TbaoHub Arsenal",
         Content = "TbaoHub Arsenal script loaded!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Section6_3 = Tab6:CreateSection("Brookhaven Scripts")

local Button6_3 = Tab6:CreateButton({
   Name = "Brookhaven Script",
   Callback = function()
      loadstring(game:HttpGet("https://obj.wearedevs.net/200522/scripts/Brookhaven%20Roblox%20Script.lua"))()
      Rayfield:Notify({
         Title = "Brookhaven Script",
         Content = "Brookhaven script loaded! (Has key system)",
         Duration = 4,
         Image = 4483362458,
      })
   end,
})

local Button6_4 = Tab6:CreateButton({
   Name = "Brookhaven GUI",
   Callback = function()
      loadstring(game:HttpGet("https://pastebin.com/raw/AHg2NLqG"))()
      Rayfield:Notify({
         Title = "Brookhaven GUI",
         Content = "Brookhaven GUI loaded successfully!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Section6_4 = Tab6:CreateSection("Prison Life Scripts")

local Button6_5 = Tab6:CreateButton({
   Name = "TbaoHub Prison Life",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/tbao143/thaibao/main/TbaohubPrisonLife"))()
      Rayfield:Notify({
         Title = "TbaoHub Prison Life",
         Content = "TbaoHub Prison Life script loaded!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Button6_6 = Tab6:CreateButton({
   Name = "Suslik Hub Prison Life",
   Callback = function()
      loadstring(game:HttpGet('https://raw.githubusercontent.com/KrutoySuslik/-Prison-Life-/main/%7CSuslik%20Hub%7C%20%7CPrison%20Life%7C'))()
      Rayfield:Notify({
         Title = "Suslik Hub Prison Life",
         Content = "Suslik Hub Prison Life loaded!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Section6_5 = Tab6:CreateSection("Da Hood Scripts")

local Button6_7 = Tab6:CreateButton({
   Name = "Da Hood Script v1",
   Callback = function()
      loadstring(game:HttpGet('https://raw.githubusercontent.com/Zinzs/luascripting/main/canyoutellitsadahoodscriptornot.lua'))()
      Rayfield:Notify({
         Title = "Da Hood Script v1",
         Content = "Da Hood script v1 loaded successfully!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Button6_8 = Tab6:CreateButton({
   Name = "Vortex Da Hood",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/ImagineProUser/vortexdahood/main/vortex", true))()
      Rayfield:Notify({
         Title = "Vortex Da Hood",
         Content = "Vortex Da Hood script loaded!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Section6_6 = Tab6:CreateSection("Jailbreak Scripts")

local Button6_9 = Tab6:CreateButton({
   Name = "Jailbreak Auto Rob",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/Marco8642/science/main/jailbreak", true))()
      Rayfield:Notify({
         Title = "Jailbreak Auto Rob",
         Content = "Jailbreak Auto Rob loaded!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Button6_10 = Tab6:CreateButton({
   Name = "Jailbreak GUI",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/Denverrz/scripts/master/JAILBREAK.lua"))()
      Rayfield:Notify({
         Title = "Jailbreak GUI",
         Content = "Jailbreak GUI loaded!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Section6_7 = Tab6:CreateSection("Jailbreak Scripts")

local Button6_11 = Tab6:CreateButton({
   Name = "99 Nights In the Forest Script",
   Callback = function()
      loadstring(game:HttpGet("https://pastebin.com/raw/GreLQtfN"))()
      Rayfield:Notify({
         Title = "99 Nights In the Forest Script",
         Content = "99 Nights In the Forest Script loaded!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

-- ═══════════════════════════════════════
-- TAB 7: Admin Scripts
-- ═══════════════════════════════════════

local Section7_1 = Tab7:CreateSection("Popular Admin Commands")

local Button7_1 = Tab7:CreateButton({
   Name = "Infinite Yield FE Admin",
   Callback = function()
      loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
      Rayfield:Notify({
         Title = "Infinite Yield",
         Content = "Infinite Yield admin commands loaded!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Button7_2 = Tab7:CreateButton({
   Name = "CMD-X Admin",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/CMD-X/CMD-X/master/Source", true))()
      Rayfield:Notify({
         Title = "CMD-X Admin",
         Content = "CMD-X admin commands loaded!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Button7_3 = Tab7:CreateButton({
   Name = "Fates Admin",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/fatesc/fates-admin/main/main.lua"))()
      Rayfield:Notify({
         Title = "Fates Admin",
         Content = "Fates Admin commands loaded!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Button7_4 = Tab7:CreateButton({
   Name = "Reviz Admin",
   Callback = function()
      loadstring(game:HttpGet("https://pastebin.com/raw/Caniwq2N",true))()
      Rayfield:Notify({
         Title = "Reviz Admin",
         Content = "Reviz Admin loaded successfully!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Section7_2 = Tab7:CreateSection("Additional Admin Scripts")

local Button7_5 = Tab7:CreateButton({
   Name = "Homebrew Admin",
   Callback = function()
      loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Syntaxx64/HomebrewAdmin/master/Main.lua"))()
      Rayfield:Notify({
         Title = "Homebrew Admin",
         Content = "Homebrew Admin loaded!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Button7_6 = Tab7:CreateButton({
   Name = "Shattervast Admin",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/shattervast/scripts/main/shattervast_admin.lua"))()
      Rayfield:Notify({
         Title = "Shattervast Admin",
         Content = "Shattervast Admin loaded!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Button7_7 = Tab7:CreateButton({
   Name = "Pendulum Admin",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/Pend00/PendulumAdmin/main/Main.lua"))()
      Rayfield:Notify({
         Title = "Pendulum Admin",
         Content = "Pendulum Admin loaded!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Button7_8 = Tab7:CreateButton({
   Name = "Neptune Admin",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/Nepgearsy/Neptune-RBX/main/neptune.lua"))()
      Rayfield:Notify({
         Title = "Neptune Admin",
         Content = "Neptune Admin loaded!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Section7_3 = Tab7:CreateSection("Legacy Admin Scripts")

local Button7_9 = Tab7:CreateButton({
   Name = "Kohl's Admin",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/kohls-admin/kohls-admin/main/main.lua"))()
      Rayfield:Notify({
         Title = "Kohl's Admin",
         Content = "Kohl's Admin loaded!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Button7_10 = Tab7:CreateButton({
   Name = "Person299 Admin",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/PersonAdmin/PersonAdmin/main/main.lua"))()
      Rayfield:Notify({
         Title = "Person299 Admin",
         Content = "Person299 Admin loaded!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Button7_11 = Tab7:CreateButton({
   Name = "YCloud Admin",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/YCloud-Developments/ycloud/main/admin.lua"))()
      Rayfield:Notify({
         Title = "YCloud Admin",
         Content = "YCloud Admin loaded!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Section7_4 = Tab7:CreateSection("Server Control Tools")

local Button7_12 = Tab7:CreateButton({
   Name = "Server Destroyer",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/Pixeluted/adoniscries/main/Source.lua",true))()
      Rayfield:Notify({
         Title = "Server Destroyer",
         Content = "Server Destroyer loaded! Use responsibly!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Button7_13 = Tab7:CreateButton({
   Name = "Anti-Kick Script",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/Anti-Kick/main/Anti-Kick.lua"))()
      Rayfield:Notify({
         Title = "Anti-Kick",
         Content = "Anti-Kick protection enabled!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Button7_14 = Tab7:CreateButton({
   Name = "Server Crash",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/lerkermer/lua-projects/master/SuperPowersCrash.lua"))()
      Rayfield:Notify({
         Title = "Server Crash",
         Content = "Server Crash loaded! ⚠ Use carefully!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Section7_5 = Tab7:CreateSection("Admin Commands Info")

local Paragraph7_1 = Tab7:CreateParagraph({
   Title = "How to Use Admin Commands",
   Content = "After loading an admin script:\n• Type commands in chat (e.g., ;fly, ;speed 50)\n• Use prefixes like ; or :\n• Type ;cmds or ;help for command list\n• Some require specific permissions"
})

local Paragraph7_2 = Tab7:CreateParagraph({
   Title = "⚠ Warning",
   Content = "Use admin scripts responsibly!\n• Don't grief or ruin others' fun\n• Some scripts may get you kicked\n• Server tools are for emergencies only\n• Respect other players and server rules"
})

-- ═══════════════════════════════════════
-- TAB 8: Settings
-- ═══════════════════════════════════════

local Section8_1 = Tab8:CreateSection("GUI Settings")

local Toggle8_1 = Tab8:CreateToggle({
   Name = "UI Toggle Keybind (RightShift)",
   CurrentValue = true,
   Flag = "UIToggle",
   Callback = function(Value)
      Rayfield:Notify({
         Title = "UI Toggle",
         Content = Value and "Press RightShift to toggle UI" or "UI Toggle disabled",
         Duration = 2,
         Image = 4483362458,
      })
   end,
})

local Section8_2 = Tab8:CreateSection("Performance")

local Button8_1 = Tab8:CreateButton({
   Name = "FPS Booster",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/FPS%20Boost.lua"))()
      Rayfield:Notify({
         Title = "FPS Booster",
         Content = "FPS Booster activated!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Button8_2 = Tab8:CreateButton({
   Name = "Reduce Lag",
   Callback = function()
      -- Reduce graphics
      local lighting = game:GetService("Lighting")
      lighting.GlobalShadows = false
      lighting.FogEnd = 9e9
      
      for i, v in pairs(lighting:GetDescendants()) do
         if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
            v.Enabled = false
         end
      end
      
      settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
      
      Rayfield:Notify({
         Title = "Lag Reduction",
         Content = "Graphics optimized for performance!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Section8_3 = Tab8:CreateSection("Configuration")

local Button8_3 = Tab8:CreateButton({
   Name = "Reset Configuration",
   Callback = function()
      Rayfield:Notify({
         Title = "Configuration Reset",
         Content = "Configuration has been reset to default!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Button8_4 = Tab8:CreateButton({
   Name = "Load Configuration",
   Callback = function()
      Rayfield:Notify({
         Title = "Configuration",
         Content = "Configuration loaded successfully!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Section8_4 = Tab8:CreateSection("About ConTab")

local Paragraph8_1 = Tab8:CreateParagraph({
   Title = "ConTab Version",
   Content = "ConTab GUI v1.0\nMade by Connet and Tabex\nWith help from @MisterSSguy\n\nThank you for using ConTab!"
})

local Section8_5 = Tab8:CreateSection("GUI Controls")

local Button8_5 = Tab8:CreateButton({
   Name = "Rejoin Server",
   Callback = function()
      local ts = game:GetService("TeleportService")
      local p = game:GetService("Players").LocalPlayer
      ts:Teleport(game.PlaceId, p)
   end,
})

local Button8_6 = Tab8:CreateButton({
   Name = "Copy Game Link",
   Callback = function()
      setclipboard("https://www.roblox.com/games/" .. game.PlaceId)
      Rayfield:Notify({
         Title = "Game Link",
         Content = "Game link copied to clipboard!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

local Button8_7 = Tab8:CreateButton({
   Name = "Destroy GUI",
   Callback = function()
      Rayfield:Destroy()
      Rayfield:Notify({
         Title = "GUI Destroyed",
         Content = "ConTab GUI has been destroyed. Goodbye!",
         Duration = 2,
         Image = 4483362458,
      })
   end,
})