-- Grow a Garden GUI Automation Script

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

-- Remotes
local GameEvents = ReplicatedStorage:WaitForChild("GameEvents")

-- UI Creation
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GrowGardenUI"
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 250, 0, 200)
Frame.Position = UDim2.new(0.5, -125, 0.5, -100)
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

local plantToggle = makeToggle("Auto Plant", 40)
local waterToggle = makeToggle("Auto Water", 80)
local harvestToggle = makeToggle("Auto Harvest", 120)

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

-- Crop selection
local cropBox = Instance.new("TextBox")
cropBox.Size = UDim2.new(0, 200, 0, 30)
cropBox.Position = UDim2.new(0, 25, 0, 160)
cropBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
cropBox.TextColor3 = Color3.fromRGB(255, 255, 255)
cropBox.Font = Enum.Font.SourceSans
cropBox.TextSize = 18
cropBox.Text = "WheatSeed"
cropBox.PlaceholderText = "Enter Crop Name"
cropBox.Parent = Frame

-- Automation Loop
spawn(function()
    while true do
        if autoPlant then
            local crop = cropBox.Text
            if crop and #crop > 0 then
                local remote = GameEvents:FindFirstChild("Plant_RE")
                if remote then
                    remote:FireServer(crop)
                end
            end
        end
        if autoWater then
            local remote = GameEvents:FindFirstChild("Water_RE")
            if remote then
                remote:FireServer()
            end
        end
        if autoHarvest then
            local remote = GameEvents:FindFirstChild("HarvestRemote")
            if remote then
                remote:FireServer()
            end
        end
        wait(1)
    end
end)

print("Grow a Garden GUI automation loaded! Toggle features in the UI.")
