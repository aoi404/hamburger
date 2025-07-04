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
sidebar.Size = UDim2.new(0, 400, 0, 540)
sidebar.Position = UDim2.new(0.5, -200, 0.5, -270)
sidebar.BackgroundColor3 = Color3.fromRGB(80, 90, 110)
sidebar.BorderSizePixel = 0
sidebar.Parent = screenGui
sidebar.Visible = true

-- Top Bar (Header) for Sidebar
local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 44)
topBar.Position = UDim2.new(0, 0, 0, 0)
topBar.BackgroundColor3 = Color3.fromRGB(80, 90, 110)
topBar.BorderSizePixel = 0
topBar.Parent = sidebar

-- Subtle bottom border for top bar
local topBarBorder = Instance.new("Frame")
topBarBorder.Size = UDim2.new(1, 0, 0, 2)
topBarBorder.Position = UDim2.new(0, 0, 1, -2)
topBarBorder.BackgroundColor3 = Color3.fromRGB(60, 70, 90)
topBarBorder.BorderSizePixel = 0
topBarBorder.Parent = topBar

-- Title Label in Top Bar
local topBarTitle = Instance.new("TextLabel")
topBarTitle.Name = "TopBarTitle"
topBarTitle.Size = UDim2.new(1, -80, 1, 0)
topBarTitle.Position = UDim2.new(0, 12, 0, 0)
topBarTitle.BackgroundTransparency = 1
topBarTitle.Text = "GAG SCRIPT BY:BREAD"
topBarTitle.Font = Enum.Font.SourceSansBold
topBarTitle.TextSize = 24
topBarTitle.TextColor3 = Color3.fromRGB(40, 40, 40)
topBarTitle.TextXAlignment = Enum.TextXAlignment.Left
topBarTitle.Parent = topBar

-- Move Minimize and Close Buttons to Top Bar
minimizeBtn.Parent = topBar
minimizeBtn.Position = UDim2.new(1, -64, 0, 0)
minimizeBtn.Size = UDim2.new(0, 32, 1, 0)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(80, 90, 110)

