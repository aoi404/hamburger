local player = game.Players.LocalPlayer
local rs = game:GetService("ReplicatedStorage")
local events = rs:WaitForChild("GameEvents")
local char = player.Character or player.CharacterAdded:Wait()

-- GUI Setup
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "SellPearGUI"

local btn = Instance.new("TextButton", gui)
btn.Size = UDim2.new(0, 200, 0, 50)
btn.Position = UDim2.new(0.5, -100, 0.5, -25)
btn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.SourceSansBold
btn.TextSize = 22
btn.Text = "🍐 Sell Pears"

-- Teleport position (replace if needed!)
local SELL_POS = Vector3.new(-324, 5, 1012)

btn.MouseButton1Click:Connect(function()
	print("🌀 [Sell GUI] Button clicked.")

	-- Teleport to sell area
	pcall(function()
		char:MoveTo(SELL_POS)
		print("🚶‍♂️ Moved to sell zone at:", SELL_POS)
	end)

	task.wait(1.5) -- let teleport settle

	-- Search backpack and try to sell Pears
	local backpack = player:WaitForChild("Backpack")
	local found = false

	for _, item in pairs(backpack:GetChildren()) do
		if item.Name == "Pear" then
			found = true
			print("🍐 Found Pear:", item)

			-- Try direct instance
			local s1 = pcall(function() events.SellFruit:FireServer(item) end)
			print("🔁 Try 1 [Instance]:", s1 and "✅" or "❌")

			-- Try name string
			local s2 = pcall(function() events.SellFruit:FireServer("Pear") end)
			print("🔁 Try 2 [String]:", s2 and "✅" or "❌")

			-- Try structured table
			local s3 = pcall(function()
				events.SellFruit:FireServer({
					Name = "Pear",
					Weight = item:FindFirstChild("Weight") and item.Weight.Value or 1,
					ID = item:GetAttribute("ID") or tostring(item)
				})
			end)
			print("🔁 Try 3 [Table]:", s3 and "✅" or "❌")
		end
	end

	if not found then
		print("❌ No Pears found in Backpack to sell.")
	end
end)
