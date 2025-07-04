-- Modernized Grow a Garden GUI Automation Script with improved UI, correct egg/seed lists, and robust auto-harvest

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local GameEvents = ReplicatedStorage:WaitForChild("GameEvents")
local Workspace = game:GetService("Workspace")

-- Remove old UI if exists
if Player.PlayerGui:FindFirstChild("GrowGardenUI") then
    Player.PlayerGui.GrowGardenUI:Destroy()
end

-- Variables for automation toggles
local autoFarm, autoHarvest, autoSell = false, false, false
local autoBuyEgg, autoBuySeed = false, false
local autoSubmit = false
local selectedEggs, selectedSeeds = {}, {}

-- Egg and Seed lists
local eggList = {
    "Common Egg", "Uncommon Egg", "Rare Egg", "Legendary Egg", "Mythical Egg", "Bug Egg", "Exotic Bug Egg", "Night Egg", "Premium Night Egg", "Bee Egg", "Anti Bee Egg", "Premium Anti Bee Egg", "Common Summer Egg", "Rare Summer Egg", "Paradise Egg", "Oasis Egg", "Premium Oasis Egg", "Raphael Egg 1", "Raphael Egg 2", "Raphael Egg 3"
}
local seedList = {
    "Carrot", "Strawberry", "Blueberry", "Tomato", "Cauliflower", "Watermelon", "Rafflesia", "Green Apple", "Avocado", "Banana", "Pineapple", "Kiwi", "Bell Pepper", "Prickly Pear", "Loquat", "Feijoa", "Pitcher Plant", "Sugar Apple"
}

-- Create main UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GrowGardenUI"
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 500, 0, 340)
Frame.Position = UDim2.new(0.5, -250, 0.5, -170)
Frame.BackgroundColor3 = Color3.fromRGB(120, 135, 150)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = Frame

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 38)
TitleBar.BackgroundColor3 = Color3.fromRGB(40, 50, 60)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = Frame

local Title = Instance.new("TextLabel")
Title.Text = "GAG SCRIPT BY:BREAD"
Title.Size = UDim2.new(1, -80, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(0,0,0)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 26
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

-- Minimize Button
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 32, 0, 32)
MinBtn.Position = UDim2.new(1, -72, 0, 3)
MinBtn.Text = "-"
MinBtn.BackgroundColor3 = Color3.fromRGB(40, 50, 60)
MinBtn.TextColor3 = Color3.fromRGB(0,0,0)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 24
MinBtn.Parent = TitleBar

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 32, 0, 32)
CloseBtn.Position = UDim2.new(1, -36, 0, 3)
CloseBtn.Text = "✕"
CloseBtn.BackgroundColor3 = Color3.fromRGB(40, 50, 60)
CloseBtn.TextColor3 = Color3.fromRGB(0,0,0)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 22
CloseBtn.Parent = TitleBar

-- Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 70, 1, -38)
Sidebar.Position = UDim2.new(0, 0, 0, 38)
Sidebar.BackgroundColor3 = Color3.fromRGB(100, 110, 120)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Frame

local SideLine = Instance.new("Frame")
SideLine.Size = UDim2.new(0, 6, 1, 0)
SideLine.Position = UDim2.new(0, 64, 0, 0)
SideLine.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
SideLine.BorderSizePixel = 0
SideLine.Parent = Sidebar

local EventBtn = Instance.new("TextButton")
EventBtn.Size = UDim2.new(1, -10, 0, 36)
EventBtn.Position = UDim2.new(0, 5, 0, 10)
EventBtn.Text = "EVENT"
EventBtn.BackgroundColor3 = Color3.fromRGB(200, 160, 120)
EventBtn.TextColor3 = Color3.fromRGB(0,0,0)
EventBtn.Font = Enum.Font.GothamBold
EventBtn.TextSize = 16
EventBtn.Parent = Sidebar

local ShopBtn = Instance.new("TextButton")
ShopBtn.Size = UDim2.new(1, -10, 0, 36)
ShopBtn.Position = UDim2.new(0, 5, 0, 56)
ShopBtn.Text = "SHOP"
ShopBtn.BackgroundColor3 = Color3.fromRGB(120, 135, 150)
ShopBtn.TextColor3 = Color3.fromRGB(0,0,0)
ShopBtn.Font = Enum.Font.GothamBold
ShopBtn.TextSize = 16
ShopBtn.Parent = Sidebar

