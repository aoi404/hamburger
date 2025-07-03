local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer

-- Create screen GUI
local gui = Instance.new("ScreenGui")
gui.Name = "HelloGUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Create the Hello Button
local helloBtn = Instance.new("TextButton")
helloBtn.Parent = gui
helloBtn.Size = UDim2.new(0, 200, 0, 50)
helloBtn.Position = UDim2.new(0.5, -100, 0.5, -25)
helloBtn.Text = "Say Hello"
helloBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
helloBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
helloBtn.Font = Enum.Font.SourceSans
helloBtn.TextSize = 24

-- When Hello is clicked, show a system message in chat
helloBtn.MouseButton1Click:Connect(function()
    StarterGui:SetCore("ChatMakeSystemMessage", {
        Text = "[HelloGUI] Hello, world!";
        Color = Color3.new(0, 1, 1);
        Font = Enum.Font.SourceSansBold;
        FontSize = Enum.FontSize.Size24;
    })
end)

-- Create the X (Close) Button
local xBtn = Instance.new("TextButton")
xBtn.Parent = gui
xBtn.Size = UDim2.new(0, 40, 0, 40)
xBtn.Position = UDim2.new(1, -50, 0, 10)
xBtn.Text = "X"
xBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
xBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
xBtn.Font = Enum.Font.SourceSansBold
xBtn.TextSize = 22

-- When X is clicked, remove the GUI
xBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)
