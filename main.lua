--// FTAP STYLE PANEL
--// One LocalScript
--// StarterPlayer > StarterPlayerScripts

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

--==================================================
-- SETTINGS
--==================================================

local PANEL_WIDTH = 390
local PANEL_HEIGHT = 300

local strength = 500
local antiGrabEnabled = true
local panelOpen = true
local dragging = false
local dragStart
local startPosition

--==================================================
-- GUI
--==================================================

local gui = Instance.new("ScreenGui")
gui.Name = "FTAPPanel"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = false
gui.DisplayOrder = 9999
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = playerGui

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.fromOffset(PANEL_WIDTH, PANEL_HEIGHT)
main.Position = UDim2.new(0.5, -PANEL_WIDTH / 2, 0.5, -PANEL_HEIGHT / 2)
main.BackgroundColor3 = Color3.fromRGB(30, 30, 33)
main.BorderSizePixel = 0
main.Active = true
main.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = main

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(65, 65, 70)
mainStroke.Thickness = 1
mainStroke.Transparency = 0.15
mainStroke.Parent = main

--==================================================
-- HEADER
--==================================================

local header = Instance.new("Frame")
header.Name = "Header"
header.BackgroundTransparency = 1
header.Size = UDim2.new(1, 0, 0, 48)
header.Active = true
header.Parent = main

local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Position = UDim2.fromOffset(17, 8)
title.Size = UDim2.new(1, -60, 0, 30)
title.Font = Enum.Font.GothamSemibold
title.Text = "Control"
title.TextColor3 = Color3.fromRGB(235, 235, 238)
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local close = Instance.new("TextButton")
close.BackgroundTransparency = 1
close.Position = UDim2.new(1, -42, 0, 9)
close.Size = UDim2.fromOffset(30, 30)
close.Font = Enum.Font.GothamMedium
close.Text = "×"
close.TextColor3 = Color3.fromRGB(155, 155, 160)
close.TextSize = 22
close.AutoButtonColor = false
close.Parent = header

close.MouseEnter:Connect(function()
	close.TextColor3 = Color3.fromRGB(235, 235, 238)
end)

close.MouseLeave:Connect(function()
	close.TextColor3 = Color3.fromRGB(155, 155, 160)
end)

close.MouseButton1Click:Connect(function()
	panelOpen = false
	main.Visible = false
end)

--==================================================
-- DRAGGING
--==================================================

local function updateDrag(input)
	local delta = input.Position - dragStart

	main.Position = UDim2.new(
		startPosition.X.Scale,
		startPosition.X.Offset + delta.X,
		startPosition.Y.Scale,
		startPosition.Y.Offset + delta.Y
	)
end

header.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPosition = main.Position
	end
end)

header.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragStart = dragStart
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		updateDrag(input)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

--==================================================
-- TABS
--==================================================

local tabs = Instance.new("Frame")
tabs.BackgroundTransparency = 1
tabs.Position = UDim2.fromOffset(15, 48)
tabs.Size = UDim2.new(1, -30, 0, 36)
tabs.Parent = main

local combatTab = Instance.new("TextButton")
combatTab.Name = "Combat"
combatTab.Size = UDim2.fromOffset(110, 34)
combatTab.BackgroundColor3 = Color3.fromRGB(55, 55, 60)
combatTab.BorderSizePixel = 0
combatTab.Font = Enum.Font.GothamMedium
combatTab.Text = "Combat"
combatTab.TextColor3 = Color3.fromRGB(235, 235, 238)
combatTab.TextSize = 13
combatTab.AutoButtonColor = false
combatTab.Parent = tabs

local combatCorner = Instance.new("UICorner")
combatCorner.CornerRadius = UDim.new(0, 8)
combatCorner.Parent = combatTab

local defenseTab = Instance.new("TextButton")
defenseTab.Name = "Defense"
defenseTab.Position = UDim2.fromOffset(118, 0)
defenseTab.Size = UDim2.fromOffset(110, 34)
defenseTab.BackgroundColor3 = Color3.fromRGB(40, 40, 43)
defenseTab.BorderSizePixel = 0
defenseTab.Font = Enum.Font.GothamMedium
defenseTab.Text = "Defense"
defenseTab.TextColor3 = Color3.fromRGB(190, 190, 195)
defenseTab.TextSize = 13
defenseTab.AutoButtonColor = false
defenseTab.Parent = tabs

local defenseCorner = Instance.new("UICorner")
defenseCorner.CornerRadius = UDim.new(0, 8)
defenseCorner.Parent = defenseTab

--==================================================
-- CONTENT
--==================================================

