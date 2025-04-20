-- ⚡ ISHKEBHUB LOADER ANIMATION (INTEGRATED VERSION)
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

local loaderScreen = Instance.new("ScreenGui", CoreGui)
loaderScreen.Name = "IshkebLoader"
loaderScreen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
loaderScreen.ResetOnSpawn = false

-- 🔳 Background
local bg = Instance.new("Frame", loaderScreen)
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
bg.BackgroundTransparency = 1
bg.ZIndex = 10
TweenService:Create(bg, TweenInfo.new(0.5), {BackgroundTransparency = 0.4}):Play()

-- 🧠 Loading Text
local textLabel = Instance.new("TextLabel", bg)
textLabel.Size = UDim2.new(0, 500, 0, 50)
textLabel.Position = UDim2.new(0.5, -250, 0.5, -75)
textLabel.BackgroundTransparency = 1
textLabel.TextColor3 = Color3.new(1, 1, 1)
textLabel.Font = Enum.Font.GothamBold
textLabel.TextScaled = true
textLabel.Text = "Loading IshkebHub..."
textLabel.ZIndex = 11

-- 📶 Progress Bar Frame
local barFrame = Instance.new("Frame", bg)
barFrame.Size = UDim2.new(0, 500, 0, 10)
barFrame.Position = UDim2.new(0.5, -250, 0.5, -10)
barFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
barFrame.BorderSizePixel = 0
barFrame.ZIndex = 11
Instance.new("UICorner", barFrame).CornerRadius = UDim.new(1, 0)

-- 🔴 Fill
local barFill = Instance.new("Frame", barFrame)
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(255, 75, 75)
barFill.BorderSizePixel = 0
barFill.ZIndex = 12
Instance.new("UICorner", barFill).CornerRadius = UDim.new(1, 0)
-- ⏳ Animate Loading Bar Smoothly
spawn(function()
	for i = 1, 100 do
		barFill.Size = UDim2.new(i / 100, 0, 1, 0)
		wait(0.015)
	end
end)

-- 💤 Fake Delay (matches animation)
wait(1.6)

-- ✅ Now we continue to execute the actual GUI
-- We'll build your full IshkebHub UI below after animation plays
-- 🚀 MAIN GUI EXECUTION
pcall(function()
    -- Insert your full IshkebHub script here 👇👇👇
    
    -- Example:
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local StarterGui = game:GetService("StarterGui")

    StarterGui:SetCore("SendNotification", {
        Title = "IshkebHub",
        Text = "GUI has loaded successfully!",
        Duration = 4
    })

    -- YOUR FULL GUI STARTS HERE...
    -- (Paste everything from Part 1 to 6 of your menu here)

end)
-- SERVICES
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

StarterGui:SetCore("SendNotification", {
    Title = "Ishkeb Hub",
    Text = "Ishkeb Hub Loaded successfully!",
    Duration = 5
})

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

-- GUI SETUP
local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
gui.Name = "IshkebGUI"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0, 720, 0, 480)
mainFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.ZIndex = 10
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, -35)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1, 1, 1)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.ZIndex = 10
title.Text = "Ishkeb Hub"

-- TAB BUTTONS
local tabButtonsFrame = Instance.new("Frame", mainFrame)
tabButtonsFrame.Size = UDim2.new(1, 0, 0, 40)
tabButtonsFrame.Position = UDim2.new(0, 0, 0, 0)
tabButtonsFrame.BackgroundTransparency = 1
tabButtonsFrame.ZIndex = 3

local espTabBtn = Instance.new("TextButton", tabButtonsFrame)
espTabBtn.Text = "ESP & Aimbot"
espTabBtn.Size = UDim2.new(0, 240, 1, 0)
espTabBtn.Position = UDim2.new(0, 0, 0, 0)
espTabBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
espTabBtn.TextColor3 = Color3.new(1, 1, 1)
espTabBtn.Font = Enum.Font.GothamBold
espTabBtn.TextScaled = true
espTabBtn.ZIndex = 4

local playerTabBtn = Instance.new("TextButton", tabButtonsFrame)
playerTabBtn.Text = "Player"
playerTabBtn.Size = UDim2.new(0, 240, 1, 0)
playerTabBtn.Position = UDim2.new(0, 240, 0, 0)
playerTabBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
playerTabBtn.TextColor3 = Color3.new(1, 1, 1)
playerTabBtn.Font = Enum.Font.GothamBold
playerTabBtn.TextScaled = true
playerTabBtn.ZIndex = 4

