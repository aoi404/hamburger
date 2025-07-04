--[[
GAG SCRIPT BY:BREAD
Modern Sidebar GUI (Restarted)
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
sidebar.Size = UDim2.new(0, 400, 0, 270)
sidebar.Position = UDim2.new(0.5, -200, 0.5, -135)
sidebar.BackgroundColor3 = Color3.fromRGB(120, 130, 150)
sidebar.BorderSizePixel = 0
sidebar.Parent = screenGui
sidebar.Visible = true

-- Top Bar
local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 36)
topBar.Position = UDim2.new(0, 0, 0, 0)
topBar.BackgroundColor3 = Color3.fromRGB(80, 90, 110)
topBar.BorderSizePixel = 0
topBar.Parent = sidebar

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

local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Name = "MinimizeBtn"
minimizeBtn.Size = UDim2.new(0, 32, 1, 0)
minimizeBtn.Position = UDim2.new(1, -64, 0, 0)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(80, 90, 110)
minimizeBtn.Text = "_"
minimizeBtn.Font = Enum.Font.SourceSansBold
minimizeBtn.TextSize = 22
minimizeBtn.TextColor3 = Color3.fromRGB(0,0,0)
minimizeBtn.Parent = topBar

local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseBtn"
closeBtn.Size = UDim2.new(0, 32, 1, 0)
closeBtn.Position = UDim2.new(1, -32, 0, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(120, 40, 40)
closeBtn.Text = "✕"
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.TextSize = 22
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeBtn.Parent = topBar

-- Sidebar Tabs
local tabNames = {"EVENT", "SHOP", "FARM"}
local tabButtons = {}
for i, name in ipairs(tabNames) do
    local tabBtn = Instance.new("TextButton")
    tabBtn.Name = name .. "TabBtn"
    tabBtn.Size = UDim2.new(0, 100, 0, 40)
    tabBtn.Position = UDim2.new(0, 0, 0, 36 + (i-1)*40)
    tabBtn.BackgroundColor3 = i == 1 and Color3.fromRGB(220, 160, 80) or Color3.fromRGB(80, 90, 110)
    tabBtn.Text = name
    tabBtn.Font = Enum.Font.SourceSansBold
    tabBtn.TextSize = 20
    tabBtn.TextColor3 = Color3.fromRGB(40, 40, 40)
    tabBtn.BorderSizePixel = 0
    tabBtn.Parent = sidebar
    tabButtons[name] = tabBtn
end

-- Vertical Black Line
local navLine = Instance.new("Frame")
navLine.Size = UDim2.new(0, 4, 1, -36)
navLine.Position = UDim2.new(0, 100, 0, 36)
navLine.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
navLine.BorderSizePixel = 0
navLine.Parent = sidebar

-- Main Content Frame
local contentFrame = Instance.new("Frame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(1, -104, 1, -36)
contentFrame.Position = UDim2.new(0, 104, 0, 36)
contentFrame.BackgroundColor3 = Color3.fromRGB(120, 130, 150)
contentFrame.BorderSizePixel = 0
contentFrame.Parent = sidebar

-- Tab Content
local tabContent = {}
for _, name in ipairs(tabNames) do
    local frame = Instance.new("Frame")
    frame.Name = name .. "TabContent"
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 1
    frame.Visible = (name == "EVENT")
    frame.Parent = contentFrame
    tabContent[name] = frame
end

-- EVENT TAB CONTENT
local eventFrame = tabContent["EVENT"]
local eventHeader = Instance.new("TextLabel")
eventHeader.Size = UDim2.new(1, -32, 0, 40)
eventHeader.Position = UDim2.new(0, 16, 0, 16)
eventHeader.BackgroundColor3 = Color3.fromRGB(40, 90, 180)
eventHeader.Text = "SUMMER HARVEST"
eventHeader.Font = Enum.Font.SourceSansBold
eventHeader.TextSize = 22
eventHeader.TextColor3 = Color3.fromRGB(255,255,255)
eventHeader.BorderSizePixel = 0
eventHeader.TextXAlignment = Enum.TextXAlignment.Center
eventHeader.Parent = eventFrame

local autoSubmitToggle = Instance.new("TextButton")
autoSubmitToggle.Name = "AutoSubmitToggle"
autoSubmitToggle.Size = UDim2.new(1, -32, 0, 36)
autoSubmitToggle.Position = UDim2.new(0, 16, 0, 64)
autoSubmitToggle.BackgroundColor3 = Color3.fromRGB(60, 90, 130)
autoSubmitToggle.Text = "AUTO SUBMIT:"
autoSubmitToggle.Font = Enum.Font.SourceSansBold
autoSubmitToggle.TextSize = 20
autoSubmitToggle.TextColor3 = Color3.fromRGB(255,255,255)
autoSubmitToggle.BorderSizePixel = 0
autoSubmitToggle.TextXAlignment = Enum.TextXAlignment.Left
autoSubmitToggle.Parent = eventFrame

local check = Instance.new("TextLabel")
check.Name = "Checkmark"
check.Size = UDim2.new(0, 32, 1, 0)
check.Position = UDim2.new(1, -36, 0, 0)
check.BackgroundTransparency = 1
check.Font = Enum.Font.SourceSansBold
check.TextSize = 24
check.TextColor3 = Color3.fromRGB(220, 220, 220)
check.Text = ""
check.Parent = autoSubmitToggle

local autoSubmitState = false
local function updateAutoSubmitToggle()
    autoSubmitToggle.BackgroundColor3 = autoSubmitState and Color3.fromRGB(40, 90, 180) or Color3.fromRGB(60, 90, 130)
    check.Text = autoSubmitState and "✔" or ""
end
updateAutoSubmitToggle()
autoSubmitToggle.MouseButton1Click:Connect(function()
    autoSubmitState = not autoSubmitState
    updateAutoSubmitToggle()
end)

-- SHOP TAB CONTENT
local shopFrame = tabContent["SHOP"]

-- Toggles (create these first so updateShopToggle can reference them)
local autoBuyEggToggle = Instance.new("TextButton")
autoBuyEggToggle.Name = "AutoBuyEggToggle"
autoBuyEggToggle.Size = UDim2.new(1, -32, 0, 36)
autoBuyEggToggle.BackgroundColor3 = Color3.fromRGB(60, 90, 130)
autoBuyEggToggle.Text = "AUTO BUY EGG"
autoBuyEggToggle.Font = Enum.Font.SourceSansBold
autoBuyEggToggle.TextSize = 20
autoBuyEggToggle.TextColor3 = Color3.fromRGB(255,255,255)
autoBuyEggToggle.BorderSizePixel = 0
autoBuyEggToggle.TextXAlignment = Enum.TextXAlignment.Left
autoBuyEggToggle.Parent = shopFrame

local eggCheck = Instance.new("TextLabel")
eggCheck.Name = "Checkmark"
eggCheck.Size = UDim2.new(0, 32, 1, 0)
eggCheck.Position = UDim2.new(1, -36, 0, 0)
eggCheck.BackgroundTransparency = 1
eggCheck.Font = Enum.Font.SourceSansBold
eggCheck.TextSize = 24
eggCheck.TextColor3 = Color3.fromRGB(220, 220, 220)
eggCheck.Text = ""
eggCheck.Parent = autoBuyEggToggle

local autoBuyEggState = false
local function updateAutoBuyEggToggle()
    autoBuyEggToggle.BackgroundColor3 = autoBuyEggState and Color3.fromRGB(40, 90, 180) or Color3.fromRGB(60, 90, 130)
    eggCheck.Text = autoBuyEggState and "✔" or ""
end
updateAutoBuyEggToggle()
autoBuyEggToggle.MouseButton1Click:Connect(function()
    autoBuyEggState = not autoBuyEggState
    updateAutoBuyEggToggle()
end)

local autoBuySeedToggle = Instance.new("TextButton")
autoBuySeedToggle.Name = "AutoBuySeedToggle"
autoBuySeedToggle.Size = UDim2.new(1, -32, 0, 36)
autoBuySeedToggle.BackgroundColor3 = Color3.fromRGB(60, 90, 130)
autoBuySeedToggle.Text = "AUTO BUY SEED"
autoBuySeedToggle.Font = Enum.Font.SourceSansBold
autoBuySeedToggle.TextSize = 20
autoBuySeedToggle.TextColor3 = Color3.fromRGB(255,255,255)
autoBuySeedToggle.BorderSizePixel = 0
autoBuySeedToggle.TextXAlignment = Enum.TextXAlignment.Left
autoBuySeedToggle.Parent = shopFrame

local seedCheck = Instance.new("TextLabel")
seedCheck.Name = "Checkmark"
seedCheck.Size = UDim2.new(0, 32, 1, 0)
seedCheck.Position = UDim2.new(1, -36, 0, 0)
seedCheck.BackgroundTransparency = 1
seedCheck.Font = Enum.Font.SourceSansBold
seedCheck.TextSize = 24
seedCheck.TextColor3 = Color3.fromRGB(220, 220, 220)
seedCheck.Text = ""
seedCheck.Parent = autoBuySeedToggle

local autoBuySeedState = false
local function updateAutoBuySeedToggle()
    autoBuySeedToggle.BackgroundColor3 = autoBuySeedState and Color3.fromRGB(40, 90, 180) or Color3.fromRGB(60, 90, 130)
    seedCheck.Text = autoBuySeedState and "✔" or ""
end
updateAutoBuySeedToggle()
autoBuySeedToggle.MouseButton1Click:Connect(function()
    autoBuySeedState = not autoBuySeedState
    updateAutoBuySeedToggle()
end)

-- Egg Dropdown Button
local eggDropdownBtn = Instance.new("TextButton")
eggDropdownBtn.Name = "EggDropdownBtn"
eggDropdownBtn.Size = UDim2.new(1, -32, 0, 36)
eggDropdownBtn.Position = UDim2.new(0, 16, 0, 16)
eggDropdownBtn.BackgroundColor3 = Color3.fromRGB(40, 90, 180)
eggDropdownBtn.Text = "BUY EGG:"
eggDropdownBtn.Font = Enum.Font.SourceSansBold
eggDropdownBtn.TextSize = 20
eggDropdownBtn.TextColor3 = Color3.fromRGB(255,255,255)
eggDropdownBtn.BorderSizePixel = 0
eggDropdownBtn.TextXAlignment = Enum.TextXAlignment.Center
eggDropdownBtn.Parent = shopFrame

local eggDropdownList = Instance.new("Frame")
eggDropdownList.Name = "EggDropdownList"
eggDropdownList.Size = UDim2.new(1, -32, 0, 0)
eggDropdownList.Position = UDim2.new(0, 16, 0, 52)
eggDropdownList.BackgroundColor3 = Color3.fromRGB(60, 120, 180)
eggDropdownList.BorderSizePixel = 0
eggDropdownList.Visible = false
eggDropdownList.Parent = shopFrame

local eggOptions = {"Egg A", "Egg B", "Egg C"}
local selectedEggs = {}
local function updateEggDropdownText()
    if #selectedEggs == 0 then
        eggDropdownBtn.Text = "BUY EGG:"
    else
        eggDropdownBtn.Text = "BUY EGG: " .. table.concat(selectedEggs, ", ")
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
    updateShopTogglePositions()
end)

-- Seed Dropdown Button
local seedDropdownBtn = Instance.new("TextButton")
seedDropdownBtn.Name = "SeedDropdownBtn"
seedDropdownBtn.Size = UDim2.new(1, -32, 0, 36)
seedDropdownBtn.Position = UDim2.new(0, 16, 0, 60)
seedDropdownBtn.BackgroundColor3 = Color3.fromRGB(40, 90, 180)
seedDropdownBtn.Text = "BUY SEEDS:"
seedDropdownBtn.Font = Enum.Font.SourceSansBold
seedDropdownBtn.TextSize = 20
seedDropdownBtn.TextColor3 = Color3.fromRGB(255,255,255)
seedDropdownBtn.BorderSizePixel = 0
seedDropdownBtn.TextXAlignment = Enum.TextXAlignment.Center
seedDropdownBtn.Parent = shopFrame

local seedDropdownList = Instance.new("Frame")
seedDropdownList.Name = "SeedDropdownList"
seedDropdownList.Size = UDim2.new(1, -32, 0, 0)
seedDropdownList.Position = UDim2.new(0, 16, 0, 96)
seedDropdownList.BackgroundColor3 = Color3.fromRGB(60, 120, 180)
seedDropdownList.BorderSizePixel = 0
seedDropdownList.Visible = false
seedDropdownList.Parent = shopFrame

local seedOptions = {"Seed X", "Seed Y", "Seed Z"}
local selectedSeeds = {}
local function updateSeedDropdownText()
    if #selectedSeeds == 0 then
        seedDropdownBtn.Text = "BUY SEEDS:"
    else
        seedDropdownBtn.Text = "BUY SEEDS: " .. table.concat(selectedSeeds, ", ")
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
    updateShopTogglePositions()
end)

-- Helper to update toggle positions based on dropdowns
function updateShopTogglePositions()
    local y = 16
    -- Egg Dropdown Button
    eggDropdownBtn.Position = UDim2.new(0, 16, 0, y)
    y = y + 36
    -- Egg Dropdown List
    if eggDropdownList.Visible then
        eggDropdownList.Position = UDim2.new(0, 16, 0, y)
        eggDropdownList.Size = UDim2.new(1, -32, 0, #eggOptions * 32)
        y = y + #eggOptions * 32
    else
        eggDropdownList.Position = UDim2.new(0, 16, 0, y)
        eggDropdownList.Size = UDim2.new(1, -32, 0, 0)
    end
    -- Seed Dropdown Button
    seedDropdownBtn.Position = UDim2.new(0, 16, 0, y)
    y = y + 36
    -- Seed Dropdown List
    if seedDropdownList.Visible then
        seedDropdownList.Position = UDim2.new(0, 16, 0, y)
        seedDropdownList.Size = UDim2.new(1, -32, 0, #seedOptions * 32)
        y = y + #seedOptions * 32
    else
        seedDropdownList.Position = UDim2.new(0, 16, 0, y)
        seedDropdownList.Size = UDim2.new(1, -32, 0, 0)
    end
    -- Toggles
    autoBuyEggToggle.Position = UDim2.new(0, 16, 0, y + 12)
    autoBuySeedToggle.Position = UDim2.new(0, 16, 0, y + 12 + 44)
end

eggDropdownBtn.MouseButton1Click:Connect(function()
    eggDropdownList.Visible = not eggDropdownList.Visible
    updateShopTogglePositions()
end)

seedDropdownBtn.MouseButton1Click:Connect(function()
    seedDropdownList.Visible = not seedDropdownList.Visible
    updateShopTogglePositions()
end)

-- Hide dropdowns if clicking elsewhere
UserInputService.InputBegan:Connect(function(input, processed)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local changed = false
        if eggDropdownList.Visible and not eggDropdownBtn:IsAncestorOf(input.Target) then
            eggDropdownList.Visible = false
            changed = true
        end
        if seedDropdownList.Visible and not seedDropdownBtn:IsAncestorOf(input.Target) then
            seedDropdownList.Visible = false
            changed = true
        end
        if changed then updateShopTogglePositions() end
    end
end)

-- Tab Switching Logic
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

-- Hide/Show Logic
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
