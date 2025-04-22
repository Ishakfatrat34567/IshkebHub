-- 💡 ISHKEBHUB: FINAL NEON RED GUI SCRIPT 🟥🔥
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

StarterGui:SetCore("SendNotification", {
    Title = "IshkebHub",
    Text = "🔥 Neon Red UI Loaded 🔥",
    Duration = 5
})

for _, v in ipairs(game:GetService("Lighting"):GetChildren()) do
    if v:IsA("BlurEffect") then
        v:Destroy()
    end
end

local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local AimbotEnabled, ESPEnabled, TeamCheck, NoclipEnabled = false, false, false, false
local AimbotSmoothness, FOVRadius = 0.1, 150
local ShowFOVCircle = true
local WalkSpeed, JumpPower = 16, 50
local HoldingRightMouse = false
local LockedTarget = nil
local Chams = {}
local TriggerBotEnabled = false

LocalPlayer.CharacterAdded:Connect(function(char)
    Character = char
    Humanoid = char:WaitForChild("Humanoid")
end)

local gui = Instance.new("ScreenGui")
gui.Name = "IshkebGUI"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.IgnoreGuiInset = true
gui.DisplayOrder = 9999 -- MAX ORDER
gui.Parent = game:GetService("CoreGui")

gui.Name = "IshkebGUI"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0, 800, 0, 580)
mainFrame.Position = UDim2.new(0.5, -400, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BorderSizePixel = 0
mainFrame.BackgroundTransparency = 0.1
mainFrame.ZIndex = 10
mainFrame.Active = true
mainFrame.Draggable = true

Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)

local glow = Instance.new("UIStroke", mainFrame)
glow.Color = Color3.fromRGB(255, 0, 0)
glow.Thickness = 2
glow.Transparency = 0.25

local titleBar = Instance.new("TextLabel", mainFrame)
titleBar.Size = UDim2.new(1, 0, 0, 50)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundTransparency = 1
titleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
titleBar.Font = Enum.Font.GothamBlack
titleBar.TextScaled = true
titleBar.Text = "🔥 IshkebHub | NEON RED UI 🔥"
titleBar.ZIndex = 11
local tabContainer = Instance.new("Frame", mainFrame)
tabContainer.Size = UDim2.new(1, 0, 1, -60)
tabContainer.Position = UDim2.new(0, 0, 0, 60)
tabContainer.BackgroundTransparency = 1

local tabButtons = Instance.new("Frame", mainFrame)
tabButtons.Size = UDim2.new(1, 0, 0, 40)
tabButtons.Position = UDim2.new(0, 0, 0, 60)
tabButtons.BackgroundTransparency = 1
tabButtons.ZIndex = 11

local activeTabLine = Instance.new("Frame", tabButtons)
activeTabLine.Size = UDim2.new(0, 0, 0, 2)
activeTabLine.Position = UDim2.new(0, 0, 1, -2)
activeTabLine.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
activeTabLine.BorderSizePixel = 0
activeTabLine.ZIndex = 12

local function animateTabLine(button)
	TweenService:Create(activeTabLine, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
		Size = UDim2.new(0, button.AbsoluteSize.X, 0, 2),
		Position = UDim2.new(0, button.Position.X.Offset, 1, -2)
	}):Play()
end

local function createTabButton(name, pos, callback)
	local btn = Instance.new("TextButton", tabButtons)
	btn.Text = name
	btn.Size = UDim2.new(0, 200, 1, 0)
	btn.Position = UDim2.new(0, pos * 200, 0, 0)
	btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.GothamBold
	btn.TextScaled = true
	btn.ZIndex = 11
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

	btn.MouseEnter:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
	end)
	btn.MouseLeave:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
	end)

	btn.MouseButton1Click:Connect(function()
		animateTabLine(btn)
		callback()
	end)

	return btn
end

local espTab = Instance.new("Frame", tabContainer)
espTab.Size = UDim2.new(1, 0, 1, 0)
espTab.Position = UDim2.new(0, 0, 0, 0)
espTab.BackgroundTransparency = 1
espTab.Visible = true

local playerTab = Instance.new("Frame", tabContainer)
playerTab.Size = UDim2.new(1, 0, 1, 0)
playerTab.Position = UDim2.new(0, 0, 0, 0)
playerTab.BackgroundTransparency = 1
playerTab.Visible = false

