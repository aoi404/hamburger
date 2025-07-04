
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
sidebar.Size = UDim2.new(0, 520, 0, 480) -- Increased width and height
sidebar.Position = UDim2.new(0.5, -260, 0.5, -240)
sidebar.BackgroundColor3 = Color3.fromRGB(120, 130, 150)
sidebar.BorderSizePixel = 0
sidebar.Parent = screenGui
sidebar.Visible = true

-- Top Bar
local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 44) -- Increased height
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
    tabBtn.Size = UDim2.new(0, 120, 0, 54) -- Increased width and height
    tabBtn.Position = UDim2.new(0, 0, 0, 44 + (i-1)*54)
    tabBtn.BackgroundColor3 = i == 1 and Color3.fromRGB(220, 160, 80) or Color3.fromRGB(80, 90, 110)
    tabBtn.Text = name
    tabBtn.Font = Enum.Font.SourceSansBold
    tabBtn.TextSize = 24
    tabBtn.TextColor3 = Color3.fromRGB(40, 40, 40)
    tabBtn.BorderSizePixel = 0
    tabBtn.Parent = sidebar
    tabButtons[name] = tabBtn
end

-- Vertical Black Line
local navLine = Instance.new("Frame")
navLine.Size = UDim2.new(0, 4, 1, -44)
navLine.Position = UDim2.new(0, 120, 0, 44)
navLine.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
navLine.BorderSizePixel = 0
navLine.Parent = sidebar

