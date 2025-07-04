-- Improved Grow a Garden GUI Automation Script with working auto-harvest (harvests all fruits in your garden)

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
Frame.Size = UDim2.new(0, 400, 0, 340)
Frame.Position = UDim2.new(0.5, -200, 0.5, -170)
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Text = "Grow a Garden Hub"
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 28
Title.Parent = Frame

-- Hide/Show/X Buttons
local HideBtn = Instance.new("TextButton")
HideBtn.Size = UDim2.new(0, 60, 0, 35)
HideBtn.Position = UDim2.new(1, -140, 0, 8)
HideBtn.Text = "Hide"
HideBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
HideBtn.TextColor3 = Color3.fromRGB(255,255,255)
HideBtn.Parent = Frame

local ShowBtn = Instance.new("TextButton")
ShowBtn.Size = UDim2.new(0, 100, 0, 35)
ShowBtn.Position = UDim2.new(0.5, -50, 0, -45)
ShowBtn.Text = "Show UI"
ShowBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ShowBtn.TextColor3 = Color3.fromRGB(255,255,255)
ShowBtn.Visible = false
ShowBtn.Parent = ScreenGui

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 60, 0, 35)
CloseBtn.Position = UDim2.new(1, -70, 0, 8)
CloseBtn.Text = "X"
CloseBtn.BackgroundColor3 = Color3.fromRGB(120, 40, 40)
CloseBtn.TextColor3 = Color3.fromRGB(255,255,255)
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
    Toggle.Size = UDim2.new(0, 320, 0, 45)
    Toggle.Position = UDim2.new(0, 40, 0, y)
    Toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    Toggle.Font = Enum.Font.SourceSans
    Toggle.TextSize = 22
    Toggle.Text = name .. ": OFF"
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
end)
waterToggle.MouseButton1Click:Connect(function()
    autoWater = not autoWater
    waterToggle.Text = "Auto Water: " .. (autoWater and "ON" or "OFF")
end)
harvestToggle.MouseButton1Click:Connect(function()
    autoHarvest = not autoHarvest
    harvestToggle.Text = "Auto Harvest: " .. (autoHarvest and "ON" or "OFF")
end)
sellToggle.MouseButton1Click:Connect(function()
    autoSell = not autoSell
    sellToggle.Text = "Auto Sell: " .. (autoSell and "ON" or "OFF")
end)

-- Crop selection
local cropBox = Instance.new("TextBox")
cropBox.Size = UDim2.new(0, 320, 0, 45)
cropBox.Position = UDim2.new(0, 40, 0, 60 + 240)
cropBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
cropBox.TextColor3 = Color3.fromRGB(255, 255, 255)
cropBox.Font = Enum.Font.SourceSans
cropBox.TextSize = 22
cropBox.Text = "WheatSeed"
cropBox.PlaceholderText = "Enter Crop Name"
cropBox.Parent = Frame

-- SHOP CATEGORY UI
local ShopLabel = Instance.new("TextLabel")
ShopLabel.Text = "Shop"
ShopLabel.Size = UDim2.new(0, 320, 0, 30)
ShopLabel.Position = UDim2.new(0, 40, 0, 250)
ShopLabel.BackgroundTransparency = 1
ShopLabel.TextColor3 = Color3.fromRGB(255, 255, 127)
ShopLabel.Font = Enum.Font.SourceSansBold
ShopLabel.TextSize = 24
ShopLabel.Parent = Frame

-- Dropdown for eggs
local eggList = {"BasicEgg", "RareEgg", "EpicEgg", "LegendaryEgg"} -- Add actual egg names here
local selectedEgg = nil
local autoBuyEgg = false

local EggDropdown = Instance.new("TextButton")
EggDropdown.Size = UDim2.new(0, 200, 0, 35)
EggDropdown.Position = UDim2.new(0, 50, 0, 290)
EggDropdown.BackgroundColor3 = Color3.fromRGB(80, 80, 120)
EggDropdown.TextColor3 = Color3.fromRGB(255,255,255)
EggDropdown.Font = Enum.Font.SourceSans
EggDropdown.TextSize = 20
EggDropdown.Text = "Select Egg to Auto Buy"
EggDropdown.Parent = Frame