local creditsTabBtn = Instance.new("TextButton", tabButtonsFrame)
creditsTabBtn.Text = "Credits"
creditsTabBtn.Size = UDim2.new(0, 240, 1, 0)
creditsTabBtn.Position = UDim2.new(0, 480, 0, 0)
creditsTabBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
creditsTabBtn.TextColor3 = Color3.new(1, 1, 1)
creditsTabBtn.Font = Enum.Font.GothamBold
creditsTabBtn.TextScaled = true
creditsTabBtn.ZIndex = 4
local tabContainer = Instance.new("Frame", mainFrame)
tabContainer.Position = UDim2.new(0, 0, 0, 40)
tabContainer.Size = UDim2.new(1, 0, 1, -40)
tabContainer.BackgroundTransparency = 1
tabContainer.ClipsDescendants = true
tabContainer.ZIndex = 1

local espTab = Instance.new("Frame", tabContainer)
espTab.Size = UDim2.new(1, 0, 1, 0)
espTab.Position = UDim2.new(0, 0, 0, 0)
espTab.BackgroundTransparency = 1
espTab.ZIndex = 1

local playerTab = Instance.new("Frame", tabContainer)
playerTab.Size = UDim2.new(1, 0, 1, 0)
playerTab.Position = UDim2.new(1, 0, 0, 0)
playerTab.BackgroundTransparency = 1
playerTab.ZIndex = 1

local creditsTab = Instance.new("Frame", tabContainer)
creditsTab.Size = UDim2.new(1, 0, 1, 0)
creditsTab.Position = UDim2.new(2, 0, 0, 0)
creditsTab.BackgroundTransparency = 1
creditsTab.ZIndex = 1

-- SLIDE ANIMATION HELPER
local function tweenObject(obj, props, time, style, dir, callback)
    local info = TweenInfo.new(time or 0.3, style or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out)
    local tween = TweenService:Create(obj, info, props)
    tween:Play()
    if callback then tween.Completed:Connect(callback) end
end

-- CURRENT TAB STATE
local currentTab = "esp"
local function toggleTab(tabName)
    if tabName == currentTab then return end
    currentTab = tabName

    if tabName == "esp" then
        tweenObject(playerTab, {Position = UDim2.new(1, 0, 0, 0)}, 0.25)
        tweenObject(creditsTab, {Position = UDim2.new(2, 0, 0, 0)}, 0.25)
        tweenObject(espTab, {Position = UDim2.new(0, 0, 0, 0)}, 0.25)
    elseif tabName == "player" then
        tweenObject(espTab, {Position = UDim2.new(-1, 0, 0, 0)}, 0.25)
        tweenObject(creditsTab, {Position = UDim2.new(2, 0, 0, 0)}, 0.25)
        tweenObject(playerTab, {Position = UDim2.new(0, 0, 0, 0)}, 0.25)
    elseif tabName == "credits" then
        tweenObject(espTab, {Position = UDim2.new(-1, 0, 0, 0)}, 0.25)
        tweenObject(playerTab, {Position = UDim2.new(-1, 0, 0, 0)}, 0.25)
        tweenObject(creditsTab, {Position = UDim2.new(0, 0, 0, 0)}, 0.25)
    end
end

-- HOOK BUTTONS TO TABS
espTabBtn.MouseButton1Click:Connect(function() toggleTab("esp") end)
playerTabBtn.MouseButton1Click:Connect(function() toggleTab("player") end)
creditsTabBtn.MouseButton1Click:Connect(function() toggleTab("credits") end)
-- UI HELPERS
local function createToggle(parent, text, posY, default, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0, 250, 0, 30)
    btn.Position = UDim2.new(0, 20, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextScaled = true
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    local state = default
    btn.Text = text .. ": " .. (state and "ON" or "OFF")
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = text .. ": " .. (state and "ON" or "OFF")
        callback(state)
    end)
end

