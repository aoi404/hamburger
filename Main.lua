local player = game.Players.LocalPlayer
local rs = game:GetService("ReplicatedStorage")
local events = rs:WaitForChild("GameEvents")
local char = player.Character or player.CharacterAdded:Wait()

-- GUI setup
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "SellAllButtonGUI"
gui.ResetOnSpawn = false

-- Your saved sell zone position
local SELL_POS = Vector3.new(86.6, 3.0, 0.4)

-- Create button
local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0, 180, 0, 45)
btn.Position = UDim2.new(1, -200, 1, -60)
btn.BackgroundColor3 = Color3.fromRGB(255, 112, 67)
btn.TextColor3 = Color3.new(1, 1, 1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 18
btn.Text = "🛒 Sell All Fruits"
btn.Parent = gui

-- Action logic
btn.MouseButton1Click:Connect(function()
	print("🛒 Sell All activated!")

	-- Teleport to sell zone
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if hrp then
		hrp.CFrame = CFrame.new(SELL_POS)
		print("🚀 Teleported to:", SELL_POS)
	end

	task.wait(1.5) -- Let teleport settle

	-- Iterate and sell everything in Backpack
	local backpack = player:FindFirstChild("Backpack")
	if not backpack then
		warn("⚠️ No Backpack found.")
		return
	end

	local count = 0
	for _, item in pairs(backpack:GetChildren()) do
		if item:IsA("Tool") or item:IsA("Folder") then
			count += 1
			print("🍎 Found item:", item.Name)

			-- Format 1: Instance
			local a = pcall(function() events.SellFruit:FireServer(item) end)
			print("🔁 Format 1 [Instance]:", a and "✅" or "❌")

			-- Format 2: String
			local b = pcall(function() events.SellFruit:FireServer(item.Name) end)
			print("🔁 Format 2 [String]:", b and "✅" or "❌")

			-- Format 3: Table
			local c = pcall(function()
				events.SellFruit:FireServer({
					Name = item.Name,
					Weight = item:FindFirstChild("Weight") and item.Weight.Value or 1,
					ID = item:GetAttribute("ID") or tostring(item)
				})
			end)
			print("🔁 Format 3 [Table]:", c and "✅" or "❌")
		end
	end

	if count == 0 then
		print("❌ No fruits found to sell.")
	else
		print("✅ Attempted to sell", count, "items.")
	end
end)