local FarmBtn = Instance.new("TextButton")
FarmBtn.Size = UDim2.new(1, -10, 0, 36)
FarmBtn.Position = UDim2.new(0, 5, 0, 102)
FarmBtn.Text = "FARM"
FarmBtn.BackgroundColor3 = Color3.fromRGB(120, 135, 150)
FarmBtn.TextColor3 = Color3.fromRGB(0,0,0)
FarmBtn.Font = Enum.Font.GothamBold
FarmBtn.TextSize = 16
FarmBtn.Parent = Sidebar

-- Main Content Area
local MainPanel = Instance.new("Frame")
MainPanel.Size = UDim2.new(1, -80, 1, -48)
MainPanel.Position = UDim2.new(0, 80, 0, 48)
MainPanel.BackgroundTransparency = 1
MainPanel.Parent = Frame

-- EVENT TAB
local EventPanel = Instance.new("Frame")
EventPanel.Size = UDim2.new(1, 0, 1, 0)
EventPanel.BackgroundTransparency = 1
EventPanel.Visible = true
EventPanel.Parent = MainPanel

local SummerHeader = Instance.new("TextLabel")
SummerHeader.Size = UDim2.new(0.9, 0, 0, 36)
SummerHeader.Position = UDim2.new(0.05, 0, 0, 20)
SummerHeader.BackgroundColor3 = Color3.fromRGB(30, 60, 110)
SummerHeader.TextColor3 = Color3.fromRGB(255,255,255)
SummerHeader.Font = Enum.Font.GothamBold
SummerHeader.TextSize = 18
SummerHeader.Text = "SUMMER HARVEST"
SummerHeader.Parent = EventPanel

local AutoSubmitLabel = Instance.new("TextLabel")
AutoSubmitLabel.Size = UDim2.new(0.5, 0, 0, 32)
AutoSubmitLabel.Position = UDim2.new(0.05, 0, 0, 70)
AutoSubmitLabel.BackgroundTransparency = 1
AutoSubmitLabel.TextColor3 = Color3.fromRGB(0,0,0)
AutoSubmitLabel.Font = Enum.Font.GothamBold
AutoSubmitLabel.TextSize = 16
AutoSubmitLabel.Text = "AUTO SUBMIT:"
AutoSubmitLabel.TextXAlignment = Enum.TextXAlignment.Left
AutoSubmitLabel.Parent = EventPanel

local AutoSubmitToggle = Instance.new("TextButton")
AutoSubmitToggle.Size = UDim2.new(0, 32, 0, 32)
AutoSubmitToggle.Position = UDim2.new(0.55, 0, 0, 70)
AutoSubmitToggle.BackgroundColor3 = Color3.fromRGB(30, 60, 110)
AutoSubmitToggle.Text = ""
AutoSubmitToggle.Parent = EventPanel
local AutoSubmitCheck = Instance.new("ImageLabel")
AutoSubmitCheck.Size = UDim2.new(1, -6, 1, -6)
AutoSubmitCheck.Position = UDim2.new(0, 3, 0, 3)
AutoSubmitCheck.BackgroundTransparency = 1
AutoSubmitCheck.Image = "rbxassetid://6031094678" -- checkmark
AutoSubmitCheck.Visible = false
AutoSubmitCheck.Parent = AutoSubmitToggle

local autoSubmit = false
AutoSubmitToggle.MouseButton1Click:Connect(function()
    autoSubmit = not autoSubmit
    AutoSubmitCheck.Visible = autoSubmit
end)

-- SHOP TAB
local ShopPanel = Instance.new("Frame")
ShopPanel.Size = UDim2.new(1, 0, 1, 0)
ShopPanel.BackgroundTransparency = 1
ShopPanel.Visible = false
ShopPanel.Parent = MainPanel

local BuyEggHeader = Instance.new("TextLabel")
BuyEggHeader.Size = UDim2.new(0.9, 0, 0, 36)
BuyEggHeader.Position = UDim2.new(0.05, 0, 0, 20)
BuyEggHeader.BackgroundColor3 = Color3.fromRGB(30, 60, 110)
BuyEggHeader.TextColor3 = Color3.fromRGB(255,255,255)
BuyEggHeader.Font = Enum.Font.GothamBold
BuyEggHeader.TextSize = 18
BuyEggHeader.Text = "BUY EGG:"
BuyEggHeader.Parent = ShopPanel
BuyEggHeader.TextXAlignment = Enum.TextXAlignment.Left
BuyEggHeader.TextYAlignment = Enum.TextYAlignment.Center
BuyEggHeader.ClipsDescendants = true

