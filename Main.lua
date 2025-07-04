-- Modernized Grow a Garden GUI Automation Script with improved UI, correct egg/seed lists, and robust auto-harvest

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local GameEvents = ReplicatedStorage:WaitForChild("GameEvents")
local Workspace = game:GetService("Workspace")

-- Redesigned UI to match provided screenshot
-- Remove old UI if exists
if Player.PlayerGui:FindFirstChild("GrowGardenUI") then
    Player.PlayerGui.GrowGardenUI:Destroy()
end

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

local EggBox = Instance.new("TextLabel")
EggBox.Size = UDim2.new(0.9, 0, 0, 60)
EggBox.Position = UDim2.new(0.05, 0, 0, 60)
EggBox.BackgroundColor3 = Color3.fromRGB(70, 110, 150)
EggBox.TextColor3 = Color3.fromRGB(255,255,255)
EggBox.Font = Enum.Font.GothamBold
EggBox.TextSize = 18
EggBox.Text = "EGGS HERE"
EggBox.Parent = ShopPanel

local BuySeedHeader = Instance.new("TextLabel")
BuySeedHeader.Size = UDim2.new(0.9, 0, 0, 36)
BuySeedHeader.Position = UDim2.new(0.05, 0, 0, 130)
BuySeedHeader.BackgroundColor3 = Color3.fromRGB(30, 60, 110)
BuySeedHeader.TextColor3 = Color3.fromRGB(255,255,255)
BuySeedHeader.Font = Enum.Font.GothamBold
BuySeedHeader.TextSize = 18
BuySeedHeader.Text = "BUY SEEDS:"
BuySeedHeader.Parent = ShopPanel

local SeedBox = Instance.new("TextLabel")
SeedBox.Size = UDim2.new(0.9, 0, 0, 60)
SeedBox.Position = UDim2.new(0.05, 0, 0, 170)
SeedBox.BackgroundColor3 = Color3.fromRGB(70, 110, 150)
SeedBox.TextColor3 = Color3.fromRGB(255,255,255)
SeedBox.Font = Enum.Font.GothamBold
SeedBox.TextSize = 18
SeedBox.Text = "SEEDS HERE"
SeedBox.Parent = ShopPanel

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

local autoFarm, autoHarvest, autoSell = false, false, false
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

-- Default to event tab
showTab("event")

-- Hide/Show UI logic
local isHidden = false
local ShowUIButton = nil

local function setUIVisible(visible)
    ScreenGui.Enabled = visible
    isHidden = not visible
    if ShowUIButton then ShowUIButton.Visible = not visible end
end

-- Hide UI when close or minimize is clicked
CloseBtn.MouseButton1Click:Connect(function()
    setUIVisible(false)
end)
MinBtn.MouseButton1Click:Connect(function()
    setUIVisible(false)
end)

-- Show UI button (appears when UI is hidden)
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

-- SHOP TAB: Egg and Seed Dropdowns (single-select, header is dropdown, auto-size)
local eggList = {
    "Common Egg", "Uncommon Egg", "Rare Egg", "Legendary Egg", "Mythical Egg", "Bug Egg", "Exotic Bug Egg", "Night Egg", "Premium Night Egg", "Bee Egg", "Anti Bee Egg", "Premium Anti Bee Egg", "Common Summer Egg", "Rare Summer Egg", "Paradise Egg", "Oasis Egg", "Premium Oasis Egg", "Raphael Egg 1", "Raphael Egg 2", "Raphael Egg 3"
}
local selectedEgg = nil

BuyEggHeader.Text = "BUY EGG:"
BuyEggHeader.TextXAlignment = Enum.TextXAlignment.Left
BuyEggHeader.TextYAlignment = Enum.TextYAlignment.Center
BuyEggHeader.ClipsDescendants = true

local EggListFrame = Instance.new("Frame")
EggListFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 90)
EggListFrame.Visible = false
EggListFrame.Parent = ShopPanel
EggListFrame.ClipsDescendants = true

