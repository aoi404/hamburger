
--[[
GAG SCRIPT BY:BREAD
Modern Sidebar GUI Foundation (Step 1)
--]]

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

-- Main GUI
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "GAG_SidebarGUI"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

-- Sidebar Frame (match screenshot: left sidebar, main content right)
local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Size = UDim2.new(0, 480, 0, 320)
sidebar.Position = UDim2.new(0.5, -240, 0.5, -160)
sidebar.BackgroundColor3 = Color3.fromRGB(80, 90, 110)
sidebar.BorderSizePixel = 0
sidebar.Parent = screenGui
sidebar.Visible = true

-- Title Bar
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 36)
titleBar.BackgroundColor3 = Color3.fromRGB(60, 70, 90)
titleBar.BorderSizePixel = 0
titleBar.Parent = sidebar

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(1, -60, 1, 0)
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "GAG SCRIPT BY:BREAD"
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 22
titleLabel.TextColor3 = Color3.fromRGB(20, 20, 20)
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

-- Close Button
local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseBtn"
closeBtn.Size = UDim2.new(0, 32, 1, 0)
closeBtn.Position = UDim2.new(1, -32, 0, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(120, 40, 40)
closeBtn.Text = "✕"
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.TextSize = 22
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeBtn.Parent = titleBar

-- Minimize Button
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Name = "MinimizeBtn"
minimizeBtn.Size = UDim2.new(0, 32, 1, 0)
minimizeBtn.Position = UDim2.new(1, -64, 0, 0)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(60, 70, 90)
minimizeBtn.Text = "_"
minimizeBtn.Font = Enum.Font.SourceSansBold
minimizeBtn.TextSize = 22
minimizeBtn.TextColor3 = Color3.fromRGB(255,255,255)
minimizeBtn.Parent = titleBar

-- Remove old contentFrame if exists
for _, child in ipairs(sidebar:GetChildren()) do
    if child.Name == "ContentFrame" then child:Destroy() end
    if child.Name == "NavBar" then child:Destroy() end
end

-- Sidebar Navigation (vertical, left, fixed width)
local navBar = Instance.new("Frame")
navBar.Name = "NavBar"
navBar.Size = UDim2.new(0, 120, 1, -36)
navBar.Position = UDim2.new(0, 0, 0, 36)
navBar.BackgroundColor3 = Color3.fromRGB(80, 90, 110)
navBar.BorderSizePixel = 0
navBar.Parent = sidebar

local navLine = Instance.new("Frame")
navLine.Size = UDim2.new(0, 4, 1, 0)
navLine.Position = UDim2.new(1, -4, 0, 0)
navLine.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
navLine.BorderSizePixel = 0
navLine.Parent = navBar

-- Tab Buttons (vertical, full width of navBar)
local tabNames = {"EVENT", "SHOP", "FARM"}
local tabButtons = {}
for i, name in ipairs(tabNames) do
    local tabBtn = Instance.new("TextButton")
    tabBtn.Name = name .. "TabBtn"
    tabBtn.Size = UDim2.new(1, 0, 0, 48)
    tabBtn.Position = UDim2.new(0, 0, 0, (i-1)*48)
    tabBtn.BackgroundColor3 = i == 1 and Color3.fromRGB(220, 160, 80) or Color3.fromRGB(80, 90, 110)
    tabBtn.Text = name
    tabBtn.Font = Enum.Font.SourceSansBold
    tabBtn.TextSize = 22
    tabBtn.TextColor3 = Color3.fromRGB(20, 20, 20)
    tabBtn.BorderSizePixel = 0
    tabBtn.Parent = navBar
    tabButtons[name] = tabBtn
end

-- Main Content Frame (right of sidebar, fill remaining space)
local contentFrame = Instance.new("Frame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(1, -120, 1, -36)
contentFrame.Position = UDim2.new(0, 120, 0, 36)
contentFrame.BackgroundColor3 = Color3.fromRGB(120, 130, 150)
contentFrame.BorderSizePixel = 0
contentFrame.Parent = sidebar

-- Tab Content Creation (clear and rebuild for new layout)
for _, frame in pairs(contentFrame:GetChildren()) do frame:Destroy() end
local tabContent = {}

-- EVENT TAB CONTENT (match screenshot)
local eventFrame = Instance.new("Frame")
eventFrame.Name = "EventTabContent"
eventFrame.Size = UDim2.new(1, 0, 1, 0)
eventFrame.BackgroundTransparency = 1
eventFrame.Visible = true
eventFrame.Parent = contentFrame
tabContent["EVENT"] = eventFrame

local eventHeader = Instance.new("TextLabel")
eventHeader.Size = UDim2.new(1, -64, 0, 56)
eventHeader.Position = UDim2.new(0, 32, 0, 32)
eventHeader.BackgroundColor3 = Color3.fromRGB(20, 60, 120)
eventHeader.Text = "SUMMER HARVEST"
eventHeader.Font = Enum.Font.SourceSansBold
eventHeader.TextSize = 32
eventHeader.TextColor3 = Color3.fromRGB(255,255,255)
eventHeader.BorderSizePixel = 0
eventHeader.Parent = eventFrame
eventHeader.TextXAlignment = Enum.TextXAlignment.Center
eventHeader.TextYAlignment = Enum.TextYAlignment.Center

game:GetService("StarterGui").SetCore("ResetButtonCallback", false)

local autoSubmitToggle = Instance.new("TextButton")
autoSubmitToggle.Name = "AutoSubmitToggle"
autoSubmitToggle.Size = UDim2.new(1, -64, 0, 48)
autoSubmitToggle.Position = UDim2.new(0, 32, 0, 104)
autoSubmitToggle.BackgroundColor3 = Color3.fromRGB(40, 110, 180)
autoSubmitToggle.Text = "AUTO SUBMIT:  [OFF]"
autoSubmitToggle.Font = Enum.Font.SourceSansBold
autoSubmitToggle.TextSize = 26
autoSubmitToggle.TextColor3 = Color3.fromRGB(255,255,255)
autoSubmitToggle.BorderSizePixel = 0
autoSubmitToggle.TextXAlignment = Enum.TextXAlignment.Center
autoSubmitToggle.Parent = eventFrame

local autoSubmitState = false
autoSubmitToggle.MouseButton1Click:Connect(function()
    autoSubmitState = not autoSubmitState
    autoSubmitToggle.Text = autoSubmitState and "AUTO SUBMIT:  [ON]" or "AUTO SUBMIT:  [OFF]"
    autoSubmitToggle.BackgroundColor3 = autoSubmitState and Color3.fromRGB(60, 200, 120) or Color3.fromRGB(40, 110, 180)
end)

-- SHOP TAB CONTENT (restore)
local shopFrame = Instance.new("Frame")
shopFrame.Name = "ShopTabContent"
shopFrame.Size = UDim2.new(1, 0, 1, 0)
shopFrame.BackgroundTransparency = 1
shopFrame.Visible = false
shopFrame.Parent = contentFrame
tabContent["SHOP"] = shopFrame

local shopHeader = Instance.new("TextLabel")
shopHeader.Size = UDim2.new(1, -64, 0, 56)
shopHeader.Position = UDim2.new(0, 32, 0, 32)
shopHeader.BackgroundColor3 = Color3.fromRGB(20, 60, 120)
shopHeader.Text = "SHOP"
shopHeader.Font = Enum.Font.SourceSansBold
shopHeader.TextSize = 32
shopHeader.TextColor3 = Color3.fromRGB(255,255,255)
shopHeader.BorderSizePixel = 0
shopHeader.Parent = shopFrame
shopHeader.TextXAlignment = Enum.TextXAlignment.Center
shopHeader.TextYAlignment = Enum.TextYAlignment.Center

-- Placeholder for toggles/dropdowns (add your automation toggles/dropdowns here)
local shopPlaceholder = Instance.new("TextLabel")
shopPlaceholder.Size = UDim2.new(1, -64, 0, 40)
shopPlaceholder.Position = UDim2.new(0, 32, 0, 104)
shopPlaceholder.BackgroundTransparency = 1
shopPlaceholder.Text = "[SHOP CONTENT HERE]"
shopPlaceholder.Font = Enum.Font.SourceSans
shopPlaceholder.TextSize = 22
shopPlaceholder.TextColor3 = Color3.fromRGB(200,200,200)
shopPlaceholder.Parent = shopFrame

-- FARM TAB CONTENT (restore)
local farmFrame = Instance.new("Frame")
farmFrame.Name = "FarmTabContent"
farmFrame.Size = UDim2.new(1, 0, 1, 0)
farmFrame.BackgroundTransparency = 1
farmFrame.Visible = false
farmFrame.Parent = contentFrame
tabContent["FARM"] = farmFrame

local farmHeader = Instance.new("TextLabel")
farmHeader.Size = UDim2.new(1, -64, 0, 56)
farmHeader.Position = UDim2.new(0, 32, 0, 32)
farmHeader.BackgroundColor3 = Color3.fromRGB(20, 60, 120)
farmHeader.Text = "FARM"
farmHeader.Font = Enum.Font.SourceSansBold
farmHeader.TextSize = 32
farmHeader.TextColor3 = Color3.fromRGB(255,255,255)
farmHeader.BorderSizePixel = 0
farmHeader.Parent = farmFrame
farmHeader.TextXAlignment = Enum.TextXAlignment.Center
farmHeader.TextYAlignment = Enum.TextYAlignment.Center

local farmPlaceholder = Instance.new("TextLabel")
farmPlaceholder.Size = UDim2.new(1, -64, 0, 40)
farmPlaceholder.Position = UDim2.new(0, 32, 0, 104)
farmPlaceholder.BackgroundTransparency = 1
farmPlaceholder.Text = "[FARM CONTENT HERE]"
farmPlaceholder.Font = Enum.Font.SourceSans
farmPlaceholder.TextSize = 22
farmPlaceholder.TextColor3 = Color3.fromRGB(200,200,200)
farmPlaceholder.Parent = farmFrame

-- Tab Switching Logic (update to show/hide content)
local function selectTab(tabName)
    for name, btn in pairs(tabButtons) do
        btn.BackgroundColor3 = name == tabName and Color3.fromRGB(220, 160, 80) or Color3.fromRGB(80, 90, 110)
    end
    for name, frame in pairs(tabContent) do
        frame.Visible = (name == tabName)
    end
end
for name, btn in pairs(tabButtons) do
    btn.MouseButton1Click:Connect(function()
        selectTab(name)
    end)
end

-- Hide dropdowns if clicking elsewhere
local function hideDropdowns(input)
    if eggDropdownList.Visible and not eggDropdownBtn:IsAncestorOf(input.Target) then
        eggDropdownList.Visible = false
        eggDropdownList.Size = UDim2.new(1, 0, 0, 0)
    end
    if seedDropdownList.Visible and not seedDropdownBtn:IsAncestorOf(input.Target) then
        seedDropdownList.Visible = false
        seedDropdownList.Size = UDim2.new(1, 0, 0, 0)
    end
end
UserInputService.InputBegan:Connect(function(input, processed)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        hideDropdowns(input)
    end
end)