closeBtn.Parent = topBar
closeBtn.Position = UDim2.new(1, -32, 0, 0)
closeBtn.Size = UDim2.new(0, 32, 1, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(120, 40, 40)

-- Remove old TitleBar frame if it exists
if titleBar then titleBar:Destroy() end

-- Sidebar Tabs
local tabNames = {"EVENT", "SHOP", "FARM"}
local tabButtons = {}
for i, name in ipairs(tabNames) do
    local tabBtn = Instance.new("TextButton")
    tabBtn.Name = name .. "TabBtn"
    tabBtn.Size = UDim2.new(1, 0, 0, 36)
    tabBtn.Position = UDim2.new(0, 0, 0, 44 + (i-1)*48)
    tabBtn.BackgroundColor3 = i == 1 and Color3.fromRGB(220, 160, 80) or Color3.fromRGB(80, 90, 110)
    tabBtn.Text = name
    tabBtn.Font = Enum.Font.SourceSansBold
    tabBtn.TextSize = 22
    tabBtn.TextColor3 = Color3.fromRGB(40, 40, 40)
    tabBtn.Parent = sidebar
    tabButtons[name] = tabBtn
end

-- Add vertical black line between sidebar and content
local navLine = Instance.new("Frame")
navLine.Size = UDim2.new(0, 4, 1, -44)
navLine.Position = UDim2.new(1, -4, 0, 44)
navLine.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
navLine.BorderSizePixel = 0
navLine.Parent = sidebar

-- Main Content Frame
local contentFrame = Instance.new("Frame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(1, -120, 1, -44)
contentFrame.Position = UDim2.new(0, 120, 0, 44)
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
for _, frame in pairs(contentFrame:GetChildren()) do frame:Destroy() end
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
eventHeader.Size = UDim2.new(1, -40, 0, 48)
eventHeader.Position = UDim2.new(0, 20, 0, 32)
eventHeader.BackgroundColor3 = Color3.fromRGB(30, 60, 120)
eventHeader.Text = "SUMMER HARVEST"
eventHeader.Font = Enum.Font.SourceSansBold
eventHeader.TextSize = 28
eventHeader.TextColor3 = Color3.fromRGB(255,255,255)
eventHeader.BorderSizePixel = 0
eventHeader.Parent = eventFrame

local autoSubmitToggle = Instance.new("TextButton")
autoSubmitToggle.Name = "AutoSubmitToggle"
autoSubmitToggle.Size = UDim2.new(1, -40, 0, 44)
autoSubmitToggle.Position = UDim2.new(0, 20, 0, 96)
autoSubmitToggle.BackgroundColor3 = Color3.fromRGB(60, 120, 180)
autoSubmitToggle.Text = "AUTO SUBMIT:  [OFF]"
autoSubmitToggle.Font = Enum.Font.SourceSansBold
autoSubmitToggle.TextSize = 22
autoSubmitToggle.TextColor3 = Color3.fromRGB(255,255,255)
autoSubmitToggle.BorderSizePixel = 0
autoSubmitToggle.Parent = eventFrame
local autoSubmitState = false
autoSubmitToggle.MouseButton1Click:Connect(function()
    autoSubmitState = not autoSubmitState
    autoSubmitToggle.Text = autoSubmitState and "AUTO SUBMIT:  [ON]" or "AUTO SUBMIT:  [OFF]"
    autoSubmitToggle.BackgroundColor3 = autoSubmitState and Color3.fromRGB(60, 200, 120) or Color3.fromRGB(60, 120, 180)
end)

-- SHOP TAB CONTENT
local shopFrame = Instance.new("Frame")
shopFrame.Name = "ShopTabContent"
shopFrame.Size = UDim2.new(1, 0, 1, 0)
shopFrame.BackgroundTransparency = 1
shopFrame.Visible = false
shopFrame.Parent = contentFrame
tabContent["SHOP"] = shopFrame

local buyEggHeader = Instance.new("TextLabel")
buyEggHeader.Size = UDim2.new(1, -40, 0, 38)
buyEggHeader.Position = UDim2.new(0, 20, 0, 32)
buyEggHeader.BackgroundColor3 = Color3.fromRGB(30, 60, 120)
buyEggHeader.Text = "BUY EGG:"
buyEggHeader.Font = Enum.Font.SourceSansBold
buyEggHeader.TextSize = 22
buyEggHeader.TextColor3 = Color3.fromRGB(255,255,255)
buyEggHeader.BorderSizePixel = 0
buyEggHeader.Parent = shopFrame

-- Egg Dropdown Button
local eggDropdownBtn = Instance.new("TextButton")
eggDropdownBtn.Name = "EggDropdownBtn"
eggDropdownBtn.Size = UDim2.new(1, -40, 0, 36)
eggDropdownBtn.Position = UDim2.new(0, 20, 0, 78)
eggDropdownBtn.BackgroundColor3 = Color3.fromRGB(60, 120, 180)
eggDropdownBtn.Text = "Select Eggs..."
eggDropdownBtn.Font = Enum.Font.SourceSansSemibold
eggDropdownBtn.TextSize = 18
eggDropdownBtn.TextColor3 = Color3.fromRGB(255,255,255)
eggDropdownBtn.BorderSizePixel = 0
eggDropdownBtn.Parent = shopFrame

local eggDropdownList = Instance.new("Frame")
eggDropdownList.Name = "EggDropdownList"
eggDropdownList.Size = UDim2.new(1, 0, 0, 0)
eggDropdownList.Position = UDim2.new(0, 0, 1, 0)
eggDropdownList.BackgroundColor3 = Color3.fromRGB(80, 140, 200)
eggDropdownList.BorderSizePixel = 0
eggDropdownList.Visible = false
eggDropdownList.Parent = eggDropdownBtn

local eggOptions = {"Egg A", "Egg B", "Egg C"}
local selectedEggs = {}
local function updateEggDropdownText()
    if #selectedEggs == 0 then
        eggDropdownBtn.Text = "Select Eggs..."
    else
        eggDropdownBtn.Text = table.concat(selectedEggs, ", ")
    end
end
for i, name in ipairs(eggOptions) do
    local opt = Instance.new("TextButton")
    opt.Size = UDim2.new(1, 0, 0, 32)
    opt.Position = UDim2.new(0, 0, 0, (i-1)*32)
    opt.BackgroundColor3 = Color3.fromRGB(100, 170, 220)
    opt.Text = name
    opt.Font = Enum.Font.SourceSans
    opt.TextSize = 18
    opt.TextColor3 = Color3.fromRGB(255,255,255)
    opt.BorderSizePixel = 0
    opt.Parent = eggDropdownList
    opt.MouseButton1Click:Connect(function()
        local found = false
        for j, v in ipairs(selectedEggs) do
            if v == name then table.remove(selectedEggs, j) found = true break end
        end
        if not found then table.insert(selectedEggs, name) end
        updateEggDropdownText()
        opt.BackgroundColor3 = found and Color3.fromRGB(100, 170, 220) or Color3.fromRGB(60, 200, 120)
    end)
end
updateEggDropdownText()
eggDropdownBtn.MouseButton1Click:Connect(function()
    eggDropdownList.Visible = not eggDropdownList.Visible
    eggDropdownList.Size = eggDropdownList.Visible and UDim2.new(1, 0, 0, #eggOptions*32) or UDim2.new(1, 0, 0, 0)
end)

-- BUY SEEDS HEADER
local buySeedsHeader = Instance.new("TextLabel")
buySeedsHeader.Size = UDim2.new(1, -40, 0, 38)
buySeedsHeader.Position = UDim2.new(0, 20, 0, 124)
buySeedsHeader.BackgroundColor3 = Color3.fromRGB(30, 60, 120)
buySeedsHeader.Text = "BUY SEEDS:"
buySeedsHeader.Font = Enum.Font.SourceSansBold
buySeedsHeader.TextSize = 22
buySeedsHeader.TextColor3 = Color3.fromRGB(255,255,255)
buySeedsHeader.BorderSizePixel = 0
buySeedsHeader.Parent = shopFrame

-- Seed Dropdown Button
local seedDropdownBtn = Instance.new("TextButton")
seedDropdownBtn.Name = "SeedDropdownBtn"
seedDropdownBtn.Size = UDim2.new(1, -40, 0, 36)
seedDropdownBtn.Position = UDim2.new(0, 20, 0, 170)
seedDropdownBtn.BackgroundColor3 = Color3.fromRGB(60, 120, 180)
seedDropdownBtn.Text = "Select Seeds..."
seedDropdownBtn.Font = Enum.Font.SourceSansSemibold
seedDropdownBtn.TextSize = 18
seedDropdownBtn.TextColor3 = Color3.fromRGB(255,255,255)
seedDropdownBtn.BorderSizePixel = 0
seedDropdownBtn.Parent = shopFrame

local seedDropdownList = Instance.new("Frame")
seedDropdownList.Name = "SeedDropdownList"
seedDropdownList.Size = UDim2.new(1, 0, 0, 0)
seedDropdownList.Position = UDim2.new(0, 0, 1, 0)
seedDropdownList.BackgroundColor3 = Color3.fromRGB(80, 140, 200)
seedDropdownList.BorderSizePixel = 0
seedDropdownList.Visible = false
seedDropdownList.Parent = seedDropdownBtn

local seedOptions = {"Seed X", "Seed Y", "Seed Z"}
local selectedSeeds = {}
local function updateSeedDropdownText()
    if #selectedSeeds == 0 then
        seedDropdownBtn.Text = "Select Seeds..."
    else
        seedDropdownBtn.Text = table.concat(selectedSeeds, ", ")
    end
end
for i, name in ipairs(seedOptions) do
    local opt = Instance.new("TextButton")
    opt.Size = UDim2.new(1, 0, 0, 32)
    opt.Position = UDim2.new(0, 0, 0, (i-1)*32)
    opt.BackgroundColor3 = Color3.fromRGB(100, 170, 220)
    opt.Text = name
    opt.Font = Enum.Font.SourceSans
    opt.TextSize = 18
    opt.TextColor3 = Color3.fromRGB(255,255,255)
    opt.BorderSizePixel = 0
    opt.Parent = seedDropdownList
    opt.MouseButton1Click:Connect(function()
        local found = false
        for j, v in ipairs(selectedSeeds) do
            if v == name then table.remove(selectedSeeds, j) found = true break end
        end
        if not found then table.insert(selectedSeeds, name) end
        updateSeedDropdownText()
        opt.BackgroundColor3 = found and Color3.fromRGB(100, 170, 220) or Color3.fromRGB(60, 200, 120)
    end)
end
updateSeedDropdownText()
seedDropdownBtn.MouseButton1Click:Connect(function()
    seedDropdownList.Visible = not seedDropdownList.Visible
    seedDropdownList.Size = seedDropdownList.Visible and UDim2.new(1, 0, 0, #seedOptions*32) or UDim2.new(1, 0, 0, 0)
end)

-- AUTO BUY EGG TOGGLE
local autoBuyEggToggle = Instance.new("TextButton")
autoBuyEggToggle.Name = "AutoBuyEggToggle"
autoBuyEggToggle.Size = UDim2.new(1, -40, 0, 44)
autoBuyEggToggle.Position = UDim2.new(0, 20, 0, 220)
autoBuyEggToggle.BackgroundColor3 = Color3.fromRGB(60, 120, 240)
autoBuyEggToggle.Text = "AUTO BUY EGG:  [OFF]"
autoBuyEggToggle.Font = Enum.Font.SourceSansBold
autoBuyEggToggle.TextSize = 22
autoBuyEggToggle.TextColor3 = Color3.fromRGB(255,255,255)
autoBuyEggToggle.BorderSizePixel = 0
autoBuyEggToggle.Parent = shopFrame
local autoBuyEggState = false
autoBuyEggToggle.MouseButton1Click:Connect(function()
    autoBuyEggState = not autoBuyEggState
    autoBuyEggToggle.Text = autoBuyEggState and "AUTO BUY EGG:  [ON]" or "AUTO BUY EGG:  [OFF]"
    autoBuyEggToggle.BackgroundColor3 = autoBuyEggState and Color3.fromRGB(60, 200, 120) or Color3.fromRGB(60, 120, 240)
end)

-- AUTO BUY SEED TOGGLE
local autoBuySeedToggle = Instance.new("TextButton")
autoBuySeedToggle.Name = "AutoBuySeedToggle"
autoBuySeedToggle.Size = UDim2.new(1, -40, 0, 44)
autoBuySeedToggle.Position = UDim2.new(0, 20, 0, 272)
autoBuySeedToggle.BackgroundColor3 = Color3.fromRGB(60, 120, 240)
autoBuySeedToggle.Text = "AUTO BUY SEED:  [OFF]"
autoBuySeedToggle.Font = Enum.Font.SourceSansBold
autoBuySeedToggle.TextSize = 22
autoBuySeedToggle.TextColor3 = Color3.fromRGB(255,255,255)
autoBuySeedToggle.BorderSizePixel = 0
autoBuySeedToggle.Parent = shopFrame
local autoBuySeedState = false
autoBuySeedToggle.MouseButton1Click:Connect(function()
    autoBuySeedState = not autoBuySeedState
    autoBuySeedToggle.Text = autoBuySeedState and "AUTO BUY SEED:  [ON]" or "AUTO BUY SEED:  [OFF]"
    autoBuySeedToggle.BackgroundColor3 = autoBuySeedState and Color3.fromRGB(60, 200, 120) or Color3.fromRGB(60, 120, 240)
end)

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
autoFarmToggle.Size = UDim2.new(1, -40, 0, 44)
autoFarmToggle.Position = UDim2.new(0, 20, 0, 32)
autoFarmToggle.BackgroundColor3 = Color3.fromRGB(30, 60, 120)
autoFarmToggle.Text = "AUTO FARM:  [OFF]"
autoFarmToggle.Font = Enum.Font.SourceSansBold
autoFarmToggle.TextSize = 22
autoFarmToggle.TextColor3 = Color3.fromRGB(255,255,255)
autoFarmToggle.BorderSizePixel = 0
autoFarmToggle.Parent = farmFrame
local autoFarmState = false
autoFarmToggle.MouseButton1Click:Connect(function()
    autoFarmState = not autoFarmState
    autoFarmToggle.Text = autoFarmState and "AUTO FARM:  [ON]" or "AUTO FARM:  [OFF]"
    autoFarmToggle.BackgroundColor3 = autoFarmState and Color3.fromRGB(60, 200, 120) or Color3.fromRGB(30, 60, 120)
end)

local autoHarvestToggle = Instance.new("TextButton")
autoHarvestToggle.Name = "AutoHarvestToggle"
autoHarvestToggle.Size = UDim2.new(1, -40, 0, 44)
autoHarvestToggle.Position = UDim2.new(0, 20, 0, 86)
autoHarvestToggle.BackgroundColor3 = Color3.fromRGB(30, 60, 120)
autoHarvestToggle.Text = "AUTO HARVEST:  [OFF]"
autoHarvestToggle.Font = Enum.Font.SourceSansBold
autoHarvestToggle.TextSize = 22
autoHarvestToggle.TextColor3 = Color3.fromRGB(255,255,255)
autoHarvestToggle.BorderSizePixel = 0
autoHarvestToggle.Parent = farmFrame
local autoHarvestState = false
autoHarvestToggle.MouseButton1Click:Connect(function()
    autoHarvestState = not autoHarvestState
    autoHarvestToggle.Text = autoHarvestState and "AUTO HARVEST:  [ON]" or "AUTO HARVEST:  [OFF]"
    autoHarvestToggle.BackgroundColor3 = autoHarvestState and Color3.fromRGB(60, 200, 120) or Color3.fromRGB(30, 60, 120)
end)

local autoSellToggle = Instance.new("TextButton")
autoSellToggle.Name = "AutoSellToggle"
autoSellToggle.Size = UDim2.new(1, -40, 0, 44)
autoSellToggle.Position = UDim2.new(0, 20, 0, 140)
autoSellToggle.BackgroundColor3 = Color3.fromRGB(30, 60, 120)
autoSellToggle.Text = "AUTO SELL:  [OFF]"
autoSellToggle.Font = Enum.Font.SourceSansBold
autoSellToggle.TextSize = 22
autoSellToggle.TextColor3 = Color3.fromRGB(255,255,255)
autoSellToggle.BorderSizePixel = 0
autoSellToggle.Parent = farmFrame
local autoSellState = false
autoSellToggle.MouseButton1Click:Connect(function()
    autoSellState = not autoSellState
    autoSellToggle.Text = autoSellState and "AUTO SELL:  [ON]" or "AUTO SELL:  [OFF]"
    autoSellToggle.BackgroundColor3 = autoSellState and Color3.fromRGB(60, 200, 120) or Color3.fromRGB(30, 60, 120)
end)

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

-- Toggle restyling helper
local function styleToggle(toggleBtn, state)
    toggleBtn.BackgroundColor3 = state and Color3.fromRGB(40, 90, 180) or Color3.fromRGB(60, 90, 130)
    toggleBtn.TextColor3 = Color3.fromRGB(255,255,255)
    toggleBtn.TextXAlignment = Enum.TextXAlignment.Left
    if not toggleBtn:FindFirstChild("Checkmark") then
        local check = Instance.new("TextLabel")
        check.Name = "Checkmark"
        check.Size = UDim2.new(0, 32, 1, 0)
        check.Position = UDim2.new(1, -36, 0, 0)
        check.BackgroundTransparency = 1
        check.Font = Enum.Font.SourceSansBold
        check.TextSize = 28
        check.TextColor3 = Color3.fromRGB(220, 220, 220)
        check.Text = "✔"
        check.Visible = state
        check.Parent = toggleBtn
    else
        toggleBtn.Checkmark.Visible = state
    end
end

-- Apply to all toggles
styleToggle(autoSubmitToggle, autoSubmitState)
autoSubmitToggle.MouseButton1Click:Connect(function()
    autoSubmitState = not autoSubmitState
    autoSubmitToggle.Text = "AUTO SUBMIT:"
    styleToggle(autoSubmitToggle, autoSubmitState)
end)

styleToggle(autoBuyEggToggle, autoBuyEggState)
autoBuyEggToggle.MouseButton1Click:Connect(function()
    autoBuyEggState = not autoBuyEggState
    autoBuyEggToggle.Text = "AUTO BUY EGG"
    styleToggle(autoBuyEggToggle, autoBuyEggState)
end)

styleToggle(autoBuySeedToggle, autoBuySeedState)
autoBuySeedToggle.MouseButton1Click:Connect(function()
    autoBuySeedState = not autoBuySeedState
    autoBuySeedToggle.Text = "AUTO BUY SEED"
    styleToggle(autoBuySeedToggle, autoBuySeedState)
end)

styleToggle(autoFarmToggle, autoFarmState)
autoFarmToggle.MouseButton1Click:Connect(function()
    autoFarmState = not autoFarmState
    autoFarmToggle.Text = "AUTO FARM"
    styleToggle(autoFarmToggle, autoFarmState)
end)

styleToggle(autoHarvestToggle, autoHarvestState)
autoHarvestToggle.MouseButton1Click:Connect(function()
    autoHarvestState = not autoHarvestState
    autoHarvestToggle.Text = "AUTO HARVEST"
    styleToggle(autoHarvestToggle, autoHarvestState)
end)

styleToggle(autoSellToggle, autoSellState)
autoSellToggle.MouseButton1Click:Connect(function()
    autoSellState = not autoSellState
    autoSellToggle.Text = "AUTO SELL"
    styleToggle(autoSellToggle, autoSellState)
end)

