-- Fatality tarzı GUI tasarımı - Tam Kod
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local function hexToColor3(hex)
	hex = hex:gsub("#","")
	return Color3.fromRGB(
		tonumber("0x"..hex:sub(1,2)),
		tonumber("0x"..hex:sub(3,4)),
		tonumber("0x"..hex:sub(5,6))
	)
end

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FatalityMenu"
screenGui.Parent = playerGui

local menu = Instance.new("Frame")
menu.Name = "Menu"
menu.Size = UDim2.new(0, 800, 0, 652)
menu.Position = UDim2.new(0.5, -400, 0.5, -326)
menu.BackgroundColor3 = hexToColor3("#2d3039")
menu.BorderSizePixel = 1
menu.BorderColor3 = hexToColor3("#463f6a")
menu.Parent = screenGui

local bar = Instance.new("Frame")
bar.Name = "Bar"
bar.BackgroundColor3 = hexToColor3("#1b1539")
bar.Size = UDim2.new(1, 0, 0, 75)
bar.Position = UDim2.new(0, 0, 0, 0)
bar.Parent = menu

local barShadow = Instance.new("Frame")
barShadow.Size = UDim2.new(1, 0, 0, 10)
barShadow.Position = UDim2.new(0, 0, 1, 0)
barShadow.BackgroundColor3 = Color3.new(0,0,0)
barShadow.BackgroundTransparency = 0.5
barShadow.Parent = bar

local line = Instance.new("Frame")
line.Name = "Line"
line.Size = UDim2.new(1, 0, 0, 2)
line.Position = UDim2.new(0, 0, 0, 15)
line.BackgroundColor3 = Color3.new(1,1,1)
line.Parent = bar

local uiGradient = Instance.new("UIGradient")
uiGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, hexToColor3("4632f0")),
	ColorSequenceKeypoint.new(1, hexToColor3("eb055a")),
}
uiGradient.Rotation = 90
uiGradient.Parent = line

local logo = Instance.new("TextLabel")
logo.Name = "Logo"
logo.Text = "FATALITY"
logo.Font = Enum.Font.GothamBold
logo.TextSize = 28
logo.TextColor3 = Color3.new(1,1,1)
logo.BackgroundTransparency = 1
logo.Position = UDim2.new(0, 4, 0, 30)
logo.Size = UDim2.new(0, 150, 0, 30)
logo.Parent = bar

local function glitchEffect(label)
	local glitchColors = {
		hexToColor3("eb055a"),
		hexToColor3("4632f0")
	}
	local i = 1
	RunService.Heartbeat:Connect(function()
		label.TextStrokeColor3 = glitchColors[i]
		i = i % 2 + 1
	end)
	label.TextStrokeTransparency = 0.4
	label.TextStrokeColor3 = glitchColors[1]
end
glitchEffect(logo)

local tabList = Instance.new("Frame")
tabList.Name = "TabList"
tabList.BackgroundTransparency = 1
tabList.Position = UDim2.new(0, 160, 0, 15)
tabList.Size = UDim2.new(0, 600, 0, 40)
tabList.Parent = menu

local tabSelectorLine = Instance.new("Frame")
tabSelectorLine.Name = "TabSelectorLine"
tabSelectorLine.Size = UDim2.new(0, 0, 0, 1)
tabSelectorLine.BackgroundColor3 = hexToColor3("eb055a")
tabSelectorLine.BorderSizePixel = 1
tabSelectorLine.Position = UDim2.new(-1, 0, 0, 1000)
tabSelectorLine.Parent = tabList

local contentContainer = Instance.new("Frame")
contentContainer.Name = "ContentContainer"
contentContainer.BackgroundColor3 = hexToColor3("#1c1437")
contentContainer.BorderSizePixel = 1
contentContainer.BorderColor3 = hexToColor3("#463f6a")
contentContainer.Position = UDim2.new(0, 0, 0, 75)
contentContainer.Size = UDim2.new(1, 0, 1, -75)
contentContainer.Parent = menu

