--// Discord UI with Launch Script + Failure Warning
-- Place this in a LocalScript under StarterGui

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DiscordUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Frame (Main UI)
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 280, 0, 200)
frame.Position = UDim2.new(0.5, -140, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "Join Discord to get key"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20
title.Parent = frame

-- Label
local infoLabel = Instance.new("TextLabel")
infoLabel.Size = UDim2.new(1, -20, 0, 30)
infoLabel.Position = UDim2.new(0, 10, 0, 45)
infoLabel.BackgroundTransparency = 1
infoLabel.Text = "Enter your key below"
infoLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
infoLabel.Font = Enum.Font.SourceSans
infoLabel.TextSize = 18
infoLabel.Parent = frame

-- TextBox
local inputBox = Instance.new("TextBox")
inputBox.Size = UDim2.new(1, -20, 0, 35)
inputBox.Position = UDim2.new(0, 10, 0, 80)
inputBox.PlaceholderText = "Type here..."
inputBox.Text = ""
inputBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
inputBox.Font = Enum.Font.SourceSans
inputBox.TextSize = 18
inputBox.Parent = frame

-- Launch Script Button
local launchButton = Instance.new("TextButton")
launchButton.Size = UDim2.new(1, -20, 0, 35)
launchButton.Position = UDim2.new(0, 10, 0, 125)
launchButton.Text = "Launch Script"
launchButton.BackgroundColor3 = Color3.fromRGB(150, 80, 80)
launchButton.TextColor3 = Color3.fromRGB(255, 255, 255)
launchButton.Font = Enum.Font.SourceSansBold
launchButton.TextSize = 18
launchButton.Parent = frame

-- Discord Button
local discordButton = Instance.new("TextButton")
discordButton.Size = UDim2.new(1, -20, 0, 35)
discordButton.Position = UDim2.new(0, 10, 0, 165)
discordButton.Text = "Join Discord"
discordButton.BackgroundColor3 = Color3.fromRGB(80, 80, 150)
discordButton.TextColor3 = Color3.fromRGB(255, 255, 255)
discordButton.Font = Enum.Font.SourceSansBold
discordButton.TextSize = 18
discordButton.Parent = frame

-- Warning Popup (hidden by default)
local warningFrame = Instance.new("Frame")
warningFrame.Size = UDim2.new(0, 220, 0, 120)
warningFrame.Position = UDim2.new(0.5, -110, 0.5, -60)
warningFrame.BackgroundColor3 = Color3.fromRGB(60, 30, 30)
warningFrame.Visible = false
warningFrame.Parent = screenGui

local warningLabel = Instance.new("TextLabel")
warningLabel.Size = UDim2.new(1, 0, 0, 60)
warningLabel.BackgroundTransparency = 1
warningLabel.Text = "⚠️ Failed to launch script"
warningLabel.TextColor3 = Color3.fromRGB(255, 200, 200)
warningLabel.Font = Enum.Font.SourceSansBold
warningLabel.TextSize = 20
warningLabel.Parent = warningFrame

local okButton = Instance.new("TextButton")
okButton.Size = UDim2.new(0.5, -10, 0, 35)
okButton.Position = UDim2.new(0.25, 5, 0, 70)
okButton.Text = "OK"
okButton.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
okButton.TextColor3 = Color3.fromRGB(255, 255, 255)
okButton.Font = Enum.Font.SourceSansBold
okButton.TextSize = 18
okButton.Parent = warningFrame

-- Logic
local discordLink = "https://discord.gg/rK47BUPJeZ"

discordButton.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(discordLink)
        discordButton.Text = "Copied to clipboard!"
    else
        discordButton.Text = "Clipboard not supported"
    end
end)

launchButton.MouseButton1Click:Connect(function()
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Jake-Brock/Scripts/main/Fw%20SAB.lua"))()
    end)
    if success then
        screenGui:Destroy() -- kill UI if success
    else
        frame.Visible = false -- hide original UI
        warningFrame.Visible = true -- show warning popup
    end
end)

okButton.MouseButton1Click:Connect(function()
    warningFrame.Visible = false
    frame.Visible = true -- restore original UI
end)
