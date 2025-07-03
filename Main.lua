local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local rs = game:GetService("ReplicatedStorage")
local events = rs:WaitForChild("GameEvents")

-- Replace with your actual dialogue RemoteEvent name if different
local dialogueRemote = events:FindFirstChild("DialogueChoice") or events:FindFirstChild("Dialogue")

-- Sell zone position (your saved coordinate)
local SELL_POS = Vector3.new(86.6, 3.0, 0.4)

-- GUI setup
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "SellInventoryGUI"
gui.ResetOnSpawn = false

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0, 180, 0, 45)
btn.Position = UDim2.new(1, -200, 1, -60)
btn.BackgroundColor3 = Color3.fromRGB(255, 153, 51)
btn.TextColor3 = Color3.new(1, 1, 1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 18
btn.Text = "💰 Sell Inventory"
btn.Parent = gui

btn.MouseButton1Click:Connect(function()
	print("💬 Sell Inventory button clicked!")

	-- Step 1: Teleport to seller
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if hrp then
		hrp.CFrame = CFrame.new(SELL_POS)
		print("🚶 Teleported to seller at", SELL_POS)
	end

	task.wait(1.5) -- Let teleport settle

	-- Step 2: Trigger dialogue option 1
	if dialogueRemote then
		pcall(function()
			dialogueRemote:FireServer(1)
			print("🗨️ Sent dialogue choice: 1 (Sell All Inventory)")
		end)
	else
		warn("⚠️ Dialogue RemoteEvent not found.")
	end
end)
