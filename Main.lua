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

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GrowGardenUI"
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 420, 0, 420)
Frame.Position = UDim2.new(0.5, -210, 0.5, -210)
Frame.BackgroundColor3 = Color3.fromRGB(30, 32, 36)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = Frame

local Title = Instance.new("TextLabel")
Title.Text = "🌱 Grow a Garden Hub"
Title.Size = UDim2.new(1, 0, 0, 48)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 32
Title.Parent = Frame

-- Hide/Show/X Buttons
local HideBtn = Instance.new("TextButton")
HideBtn.Size = UDim2.new(0, 60, 0, 32)
HideBtn.Position = UDim2.new(1, -132, 0, 8)
HideBtn.Text = "Hide"
HideBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
HideBtn.TextColor3 = Color3.fromRGB(220,220,220)
HideBtn.Font = Enum.Font.Gotham
HideBtn.TextSize = 18
HideBtn.Parent = Frame

local ShowBtn = Instance.new("TextButton")
ShowBtn.Size = UDim2.new(0, 120, 0, 36)
ShowBtn.Position = UDim2.new(0.5, -60, 0, -44)
ShowBtn.Text = "Show UI"
ShowBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
ShowBtn.TextColor3 = Color3.fromRGB(220,220,220)
ShowBtn.Font = Enum.Font.Gotham
ShowBtn.TextSize = 20
ShowBtn.Visible = false
ShowBtn.Parent = ScreenGui

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 48, 0, 32)
CloseBtn.Position = UDim2.new(1, -68, 0, 8)
CloseBtn.Text = "✕"
CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 60, 60)
CloseBtn.TextColor3 = Color3.fromRGB(255,255,255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 20
CloseBtn.Parent = Frame

HideBtn.MouseButton1Click:Connect(function()
    Frame.Visible = false
    ShowBtn.Visible = true
end)
ShowBtn.MouseButton1Click:Connect(function()
    Frame.Visible = true
    ShowBtn.Visible = false
end)
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local function makeToggle(name, y)
    local Toggle = Instance.new("TextButton")
    Toggle.Size = UDim2.new(0, 340, 0, 40)
    Toggle.Position = UDim2.new(0, 40, 0, y)
    Toggle.BackgroundColor3 = Color3.fromRGB(45, 48, 55)
    Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    Toggle.Font = Enum.Font.Gotham
    Toggle.TextSize = 20
    Toggle.Text = name .. ": OFF"
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = Toggle
    Toggle.Parent = Frame
    return Toggle
end

local autoPlant = false
local autoWater = false
local autoHarvest = false
local autoSell = false

local plantToggle = makeToggle("Auto Plant", 60)
local waterToggle = makeToggle("Auto Water", 105)
local harvestToggle = makeToggle("Auto Harvest", 150)
local sellToggle = makeToggle("Auto Sell", 195)

plantToggle.MouseButton1Click:Connect(function()
    autoPlant = not autoPlant
    plantToggle.Text = "Auto Plant: " .. (autoPlant and "ON" or "OFF")
    plantToggle.BackgroundColor3 = autoPlant and Color3.fromRGB(60, 120, 60) or Color3.fromRGB(45, 48, 55)
end)
waterToggle.MouseButton1Click:Connect(function()
    autoWater = not autoWater
    waterToggle.Text = "Auto Water: " .. (autoWater and "ON" or "OFF")
    waterToggle.BackgroundColor3 = autoWater and Color3.fromRGB(60, 120, 180) or Color3.fromRGB(45, 48, 55)
end)
harvestToggle.MouseButton1Click:Connect(function()
    autoHarvest = not autoHarvest
    harvestToggle.Text = "Auto Harvest: " .. (autoHarvest and "ON" or "OFF")
    harvestToggle.BackgroundColor3 = autoHarvest and Color3.fromRGB(180, 180, 60) or Color3.fromRGB(45, 48, 55)
end)
sellToggle.MouseButton1Click:Connect(function()
    autoSell = not autoSell
    sellToggle.Text = "Auto Sell: " .. (autoSell and "ON" or "OFF")
    sellToggle.BackgroundColor3 = autoSell and Color3.fromRGB(180, 60, 60) or Color3.fromRGB(45, 48, 55)
end)

-- Crop selection
local cropBox = Instance.new("TextBox")
cropBox.Size = UDim2.new(0, 340, 0, 38)
cropBox.Position = UDim2.new(0, 40, 0, 245)
cropBox.BackgroundColor3 = Color3.fromRGB(45, 48, 55)
cropBox.TextColor3 = Color3.fromRGB(255, 255, 255)
cropBox.Font = Enum.Font.Gotham
cropBox.TextSize = 20
cropBox.Text = "WheatSeed"
cropBox.PlaceholderText = "Enter Crop Name"
local cropCorner = Instance.new("UICorner")
cropCorner.CornerRadius = UDim.new(0, 8)
cropCorner.Parent = cropBox
cropBox.Parent = Frame

-- SHOP CATEGORY UI
local ShopLabel = Instance.new("TextLabel")
ShopLabel.Text = "Shop"
ShopLabel.Size = UDim2.new(0, 340, 0, 28)
ShopLabel.Position = UDim2.new(0, 40, 0, 290)
ShopLabel.BackgroundTransparency = 1
ShopLabel.TextColor3 = Color3.fromRGB(255, 255, 127)
ShopLabel.Font = Enum.Font.GothamBold
ShopLabel.TextSize = 22
ShopLabel.Parent = Frame

-- Updated egg list with categories (Shop and Raphael's Shop)
local eggList = {
    {label = "Egg Shop / Event Shop", isLabel = true},
    "Common Egg",
    "Uncommon Egg",
    "Rare Egg",
    "Legendary Egg",
    "Mythical Egg",
    "Bug Egg",
    "Exotic Bug Egg",
    "Night Egg",
    "Premium Night Egg",
    "Bee Egg",
    "Anti Bee Egg",
    "Premium Anti Bee Egg",
    "Common Summer Egg",
    "Rare Summer Egg",
    "Paradise Egg",
    "Oasis Egg",
    "Premium Oasis Egg",
    {label = "Raphael's Shop", isLabel = true},
    -- Add Raphael's Shop eggs here, example:
    "Raphael Egg 1",
    "Raphael Egg 2",
    "Raphael Egg 3"
}
local selectedEgg = nil
local autoBuyEgg = false

local EggDropdown = Instance.new("TextButton")
EggDropdown.Size = UDim2.new(0, 160, 0, 32)
EggDropdown.Position = UDim2.new(0, 50, 0, 325)
EggDropdown.BackgroundColor3 = Color3.fromRGB(80, 80, 120)
EggDropdown.TextColor3 = Color3.fromRGB(255,255,255)
EggDropdown.Font = Enum.Font.Gotham
EggDropdown.TextSize = 18
EggDropdown.Text = "Select Egg to Auto Buy"
local eggCorner = Instance.new("UICorner")
eggCorner.CornerRadius = UDim.new(0, 8)
eggCorner.Parent = EggDropdown
EggDropdown.Parent = Frame

local totalEggs = 0
for _,v in ipairs(eggList) do totalEggs = totalEggs + 1 end
local EggListFrame = Instance.new("Frame")
EggListFrame.Size = UDim2.new(0, 160, 0, totalEggs*28)
EggListFrame.Position = UDim2.new(0, 50, 0, 357)
EggListFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 90)
EggListFrame.Visible = false
local eggListCorner = Instance.new("UICorner")
eggListCorner.CornerRadius = UDim.new(0, 8)
eggListCorner.Parent = EggListFrame
EggListFrame.Parent = Frame

local y = 0
for _,egg in ipairs(eggList) do
    if type(egg) == "table" and egg.isLabel then
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 0, 24)
        label.Position = UDim2.new(0, 0, 0, y)
        label.BackgroundTransparency = 1
        label.TextColor3 = Color3.fromRGB(200,200,255)
        label.Font = Enum.Font.GothamBold
        label.TextSize = 15
        label.Text = egg.label
        label.Parent = EggListFrame
        y = y + 24
    else
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 28)
        btn.Position = UDim2.new(0, 0, 0, y)
        btn.BackgroundColor3 = Color3.fromRGB(100, 100, 140)
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 16
        btn.Text = egg
        btn.Parent = EggListFrame
        btn.MouseButton1Click:Connect(function()
            selectedEgg = egg
            autoBuyEgg = not autoBuyEgg
            EggDropdown.Text = (autoBuyEgg and ("Auto Buy: "..egg)) or "Select Egg to Auto Buy"
            EggListFrame.Visible = false
        end)
        y = y + 28
    end
