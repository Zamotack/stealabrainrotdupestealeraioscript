--// HorizonV1 Script
-- Place this in a LocalScript under StarterGui

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "HorizonV1"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Frame (Main UI)
local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Size = UDim2.new(0, 280, 0, 200)
frame.Position = UDim2.new(0.5, -140, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

-- Title (Top)
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "HorizonV1"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 22
title.Parent = frame

-- Subtitle (Below Title)
local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, -20, 0, 30)
subtitle.Position = UDim2.new(0, 10, 0, 40)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Join Discord for the key"
subtitle.TextColor3 = Color3.fromRGB(200, 200, 200)
subtitle.Font = Enum.Font.SourceSans
subtitle.TextSize = 18
subtitle.Parent = frame

-- TextBox
local inputBox = Instance.new("TextBox")
inputBox.Size = UDim2.new(1, -20, 0, 35)
inputBox.Position = UDim2.new(0, 10, 0, 75)
inputBox.PlaceholderText = "Type key here..."
inputBox.Text = ""
inputBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
inputBox.Font = Enum.Font.SourceSans
inputBox.TextSize = 18
inputBox.Parent = frame

-- Check Key Button
local checkButton = Instance.new("TextButton")
checkButton.Size = UDim2.new(1, -20, 0, 35)
checkButton.Position = UDim2.new(0, 10, 0, 115)
checkButton.Text = "Check Key"
checkButton.BackgroundColor3 = Color3.fromRGB(80, 150, 80)
checkButton.TextColor3 = Color3.fromRGB(255, 255, 255)
checkButton.Font = Enum.Font.SourceSansBold
checkButton.TextSize = 18
checkButton.Parent = frame

-- Launch Script Button (hidden until correct key)
local launchButton = Instance.new("TextButton")
launchButton.Size = UDim2.new(1, -20, 0, 35)
launchButton.Position = UDim2.new(0, 10, 0, 155)
launchButton.Text = "Launch Script"
launchButton.TextColor3 = Color3.fromRGB(255, 255, 255)
launchButton.Font = Enum.Font.SourceSansBold
launchButton.TextSize = 18
launchButton.Visible = false
launchButton.Parent = frame

-- Warning Popup (hidden by default)
local warningFrame = Instance.new("Frame")
warningFrame.Name = "WarningPopup"
warningFrame.Size = UDim2.new(0, 240, 0, 150)
warningFrame.Position = UDim2.new(0.5, -120, 0.5, -75)
warningFrame.BackgroundColor3 = Color3.fromRGB(60, 30, 30)
warningFrame.Visible = false
warningFrame.Parent = screenGui

local warningLabel = Instance.new("TextLabel")
warningLabel.Size = UDim2.new(1, 0, 0, 60)
warningLabel.BackgroundTransparency = 1
warningLabel.Text = "❌ Incorrect key\nPlease join the Discord for assistance"
warningLabel.TextColor3 = Color3.fromRGB(255, 200, 200)
warningLabel.Font = Enum.Font.SourceSansBold
warningLabel.TextSize = 18
warningLabel.TextWrapped = true
warningLabel.Parent = warningFrame

local okButton = Instance.new("TextButton")
okButton.Size = UDim2.new(0.5, -10, 0, 35)
okButton.Position = UDim2.new(0, 10, 0, 100)
okButton.Text = "OK"
okButton.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
okButton.TextColor3 = Color3.fromRGB(255, 255, 255)
okButton.Font = Enum.Font.SourceSansBold
okButton.TextSize = 18
okButton.Parent = warningFrame

local discordPopupButton = Instance.new("TextButton")
discordPopupButton.Size = UDim2.new(0.5, -10, 0, 35)
discordPopupButton.Position = UDim2.new(0.5, 0, 0, 100)
discordPopupButton.Text = "Join Discord"
discordPopupButton.BackgroundColor3 = Color3.fromRGB(80, 80, 150)
discordPopupButton.TextColor3 = Color3.fromRGB(255, 255, 255)
discordPopupButton.Font = Enum.Font.SourceSansBold
discordPopupButton.TextSize = 18
discordPopupButton.Parent = warningFrame

-- Logic
local correctKey = "HorizonV1"
local discordLink = "https://discord.gg/rK47BUPJeZ"

-- Rainbow effect for Launch Button
local function rainbowButton(button)
    spawn(function()
        local hue = 0
        while button.Parent do
            hue = (hue + 0.01) % 1
            button.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
            task.wait(0.05)
        end
    end)
end

checkButton.MouseButton1Click:Connect(function()
    if inputBox.Text == correctKey then
        checkButton.Text = "Key Accepted!"
        checkButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        launchButton.Visible = true
        rainbowButton(launchButton) -- start rainbow effect once visible
    else
        frame.Visible = false
        warningFrame.Visible = true
    end
end)

launchButton.MouseButton1Click:Connect(function()
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Jake-Brock/Scripts/main/Fw%20SAB.lua"))()
    end)
    if success then
        screenGui:Destroy() -- kill UI if success
    else
        frame.Visible = false
        warningFrame.Visible = true
    end
end)

okButton.MouseButton1Click:Connect(function()
    warningFrame.Visible = false
    frame.Visible = true
end)

discordPopupButton.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(discordLink)
        discordPopupButton.Text = "Copied!"
    else
        discordPopupButton.Text = "Clipboard not supported"
    end
end)