local content = Instance.new("Frame")
content.Name = "Content"
content.BackgroundTransparency = 1
content.Position = UDim2.fromOffset(15, 92)
content.Size = UDim2.new(1, -30, 1, -105)
content.Parent = main

--==================================================
-- COMBAT
--==================================================

local combatPage = Instance.new("Frame")
combatPage.Name = "CombatPage"
combatPage.BackgroundTransparency = 1
combatPage.Size = UDim2.fromScale(1, 1)
combatPage.Parent = content

local strengthTitle = Instance.new("TextLabel")
strengthTitle.BackgroundTransparency = 1
strengthTitle.Position = UDim2.fromOffset(5, 5)
strengthTitle.Size = UDim2.new(1, -85, 0, 24)
strengthTitle.Font = Enum.Font.GothamMedium
strengthTitle.Text = "Strength"
strengthTitle.TextColor3 = Color3.fromRGB(225, 225, 228)
strengthTitle.TextSize = 14
strengthTitle.TextXAlignment = Enum.TextXAlignment.Left
strengthTitle.Parent = combatPage

local strengthValue = Instance.new("TextLabel")
strengthValue.BackgroundTransparency = 1
strengthValue.Position = UDim2.new(1, -70, 0, 5)
strengthValue.Size = UDim2.fromOffset(65, 24)
strengthValue.Font = Enum.Font.GothamMedium
strengthValue.Text = tostring(strength)
strengthValue.TextColor3 = Color3.fromRGB(190, 190, 195)
strengthValue.TextSize = 13
strengthValue.TextXAlignment = Enum.TextXAlignment.Right
strengthValue.Parent = combatPage

local slider = Instance.new("Frame")
slider.Name = "Slider"
slider.Position = UDim2.fromOffset(5, 43)
slider.Size = UDim2.new(1, -10, 0, 7)
slider.BackgroundColor3 = Color3.fromRGB(55, 55, 59)
slider.BorderSizePixel = 0
slider.Active = true
slider.Parent = combatPage

local sliderCorner = Instance.new("UICorner")
sliderCorner.CornerRadius = UDim.new(1, 0)
sliderCorner.Parent = slider

local fill = Instance.new("Frame")
fill.Size = UDim2.new(strength / 1000, 0, 1, 0)
fill.BackgroundColor3 = Color3.fromRGB(150, 150, 155)
fill.BorderSizePixel = 0
fill.Parent = slider

local fillCorner = Instance.new("UICorner")
fillCorner.CornerRadius = UDim.new(1, 0)
fillCorner.Parent = fill

local knob = Instance.new("Frame")
knob.AnchorPoint = Vector2.new(0.5, 0.5)
knob.Position = UDim2.new(strength / 1000, 0, 0.5, 0)
knob.Size = UDim2.fromOffset(15, 15)
knob.BackgroundColor3 = Color3.fromRGB(230, 230, 233)
knob.BorderSizePixel = 0
knob.Parent = slider

local knobCorner = Instance.new("UICorner")
knobCorner.CornerRadius = UDim.new(1, 0)
knobCorner.Parent = knob

local sliderDragging = false

local function setStrength(mouseX)
	local left = slider.AbsolutePosition.X
	local width = slider.AbsoluteSize.X

	local percent = math.clamp(
		(mouseX - left) / width,
		0,
		1
	)

	strength = math.floor(percent * 1000 + 0.5)

	fill.Size = UDim2.new(percent, 0, 1, 0)
	knob.Position = UDim2.new(percent, 0, 0.5, 0)
	strengthValue.Text = tostring(strength)
end

slider.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		sliderDragging = true
		setStrength(input.Position.X)
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if sliderDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		setStrength(input.Position.X)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		sliderDragging = false
	end
end)

local info = Instance.new("TextLabel")
info.BackgroundTransparency = 1
info.Position = UDim2.fromOffset(5, 68)
info.Size = UDim2.new(1, -10, 0, 25)
info.Font = Enum.Font.Gotham
info.Text = "Throw strength"
info.TextColor3 = Color3.fromRGB(125, 125, 130)
info.TextSize = 11
info.TextXAlignment = Enum.TextXAlignment.Left
info.Parent = combatPage

local mouseHint = Instance.new("TextLabel")
mouseHint.BackgroundTransparency = 1
mouseHint.Position = UDim2.fromOffset(5, 100)
mouseHint.Size = UDim2.new(1, -10, 0, 25)
mouseHint.Font = Enum.Font.Gotham
mouseHint.Text = "RMB  •  Throw"
mouseHint.TextColor3 = Color3.fromRGB(155, 155, 160)
mouseHint.TextSize = 12
mouseHint.TextXAlignment = Enum.TextXAlignment.Left
mouseHint.Parent = combatPage

--==================================================
-- DEFENSE
--==================================================