local function updateEggHeader()
    local sel = {}
    for k in pairs(selectedEggs) do table.insert(sel, k) end
    if #sel == 0 then
        BuyEggHeader.Text = "BUY EGG:"
    elseif #sel == 1 then
        BuyEggHeader.Text = "BUY EGG: "..sel[1]
    else
        BuyEggHeader.Text = "BUY EGG: "..#sel.." selected"
    end
end
updateEggHeader()

local EggListFrame = Instance.new("Frame")
EggListFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 90)
EggListFrame.Visible = false
EggListFrame.Parent = ShopPanel
EggListFrame.ClipsDescendants = true
EggListFrame.Position = UDim2.new(0.05, 0, 0, 56)
EggListFrame.Size = UDim2.new(0, 220, 0, #eggList*28)

for i,egg in ipairs(eggList) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 28)
    btn.Position = UDim2.new(0, 0, 0, (i-1)*28)
    btn.BackgroundColor3 = Color3.fromRGB(100, 100, 140)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 16
    btn.Text = egg
    btn.Parent = EggListFrame
    local check = Instance.new("ImageLabel")
    check.Size = UDim2.new(0, 24, 0, 24)
    check.Position = UDim2.new(1, -28, 0, 2)
    check.BackgroundTransparency = 1
    check.Image = "rbxassetid://6031094678"
    check.Visible = false
    check.Parent = btn
    btn.MouseButton1Click:Connect(function()
        if selectedEggs[egg] then
            selectedEggs[egg] = nil
            check.Visible = false
        else
            selectedEggs[egg] = true
            check.Visible = true
        end
        updateEggHeader()
    end)
end
BuyEggHeader.MouseButton1Click:Connect(function()
    EggListFrame.Visible = not EggListFrame.Visible
end)

