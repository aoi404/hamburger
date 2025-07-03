local rs = game:GetService("ReplicatedStorage")
local events = rs:WaitForChild("GameEvents")
local player = game.Players.LocalPlayer

-- Loop through backpack and sell all Pears
for _, item in pairs(player.Backpack:GetChildren()) do
    if item.Name == "Pear" then
        events.SellFruit:FireServer(item)
    end
end
