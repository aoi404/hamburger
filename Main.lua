local player = game.Players.LocalPlayer
local rs = game:GetService("ReplicatedStorage")
local events = rs:WaitForChild("GameEvents")
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "SellPearButtonGUI"
gui.ResetOnSpawn = false

-- Create the Sell Pears button
local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0, 160, 0, 45)
btn.Position = UDim2.new(1, -180, 1, -60) -- bottom right corner
btn.AnchorPoint = Vector2.new(0, 0)
btn.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
btn.TextColor3 = Color3.new(1, 1, 1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 18
btn.Text = "🍐 Sell All Pears"
btn.Parent = gui

-- Button logic
btn.MouseButton1Click:Connect(function()
	print("🛍️ Sell button clicked!")

	local backpack = player:FindFirstChild("Backpack")
	if not backpack then
		warn("⚠️ Could not find Backpack.")
		return
	end

	local found = false
	for _, item in pairs(backpack:GetChildren()) do
		if item.Name == "Pear" then
			found = true
			print("🍐 Selling Pear:", item)

			-- Try all major formats
			local ok1 = pcall(function() events.SellFruit:FireServer(item) end)
			print("🔁 Format 1 [Instance]:", ok1 and "✅" or "❌")

			local ok2 = pcall(function() events.SellFruit:FireServer("Pear") end)
			print("🔁 Format 2 [String]:", ok2 and "✅" or "❌")

			local ok3 = pcall(function()
				events.SellFruit:FireServer({
					Name = "Pear",
					Weight = item:FindFirstChild("Weight") and item.Weight.Value or 1,
					ID = item:GetAttribute("ID") or tostring(item)
				})
			end)
			print("🔁 Format 3 [Table]:", ok3 and "✅" or "❌")
		end
	end

	if not found then
		print("❌ No Pears found in Backpack.")
	end
end)