local AutoBuyEggToggle = Instance.new("TextButton")
AutoBuyEggToggle.Size = UDim2.new(0, 180, 0, 32)
AutoBuyEggToggle.Position = UDim2.new(0.05, 0, 0, 56 + #eggList*28 + 10)
AutoBuyEggToggle.BackgroundColor3 = Color3.fromRGB(30, 60, 110)
AutoBuyEggToggle.TextColor3 = Color3.fromRGB(255,255,255)
AutoBuyEggToggle.Font = Enum.Font.GothamBold
AutoBuyEggToggle.TextSize = 16
AutoBuyEggToggle.Text = "Auto Buy Egg: OFF"
AutoBuyEggToggle.Parent = ShopPanel
local EggCheck = Instance.new("ImageLabel")
EggCheck.Size = UDim2.new(0, 24, 0, 24)
EggCheck.Position = UDim2.new(1, -28, 0, 4)
EggCheck.BackgroundTransparency = 1
EggCheck.Image = "rbxassetid://6031094678"
EggCheck.Visible = false
EggCheck.Parent = AutoBuyEggToggle
AutoBuyEggToggle.MouseButton1Click:Connect(function()
    autoBuyEgg = not autoBuyEgg
    AutoBuyEggToggle.Text = autoBuyEgg and "Auto Buy Egg: ON" or "Auto Buy Egg: OFF"
    EggCheck.Visible = autoBuyEgg
end)

local BuySeedHeader = Instance.new("TextLabel")
BuySeedHeader.Size = UDim2.new(0.9, 0, 0, 36)
BuySeedHeader.Position = UDim2.new(0.05, 0, 0, 130)
BuySeedHeader.BackgroundColor3 = Color3.fromRGB(30, 60, 110)
BuySeedHeader.TextColor3 = Color3.fromRGB(255,255,255)
BuySeedHeader.Font = Enum.Font.GothamBold
BuySeedHeader.TextSize = 18
BuySeedHeader.Text = "BUY SEEDS:"
BuySeedHeader.Parent = ShopPanel
BuySeedHeader.TextXAlignment = Enum.TextXAlignment.Left
BuySeedHeader.TextYAlignment = Enum.TextYAlignment.Center
BuySeedHeader.ClipsDescendants = true

local function updateSeedHeader()
    local sel = {}
    for k in pairs(selectedSeeds) do table.insert(sel, k) end
    if #sel == 0 then
        BuySeedHeader.Text = "BUY SEEDS:"
    elseif #sel == 1 then
        BuySeedHeader.Text = "BUY SEEDS: "..sel[1]
    else
        BuySeedHeader.Text = "BUY SEEDS: "..#sel.." selected"
    end
end
updateSeedHeader()

local SeedListFrame = Instance.new("Frame")
SeedListFrame.BackgroundColor3 = Color3.fromRGB(60, 90, 60)
SeedListFrame.Visible = false
SeedListFrame.Parent = ShopPanel
SeedListFrame.ClipsDescendants = true
SeedListFrame.Position = UDim2.new(0.05, 0, 0, 130+36)
SeedListFrame.Size = UDim2.new(0, 220, 0, #seedList*28)

for i,seed in ipairs(seedList) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 28)
    btn.Position = UDim2.new(0, 0, 0, (i-1)*28)
    btn.BackgroundColor3 = Color3.fromRGB(100, 140, 100)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 16
    btn.Text = seed
    btn.Parent = SeedListFrame
    local check = Instance.new("ImageLabel")
    check.Size = UDim2.new(0, 24, 0, 24)
    check.Position = UDim2.new(1, -28, 0, 2)
    check.BackgroundTransparency = 1
    check.Image = "rbxassetid://6031094678"
    check.Visible = false
    check.Parent = btn
    btn.MouseButton1Click:Connect(function()
        if selectedSeeds[seed] then
            selectedSeeds[seed] = nil
            check.Visible = false
        else
            selectedSeeds[seed] = true
            check.Visible = true
        end
        updateSeedHeader()
    end)
end
BuySeedHeader.MouseButton1Click:Connect(function()
    SeedListFrame.Visible = not SeedListFrame.Visible
end)

local AutoBuySeedToggle = Instance.new("TextButton")
AutoBuySeedToggle.Size = UDim2.new(0, 180, 0, 32)
AutoBuySeedToggle.Position = UDim2.new(0.05, 0, 0, 130+36+#seedList*28+10)
AutoBuySeedToggle.BackgroundColor3 = Color3.fromRGB(30, 60, 110)
AutoBuySeedToggle.TextColor3 = Color3.fromRGB(255,255,255)
AutoBuySeedToggle.Font = Enum.Font.GothamBold
AutoBuySeedToggle.TextSize = 16
AutoBuySeedToggle.Text = "Auto Buy Seed: OFF"
AutoBuySeedToggle.Parent = ShopPanel
local SeedCheck = Instance.new("ImageLabel")
SeedCheck.Size = UDim2.new(0, 24, 0, 24)
SeedCheck.Position = UDim2.new(1, -28, 0, 4)
SeedCheck.BackgroundTransparency = 1
SeedCheck.Image = "rbxassetid://6031094678"
SeedCheck.Visible = false
SeedCheck.Parent = AutoBuySeedToggle
AutoBuySeedToggle.MouseButton1Click:Connect(function()
    autoBuySeed = not autoBuySeed
    AutoBuySeedToggle.Text = autoBuySeed and "Auto Buy Seed: ON" or "Auto Buy Seed: OFF"
    SeedCheck.Visible = autoBuySeed
end)

-- FARM TAB
local FarmPanel = Instance.new("Frame")
FarmPanel.Size = UDim2.new(1, 0, 1, 0)
FarmPanel.BackgroundTransparency = 1
FarmPanel.Visible = false
FarmPanel.Parent = MainPanel

local function makeFarmToggle(name, y)
    local Toggle = Instance.new("TextButton")
    Toggle.Size = UDim2.new(0.9, 0, 0, 36)
    Toggle.Position = UDim2.new(0.05, 0, 0, y)
    Toggle.BackgroundColor3 = Color3.fromRGB(30, 60, 110)
    Toggle.TextColor3 = Color3.fromRGB(255,255,255)
    Toggle.Font = Enum.Font.GothamBold
    Toggle.TextSize = 16
    Toggle.Text = name
    Toggle.TextXAlignment = Enum.TextXAlignment.Left
    Toggle.Parent = FarmPanel
    local Check = Instance.new("ImageLabel")
    Check.Size = UDim2.new(0, 28, 0, 28)
    Check.Position = UDim2.new(1, -36, 0, 4)
    Check.BackgroundTransparency = 1
    Check.Image = "rbxassetid://6031094678"
    Check.Visible = false
    Check.Parent = Toggle
    return Toggle, Check
end

local farmToggles = {}
farmToggles[1], farmToggles["farmCheck"] = makeFarmToggle("AUTO FARM", 20)
farmToggles[2], farmToggles["harvestCheck"] = makeFarmToggle("AUTO HARVEST", 66)
farmToggles[3], farmToggles["sellCheck"] = makeFarmToggle("AUTO SELL", 112)

farmToggles[1].MouseButton1Click:Connect(function()
    autoFarm = not autoFarm
    farmToggles["farmCheck"].Visible = autoFarm
end)
farmToggles[2].MouseButton1Click:Connect(function()
    autoHarvest = not autoHarvest
    farmToggles["harvestCheck"].Visible = autoHarvest
end)
farmToggles[3].MouseButton1Click:Connect(function()
    autoSell = not autoSell
    farmToggles["sellCheck"].Visible = autoSell
end)

-- Tab switching logic
local function showTab(tab)
    EventPanel.Visible = (tab == "event")
    ShopPanel.Visible = (tab == "shop")
    FarmPanel.Visible = (tab == "farm")
    EventBtn.BackgroundColor3 = (tab == "event") and Color3.fromRGB(200, 160, 120) or Color3.fromRGB(120, 135, 150)
    ShopBtn.BackgroundColor3 = (tab == "shop") and Color3.fromRGB(200, 160, 120) or Color3.fromRGB(120, 135, 150)
    FarmBtn.BackgroundColor3 = (tab == "farm") and Color3.fromRGB(200, 160, 120) or Color3.fromRGB(120, 135, 150)
end
EventBtn.MouseButton1Click:Connect(function() showTab("event") end)
ShopBtn.MouseButton1Click:Connect(function() showTab("shop") end)
FarmBtn.MouseButton1Click:Connect(function() showTab("farm") end)
showTab("event")

-- Hide/Show UI logic
local isHidden = false
local ShowUIButton = nil
local function setUIVisible(visible)
    ScreenGui.Enabled = visible
    isHidden = not visible
    if ShowUIButton then ShowUIButton.Visible = not visible end
end
CloseBtn.MouseButton1Click:Connect(function()
    setUIVisible(false)
end)
MinBtn.MouseButton1Click:Connect(function()
    setUIVisible(false)
end)
ShowUIButton = Instance.new("TextButton")
ShowUIButton.Size = UDim2.new(0, 120, 0, 36)
ShowUIButton.Position = UDim2.new(0, 20, 0, 80)
ShowUIButton.Text = "Show GAG UI"
ShowUIButton.BackgroundColor3 = Color3.fromRGB(30, 60, 110)
ShowUIButton.TextColor3 = Color3.fromRGB(255,255,255)
ShowUIButton.Font = Enum.Font.GothamBold
ShowUIButton.TextSize = 18
ShowUIButton.Visible = false
ShowUIButton.Parent = Player.PlayerGui
ShowUIButton.MouseButton1Click:Connect(function()
    setUIVisible(true)
end)

-- Keyboard shortcut (RightShift) to toggle UI
local UIS = game:GetService("UserInputService")
UIS.InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.RightShift then
        setUIVisible(isHidden)
    end
end)

-- Dummy variables and functions to prevent runtime errors and allow UI to work
local autoPlant, autoWater = false, false
local cropBox = {Text = ""}
function harvestAllFruits() end
function sellAllInventory() end
function autoBuyEggFunc() end
function autoBuySeedFunc() end

-- Automation Loop (dummy, add your logic here)
spawn(function()
    while true do
        local ok, err = pcall(function()
            if autoPlant then
                local crop = cropBox.Text
                if crop and #crop > 0 then
                    local remote = GameEvents:FindFirstChild("Plant_RE")
                    if remote then
                        pcall(function()
                            remote:FireServer(crop)
                        end)
                    end
                end
            end
            if autoWater then
                local remote = GameEvents:FindFirstChild("Water_RE")
                if remote then
                    pcall(function()
                        remote:FireServer()
                    end)
                end
            end
            if autoHarvest then
                harvestAllFruits()
            end
            if autoSell then
                sellAllInventory()
            end
            autoBuyEggFunc()
            autoBuySeedFunc()
        end)
        wait(1)
    end
end)

print("Grow a Garden GUI automation loaded! Use Hide/Show/X to control the UI.")