-- Main Content Frame
local contentFrame = Instance.new("Frame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(1, -124, 1, -44)
contentFrame.Position = UDim2.new(0, 124, 0, 44)
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
local autoBuyEggLoopRunning = false
local function updateAutoBuyEggToggle()
    if autoBuyEggState then
        autoBuyEggToggle.BackgroundColor3 = Color3.fromRGB(40, 90, 180)
        eggCheck.Text = "✅"
    else
        autoBuyEggToggle.BackgroundColor3 = Color3.fromRGB(60, 90, 130)
        eggCheck.Text = ""
    end
end
updateAutoBuyEggToggle()

-- Only one connection for auto-buy egg toggle, fully automatic
autoBuyEggToggle.MouseButton1Click:Connect(function()
    autoBuyEggState = not autoBuyEggState
    updateAutoBuyEggToggle()
    if autoBuyEggState and not autoBuyEggLoopRunning then
        autoBuyEggLoopRunning = true
        task.spawn(function()
            while autoBuyEggState do
                for _, egg in ipairs(selectedEggs) do
                    if isEggInStock(egg) then
                        if buyEggRemote then
                            buyEggRemote:FireServer(egg)
                        end
                    end
                end
                task.wait(0.1)
            end
            autoBuyEggLoopRunning = false
        end)
    end
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
local autoBuySeedLoopRunning = false
local function updateAutoBuySeedToggle()
    if autoBuySeedState then
        autoBuySeedToggle.BackgroundColor3 = Color3.fromRGB(40, 90, 180)
        seedCheck.Text = "✅"
    else
        autoBuySeedToggle.BackgroundColor3 = Color3.fromRGB(60, 90, 130)
        seedCheck.Text = ""
    end
end
updateAutoBuySeedToggle()

-- Only one connection for auto-buy seed toggle, fully automatic
autoBuySeedToggle.MouseButton1Click:Connect(function()
    autoBuySeedState = not autoBuySeedState
    updateAutoBuySeedToggle()
    if autoBuySeedState and not autoBuySeedLoopRunning then
        autoBuySeedLoopRunning = true
        task.spawn(function()
            while autoBuySeedState do
                for _, seed in ipairs(selectedSeeds) do
                    if isSeedInStock(seed) then
                        if buySeedRemote then
                            buySeedRemote:FireServer(seed)
                        end
                    end
                end
                task.wait(0.1)
            end
            autoBuySeedLoopRunning = false
        end)
    end
end)

-- === GEAR DROPDOWN & AUTO BUY ===
-- Gear Dropdown Button
local gearDropdownBtn = Instance.new("TextButton")
gearDropdownBtn.Name = "GearDropdownBtn"
gearDropdownBtn.Size = UDim2.new(1, -40, 0, 44)
gearDropdownBtn.Position = UDim2.new(0, 20, 0, 74 + (#eggOptions > 0 and (#eggOptions * 38) or 0) + 54 + (#seedOptions > 0 and (#seedOptions * 38) or 0))
gearDropdownBtn.BackgroundColor3 = Color3.fromRGB(40, 90, 180)
gearDropdownBtn.Text = "BUY GEAR:"
gearDropdownBtn.Font = Enum.Font.SourceSansBold
gearDropdownBtn.TextSize = 22
gearDropdownBtn.TextColor3 = Color3.fromRGB(255,255,255)
gearDropdownBtn.BorderSizePixel = 0
gearDropdownBtn.TextXAlignment = Enum.TextXAlignment.Center
gearDropdownBtn.Parent = shopFrame
gearDropdownBtn.ZIndex = 2

-- Gear Dropdown ScrollingFrame
local gearDropdownList = Instance.new("ScrollingFrame")
gearDropdownList.Name = "GearDropdownList"
gearDropdownList.Size = UDim2.new(1, -40, 0, 0)
gearDropdownList.Position = UDim2.new(0, 20, 0, 118 + (#eggOptions > 0 and (#eggOptions * 38) or 0) + 54 + (#seedOptions > 0 and (#seedOptions * 38) or 0))
gearDropdownList.BackgroundColor3 = Color3.fromRGB(60, 120, 180)
gearDropdownList.BorderSizePixel = 0
gearDropdownList.Visible = false
gearDropdownList.Parent = shopFrame
gearDropdownList.ZIndex = 3
gearDropdownList.ClipsDescendants = true
gearDropdownList.CanvasSize = UDim2.new(0, 0, 0, 0)
gearDropdownList.ScrollBarThickness = 10

-- Gear List (example, update as needed)
local gearOptions = {
    "Watering Can",
    "Hoe",
    "Sprinkler",
    "Fertilizer",
    "Shovel",
    "Trowel",
    "Scarecrow",
    "Bee Smoker",
    "Composter",
    "Greenhouse",
    "Tractor",
    "Drone"
}
local gearDetails = {
    ["Watering Can"] = "Basic watering tool.",
    ["Hoe"] = "Prepare soil for planting.",
    ["Sprinkler"] = "Waters crops automatically.",
    ["Fertilizer"] = "Boosts crop growth.",
    ["Shovel"] = "Dig up crops.",
    ["Trowel"] = "Small digging tool.",
    ["Scarecrow"] = "Keeps pests away.",
    ["Bee Smoker"] = "Calms bees.",
    ["Composter"] = "Turns waste into fertilizer.",
    ["Greenhouse"] = "Protects crops.",
    ["Tractor"] = "Automates farming.",
    ["Drone"] = "High-tech helper."
}
local selectedGears = {}
local function updateGearDropdownText()
    if #selectedGears == 0 then
        gearDropdownBtn.Text = "BUY GEAR:"
    else
        gearDropdownBtn.Text = "BUY GEAR: " .. table.concat(selectedGears, ", ")
    end
end
for i, name in ipairs(gearOptions) do
    local opt = Instance.new("TextButton")
    opt.Size = UDim2.new(1, 0, 0, 38)
    opt.Position = UDim2.new(0, 0, 0, (i-1)*38)
    opt.BackgroundColor3 = Color3.fromRGB(100, 170, 220)
    opt.Text = name
    opt.Font = Enum.Font.SourceSans
    opt.TextSize = 20
    opt.TextColor3 = Color3.fromRGB(255,255,255)
    opt.BorderSizePixel = 0
    opt.Parent = gearDropdownList
    opt.ZIndex = 4
    -- Tooltip for details
    opt.MouseEnter:Connect(function()
        opt.Text = name .. "\n" .. (gearDetails[name] or "")
        opt.TextWrapped = true
    end)
    opt.MouseLeave:Connect(function()
        opt.Text = name
        opt.TextWrapped = false
    end)
    opt.MouseButton1Click:Connect(function()
        local found = false
        for j, v in ipairs(selectedGears) do
            if v == name then table.remove(selectedGears, j) found = true break end
        end
        if not found then table.insert(selectedGears, name) end
        updateGearDropdownText()
        opt.BackgroundColor3 = found and Color3.fromRGB(100, 170, 220) or Color3.fromRGB(60, 200, 120)
    end)
end
updateGearDropdownText()
gearDropdownList.CanvasSize = UDim2.new(0, 0, 0, #gearOptions * 38)

-- Gear Toggle
local autoBuyGearToggle = Instance.new("TextButton")
autoBuyGearToggle.Name = "AutoBuyGearToggle"
autoBuyGearToggle.Size = UDim2.new(1, -32, 0, 36)
autoBuyGearToggle.BackgroundColor3 = Color3.fromRGB(60, 90, 130)
autoBuyGearToggle.Text = "AUTO BUY GEAR"
autoBuyGearToggle.Font = Enum.Font.SourceSansBold
autoBuyGearToggle.TextSize = 20
autoBuyGearToggle.TextColor3 = Color3.fromRGB(255,255,255)
autoBuyGearToggle.BorderSizePixel = 0
autoBuyGearToggle.TextXAlignment = Enum.TextXAlignment.Left
autoBuyGearToggle.Parent = shopFrame

local gearCheck = Instance.new("TextLabel")
gearCheck.Name = "Checkmark"
gearCheck.Size = UDim2.new(0, 32, 1, 0)
gearCheck.Position = UDim2.new(1, -36, 0, 0)
gearCheck.BackgroundTransparency = 1
gearCheck.Font = Enum.Font.SourceSansBold
gearCheck.TextSize = 24
gearCheck.TextColor3 = Color3.fromRGB(220, 220, 220)
gearCheck.Text = ""
gearCheck.Parent = autoBuyGearToggle

local autoBuyGearState = false
local autoBuyGearLoopRunning = false
local function updateAutoBuyGearToggle()
    if autoBuyGearState then
        autoBuyGearToggle.BackgroundColor3 = Color3.fromRGB(40, 90, 180)
        gearCheck.Text = "✅"
    else
        autoBuyGearToggle.BackgroundColor3 = Color3.fromRGB(60, 90, 130)
        gearCheck.Text = ""
    end
end
updateAutoBuyGearToggle()

-- Only one connection for auto-buy gear toggle, fully automatic
autoBuyGearToggle.MouseButton1Click:Connect(function()
    autoBuyGearState = not autoBuyGearState
    updateAutoBuyGearToggle()
    if autoBuyGearState and not autoBuyGearLoopRunning then
        autoBuyGearLoopRunning = true
        task.spawn(function()
            while autoBuyGearState do
                for _, gear in ipairs(selectedGears) do
                    print("[GAG DEBUG] Attempting to buy gear:", gear, "Type:", typeof(gear))
                    print("[GAG DEBUG] buyGearRemote exists:", buyGearRemote ~= nil)
                    print("[GAG DEBUG] Player money:", player.leaderstats and player.leaderstats.Cash and player.leaderstats.Cash.Value or "N/A")
                    local success, err = pcall(function()
                        if buyGearRemote then
                            buyGearRemote:FireServer(gear)
                        end
                    end)
                    if not success then
                        warn("[GAG DEBUG] Error firing BuyGearStock:", err)
                    else
                        print("[GAG DEBUG] Fired BuyGearStock with:", gear)
                    end
                end
                task.wait(0.1)
            end
            autoBuyGearLoopRunning = false
        end)
    end
end)

-- Show/hide logic for gear dropdown
gearDropdownBtn.MouseButton1Click:Connect(function()
    gearDropdownList.Visible = not gearDropdownList.Visible
    updateShopTogglePositions()
end)

-- Update toggle positions to include gear
local oldUpdateShopTogglePositions = updateShopTogglePositions
function updateShopTogglePositions()
    oldUpdateShopTogglePositions()
    -- Place gear dropdown and toggle below seed
    local y = seedDropdownBtn.Position.Y.Offset + seedDropdownBtn.Size.Y.Offset
    if seedDropdownList.Visible then
        y = y + seedDropdownList.Size.Y.Offset
    end
    gearDropdownBtn.Position = UDim2.new(0, 20, 0, y)
    y = y + 44
    if gearDropdownList.Visible then
        gearDropdownList.Position = UDim2.new(0, 20, 0, y)
        gearDropdownList.Size = UDim2.new(1, -40, 0, #gearOptions * 38)
        y = y + #gearOptions * 38
    else
        gearDropdownList.Position = UDim2.new(0, 20, 0, y)
        gearDropdownList.Size = UDim2.new(1, -40, 0, 0)
    end
    autoBuyEggToggle.Position = UDim2.new(0, 20, 0, y + 18)
    autoBuySeedToggle.Position = UDim2.new(0, 20, 0, y + 18 + 54)
    autoBuyGearToggle.Position = UDim2.new(0, 20, 0, y + 18 + 108)
end

-- Automation Remote for Gear
local buyGearRemote = ReplicatedStorage:FindFirstChild("GameEvents"):FindFirstChild("BuyGearStock")

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
        if gearDropdownList.Visible and not gearDropdownBtn:IsAncestorOf(input.Target) then
            gearDropdownList.Visible = false
            changed = true
        end
        if changed then updateShopTogglePositions() end
    end
end)

-- Automation Remotes
local buyEggRemote = ReplicatedStorage:FindFirstChild("GameEvents"):FindFirstChild("BuyPetEgg")
local buySeedRemote = ReplicatedStorage:FindFirstChild("GameEvents"):FindFirstChild("BuySeedStock")

-- Helper: Check if an egg/seed is in stock (stub, should be replaced with real stock check if available)
local function isEggInStock(eggName)
    -- TODO: Replace with real stock check if possible
    return true -- Assume always in stock for now
end
local function isSeedInStock(seedName)
    -- TODO: Replace with real stock check if possible
    return true -- Assume always in stock for now
end

-- Auto-buy logic
local autoBuyEggLoopRunning = false
local autoBuySeedLoopRunning = false

-- Start auto-buy egg loop on script load
if not autoBuyEggLoopRunning then
    autoBuyEggLoopRunning = true
    task.spawn(function()
        while true do
            if autoBuyEggState then
                for _, egg in ipairs(selectedEggs) do
                    if isEggInStock(egg) then
                        if buyEggRemote then
                            buyEggRemote:FireServer(egg)
                        end
                    end
                end
            end
            task.wait(0.1)
        end
    end)
end

-- Start auto-buy seed loop on script load
if not autoBuySeedLoopRunning then
    autoBuySeedLoopRunning = true
    task.spawn(function()
        while true do
            if autoBuySeedState then
                for _, seed in ipairs(selectedSeeds) do
                    if isSeedInStock(seed) then
                        if buySeedRemote then
                            buySeedRemote:FireServer(seed)
                        end
                    end
                end
            end
            task.wait(0.1)
        end
    end)
end

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