local creditsTab = Instance.new("Frame", tabContainer)
creditsTab.Size = UDim2.new(1, 0, 1, 0)
creditsTab.Position = UDim2.new(0, 0, 0, 0)
creditsTab.BackgroundTransparency = 1
creditsTab.Visible = false

local function showTab(tab)
	espTab.Visible = false
	playerTab.Visible = false
	creditsTab.Visible = false
	tab.Visible = true
end

createTabButton("ESP", 0, function() showTab(espTab) end)
createTabButton("Player", 1, function() showTab(playerTab) end)
createTabButton("Credits", 2, function() showTab(creditsTab) end)
local function createToggle(parent, label, yPos, default, callback)
	local toggleBtn = Instance.new("TextButton", parent)
	toggleBtn.Size = UDim2.new(0, 250, 0, 35)
	toggleBtn.Position = UDim2.new(0, 20, 0, yPos)
	toggleBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	toggleBtn.TextColor3 = Color3.new(1, 1, 1)
	toggleBtn.Font = Enum.Font.GothamBold
	toggleBtn.TextScaled = true
	toggleBtn.Text = label .. ": " .. (default and "ON" or "OFF")
	toggleBtn.ZIndex = 10
	Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0, 8)

	local uiStroke = Instance.new("UIStroke", toggleBtn)
	uiStroke.Color = default and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(60, 60, 60)
	uiStroke.Thickness = 2

	local state = default
	toggleBtn.MouseButton1Click:Connect(function()
		state = not state
		toggleBtn.Text = label .. ": " .. (state and "ON" or "OFF")
		uiStroke.Color = state and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(60, 60, 60)
		callback(state)
	end)
end

local function createSlider(parent, label, yPos, initial, min, max, step, callback)
	local labelText = Instance.new("TextLabel", parent)
	labelText.Text = label .. ": " .. tostring(initial)
	labelText.Position = UDim2.new(0, 20, 0, yPos)
	labelText.Size = UDim2.new(0, 200, 0, 20)
	labelText.BackgroundTransparency = 1
	labelText.TextColor3 = Color3.new(1, 1, 1)
	labelText.Font = Enum.Font.Gotham
	labelText.TextScaled = true

	local sliderBack = Instance.new("Frame", parent)
	sliderBack.Position = UDim2.new(0, 240, 0, yPos)
	sliderBack.Size = UDim2.new(0, 400, 0, 20)
	sliderBack.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	Instance.new("UICorner", sliderBack).CornerRadius = UDim.new(1, 0)

	local fill = Instance.new("Frame", sliderBack)
	fill.Size = UDim2.new((initial - min) / (max - min), 0, 1, 0)
	fill.BackgroundColor3 = Color3.fromRGB(255, 0, 0)

	local knob = Instance.new("TextButton", sliderBack)
	knob.Size = UDim2.new(0, 20, 1, 0)
	knob.Position = UDim2.new((initial - min) / (max - min), -10, 0, 0)
	knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	knob.Text = ""
	Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

	local dragging = false
	knob.MouseButton1Down:Connect(function() dragging = true end)
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
	end)

	RunService.RenderStepped:Connect(function()
		if dragging then
			local percent = math.clamp((UserInputService:GetMouseLocation().X - sliderBack.AbsolutePosition.X) / sliderBack.AbsoluteSize.X, 0, 1)
			local value = math.floor((min + percent * (max - min)) / step + 0.5) * step
			fill.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
			knob.Position = UDim2.new((value - min) / (max - min), -10, 0, 0)
			labelText.Text = label .. ": " .. tostring(value)
			callback(value)
		end
	end)
end
-- 🔫 ESP TAB CONTROLS (Y+20 offset fix)
createToggle(espTab, "Aimbot", 40, false, function(v) AimbotEnabled = v end)
createToggle(espTab, "ESP (Chams)", 85, false, function(v) ESPEnabled = v end)
createToggle(espTab, "Team Check", 130, false, function(v) TeamCheck = v end)
createToggle(espTab, "FOV Circle", 175, true, function(v) ShowFOVCircle = v end)
createToggle(espTab, "Noclip", 220, false, function(v) NoclipEnabled = v end)
createToggle(espTab, "TriggerBot", 265, false, function(v) TriggerBotEnabled = v end)

