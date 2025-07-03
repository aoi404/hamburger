local Players = game:GetService("Players")
local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "HelloGUI"

local button = Instance.new("TextButton")
button.Parent = gui
button.Size = UDim2.new(0, 200, 0, 50)
button.Position = UDim2.new(0.5, -100, 0.5, -25)
button.Text = "Say Hello"
button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.SourceSans
button.TextSize = 24

button.MouseButton1Click:Connect(function()
    print("Hello from the button!")
end)