end
EggDropdown.MouseButton1Click:Connect(function()
    EggListFrame.Visible = not EggListFrame.Visible
end)

-- Corrected seed list (from user-provided Grow a Garden list)
local seedList = {
    "Carrot",
    "Strawberry",
    "Blueberry",
    "Tomato",
    "Cauliflower",
    "Watermelon",
    "Rafflesia",
    "Green Apple",
    "Avocado",
    "Banana",
    "Pineapple",
    "Kiwi",
    "Bell Pepper",
    "Prickly Pear",
    "Loquat",
    "Feijoa",
    "Pitcher Plant",
    "Sugar Apple"
}
local selectedSeed = nil
local autoBuySeed = false

local SeedDropdown = Instance.new("TextButton")
SeedDropdown.Size = UDim2.new(0, 160, 0, 32)
SeedDropdown.Position = UDim2.new(0, 230, 0, 325)
SeedDropdown.BackgroundColor3 = Color3.fromRGB(80, 120, 80)
SeedDropdown.TextColor3 = Color3.fromRGB(255,255,255)
SeedDropdown.Font = Enum.Font.Gotham
SeedDropdown.TextSize = 18
SeedDropdown.Text = "Select Seed to Auto Buy"
local seedCorner = Instance.new("UICorner")
seedCorner.CornerRadius = UDim.new(0, 8)
seedCorner.Parent = SeedDropdown
SeedDropdown.Parent = Frame