createSlider(espTab, "Smoothness", 320, 0.1, 0.01, 1, 0.01, function(v) AimbotSmoothness = v end)
createSlider(espTab, "FOV Radius", 365, 150, 10, 300, 1, function(v) FOVRadius = v end)

-- 🦶 PLAYER TAB CONTROLS (Y+20 offset fix)
createSlider(playerTab, "WalkSpeed", 40, WalkSpeed, 0, 100, 1, function(v)
	WalkSpeed = v
	if Humanoid then Humanoid.WalkSpeed = v end
end)

createSlider(playerTab, "JumpPower", 85, JumpPower, 0, 150, 1, function(v)
	JumpPower = v
	if Humanoid then Humanoid.JumpPower = v end
end)

createSlider(playerTab, "Camera FOV", 130, Camera.FieldOfView, 30, 120, 1, function(v)
	Camera.FieldOfView = v
end)

-- 🧙 TELEPORT TOOL BUTTON (Y = 200 fix)
local function giveTeleportTool()
	if LocalPlayer.Backpack:FindFirstChild("Teleport Tool") then return end
	local tool = Instance.new("Tool")
	tool.Name = "Teleport Tool"
	tool.RequiresHandle = false
	tool.CanBeDropped = false
	tool.Parent = LocalPlayer:WaitForChild("Backpack")
	tool.Activated:Connect(function()
		local mouse = LocalPlayer:GetMouse()
		if Character and Character:FindFirstChild("HumanoidRootPart") then
			Character.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0, 5, 0))
		end
	end)
end

local tpButton = Instance.new("TextButton", playerTab)
tpButton.Text = "Get Teleport Tool"
tpButton.Size = UDim2.new(0, 200, 0, 30)
tpButton.Position = UDim2.new(0, 20, 0, 200)
tpButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
tpButton.TextColor3 = Color3.new(1, 1, 1)
tpButton.Font = Enum.Font.Gotham
tpButton.TextScaled = true
Instance.new("UICorner", tpButton).CornerRadius = UDim.new(0, 6)
tpButton.MouseButton1Click:Connect(giveTeleportTool)
-- 🧿 FOV Circle Setup
local FOVCircle = Drawing.new("Circle")
FOVCircle.Color = Color3.fromRGB(255, 0, 0)
FOVCircle.Thickness = 2
FOVCircle.Filled = false
FOVCircle.Visible = false

-- 🎮 Mouse Input for Right-Click Aimbot
UserInputService.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton2 then
		HoldingRightMouse = true
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton2 then
		HoldingRightMouse = false
		LockedTarget = nil
	end
end)

-- 🔦 ESP Chams Highlight Logic
local function updateChams()
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			local distance = (Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
			if ESPEnabled and distance <= 1000 then
				if not Chams[player] then
					local highlight = Instance.new("Highlight")
					highlight.Adornee = player.Character
					highlight.FillTransparency = 0.5
					highlight.OutlineTransparency = 0
					highlight.FillColor = (player.Team == LocalPlayer.Team) and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
					highlight.Parent = player.Character
					Chams[player] = highlight
				end
			else
				if Chams[player] then
					Chams[player]:Destroy()
					Chams[player] = nil
				end
			end
		end
	end
end
RunService.RenderStepped:Connect(function()
	local mousePos = UserInputService:GetMouseLocation() - Vector2.new(0, 36)

	-- 🧿 FOV Circle visuals
	FOVCircle.Visible = ShowFOVCircle
	FOVCircle.Position = mousePos
	FOVCircle.Radius = FOVRadius
	FOVCircle.Color = LockedTarget and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)

	-- 🚫 Noclip
	if NoclipEnabled and Character then
		for _, part in ipairs(Character:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = false
			end
		end
	end

	-- 🎯 Aimbot Lock-On
	if AimbotEnabled and HoldingRightMouse then
		if not LockedTarget or not LockedTarget.Character or not LockedTarget.Character:FindFirstChild("Head") then
			local closest, shortest = nil, FOVRadius
			for _, player in ipairs(Players:GetPlayers()) do
				if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
					if not TeamCheck or player.Team ~= LocalPlayer.Team then
						local screenPos, onScreen = Camera:WorldToViewportPoint(player.Character.Head.Position)
						if onScreen then
							local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
							if dist < shortest then
								shortest = dist
								closest = player
							end
						end
					end
				end
			end
			LockedTarget = closest
		end

		if LockedTarget and LockedTarget.Character and LockedTarget.Character:FindFirstChild("Head") then
			local headPos = LockedTarget.Character.Head.Position
			local dir = (headPos - Camera.CFrame.Position).Unit
			Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + dir), AimbotSmoothness)
		end
	end

	-- 🔫 TriggerBot Logic
	if TriggerBotEnabled and LockedTarget and LockedTarget.Character and LockedTarget.Character:FindFirstChild("Head") then
		local mouse = LocalPlayer:GetMouse()
		local target = LockedTarget.Character.Head
		local headPos, onScreen = Camera:WorldToViewportPoint(target.Position)
		if onScreen then
			local dist = (Vector2.new(headPos.X, headPos.Y) - mousePos).Magnitude
			if dist < 15 then
				mouse1click()
			end
		end
	end

	-- 🔄 Update ESP
	updateChams()

	-- 💪 Lock Player Stats
	if Humanoid then
		Humanoid.WalkSpeed = WalkSpeed
		Humanoid.JumpPower = JumpPower
	end
