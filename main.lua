--// FTAP-STYLE CONTROL PANEL
--// Place this LocalScript in StarterPlayer > StarterPlayerScripts

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local gui = Instance.new("ScreenGui")
gui.Name = "FTAPControlPanel"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = playerGui

local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(390, 300)
main.Position = UDim2.new(0.5, -195, 0.5, -150)
main.BackgroundColor3 = Color3.fromRGB(30, 30, 33)
main.BorderSizePixel = 0
main.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = main

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(65, 65, 70)
stroke.Thickness = 1
stroke.Parent = main

local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Position = UDim2.fromOffset(18, 12)
title.Size = UDim2.new(1, -36, 0, 30)
title.Font = Enum.Font.GothamSemibold
title.Text = "Control"
title.TextColor3 = Color3.fromRGB(235, 235, 238)
title.TextSize = 19
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = main

local tabs = Instance.new("Frame")
tabs.BackgroundTransparency = 1
tabs.Position = UDim2.fromOffset(15, 52)
tabs.Size = UDim2.new(1, -30, 0, 35)
tabs.Parent = main

local combatTab = Instance.new("TextButton")
combatTab.Size = UDim2.fromOffset(105, 32)
combatTab.BackgroundColor3 = Color3.fromRGB(55, 55, 60)
combatTab.BorderSizePixel = 0
combatTab.Font = Enum.Font.GothamMedium
combatTab.Text = "Combat"
combatTab.TextColor3 = Color3.fromRGB(235, 235, 238)
combatTab.TextSize = 13
combatTab.Parent = tabs

local combatCorner = Instance.new("UICorner")
combatCorner.CornerRadius = UDim.new(0, 8)
combatCorner.Parent = combatTab

local defenseTab = combatTab:Clone()
defenseTab.Text = "Defense"
defenseTab.Position = UDim2.fromOffset(112, 0)
defenseTab.BackgroundColor3 = Color3.fromRGB(40, 40, 43)
defenseTab.Parent = tabs

local content = Instance.new("Frame")
content.BackgroundTransparency = 1
content.Position = UDim2.fromOffset(15, 100)
content.Size = UDim2.new(1, -30, 1, -112)
content.Parent = main

local strengthTitle = Instance.new("TextLabel")
strengthTitle.BackgroundTransparency = 1
strengthTitle.Position = UDim2.fromOffset(5, 4)
strengthTitle.Size = UDim2.new(1, -10, 0, 25)
strengthTitle.Font = Enum.Font.GothamMedium
strengthTitle.Text = "Strength"
strengthTitle.TextColor3 = Color3.fromRGB(225, 225, 228)
strengthTitle.TextSize = 14
strengthTitle.TextXAlignment = Enum.TextXAlignment.Left
strengthTitle.Parent = content

local valueLabel = Instance.new("TextLabel")
valueLabel.BackgroundTransparency = 1
valueLabel.Position = UDim2.new(1, -70, 0, 4)
valueLabel.Size = UDim2.fromOffset(65, 25)
valueLabel.Font = Enum.Font.GothamMedium
valueLabel.Text = "500"
valueLabel.TextColor3 = Color3.fromRGB(190, 190, 195)
valueLabel.TextSize = 13
valueLabel.TextXAlignment = Enum.TextXAlignment.Right
valueLabel.Parent = content

local sliderBack = Instance.new("Frame")
sliderBack.Position = UDim2.fromOffset(5, 43)
sliderBack.Size = UDim2.new(1, -10, 0, 7)
sliderBack.BackgroundColor3 = Color3.fromRGB(55, 55, 59)
sliderBack.BorderSizePixel = 0
sliderBack.Parent = content

local sliderBackCorner = Instance.new("UICorner")
sliderBackCorner.CornerRadius = UDim.new(1, 0)
sliderBackCorner.Parent = sliderBack

local sliderFill = Instance.new("Frame")
sliderFill.Size = UDim2.new(0.5, 0, 1, 0)
sliderFill.BackgroundColor3 = Color3.fromRGB(150, 150, 155)
sliderFill.BorderSizePixel = 0
sliderFill.Parent = sliderBack