local tabs = {}
local tabContents = {}
local tabOrder = {"RAGE", "LEGIT", "VISUALS", "GUN", "SKINS", "MISC"}

local function createTab(name, index)
	local tab = Instance.new("TextButton")
	tab.Name = name .. "Tab"
	tab.Text = name:upper()
	tab.Font = Enum.Font.GothamSemibold
	tab.TextSize = 22
	tab.TextColor3 = hexToColor3("68648c")
	tab.BackgroundTransparency = 1
	tab.Size = UDim2.new(0, 100, 1, 0)
	tab.Position = UDim2.new(0, (index - 1.1) * 108, 0.3, 0)
	tab.Parent = tabList
	tab.AutoButtonColor = false

	local content = Instance.new("Frame")
	content.Name = name .. "Content"
	content.BackgroundTransparency = 1
	content.Size = UDim2.new(1, 0, 1, 0)
	content.Visible = false
	content.Parent = contentContainer

	tabs[name] = tab
	tabContents[name] = content
end

for i, name in ipairs(tabOrder) do
	createTab(name, i)
end

local function selectTab(name)
	for tabName, button in pairs(tabs) do
		local isActive = (tabName == name)
		button.TextColor3 = isActive and Color3.new(1, 1, 1) or hexToColor3("68648c")
		tabContents[tabName].Visible = isActive
		if isActive then
			local tween = TweenService:Create(tabSelectorLine, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Position = UDim2.new(0.007, button.Position.X.Offset, 1, 8),
				Size = UDim2.new(-0.01, button.AbsoluteSize.X, -0.02, 0)
			})
			tween:Play()
		end
	end
end

for name, button in pairs(tabs) do
	button.MouseButton1Click:Connect(function()
		selectTab(name)
	end)
end

selectTab("Aimbot")

local function createBox(parent, title)
    local box = Instance.new("Frame")
    box.Size = UDim2.new(0, 350, 0, 240)
    box.Position = UDim2.new(0, 10, 0, 10)  -- Bu pozisyonu parent içindeki düzenleme ile ayarlayabilirsin
    box.BackgroundColor3 = hexToColor3("#2c2c3a")
    box.BackgroundTransparency = 0
    box.Parent = parent

    -- Kenarları yuvarlatmak için
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = box

    -- Border için UIStroke
    local stroke = Instance.new("UIStroke")
    stroke.Color = hexToColor3("#463f6a")
    stroke.Thickness = 1
    stroke.Parent = box

    -- Başlık
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Text = title
    titleLabel.Font = Enum.Font.SourceSansSemibold
    titleLabel.TextSize = 18
    titleLabel.TextColor3 = Color3.new(1, 1, 1)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Size = UDim2.new(1, -30, 0, 30)
    titleLabel.Position = UDim2.new(0, 10, 0, 5)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = box

    -- Alt çizgi
    local line = Instance.new("Frame")
    line.Size = UDim2.new(0, box.Size.X.Offset - 20, 0, 2)
    line.Position = UDim2.new(0, 10, 0, 35)
    line.BackgroundColor3 = hexToColor3("eb055a")
    line.BorderSizePixel = 0
    line.Parent = box

    return box
end

local TweenService = game:GetService("TweenService")

local function hexToColor3(hex)
	hex = hex:gsub("#","")
	return Color3.fromRGB(
		tonumber("0x"..hex:sub(1,2)),
		tonumber("0x"..hex:sub(3,4)),
		tonumber("0x"..hex:sub(5,6))
	)
end

