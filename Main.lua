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

-- Sidebar Frame
local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Size = UDim2.new(0, 180, 0, 350)
sidebar.Position = UDim2.new(0, 100, 0, 100)
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

-- Sidebar Tabs
local tabNames = {"EVENT", "SHOP", "FARM"}
local tabButtons = {}
for i, name in ipairs(tabNames) do
    local tabBtn = Instance.new("TextButton")
    tabBtn.Name = name .. "TabBtn"
    tabBtn.Size = UDim2.new(1, 0, 0, 36)
    tabBtn.Position = UDim2.new(0, 0, 0, 36 + (i-1)*36)
    tabBtn.BackgroundColor3 = i == 1 and Color3.fromRGB(220, 160, 80) or Color3.fromRGB(60, 70, 90)
    tabBtn.Text = name
    tabBtn.Font = Enum.Font.SourceSansBold
    tabBtn.TextSize = 18
    tabBtn.TextColor3 = Color3.fromRGB(20, 20, 20)
    tabBtn.Parent = sidebar
    tabButtons[name] = tabBtn
end

-- Main Content Frame
local contentFrame = Instance.new("Frame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(1, -10, 1, -120)
contentFrame.Position = UDim2.new(0, 5, 0, 120)
contentFrame.BackgroundColor3 = Color3.fromRGB(120, 130, 150)
contentFrame.BorderSizePixel = 0
contentFrame.Parent = sidebar

-- Show UI Button (when hidden)
local showUIButton = Instance.new("TextButton")
showUIButton.Name = "ShowUIButton"
showUIButton.Size = UDim2.new(0, 140, 0, 36)
showUIButton.Position = UDim2.new(0, 20, 0, 20)
showUIButton.BackgroundColor3 = Color3.fromRGB(80, 90, 110)
showUIButton.Text = "Show GAG UI"
showUIButton.Font = Enum.Font.SourceSansBold
showUIButton.TextSize = 20
showUIButton.TextColor3 = Color3.fromRGB(255,255,255)
showUIButton.Visible = false
showUIButton.Parent = screenGui

-- Hide/Show Logic
local function hideUI()
    sidebar.Visible = false
    showUIButton.Visible = true
end
local function showUI()
    sidebar.Visible = true
    showUIButton.Visible = false
end
closeBtn.MouseButton1Click:Connect(hideUI)
showUIButton.MouseButton1Click:Connect(showUI)
minimizeBtn.MouseButton1Click:Connect(function()
    sidebar.Visible = not sidebar.Visible
    showUIButton.Visible = not sidebar.Visible
end)
UserInputService.InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.RightShift then
        if sidebar.Visible then
            hideUI()
        else
            showUI()
        end
    end
end)

-- Tab Switching Logic (UI only for now)
local function selectTab(tabName)
    for name, btn in pairs(tabButtons) do
        btn.BackgroundColor3 = name == tabName and Color3.fromRGB(220, 160, 80) or Color3.fromRGB(60, 70, 90)
    end
    -- Tab content will be handled in next steps
end
for name, btn in pairs(tabButtons) do
    btn.MouseButton1Click:Connect(function()
        selectTab(name)
    end)
end

-- Tab Content Creation
local tabContent = {}

-- EVENT TAB CONTENT
local eventFrame = Instance.new("Frame")
eventFrame.Name = "EventTabContent"
eventFrame.Size = UDim2.new(1, 0, 1, 0)
eventFrame.BackgroundTransparency = 1
eventFrame.Visible = true
eventFrame.Parent = contentFrame

tabContent["EVENT"] = eventFrame

local eventHeader = Instance.new("TextLabel")
eventHeader.Size = UDim2.new(1, -20, 0, 36)
eventHeader.Position = UDim2.new(0, 10, 0, 10)
eventHeader.BackgroundColor3 = Color3.fromRGB(30, 60, 120)
eventHeader.Text = "SUMMER HARVEST"
eventHeader.Font = Enum.Font.SourceSansBold
eventHeader.TextSize = 20
eventHeader.TextColor3 = Color3.fromRGB(255,255,255)
eventHeader.BorderSizePixel = 0
eventHeader.Parent = eventFrame