local SeedListFrame = Instance.new("Frame")
SeedListFrame.Size = UDim2.new(0, 160, 0, #seedList*28)
SeedListFrame.Position = UDim2.new(0, 230, 0, 357)
SeedListFrame.BackgroundColor3 = Color3.fromRGB(60, 90, 60)
SeedListFrame.Visible = false
local seedListCorner = Instance.new("UICorner")
seedListCorner.CornerRadius = UDim.new(0, 8)
seedListCorner.Parent = SeedListFrame
SeedListFrame.Parent = Frame

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
        autoBuySeed = not autoBuySeed
        SeedDropdown.Text = (autoBuySeed and ("Auto Buy: "..seed)) or "Select Seed to Auto Buy"
        SeedListFrame.Visible = false
    end)
end
SeedDropdown.MouseButton1Click:Connect(function()
    SeedListFrame.Visible = not SeedListFrame.Visible
end)

-- MISC CATEGORY LABEL
local MiscLabel = Instance.new("TextLabel")
MiscLabel.Text = "Misc"
MiscLabel.Size = UDim2.new(0, 340, 0, 28)
MiscLabel.Position = UDim2.new(0, 40, 0, 390)
MiscLabel.BackgroundTransparency = 1
MiscLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
MiscLabel.Font = Enum.Font.GothamBold
MiscLabel.TextSize = 22
MiscLabel.Parent = Frame

-- UI: Add a notification label for harvest feedback
local HarvestNotif = Instance.new("TextLabel")
HarvestNotif.Size = UDim2.new(0, 320, 0, 32)
HarvestNotif.Position = UDim2.new(0.5, -160, 0, 210)
HarvestNotif.BackgroundTransparency = 0.3
HarvestNotif.BackgroundColor3 = Color3.fromRGB(60, 80, 60)
HarvestNotif.TextColor3 = Color3.fromRGB(255,255,180)
HarvestNotif.Font = Enum.Font.GothamBold
HarvestNotif.TextSize = 18
HarvestNotif.Text = ""
HarvestNotif.Visible = false
HarvestNotif.ZIndex = 10
HarvestNotif.Parent = Frame

