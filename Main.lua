-- Services
local rs = game:GetService("ReplicatedStorage")
local events = rs:WaitForChild("GameEvents")
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

-- [1] Teleport to sell zone (estimated position)
local SELL_POS = Vector3.new(-324, 5, 1012)  -- Replace with actual coordinates

pcall(function()
    char:MoveTo(SELL_POS)
end)

-- [2] Loop through backpack to sell pears
task.wait(1.5) -- Give time for teleport before selling

for _, item in pairs(player.Backpack:GetChildren()) do
    if item.Name == "Pear" then
        print("[Sell Attempt] Found Pear:", item)
        pcall(function()
            events.SellFruit:FireServer(item)
        end)
    end
end