local function createFatalityToggle(parent, labelText, position)
	local toggleFrame = Instance.new("Frame")
	toggleFrame.Size = UDim2.new(0, 150, 0, 30)
	toggleFrame.Position = position or UDim2.new(0, 0, 0, 0)
	toggleFrame.BackgroundTransparency = 1
	toggleFrame.Parent = parent

	-- Checkbox kutusu
	local box = Instance.new("Frame")
	box.Size = UDim2.new(0, 12, 0, 12)
	box.Position = UDim2.new(0, 5, 0, 10)
	box.BackgroundColor3 = hexToColor3("#1e1e2a")  -- koyu gri zemin
	box.BorderSizePixel = 1
	box.BorderColor3 = hexToColor3("#463f6a")
	box.Parent = toggleFrame

	-- Kutu içindeki tik (kırmızı dolu kare)
	local fill = Instance.new("Frame")
	fill.Size = UDim2.new(1, 0, 1, 0)
	fill.Position = UDim2.new(0, 0, 0, 0)
	fill.BackgroundColor3 = hexToColor3("#eb055a")
	fill.Visible = false -- başta görünmesin
	fill.Parent = box


	-- Yazı
	local label = Instance.new("TextLabel")
	label.Text = labelText
	label.Font = Enum.Font.GothamMedium
	label.TextSize = 14.5
	label.TextColor3 = Color3.new(1, 1, 1)
	label.BackgroundTransparency = 1
	label.Size = UDim2.new(1, -30, 1, 0)
	label.Position = UDim2.new(0, 30, 0.02, 0)
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = toggleFrame

	local toggled = false

	local function updateToggle(state)
		toggled = state
		fill.Visible = toggled
	end

	toggleFrame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			updateToggle(not toggled)
			print(labelText .. " toggled:", toggled)
		end
	end)

	-- Başlangıç durumu
	updateToggle(false)

	return toggleFrame, function() return toggled end
end

local function createMiniSlider(parent, label, minValue, maxValue, defaultValue)
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(1, -20, 0, 40)
	frame.BackgroundTransparency = 1
	frame.Parent = parent

	-- Başlık
	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1, 0, 0, 12)
	title.Position = UDim2.new(0, 48, 0, 0)
	title.BackgroundTransparency = 1
	title.Font = Enum.Font.GothamMedium
	title.TextSize = 13
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.TextColor3 = Color3.new(1, 1, 1)
	title.Text = label
	title.Parent = frame

	-- Değer metni
	local valueLabel = Instance.new("TextLabel")
	valueLabel.Size = UDim2.new(0, 40, 0, 12)
	valueLabel.Position = UDim2.new(1, -90, 0, 0)
	valueLabel.BackgroundTransparency = 1
	valueLabel.Font = Enum.Font.GothamMedium
	valueLabel.TextSize = 13
	valueLabel.TextColor3 = Color3.new(1, 1, 1)
	valueLabel.Text = tostring(defaultValue)
	valueLabel.TextXAlignment = Enum.TextXAlignment.Right
	valueLabel.Parent = frame

	-- Slider barı
	local bar = Instance.new("Frame")
	bar.Size = UDim2.new(0.7, 0, 0, 7)
	bar.Position = UDim2.new(0.15, 0, -0.1, 25)
	bar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	bar.BorderSizePixel = 0
	bar.Parent = frame

	local corner = Instance.new("UICorner", bar)
	corner.CornerRadius = UDim.new(0, 3)

	-- Doluluk çubuğu (fill)
	local fill = Instance.new("Frame")
	fill.Size = UDim2.new((defaultValue - minValue) / (maxValue - minValue), 0, 1, 0)
	fill.Position = UDim2.new(0, 0, 0.5, 0)
	fill.AnchorPoint = Vector2.new(0, 0.5)
	fill.BackgroundColor3 = Color3.fromRGB(235, 5, 90)
	fill.BorderSizePixel = 1
	fill.Parent = bar

	local fillCorner = Instance.new("UICorner", fill)
	fillCorner.CornerRadius = UDim.new(0, 3)

	-- Fare ile sürükleme
	local dragging = false
	local UIS = game:GetService("UserInputService")

	bar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
		end
	end)

	UIS.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)

	UIS.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local percent = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
			fill.Size = UDim2.new(percent, 0, 1, 0)
			local val = math.floor((minValue + (maxValue - minValue) * percent) + 0.5)
			valueLabel.Text = tostring(val)
		end
	end)

	return frame
