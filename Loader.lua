local rs = game:GetService("ReplicatedStorage")
local events = rs:WaitForChild("GameEvents")
local player = game.Players.LocalPlayer
local backpack = player:WaitForChild("Backpack")

local summerFruits = {"Peach", "Plum", "Apricot"}
local autoFarm = true

-- Auto Harvest
task.spawn(function()
    while autoFarm do
        task.wait(2)
        pcall(function()
            events.Harvest:FireServer()
        end)
    end
end)

-- Auto Sell Summer Fruits
task.spawn(function()
    while autoFarm do
        task.wait(3)
        for _, item in pairs(backpack:GetChildren()) do
            if table.find(summerFruits, item.Name) then
                events.SellFruit:FireServer(item)
            end
        end
    end
end)

-- Auto Submit Summer Fruits
task.spawn(function()
    while autoFarm do
        task.wait(5)
        for _, item in pairs(backpack:GetChildren()) do
            if table.find(summerFruits, item.Name) and item:FindFirstChild("IsSummitable") then
                events.SubmitFruit:FireServer(item)
            end
        end
    end
end)