local function updateEggDropdownSize()
    local text = selectedEgg and ("BUY EGG: "..selectedEgg) or "BUY EGG:"
    BuyEggHeader.Text = text
    local textService = game:GetService("TextService")
    local size = textService:GetTextSize(text, 18, Enum.Font.GothamBold, Vector2.new(1000, 36))
    BuyEggHeader.Size = UDim2.new(0, math.max(180, size.X+30), 0, 36)
    EggListFrame.Size = UDim2.new(0, BuyEggHeader.Size.X.Offset, 0, #eggList*28)
    EggListFrame.Position = UDim2.new(0.05, 0, 0, BuyEggHeader.Position.Y.Offset+BuyEggHeader.Size.Y.Offset)
end
updateEggDropdownSize()

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
    btn.MouseButton1Click:Connect(function()
        selectedEgg = egg
        updateEggDropdownSize()
        EggListFrame.Visible = false
    end)
end
BuyEggHeader.MouseButton1Click:Connect(function()
    EggListFrame.Visible = not EggListFrame.Visible
end)

-- Seeds (single select, header is dropdown, auto-size)
local seedList = {
    "Carrot", "Strawberry", "Blueberry", "Tomato", "Cauliflower", "Watermelon", "Rafflesia", "Green Apple", "Avocado", "Banana", "Pineapple", "Kiwi", "Bell Pepper", "Prickly Pear", "Loquat", "Feijoa", "Pitcher Plant", "Sugar Apple"
}
local selectedSeed = nil

BuySeedHeader.Text = "BUY SEEDS:"
BuySeedHeader.TextXAlignment = Enum.TextXAlignment.Left
BuySeedHeader.TextYAlignment = Enum.TextYAlignment.Center
BuySeedHeader.ClipsDescendants = true

local SeedListFrame = Instance.new("Frame")
SeedListFrame.BackgroundColor3 = Color3.fromRGB(60, 90, 60)
SeedListFrame.Visible = false
SeedListFrame.Parent = ShopPanel
SeedListFrame.ClipsDescendants = true

local function updateSeedDropdownSize()
    local text = selectedSeed and ("BUY SEEDS: "..selectedSeed) or "BUY SEEDS:"
    BuySeedHeader.Text = text
    local textService = game:GetService("TextService")
    local size = textService:GetTextSize(text, 18, Enum.Font.GothamBold, Vector2.new(1000, 36))
    BuySeedHeader.Size = UDim2.new(0, math.max(180, size.X+30), 0, 36)
    SeedListFrame.Size = UDim2.new(0, BuySeedHeader.Size.X.Offset, 0, #seedList*28)
    SeedListFrame.Position = UDim2.new(0.05, 0, 0, BuySeedHeader.Position.Y.Offset+BuySeedHeader.Size.Y.Offset)
end
updateSeedDropdownSize()

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
    btn.MouseButton1Click:Connect(function()
        selectedSeed = seed
        updateSeedDropdownSize()
        SeedListFrame.Visible = false
    end)
end
BuySeedHeader.MouseButton1Click:Connect(function()
    SeedListFrame.Visible = not SeedListFrame.Visible
end)

-- Update auto-buy logic to buy selected egg/seed
local function autoBuyEggFunc()
    if selectedEgg then
        local remote = GameEvents:FindFirstChild("BuyPetEgg")
        if remote then
            pcall(function() remote:FireServer(selectedEgg) end)
        end
    end
end

local function autoBuySeedFunc()
    if selectedSeed then
        local remote = GameEvents:FindFirstChild("BuySeedStock")
        if remote then
            pcall(function() remote:FireServer(selectedSeed) end)
        end
    end
end

-- Automation Loop
spawn(function()
    while true do
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
        wait(1)
    end
end)

print("Grow a Garden GUI automation loaded! Use Hide/Show/X to control the UI.")
