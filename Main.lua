local rs = game:GetService("ReplicatedStorage")
local events = rs:WaitForChild("GameEvents")
local player = game.Players.LocalPlayer
local backpack = player:WaitForChild("Backpack")

-- Try multiple formats to sell the Pear
for _, item in pairs(backpack:GetChildren()) do
	if item.Name == "Pear" then
		warn("Found Pear:", item)

		-- Try different call formats
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