local EggListFrame = Instance.new("Frame")
EggListFrame.Size = UDim2.new(0, 200, 0, #eggList*30)
EggListFrame.Position = UDim2.new(0, 50, 0, 325)
EggListFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 90)
EggListFrame.Visible = false
EggListFrame.Parent = Frame

for i,egg in ipairs(eggList) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.Position = UDim2.new(0, 0, 0, (i-1)*30)
    btn.BackgroundColor3 = Color3.fromRGB(100, 100, 140)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 18
    btn.Text = egg
    btn.Parent = EggListFrame
    btn.MouseButton1Click:Connect(function()
        selectedEgg = egg
        autoBuyEgg = not autoBuyEgg
        EggDropdown.Text = (autoBuyEgg and ("Auto Buy: "..egg)) or "Select Egg to Auto Buy"
        EggListFrame.Visible = false
    end)
end
EggDropdown.MouseButton1Click:Connect(function()
    EggListFrame.Visible = not EggListFrame.Visible
end)

-- Dropdown for seeds
local seedList = {"WheatSeed", "CarrotSeed", "CornSeed", "PumpkinSeed"} -- Add actual seed names here
local selectedSeed = nil
local autoBuySeed = false

local SeedDropdown = Instance.new("TextButton")
SeedDropdown.Size = UDim2.new(0, 200, 0, 35)
SeedDropdown.Position = UDim2.new(0, 260, 0, 290)
SeedDropdown.BackgroundColor3 = Color3.fromRGB(80, 120, 80)
SeedDropdown.TextColor3 = Color3.fromRGB(255,255,255)
SeedDropdown.Font = Enum.Font.SourceSans
SeedDropdown.TextSize = 20
SeedDropdown.Text = "Select Seed to Auto Buy"
SeedDropdown.Parent = Frame

local SeedListFrame = Instance.new("Frame")
SeedListFrame.Size = UDim2.new(0, 200, 0, #seedList*30)
SeedListFrame.Position = UDim2.new(0, 260, 0, 325)
SeedListFrame.BackgroundColor3 = Color3.fromRGB(60, 90, 60)
SeedListFrame.Visible = false
SeedListFrame.Parent = Frame

for i,seed in ipairs(seedList) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.Position = UDim2.new(0, 0, 0, (i-1)*30)
    btn.BackgroundColor3 = Color3.fromRGB(100, 140, 100)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 18
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
MiscLabel.Size = UDim2.new(0, 320, 0, 30)
MiscLabel.Position = UDim2.new(0, 40, 0, 370)
MiscLabel.BackgroundTransparency = 1
MiscLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
MiscLabel.Font = Enum.Font.SourceSansBold
MiscLabel.TextSize = 24
MiscLabel.Parent = Frame

-- Helper: Harvest all fruits in your garden
local function harvestAllFruits()
    -- Try to find the player's garden in Workspace (common pattern: Workspace.Farm[Player.Name])
    local farm = Workspace:FindFirstChild("Farm")
    if not farm then return end
    local myGarden = farm:FindFirstChild(Player.Name)
    if not myGarden then return end
    for _, obj in ipairs(myGarden:GetDescendants()) do
        if obj:IsA("BasePart") or obj:IsA("Model") then
            -- Try to fire the harvest remote with the object (some games require the object as argument)
            local remote = GameEvents:FindFirstChild("HarvestRemote")
            if remote then
                pcall(function()
                    remote:FireServer(obj)
                end)
            end
        end
    end
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

-- Helper: Auto buy egg
local function autoBuyEggFunc()
    if autoBuyEgg and selectedEgg then
        local remote = GameEvents:FindFirstChild("BuyPetEgg")
        if remote then
            pcall(function()
                remote:FireServer(selectedEgg)
            end)
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