local autoSubmitToggle = Instance.new("TextButton")
autoSubmitToggle.Name = "AutoSubmitToggle"
autoSubmitToggle.Size = UDim2.new(1, -20, 0, 36)
autoSubmitToggle.Position = UDim2.new(0, 10, 0, 56)
autoSubmitToggle.BackgroundColor3 = Color3.fromRGB(60, 120, 180)
autoSubmitToggle.Text = "AUTO SUBMIT:  [OFF]"
autoSubmitToggle.Font = Enum.Font.SourceSansBold
autoSubmitToggle.TextSize = 18
autoSubmitToggle.TextColor3 = Color3.fromRGB(255,255,255)
autoSubmitToggle.BorderSizePixel = 0
autoSubmitToggle.Parent = eventFrame

-- SHOP TAB CONTENT
local shopFrame = Instance.new("Frame")
shopFrame.Name = "ShopTabContent"
shopFrame.Size = UDim2.new(1, 0, 1, 0)
shopFrame.BackgroundTransparency = 1
shopFrame.Visible = false
shopFrame.Parent = contentFrame

tabContent["SHOP"] = shopFrame

local buyEggHeader = Instance.new("TextLabel")
buyEggHeader.Size = UDim2.new(1, -20, 0, 28)
buyEggHeader.Position = UDim2.new(0, 10, 0, 10)
buyEggHeader.BackgroundColor3 = Color3.fromRGB(30, 60, 120)
buyEggHeader.Text = "BUY EGG:"
buyEggHeader.Font = Enum.Font.SourceSansBold
buyEggHeader.TextSize = 18
buyEggHeader.TextColor3 = Color3.fromRGB(255,255,255)
buyEggHeader.BorderSizePixel = 0
buyEggHeader.Parent = shopFrame

local buySeedsHeader = Instance.new("TextLabel")
buySeedsHeader.Size = UDim2.new(1, -20, 0, 28)
buySeedsHeader.Position = UDim2.new(0, 10, 0, 48)
buySeedsHeader.BackgroundColor3 = Color3.fromRGB(30, 60, 120)
buySeedsHeader.Text = "BUY SEEDS:"
buySeedsHeader.Font = Enum.Font.SourceSansBold
buySeedsHeader.TextSize = 18
buySeedsHeader.TextColor3 = Color3.fromRGB(255,255,255)
buySeedsHeader.BorderSizePixel = 0
buySeedsHeader.Parent = shopFrame

-- Placeholder for multi-select dropdowns (to be implemented)
local eggDropdown = Instance.new("TextLabel")
eggDropdown.Size = UDim2.new(1, -20, 0, 28)
eggDropdown.Position = UDim2.new(0, 10, 0, 86)
eggDropdown.BackgroundColor3 = Color3.fromRGB(60, 120, 180)
eggDropdown.Text = "[Egg Multi-Select Dropdown]"
eggDropdown.Font = Enum.Font.SourceSans
eggDropdown.TextSize = 16
eggDropdown.TextColor3 = Color3.fromRGB(255,255,255)
eggDropdown.BorderSizePixel = 0
eggDropdown.Parent = shopFrame

local seedDropdown = Instance.new("TextLabel")
seedDropdown.Size = UDim2.new(1, -20, 0, 28)
seedDropdown.Position = UDim2.new(0, 10, 0, 124)
seedDropdown.BackgroundColor3 = Color3.fromRGB(60, 120, 180)
seedDropdown.Text = "[Seed Multi-Select Dropdown]"
seedDropdown.Font = Enum.Font.SourceSans
seedDropdown.TextSize = 16
seedDropdown.TextColor3 = Color3.fromRGB(255,255,255)
seedDropdown.BorderSizePixel = 0
seedDropdown.Parent = shopFrame

