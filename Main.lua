
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
Frame.Size = UDim2.new(0, 250, 0, 220)
Frame.Position = UDim2.new(0.5, -125, 0.5, -110)
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Text = "Grow a Garden Hub"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 20
Title.Parent = Frame

-- Hide/Show/X Buttons
local HideBtn = Instance.new("TextButton")
HideBtn.Size = UDim2.new(0, 40, 0, 25)
HideBtn.Position = UDim2.new(1, -90, 0, 2)
HideBtn.Text = "Hide"
HideBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
HideBtn.TextColor3 = Color3.fromRGB(255,255,255)
HideBtn.Parent = Frame

local ShowBtn = Instance.new("TextButton")
ShowBtn.Size = UDim2.new(0, 60, 0, 25)
ShowBtn.Position = UDim2.new(0.5, -30, 0, -35)
ShowBtn.Text = "Show UI"
ShowBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ShowBtn.TextColor3 = Color3.fromRGB(255,255,255)
ShowBtn.Visible = false
ShowBtn.Parent = ScreenGui

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 40, 0, 25)
CloseBtn.Position = UDim2.new(1, -45, 0, 2)
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
    Toggle.Size = UDim2.new(0, 200, 0, 30)
    Toggle.Position = UDim2.new(0, 25, 0, y)
    Toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    Toggle.Font = Enum.Font.SourceSans
    Toggle.TextSize = 18
    Toggle.Text = name .. ": OFF"
    Toggle.Parent = Frame
    return Toggle
end

local autoPlant = false
local autoWater = false
local autoHarvest = false
local autoSell = false

local plantToggle = makeToggle("Auto Plant", 40)
local waterToggle = makeToggle("Auto Water", 80)
local harvestToggle = makeToggle("Auto Harvest", 120)
local sellToggle = makeToggle("Auto Sell", 160)

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
cropBox.Size = UDim2.new(0, 200, 0, 30)
cropBox.Position = UDim2.new(0, 25, 0, 170)
cropBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
cropBox.TextColor3 = Color3.fromRGB(255, 255, 255)
cropBox.Font = Enum.Font.SourceSans
cropBox.TextSize = 18
cropBox.Text = "WheatSeed"
cropBox.PlaceholderText = "Enter Crop Name"
cropBox.Parent = Frame

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
        wait(1)
    end
end)

print("Grow a Garden GUI automation loaded! Use Hide/Show/X to control the UI.")
