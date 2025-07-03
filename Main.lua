-- Get necessary services
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create the GUI container
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "HamburgerGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Create Hello Button
local helloBtn = Instance.new("TextButton")
helloBtn.Size = UDim2.new(0, 200, 0, 50)
helloBtn.Position = UDim2.new(0.5, -100, 0.5, -25)
helloBtn.Text = "Say Hello"
helloBtn.Font = Enum.Font.SourceSansBold
helloBtn.TextSize = 24
helloBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
helloBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
helloBtn.Parent = screenGui

-- Create Close (X) Button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Position = UDim2.new(1, -50, 0, 10)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.TextSize = 22
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Parent = screenGui

-- Custom fake chat label (acts like system message)
local chatMsg = Instance.new("TextLabel")
chatMsg.Visible = false
chatMsg.Size = UDim2.new(0, 300, 0, 30)
chatMsg.Position = UDim2.new(0.5, -150, 0.5, 40)
chatMsg.BackgroundTransparency = 1
chatMsg.TextColor3 = Color3.new(1, 1, 1)
chatMsg.TextScaled = true
chatMsg.Font = Enum.Font.SourceSansItalic
chatMsg.Text = "[HelloGUI] Hello, world!"
chatMsg.Parent = screenGui

-- Click behavior for Hello Button
helloBtn.MouseButton1Click:Connect(function()
    chatMsg.Visible = true
    wait(3)
    chatMsg.Visible = false
end)

-- Click behavior for X Button
closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)