end

local function createFatalityButton(parent, text, position, size)
    size = size or UDim2.new(0, 120, 0, 30)
    position = position or UDim2.new(0, 0, 0, 0)

    local button = Instance.new("TextButton")
    button.Parent = parent
    button.Size = size
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    button.BorderSizePixel = 0
    button.Text = ""
    button.AutoButtonColor = false

    local label = Instance.new("TextLabel")
    label.Parent = button
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 50, 50)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 18
    label.Text = text or "Button"
    label.TextXAlignment = Enum.TextXAlignment.Center

    local underline = Instance.new("Frame")
    underline.Parent = button
    underline.Size = UDim2.new(1, 0, 0, 3)
    underline.Position = UDim2.new(0, 0, 1, -3)
    underline.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    underline.BorderSizePixel = 0

    local hover = Instance.new("Frame")
    hover.Parent = button
    hover.Size = UDim2.new(1, 0, 1, 0)
    hover.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    hover.BackgroundTransparency = 0.85
    hover.Visible = false
    hover.ZIndex = 2

    button.MouseEnter:Connect(function()
        hover.Visible = true
    end)
    button.MouseLeave:Connect(function()
        hover.Visible = false
    end)

    return button
end



local mainContent = tabContents["RAGE"]

local box1 = createBox(mainContent, "RAGEBOT")
box1.Position = UDim2.new(0.025, 10, 0.02, 10)

local toggle1, getToggleState1 = createFatalityToggle(box1, "Master Switch", UDim2.new(0, 10, -0.03, 50))
local toggle2, getToggleState2 = createFatalityToggle(box1, "Auto Locked", UDim2.new(0, 10, 0.07, 50))
local toggle3, getToggleState3 = createFatalityToggle(box1, "Silent Aim", UDim2.new(0, 10, 0.17, 50))
local toggle4, getToggleState4 = createFatalityToggle(box1, "Auto Shoot", UDim2.new(0, 10, 0.27, 50))

local box2 = createBox(mainContent, "ANTI-AIM")
box2.Position = UDim2.new(0, 415, 0.02, 10)

local toggle5, getToggleState5 = createFatalityToggle(box2, "Master Switch", UDim2.new(0, 10, -0.03, 50))
local toggle6, getToggleState6 = createFatalityToggle(box2, "Spinbot", UDim2.new(0, 10, 0.07, 50))
local toggle7, getToggleState7 = createFatalityToggle(box2, "Random Head", UDim2.new(0, 10, 0.17, 50))
local toggle8, getToggleState8 = createFatalityToggle(box2, "Fake Lag", UDim2.new(0, 10, 0.27, 50))
local toggle9, getToggleState9 = createFatalityToggle(box2, "Resolver", UDim2.new(0, 10, 0.37, 50))

local slider = createMiniSlider(box2, "Fake Lag Amount", 0, 16, 0)
slider.Position = UDim2.new(0, -33.5, 0, 180)
slider.Parent = box2

local box3 = createBox(mainContent, "ANTI-AIM SETTINGS")
box3.Position = UDim2.new(0.025, 10, 0.02, 280)

local toggle10, getToggleState10 = createFatalityToggle(box3, "Pitch", UDim2.new(0, 10, -0.03, 50))
local toggle11, getToggleState11 = createFatalityToggle(box3, "Yaw", UDim2.new(0, 10, 0.07, 50))

local slider = createMiniSlider(box3, "Spinbot Speed", 0, 999999, 0)
slider.Position = UDim2.new(0, -33.5, 0, 100)
slider.Parent = box3