local autoBuyEggToggle = Instance.new("TextButton")
autoBuyEggToggle.Name = "AutoBuyEggToggle"
autoBuyEggToggle.Size = UDim2.new(1, -20, 0, 36)
autoBuyEggToggle.Position = UDim2.new(0, 10, 0, 170)
autoBuyEggToggle.BackgroundColor3 = Color3.fromRGB(60, 120, 240)
autoBuyEggToggle.Text = "AUTO BUY EGG:  [OFF]"
autoBuyEggToggle.Font = Enum.Font.SourceSansBold
autoBuyEggToggle.TextSize = 18
autoBuyEggToggle.TextColor3 = Color3.fromRGB(255,255,255)
autoBuyEggToggle.BorderSizePixel = 0
autoBuyEggToggle.Parent = shopFrame

local autoBuySeedToggle = Instance.new("TextButton")
autoBuySeedToggle.Name = "AutoBuySeedToggle"
autoBuySeedToggle.Size = UDim2.new(1, -20, 0, 36)
autoBuySeedToggle.Position = UDim2.new(0, 10, 0, 210)
autoBuySeedToggle.BackgroundColor3 = Color3.fromRGB(60, 120, 240)
autoBuySeedToggle.Text = "AUTO BUY SEED:  [OFF]"
autoBuySeedToggle.Font = Enum.Font.SourceSansBold
autoBuySeedToggle.TextSize = 18
autoBuySeedToggle.TextColor3 = Color3.fromRGB(255,255,255)
autoBuySeedToggle.BorderSizePixel = 0
autoBuySeedToggle.Parent = shopFrame

-- FARM TAB CONTENT
local farmFrame = Instance.new("Frame")
farmFrame.Name = "FarmTabContent"
farmFrame.Size = UDim2.new(1, 0, 1, 0)
farmFrame.BackgroundTransparency = 1
farmFrame.Visible = false
farmFrame.Parent = contentFrame

tabContent["FARM"] = farmFrame

local autoFarmToggle = Instance.new("TextButton")
autoFarmToggle.Name = "AutoFarmToggle"
autoFarmToggle.Size = UDim2.new(1, -20, 0, 36)
autoFarmToggle.Position = UDim2.new(0, 10, 0, 10)
autoFarmToggle.BackgroundColor3 = Color3.fromRGB(30, 60, 120)
autoFarmToggle.Text = "AUTO FARM:  [OFF]"
autoFarmToggle.Font = Enum.Font.SourceSansBold
autoFarmToggle.TextSize = 18
autoFarmToggle.TextColor3 = Color3.fromRGB(255,255,255)
autoFarmToggle.BorderSizePixel = 0
autoFarmToggle.Parent = farmFrame

local autoHarvestToggle = Instance.new("TextButton")
autoHarvestToggle.Name = "AutoHarvestToggle"
autoHarvestToggle.Size = UDim2.new(1, -20, 0, 36)
autoHarvestToggle.Position = UDim2.new(0, 10, 0, 56)
autoHarvestToggle.BackgroundColor3 = Color3.fromRGB(30, 60, 120)
autoHarvestToggle.Text = "AUTO HARVEST:  [OFF]"
autoHarvestToggle.Font = Enum.Font.SourceSansBold
autoHarvestToggle.TextSize = 18
autoHarvestToggle.TextColor3 = Color3.fromRGB(255,255,255)
autoHarvestToggle.BorderSizePixel = 0
autoHarvestToggle.Parent = farmFrame

local autoSellToggle = Instance.new("TextButton")
autoSellToggle.Name = "AutoSellToggle"
autoSellToggle.Size = UDim2.new(1, -20, 0, 36)
autoSellToggle.Position = UDim2.new(0, 10, 0, 102)
autoSellToggle.BackgroundColor3 = Color3.fromRGB(30, 60, 120)
autoSellToggle.Text = "AUTO SELL:  [OFF]"
autoSellToggle.Font = Enum.Font.SourceSansBold
autoSellToggle.TextSize = 18
autoSellToggle.TextColor3 = Color3.fromRGB(255,255,255)
autoSellToggle.BorderSizePixel = 0
autoSellToggle.Parent = farmFrame

-- Tab Switching Logic (update to show/hide content)
local function selectTab(tabName)
    for name, btn in pairs(tabButtons) do
        btn.BackgroundColor3 = name == tabName and Color3.fromRGB(220, 160, 80) or Color3.fromRGB(60, 70, 90)
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

-- Ready for next steps: toggles, dropdowns, automation logic, etc.