-- UI: Add a notification label for egg-buy troubleshooting
local EggBuyNotif = Instance.new("TextLabel")
EggBuyNotif.Size = UDim2.new(0, 320, 0, 32)
EggBuyNotif.Position = UDim2.new(0.5, -160, 0, 175)
EggBuyNotif.BackgroundTransparency = 0.3
EggBuyNotif.BackgroundColor3 = Color3.fromRGB(80, 80, 120)
EggBuyNotif.TextColor3 = Color3.fromRGB(255,255,200)
EggBuyNotif.Font = Enum.Font.GothamBold
EggBuyNotif.TextSize = 18
EggBuyNotif.Text = ""
EggBuyNotif.Visible = false
EggBuyNotif.ZIndex = 10
EggBuyNotif.Parent = Frame

-- Listen for manual harvests (server-to-client) for troubleshooting
local harvestRemote = GameEvents:FindFirstChild("HarvestRemote")
if harvestRemote and harvestRemote.OnClientEvent then
    harvestRemote.OnClientEvent:Connect(function(...)
        local args = {...}
        print("[DEV LOG] Manual Harvest: OnClientEvent received! Args:", unpack(args))
        local objName = "?"
        if #args > 0 and typeof(args[1]) == "Instance" then
            objName = args[1]:GetFullName()
        elseif #args > 0 then
            objName = tostring(args[1])
        end
        HarvestNotif.Text = "Manual Harvested: "..objName
        HarvestNotif.TextColor3 = Color3.fromRGB(255,220,120)
        HarvestNotif.Visible = true
        wait(1.2)
        HarvestNotif.Visible = false
    end)
end

-- Helper: Harvest all fruits in your garden (robust, with dev log and UI feedback)
local function harvestAllFruits()
    print("[DEV LOG] Harvest: Triggered auto-harvest at "..os.date("!%X"))
    local farm = Workspace:FindFirstChild("Farm")
    if not farm then print("[DEV LOG] Harvest: No 'Farm' found in Workspace.") HarvestNotif.Text = "No Farm found!" HarvestNotif.Visible = true wait(1) HarvestNotif.Visible = false return end
    local myGarden = farm:FindFirstChild(Player.Name)
    if not myGarden then print("[DEV LOG] Harvest: No garden found for player '"..Player.Name.."'.") HarvestNotif.Text = "No Garden found!" HarvestNotif.Visible = true wait(1) HarvestNotif.Visible = false return end
    local remote = GameEvents:FindFirstChild("HarvestRemote")
    if not remote then print("[DEV LOG] Harvest: No 'HarvestRemote' found in GameEvents.") HarvestNotif.Text = "No HarvestRemote!" HarvestNotif.Visible = true wait(1) HarvestNotif.Visible = false return end
    local found = 0
    for _, obj in ipairs(myGarden:GetDescendants()) do
        if obj:IsA("BasePart") or obj:IsA("Model") then
            found = found + 1
            print("[DEV LOG] Harvest: Attempting to harvest object:", obj:GetFullName())
            local ok1, err1 = pcall(function() remote:FireServer(obj) end)
            print("[DEV LOG] Harvest: FireServer(obj) result:", ok1, err1)
            local ok2, err2 = pcall(function() remote:FireServer() end)
            print("[DEV LOG] Harvest: FireServer() result:", ok2, err2)
        end
    end
    print("[DEV LOG] Harvest: Total objects attempted:", found)
    HarvestNotif.Text = found > 0 and ("Auto-Harvested "..found.." objects!") or "Nothing to harvest."
    HarvestNotif.Visible = true
    wait(1.2)
    HarvestNotif.Visible = false
end

-- Helper: Sell all inventory
local function sellAllInventory()
    local remote = GameEvents:FindFirstChild("Sell_Inventory") or GameEvents:FindFirstChild("Sell_Item")
    if remote then
        pcall(function()
            remote:FireServer()
        end)
    end
end