local slider = createMiniSlider(box3, "Random Head Speed", 0, 999999, 0)
slider.Position = UDim2.new(0, -33.5, 0, 135)
slider.Parent = box3

local slider = createMiniSlider(box3, "Resolver Amount", 0, 16, 0)
slider.Position = UDim2.new(0, -33.5, 0, 170)
slider.Parent = box3

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        if input.KeyCode == Enum.KeyCode.Insert then
            menu.Visible = not menu.Visible
        end
    end
end)

local mainContent = tabContents["LEGIT"]

local box4 = createBox(mainContent, "LEGITBOT")
box4.Position = UDim2.new(0.025, 10, 0.02, 10)

local toggle12, getToggleState12 = createFatalityToggle(box4, "Master Switch", UDim2.new(0, 10, -0.03, 50))
local toggle13, getToggleState13 = createFatalityToggle(box4, "Teamcheck", UDim2.new(0, 10, 0.07, 50))
local toggle14, getToggleState14 = createFatalityToggle(box4, "Wallcheck", UDim2.new(0, 10, 0.17, 50))
local toggle15, getToggleState12 = createFatalityToggle(box4, "Draw FOV", UDim2.new(0, 10, 0.27, 50))

local box5 = createBox(mainContent, "LEGIT SETTINGS")
box5.Position = UDim2.new(0, 415, 0.02, 10)

local toggle16, getToggleState16 = createFatalityToggle(box5, "Transparent FOV", UDim2.new(0, 10, -0.03, 50))
local toggle17, getToggleState17 = createFatalityToggle(box5, "Filled FOV", UDim2.new(0, 10, 0.07, 50))


local slider = createMiniSlider(box5, "Smoothness", 0, 10, 0)
slider.Position = UDim2.new(0, -33.5, 0, 102)
slider.Parent = box5

local slider = createMiniSlider(box5, "FOV Radius", 0, 360, 0)
slider.Position = UDim2.new(0, -33.5, 0, 137)
slider.Parent = box5

local slider = createMiniSlider(box5, "FOV Transparency", 0, 1, 0)
slider.Position = UDim2.new(0, -33.5, 0, 172)
slider.Parent = box5

local box6 = createBox(mainContent, "TRIGGER BOT")
box6.Position = UDim2.new(0.025, 10, 0.02, 280)

local toggle18, getToggleState18 = createFatalityToggle(box6, "Master Switch", UDim2.new(0, 10, -0.03, 50))
local toggle19, getToggleState19 = createFatalityToggle(box6, "Teamcheck", UDim2.new(0, 10, 0.07, 50))
local toggle20, getToggleState20 = createFatalityToggle(box6, "Trigger Delay", UDim2.new(0, 10, 0.17, 50))

local mainContent = tabContents["SKINS"]

local box7 = createBox(mainContent, "INVENTORY")
box7.Position = UDim2.new(0.025, 10, 0.02, 10)

local myButton = createFatalityButton(box7, "UNLOCK", UDim2.new(0, 10, -0.03, 50))

local mainContent = tabContents["MISC"]

local box8 = createBox(mainContent, "OTHERS")
box8.Position = UDim2.new(0.025, 10, 0.02, 10)

local toggle21, getToggleState21 = createFatalityToggle(box8, "Trash Talk", UDim2.new(0, 10, -0.03, 50))

local box9 = createBox(mainContent, "MOVEMENT")
box9.Position = UDim2.new(0, 415, 0.02, 10)

local toggle22, getToggleState22 = createFatalityToggle(box9, "BHop", UDim2.new(0, 10, -0.03, 50))
local toggle23, getToggleState23 = createFatalityToggle(box9, "Fly", UDim2.new(0, 10, 0.07, 50))

local box10 = createBox(mainContent, "SUBSCRIPTION")
box10.Position = UDim2.new(0.025, 10, 0.02, 280)