end)
-- 📜 Credits Tab
local devLabel = Instance.new("TextLabel", creditsTab)
devLabel.Text = "Developer: Ishkeb"
devLabel.Size = UDim2.new(1, -40, 0, 40)
devLabel.Position = UDim2.new(0, 20, 0, 40)
devLabel.TextColor3 = Color3.new(1, 1, 1)
devLabel.TextScaled = true
devLabel.BackgroundTransparency = 1
devLabel.Font = Enum.Font.GothamBold

local testerLabel = Instance.new("TextLabel", creditsTab)
testerLabel.Text = "Play Tester: Knappe-Klap"
testerLabel.Size = UDim2.new(1, -40, 0, 40)
testerLabel.Position = UDim2.new(0, 20, 0, 100)
testerLabel.TextColor3 = Color3.new(1, 1, 1)
testerLabel.TextScaled = true
testerLabel.BackgroundTransparency = 1
testerLabel.Font = Enum.Font.GothamBold
-- ✅ Final Confirmation Message
StarterGui:SetCore("SendNotification", {
	Title = "IshkebHub",
	Text = "✅ Fully Loaded - Neon Red Edition",
	Duration = 5
})

print("🔥 IshkebHub Final Neon Red Fully Operational 🔥")-- 🔔 Notify player of the toggle key
StarterGui:SetCore("SendNotification", {
    Title = "IshkebHub",
    Text = "-- Press RightCtrl to hide/show the menu --",
    Duration = 10
})

-- 🛠️ FIXED: Right Ctrl GUI Toggle Handler
UserInputService.InputBegan:Connect(function(input, gp)
	if input.KeyCode == Enum.KeyCode.RightControl and not gp then
		if gui then
			gui.Enabled = not gui.Enabled
		end
	end
end)-- 🔧 GUI ALWAYS ON TOP PATCH
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")

-- ⚠️ Move GUI to CoreGui if not already
if gui and not gui:IsDescendantOf(CoreGui) then
	gui.Parent = CoreGui
end

-- 💥 Boost DisplayOrder and ZIndex
gui.DisplayOrder = 9999
gui.IgnoreGuiInset = true

if mainFrame then
	mainFrame.ZIndex = 99
	for _, desc in ipairs(mainFrame:GetDescendants()) do
		if desc:IsA("GuiObject") then
			desc.ZIndex = 100
		end
	end
end

-- 🧠 RightCtrl Toggle for GUI Visibility
UserInputService.InputBegan:Connect(function(input, gp)
	if input.KeyCode == Enum.KeyCode.RightControl and not gp then
		if gui then
			gui.Enabled = not gui.Enabled
		end
	end
end)