local defensePage = Instance.new("Frame")
defensePage.Name = "DefensePage"
defensePage.BackgroundTransparency = 1
defensePage.Size = UDim2.fromScale(1, 1)
defensePage.Visible = false
defensePage.Parent = content

local antiGrabButton = Instance.new("TextButton")
antiGrabButton.Position = UDim2.fromOffset(5, 5)
antiGrabButton.Size = UDim2.new(1, -10, 0, 64)
antiGrabButton.BackgroundColor3 = Color3.fromRGB(42, 42, 46)
antiGrabButton.BorderSizePixel = 0
antiGrabButton.Font = Enum.Font.GothamMedium
antiGrabButton.Text = ""
antiGrabButton.AutoButtonColor = false
antiGrabButton.Parent = defensePage

local antiGrabCorner = Instance.new("UICorner")
antiGrabCorner.CornerRadius = UDim.new(0, 9)
antiGrabCorner.Parent = antiGrabButton

local antiGrabName = Instance.new("TextLabel")
antiGrabName.BackgroundTransparency = 1
antiGrabName.Position = UDim2.fromOffset(14, 9)
antiGrabName.Size = UDim2.new(1, -100, 0, 22)
antiGrabName.Font = Enum.Font.GothamMedium
antiGrabName.Text = "Anti Grab"
antiGrabName.TextColor3 = Color3.fromRGB(225, 225, 228)
antiGrabName.TextSize = 14
antiGrabName.TextXAlignment = Enum.TextXAlignment.Left
antiGrabName.Parent = antiGrabButton

local antiGrabDescription = Instance.new("TextLabel")
antiGrabDescription.BackgroundTransparency = 1
antiGrabDescription.Position = UDim2.fromOffset(14, 34)
antiGrabDescription.Size = UDim2.new(1, -28, 0, 20)
antiGrabDescription.Font = Enum.Font.Gotham
antiGrabDescription.Text = "Prevent grabbing your character"
antiGrabDescription.TextColor3 = Color3.fromRGB(130, 130, 135)
antiGrabDescription.TextSize = 11
antiGrabDescription.TextXAlignment = Enum.TextXAlignment.Left
antiGrabDescription.Parent = antiGrabButton

local antiGrabState = Instance.new("TextLabel")
antiGrabState.BackgroundTransparency = 1
antiGrabState.Position = UDim2.new(1, -70, 0, 17)
antiGrabState.Size = UDim2.fromOffset(55, 25)
antiGrabState.Font = Enum.Font.GothamMedium
antiGrabState.TextSize = 11
antiGrabState.Parent = antiGrabButton

local function updateAntiGrab()
	if antiGrabEnabled then
		antiGrabState.Text = "ON"
		antiGrabState.TextColor3 = Color3.fromRGB(190, 190, 195)
	else
		antiGrabState.Text = "OFF"
		antiGrabState.TextColor3 = Color3.fromRGB(115, 115, 120)
	end
end

updateAntiGrab()

antiGrabButton.MouseButton1Click:Connect(function()
	antiGrabEnabled = not antiGrabEnabled
	updateAntiGrab()
end)

--==================================================
-- TAB SWITCHING
--==================================================

local function showCombat()
	combatPage.Visible = true
	defensePage.Visible = false

	combatTab.BackgroundColor3 = Color3.fromRGB(55, 55, 60)
	combatTab.TextColor3 = Color3.fromRGB(235, 235, 238)

	defenseTab.BackgroundColor3 = Color3.fromRGB(40, 40, 43)
	defenseTab.TextColor3 = Color3.fromRGB(190, 190, 195)
end

local function showDefense()
	combatPage.Visible = false
	defensePage.Visible = true

	combatTab.BackgroundColor3 = Color3.fromRGB(40, 40, 43)
	combatTab.TextColor3 = Color3.fromRGB(190, 190, 195)

	defenseTab.BackgroundColor3 = Color3.fromRGB(55, 55, 60)
	defenseTab.TextColor3 = Color3.fromRGB(235, 235, 238)
end

combatTab.MouseButton1Click:Connect(showCombat)
defenseTab.MouseButton1Click:Connect(showDefense)

--==================================================
-- M = OPEN / CLOSE
--==================================================

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then
		return
	end

	if input.KeyCode == Enum.KeyCode.M then
		panelOpen = not panelOpen
		main.Visible = panelOpen
	end
end)

--==================================================
-- RMB EVENT
--==================================================

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then
		return
	end

	if input.UserInputType == Enum.UserInputType.MouseButton2 then
		-- Strength is available here for the throw
		-- The actual physics must be handled by the server
		-- in your own Roblox experience.
		print("Throw requested. Strength:", strength)
	end
end)

showCombat()
