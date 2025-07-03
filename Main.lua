local rs = game:GetService("ReplicatedStorage")
local events = rs:WaitForChild("GameEvents")
local player = game.Players.LocalPlayer
local backpack = player:WaitForChild("Backpack")
local char = player.Character or player.CharacterAdded:Wait()

-- Your custom sell zone coordinate
local SELL_POS = Vector3.new(86.6, 3.0, 0.4)

-- Teleport to sell zone
pcall(function()
    char:MoveTo(SELL_POS)
    print("🚀 Teleported to sell zone at", SELL_POS)
end)

task.wait(1.5)

-- Try selling Pears
for _, item in pairs(backpack:GetChildren()) do
    if item.Name == "Pear" then
        print("🍐 Found Pear:", item)
        pcall(function() events.SellFruit:FireServer(item) end)
        pcall(function() events.SellFruit:FireServer("Pear") end)
        pcall(function()
            events.SellFruit:FireServer({
                Name = "Pear",
                Weight = item:FindFirstChild("Weight") and item.Weight.Value or 5,
                ID = item:GetAttribute("ID") or tostring(item)
            })
        end)
    end
end
