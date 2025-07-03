local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")

local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "FlyGUI"

-- Fly/Unfly Button
local flyBtn = Instance.new("TextButton", gui)
flyBtn.Size = UDim2.new(0, 200, 0, 50)
flyBtn.Position = UDim2.new(0.5, -100, 0.5, -25)
flyBtn.Text = "Fly"
flyBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
flyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
flyBtn.Font = Enum.Font.SourceSansBold
flyBtn.TextSize = 24

-- Close Button
local xBtn = Instance.new("TextButton", gui)
xBtn.Size = UDim2.new(0, 40, 0, 40)
xBtn.Position = UDim2.new(1, -50, 0, 10)
xBtn.Text = "X"
xBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
xBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
xBtn.Font = Enum.Font.SourceSansBold
xBtn.TextSize = 22

-- Fly logic
local flying = false
local bodyVel

flyBtn.MouseButton1Click:Connect(function()
	if not flying then
		bodyVel = Instance.new("BodyVelocity")
		bodyVel.Velocity = Vector3.new(0, 50, 0)
		bodyVel.MaxForce = Vector3.new(0, math.huge, 0)
		bodyVel.P = 1250
		bodyVel.Name = "FlyForce"
		bodyVel.Parent = rootPart
		flyBtn.Text = "Unfly"
		flying = true
	else
		if bodyVel and bodyVel.Parent then
			bodyVel:Destroy()
		end
		flyBtn.Text = "Fly"
		flying = false
	end
end)

xBtn.MouseButton1Click:Connect(function()
	if bodyVel and bodyVel.Parent then
		bodyVel:Destroy()
	end
	gui:Destroy()
end)
