local player = game.Players.LocalPlayer
local rs = game:GetService("ReplicatedStorage")
local events = rs:WaitForChild("GameEvents")
local char = player.Character or player.CharacterAdded:Wait()

-- UI Setup
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "SellPearButtonTeleport"
gui.ResetOnSpawn = false

-- Sell Zone Coordinates (Your real location)
local SELL_POS = Vector3.new(86.6, 3.0, 0.4)

-- Create button
local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0, 160, 0, 45)
btn.Position = UDim2.new(1, -180, 1, -60)
btn.AnchorPoint = Vector2.new(0, 0)
btn.BackgroundColor3 = Color3.fromRGB(241, 196, 15)
btn.TextColor3 = Color3.new(0, 0, 0)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 18
btn.Text = "📦 Teleport + Sell Pears"
btn.Parent = gui

-- Button logic
btn.MouseButton1Click:Connect(function()
	print("📦 Sell + Teleport clicked!")

	-- Step 1: Teleport
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if hrp then
		hrp.CFrame = CFrame.new(SELL_POS)
		print("🚀 Teleported to sell zone at", SELL_POS)
	else
		warn("⚠️ HumanoidRootPart not found.")
	end

	task.wait(1.5) -- Let teleport settle

	-- Step 2: Sell all Pears
	local backpack = player:FindFirstChild("Backpack")
	local found = false

	for _, item in pairs(backpack:GetChildren()) do
		if item.Name == "Pear" then
			found = true
			print("🍐 Attempting to sell:", item)

			local s1 = pcall(function() events.SellFruit:FireServer(item) end)
			print("🔁 Format 1 [Instance]:", s1 and "✅" or "❌")

			local s2 = pcall(function() events.SellFruit:FireServer("Pear") end)
			print("🔁 Format 2 [String]:", s2 and "✅" or "❌")

			local s3 = pcall(function()
				events.SellFruit:FireServer({
					Name = "Pear",
					Weight = item:FindFirstChild("Weight") and item.Weight.Value or 1,
					ID = item:GetAttribute("ID") or tostring(item)
				})
			end)
			print("🔁 Format 3 [Table]:", s3 and "✅" or "❌")
		end
	end

	if not found then
		print("❌ No Pears found in Backpack.")
	end
end)
