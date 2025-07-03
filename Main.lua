local player = game.Players.LocalPlayer
local rs = game:GetService("ReplicatedStorage")
local events = rs:WaitForChild("GameEvents")
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

-- GUI setup
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "SellPearHelper"

-- Sell button
local sellBtn = Instance.new("TextButton", gui)
sellBtn.Size = UDim2.new(0, 200, 0, 50)
sellBtn.Position = UDim2.new(0.5, -100, 0.5, -60)
sellBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
sellBtn.TextColor3 = Color3.new(1, 1, 1)
sellBtn.Font = Enum.Font.SourceSansBold
sellBtn.TextSize = 22
sellBtn.Text = "🍐 Sell Pears"

-- Location display label
local positionLabel = Instance.new("TextLabel", gui)
positionLabel.Size = UDim2.new(0, 300, 0, 25)
positionLabel.Position = UDim2.new(0.5, -150, 0.5, 0)
positionLabel.BackgroundTransparency = 1
positionLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
positionLabel.Font = Enum.Font.Code
positionLabel.TextSize = 20
positionLabel.Text = "📍 Position: ..."

-- Update position live
task.spawn(function()
	while true do
		task.wait(1)
		local pos = hrp.Position
		positionLabel.Text = string.format("📍 Position: (%.1f, %.1f, %.1f)", pos.X, pos.Y, pos.Z)
	end
end)

-- Sell logic
sellBtn.MouseButton1Click:Connect(function()
	local backpack = player:WaitForChild("Backpack")
	local found = false

	for _, item in pairs(backpack:GetChildren()) do
		if item.Name == "Pear" then
			found = true
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

	if not found then
		print("❌ No Pears found in Backpack.")
	end
end)
