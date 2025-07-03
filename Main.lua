local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

-- GUI setup
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "LocationButtonGUI"
gui.ResetOnSpawn = false

-- Button config
local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0, 180, 0, 35)
btn.Position = UDim2.new(1, -190, 0, 10) -- Top-right corner
btn.AnchorPoint = Vector2.new(0, 0)
btn.BackgroundColor3 = Color3.fromRGB(0, 160, 255)
btn.TextColor3 = Color3.new(1, 1, 1)
btn.Font = Enum.Font.Gotham
btn.TextSize = 18
btn.Text = "📍 Copy Location"
btn.Parent = gui

-- Click logic
btn.MouseButton1Click:Connect(function()
	local pos = hrp.Position
	local coordStr = string.format("Vector3.new(%.1f, %.1f, %.1f)", pos.X, pos.Y, pos.Z)

	-- Say the position in chat
	pcall(function()
		player:Chat("🧭 My position is: " .. coordStr)
	end)

	-- Copy to clipboard (executor must support this)
	if setclipboard then
		setclipboard(coordStr)
		print("📋 Copied to clipboard:", coordStr)
	else
		warn("⚠️ setclipboard is not supported in this executor.")
	end
end)