-- Helper: Auto buy egg (with dev log, argument variations, and UI feedback)
local function autoBuyEggFunc()
    if autoBuyEgg and selectedEgg then
        local remote = GameEvents:FindFirstChild("BuyPetEgg")
        if remote then
            print("[DEV LOG] BuyEgg: Attempting to buy egg:", selectedEgg)
            -- Try original
            local ok, err = pcall(function() remote:FireServer(selectedEgg) end)
            print("[DEV LOG] BuyEgg: FireServer(selectedEgg) result:", ok, err)
            if ok then
                EggBuyNotif.Text = "[Egg] Bought (direct): "..selectedEgg
                EggBuyNotif.TextColor3 = Color3.fromRGB(180,255,180)
                EggBuyNotif.Visible = true
                wait(1.2)
                EggBuyNotif.Visible = false
                return
            end
            -- Try removing spaces
            local noSpace = string.gsub(selectedEgg, " ", "")
            print("[DEV LOG] BuyEgg: Retrying with no spaces:", noSpace)
            local ok2, err2 = pcall(function() remote:FireServer(noSpace) end)
            print("[DEV LOG] BuyEgg: FireServer(noSpace) result:", ok2, err2)
            if ok2 then
                EggBuyNotif.Text = "[Egg] Bought (no space): "..noSpace
                EggBuyNotif.TextColor3 = Color3.fromRGB(180,255,180)
                EggBuyNotif.Visible = true
                wait(1.2)
                EggBuyNotif.Visible = false
                return
            end
            -- Try as table
            print("[DEV LOG] BuyEgg: Retrying with table arg:", selectedEgg)
            local ok3, err3 = pcall(function() remote:FireServer({selectedEgg}) end)
            print("[DEV LOG] BuyEgg: FireServer({selectedEgg}) result:", ok3, err3)
            if ok3 then
                EggBuyNotif.Text = "[Egg] Bought (table): {"..selectedEgg.."}"
                EggBuyNotif.TextColor3 = Color3.fromRGB(180,255,180)
                EggBuyNotif.Visible = true
                wait(1.2)
                EggBuyNotif.Visible = false
                return
            end
            -- If all fail, show error
            EggBuyNotif.Text = "[Egg] FAILED: "..tostring(err or err2 or err3)
            EggBuyNotif.TextColor3 = Color3.fromRGB(255,180,180)
            EggBuyNotif.Visible = true
            wait(2)
            EggBuyNotif.Visible = false
        else
            print("[DEV LOG] BuyEgg: 'BuyPetEgg' remote not found!")
            EggBuyNotif.Text = "[Egg] Remote not found!"
            EggBuyNotif.TextColor3 = Color3.fromRGB(255,180,180)
            EggBuyNotif.Visible = true
            wait(2)
            EggBuyNotif.Visible = false
        end
    end
end

-- Helper: Auto buy seed
local function autoBuySeedFunc()
    if autoBuySeed and selectedSeed then
        local remote = GameEvents:FindFirstChild("BuySeedStock")
        if remote then
            pcall(function()
                remote:FireServer(selectedSeed)
            end)
        end
    end
end

-- UI Improvements: Add drop shadow, better spacing, and section lines
local UIScale = Instance.new("UIScale")
UIScale.Scale = 1.1
Frame.Parent = nil -- Remove to re-parent after adding shadow
local Shadow = Instance.new("ImageLabel")
Shadow.Size = UDim2.new(1, 24, 1, 24)
Shadow.Position = UDim2.new(0, -12, 0, -12)
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxassetid://1316045217"
Shadow.ImageTransparency = 0.4
Shadow.ZIndex = 0
Shadow.Parent = ScreenGui
Frame.ZIndex = 1
Frame.Parent = ScreenGui
UIScale.Parent = Frame

-- Add section lines
local function addSectionLine(y)
    local line = Instance.new("Frame")
    line.Size = UDim2.new(0, 340, 0, 2)
    line.Position = UDim2.new(0, 40, 0, y)
    line.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    line.BorderSizePixel = 0
    line.Parent = Frame
end
addSectionLine(240)
addSectionLine(380)

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