-- 🔔 Reminder notification
StarterGui:SetCore("SendNotification", {
	Title = "IshkebHub",
	Text = "-- Press RightCtrl to hide/show the menu --",
	Duration = 10
})
-- 🔁 ESP FIX: Handle Player Respawns
local function hookPlayer(player)
	player.CharacterAdded:Connect(function(char)
		char:WaitForChild("HumanoidRootPart", 5)
		task.wait(0.5)
		if ESPEnabled and char:FindFirstChild("HumanoidRootPart") then
			-- Clean old cham if any
			if Chams[player] then
				Chams[player]:Destroy()
				Chams[player] = nil
			end

			-- Add fresh cham
			local highlight = Instance.new("Highlight")
			highlight.Adornee = char
			highlight.FillTransparency = 0.5
			highlight.OutlineTransparency = 0
			highlight.FillColor = (player.Team == LocalPlayer.Team) and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
			highlight.Parent = char
			Chams[player] = highlight
		end
	end)
end

-- 🔁 Hook all current players
for _, p in ipairs(Players:GetPlayers()) do
	if p ~= LocalPlayer then
		hookPlayer(p)
	end
end

-- 🔁 Hook future players too
Players.PlayerAdded:Connect(function(p)
	if p ~= LocalPlayer then
		hookPlayer(p)
	end
end)
-- 🔥 AUTO-DETECT NEW PLAYERS FOR ESP
local function applyESPToPlayer(player)
	player.CharacterAdded:Connect(function(char)
		char:WaitForChild("HumanoidRootPart", 5)
		task.wait(0.5)
		if ESPEnabled and char:FindFirstChild("HumanoidRootPart") then
			if Chams[player] then
				Chams[player]:Destroy()
				Chams[player] = nil
			end

			local highlight = Instance.new("Highlight")
			highlight.Adornee = char
			highlight.FillTransparency = 0.5
			highlight.OutlineTransparency = 0
			highlight.FillColor = (player.Team == LocalPlayer.Team) and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
			highlight.Parent = char
			Chams[player] = highlight
		end
	end)
end

-- 🌐 Detect new players joining
Players.PlayerAdded:Connect(function(player)
	if player ~= LocalPlayer then
		applyESPToPlayer(player)
	end
end)

-- 👥 Also apply to already existing players just in case
for _, player in ipairs(Players:GetPlayers()) do
	if player ~= LocalPlayer then
		applyESPToPlayer(player)
	end
end-- 🔧 EXTEND MENU HEIGHT SLIGHTLY TO FIT TOGGLE
mainFrame.Size = UDim2.new(0, 800, 0, 640)

-- 🏷️ Nametag Toggle System (auto-refresh + ESP check + small text)
local NameTags = {}
local ShowNameTags = false

local function createNametag(player)
	if not player.Character or not player.Character:FindFirstChild("Head") then return end
	if NameTags[player] then NameTags[player]:Destroy() end

	local tag = Instance.new("BillboardGui")
	tag.Name = "IshkebNameTag"
	tag.Adornee = player.Character.Head
	tag.Size = UDim2.new(0, 200, 0, 25)
	tag.StudsOffset = Vector3.new(0, 2.5, 0)
	tag.AlwaysOnTop = true
	tag.Parent = player.Character

	local label = Instance.new("TextLabel", tag)
	label.Size = UDim2.new(1, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.TextScaled = true
	label.Font = Enum.Font.Gotham
	label.Text = player.DisplayName
	label.TextSize = 12

	NameTags[player] = tag
end

local function removeNametag(player)
	if NameTags[player] then
		NameTags[player]:Destroy()
		NameTags[player] = nil
	end
end

-- 🔁 Hook players for fresh char spawns
Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function()
		wait(0.5)
		if ESPEnabled and ShowNameTags then
			createNametag(player)
		end
	end)
end)

-- 🔁 Apply to all players right now
for _, p in ipairs(Players:GetPlayers()) do
	if p ~= LocalPlayer then
		p.CharacterAdded:Connect(function()
			wait(0.5)
			if ESPEnabled and ShowNameTags then
				createNametag(p)
			end
		end)
	end
end

-- 🔁 Real-Time Refresh Loop (every 0.2s)
task.spawn(function()
	while true do
		if ShowNameTags and ESPEnabled then
			for _, player in ipairs(Players:GetPlayers()) do
				if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
					createNametag(player)
				else
					removeNametag(player)
				end
			end
		else
			for _, tag in pairs(NameTags) do
				tag:Destroy()
			end
			table.clear(NameTags)
		end
		task.wait(0.2)
	end
end)