local sliderFillCorner = Instance.new("UICorner")
sliderFillCorner.CornerRadius = UDim.new(1, 0)
sliderFillCorner.Parent = sliderFill

local knob = Instance.new("Frame")
knob.AnchorPoint = Vector2.new(0.5, 0.5)
knob.Position = UDim2.new(0.5, 0, 0.5, 0)
knob.Size = UDim2.fromOffset(15, 15)
knob.BackgroundColor3 = Color3.fromRGB(225, 225, 228)
knob.BorderSizePixel = 0
knob.Parent = sliderBack

local knobCorner = Instance.new("UICorner")
knobCorner.CornerRadius = UDim.new(1, 0)
knobCorner.Parent = knob

local hint = Instance.new("TextLabel")
hint.BackgroundTransparency = 1
hint.Position = UDim2.fromOffset(5, 65)
hint.Size = UDim2.new(1, -10, 0, 25)
hint.Font = Enum.Font.Gotham
hint.Text = "Higher value = stronger throw"
hint.TextColor3 = Color3.fromRGB(125, 125, 130)
hint.TextSize = 11
hint.TextXAlignment = Enum.TextXAlignment.Left
hint.Parent = content

local strength = 500
local dragging = false

local function setStrengthFromMouse(x)
	local left = sliderBack.AbsolutePosition.X
	local width = sliderBack.AbsoluteSize.X

	local alpha = math.clamp((x - left) / width, 0, 1)
	strength = math.floor(alpha * 1000 + 0.5)

	sliderFill.Size = UDim2.new(alpha, 0, 1, 0)
	knob.Position = UDim2.new(alpha, 0, 0.5, 0)
	valueLabel.Text = tostring(strength)
end

sliderBack.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		setStrengthFromMouse(input.Position.X)
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		setStrengthFromMouse(input.Position.X)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

local defensePanel = Instance.new("Frame")
defensePanel.BackgroundTransparency = 1
defensePanel.Size = UDim2.fromScale(1, 1)
defensePanel.Visible = false
defensePanel.Parent = content

local antiGrab = Instance.new("TextButton")
antiGrab.Position = UDim2.fromOffset(5, 5)
antiGrab.Size = UDim2.new(1, -10, 0, 58)
antiGrab.BackgroundColor3 = Color3.fromRGB(42, 42, 46)
antiGrab.BorderSizePixel = 0
antiGrab.Font = Enum.Font.GothamMedium
antiGrab.Text = "Anti Grab                         ON"
antiGrab.TextColor3 = Color3.fromRGB(225, 225, 228)
antiGrab.TextSize = 13
antiGrab.TextXAlignment = Enum.TextXAlignment.Left
antiGrab.Parent = defensePanel

local antiGrabPadding = Instance.new("UIPadding")
antiGrabPadding.PaddingLeft = UDim.new(0, 15)
antiGrabPadding.Parent = antiGrab

local antiGrabCorner = Instance.new("UICorner")
antiGrabCorner.CornerRadius = UDim.new(0, 9)
antiGrabCorner.Parent = antiGrab

local antiGrabEnabled = true

antiGrab.MouseButton1Click:Connect(function()
	antiGrabEnabled = not antiGrabEnabled
	antiGrab.Text = "Anti Grab                         " .. (antiGrabEnabled and "ON" or "OFF")
end)

combatTab.MouseButton1Click:Connect(function()
	content.Visible = true
	defensePanel.Visible = false
	combatTab.BackgroundColor3 = Color3.fromRGB(55, 55, 60)
	defenseTab.BackgroundColor3 = Color3.fromRGB(40, 40, 43)
end)

defenseTab.MouseButton1Click:Connect(function()
	strengthTitle.Visible = false
	valueLabel.Visible = false
	sliderBack.Visible = false
	hint.Visible = false

	defensePanel.Visible = true
	combatTab.BackgroundColor3 = Color3.fromRGB(40, 40, 43)
	defenseTab.BackgroundColor3 = Color3.fromRGB(55, 55, 60)
end)

combatTab.MouseButton1Click:Connect(function()
	strengthTitle.Visible = true
	valueLabel.Visible = true
	sliderBack.Visible = true
	hint.Visible = true
end)