local function createSlider(parent, labelText, posY, initialValue, minValue, maxValue, step, onChange)
    local label = Instance.new("TextLabel", parent)
    label.Text = labelText .. ": " .. tostring(initialValue)
    label.Position = UDim2.new(0, 20, 0, posY)
    label.Size = UDim2.new(0, 200, 0, 20)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Font = Enum.Font.Gotham
    label.TextScaled = true

    local sliderBack = Instance.new("Frame", parent)
    sliderBack.Position = UDim2.new(0, 240, 0, posY)
    sliderBack.Size = UDim2.new(0, 400, 0, 20)
    sliderBack.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Instance.new("UICorner", sliderBack).CornerRadius = UDim.new(0, 6)

    local fill = Instance.new("Frame", sliderBack)
    fill.Size = UDim2.new((initialValue - minValue) / (maxValue - minValue), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(255, 0, 0)

    local dragBtn = Instance.new("TextButton", sliderBack)
    dragBtn.Size = UDim2.new(0, 20, 1, 0)
    dragBtn.Position = UDim2.new((initialValue - minValue) / (maxValue - minValue), -10, 0, 0)
    dragBtn.Text = ""
    dragBtn.BackgroundColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", dragBtn).CornerRadius = UDim.new(1, 0)

    local dragging = false
    dragBtn.MouseButton1Down:Connect(function() dragging = true end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)

    RunService.RenderStepped:Connect(function()
        if dragging then
            local percent = math.clamp((UserInputService:GetMouseLocation().X - sliderBack.AbsolutePosition.X) / sliderBack.AbsoluteSize.X, 0, 1)
            local value = math.floor((minValue + percent * (maxValue - minValue)) / step + 0.5) * step
            fill.Size = UDim2.new((value - minValue) / (maxValue - minValue), 0, 1, 0)
            dragBtn.Position = UDim2.new((value - minValue) / (maxValue - minValue), -10, 0, 0)
            label.Text = labelText .. ": " .. tostring(value)
            onChange(value)
        end
    end)
end

-- ESP TAB CONTROLS
createToggle(espTab, "Aimbot", 20, AimbotEnabled, function(v) AimbotEnabled = v end)
createToggle(espTab, "ESP (Chams)", 60, ESPEnabled, function(v) ESPEnabled = v end)
createToggle(espTab, "Team Check", 100, TeamCheck, function(v) TeamCheck = v end)
createToggle(espTab, "FOV Circle", 140, ShowFOVCircle, function(v) ShowFOVCircle = v end)
createToggle(espTab, "Noclip", 180, NoclipEnabled, function(v) NoclipEnabled = v end)
createToggle(espTab, "TriggerBot", 220, TriggerBotEnabled, function(v) TriggerBotEnabled = v end)

createSlider(espTab, "Smoothness", 270, AimbotSmoothness, 0.01, 1.00, 0.01, function(v) AimbotSmoothness = v end)
createSlider(espTab, "FOV Radius", 320, FOVRadius, 10, 300, 1, function(v) FOVRadius = v end)
-- PLAYER TAB CONTROLS
createSlider(playerTab, "WalkSpeed", 20, WalkSpeed, 0, 100, 1, function(v)
    WalkSpeed = v
    if Humanoid then Humanoid.WalkSpeed = v end
end)

createSlider(playerTab, "JumpPower", 70, JumpPower, 0, 150, 1, function(v)
    JumpPower = v
    if Humanoid then Humanoid.JumpPower = v end
end)

-- 🔭 Camera FOV Slider
createSlider(playerTab, "Camera FOV", 120, Camera.FieldOfView, 30, 120, 1, function(v)
    Camera.FieldOfView = v
end)

-- 🧙‍♂️ Teleport Tool Button
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
tpButton.Position = UDim2.new(0, 20, 0, 170)
tpButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
tpButton.TextColor3 = Color3.new(1, 1, 1)
tpButton.Font = Enum.Font.Gotham
tpButton.TextScaled = true
Instance.new("UICorner", tpButton).CornerRadius = UDim.new(0, 6)
tpButton.MouseButton1Click:Connect(giveTeleportTool)
-- 🎯 FOV Circle Setup
local FOVCircle = Drawing.new("Circle")
FOVCircle.Color = Color3.fromRGB(255, 0, 0)
FOVCircle.Thickness = 1
FOVCircle.Filled = false
FOVCircle.Visible = false

-- 👀 Mouse Inputs (Right-click Lock)
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

-- 🔥 Chams/ESP Handler
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
-- 🧠 Main Loop (Every Frame)
RunService.RenderStepped:Connect(function()
    local mousePos = UserInputService:GetMouseLocation() - Vector2.new(0, 36)

    -- 🎯 FOV Circle visuals
    FOVCircle.Visible = ShowFOVCircle
    FOVCircle.Position = mousePos
    FOVCircle.Radius = FOVRadius
    FOVCircle.Color = LockedTarget and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)

    -- 🧱 Noclip Logic
    if NoclipEnabled and Character then
        for _, part in ipairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end

    -- 🎯 Aimbot Logic
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
            local head = LockedTarget.Character.Head.Position
            local dir = (head - Camera.CFrame.Position).Unit
            Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + dir), AimbotSmoothness)
        end
    end

    -- 🔫 TriggerBot Logic
    if TriggerBotEnabled and LockedTarget and LockedTarget.Character and LockedTarget.Character:FindFirstChild("Head") then
        local mouse = LocalPlayer:GetMouse()
        local target = LockedTarget.Character:FindFirstChild("Head")
        if target then
            local headPos, onScreen = Camera:WorldToViewportPoint(target.Position)
            if onScreen then
                local dist = (Vector2.new(headPos.X, headPos.Y) - mousePos).Magnitude
                if dist < 15 then
                    mouse1click()
                end
            end
        end
    end

    -- 🧬 Update Chams
    updateChams()

    -- 🔐 Lock WalkSpeed & JumpPower
    if Humanoid then
        Humanoid.WalkSpeed = WalkSpeed
        Humanoid.JumpPower = JumpPower
    end
end)
-- 🧼 FADE OUT ANIMATION & CLEANUP
TweenService:Create(bg, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
TweenService:Create(textLabel, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
TweenService:Create(barFill, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
TweenService:Create(barFrame, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
wait(0.6)
loaderScreen:Destroy()