-- 🧠 ESP Tab Toggle
createToggle(espTab, "Nametags", 410, false, function(v)
	ShowNameTags = v
end)
-- 🛠️ FIXED: Right Ctrl GUI Toggle Handler (cleaned + safe)
UserInputService.InputBegan:Connect(function(input, gp)
	if input.KeyCode == Enum.KeyCode.RightControl and not gp then
		if gui then
			gui.Enabled = not gui.Enabled
		end
	end
end)

-- 🔔 Reminder Notification for Toggle Key
StarterGui:SetCore("SendNotification", {
	Title = "IshkebHub",
	Text = "-- Press RightCtrl to hide/show the menu --",
	Duration = 10
})-- 💀 ABSOLUTE OVERLAY DOMINANCE PATCH 💀

-- 🛡️ Try putting it in CoreGui if possible
pcall(function()
	gui.Parent = game:GetService("CoreGui")
end)

-- 💥 Force highest DisplayOrder and ZIndex on all children
gui.DisplayOrder = 999999
gui.IgnoreGuiInset = true
gui.Enabled = true

local function forceZIndex(guiObj)
	if guiObj:IsA("GuiObject") then
		guiObj.ZIndex = 999999
	end
	for _, child in ipairs(guiObj:GetChildren()) do
		forceZIndex(child)
	end
end

forceZIndex(gui)

-- 🧠 Also reconnect on every render just to be sure
RunService.RenderStepped:Connect(function()
	gui.DisplayOrder = 999999
	forceZIndex(gui)
end)

-- 🧼 Kill any BlurEffects (they mess with visibility sometimes)
for _, v in ipairs(game:GetService("Lighting"):GetChildren()) do
	if v:IsA("BlurEffect") then
		v:Destroy()
	end
end
-- 🧿 Target Line ESP System 🔥
local ShowTargetLine = false
local LineESP = Drawing.new("Line")
LineESP.Visible = false
LineESP.Color = Color3.fromRGB(255, 0, 0)
LineESP.Thickness = 2
LineESP.Transparency = 1

-- 👁️ ESP Tab Toggle for Line
createToggle(espTab, "Target Line ESP", 455, false, function(state)
	ShowTargetLine = state
	if not state then
		LineESP.Visible = false
	end
end)

-- 🔁 Update Every Frame
RunService.RenderStepped:Connect(function()
	if ShowTargetLine and ESPEnabled and LockedTarget and LockedTarget.Character and LockedTarget.Character:FindFirstChild("Head") then
		local headPos = LockedTarget.Character.Head.Position
		local screenPos, onScreen = Camera:WorldToViewportPoint(headPos)
		if onScreen then
			local mousePos = UserInputService:GetMouseLocation() - Vector2.new(0, 36)
			LineESP.From = mousePos
			LineESP.To = Vector2.new(screenPos.X, screenPos.Y)
			LineESP.Visible = true
		else
			LineESP.Visible = false
		end
	else
		LineESP.Visible = false
	end
end)-- 🐰 Auto Bunny Hop System

local AutoBunnyHop = false
local lastJump = 0

-- 📍 Toggle for Bunny Hop (Moved down so it doesn’t cover anything)
createToggle(playerTab, "Auto Bunny Hop", 250, false, function(state)
	AutoBunnyHop = state
end)

-- 🔁 Loop for continuous hop when grounded
RunService.RenderStepped:Connect(function()
	if AutoBunnyHop and Humanoid and Humanoid:GetState() == Enum.HumanoidStateType.Running then
		if tick() - lastJump > 0.35 and Humanoid.FloorMaterial ~= Enum.Material.Air then
			Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
			lastJump = tick()
		end
	end
end)-- 💤 Anti-AFK Feature
local AntiAFK = false
local VirtualUser = game:GetService("VirtualUser")

-- 🔘 Toggle inside Player Tab (slightly offset so no overlap)
createToggle(playerTab, "Anti-AFK", 290, false, function(state)
    AntiAFK = state
end)

-- ♻️ Kick Bypass Loop
LocalPlayer.Idled:Connect(function()
    if AntiAFK then
        VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end
end)
