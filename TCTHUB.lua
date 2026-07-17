local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("RobloxGuiBubbleChatService") then
    CoreGui.RobloxGuiBubbleChatService:Destroy()
end

local Theme = {
    Background = Color3.fromRGB(20, 20, 20),
    Header = Color3.fromRGB(180, 0, 0),
    Text = Color3.fromRGB(255, 255, 255),
    Button = Color3.fromRGB(40, 40, 40),
    ButtonHover = Color3.fromRGB(60, 40, 40)
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TCTHubMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 280, 0, 320)
MainFrame.Position = UDim2.new(0.05, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Theme.Background
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundColor3 = Theme.Header
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 8)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "TCTHUB MENU"
Title.TextColor3 = Theme.Text
Title.TextSize = 18
Title.Font = Enum.Font.SourceSansBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 40, 0, 40)
CloseButton.Position = UDim2.new(1, -40, 0, 0)
CloseButton.BackgroundTransparency = 1
CloseButton.Text = "X"
CloseButton.TextColor3 = Theme.Text
CloseButton.TextSize = 18
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.Parent = Header

CloseButton.MouseButton1Click:Connect(function()
    local fadeTween = TweenService:Create(MainFrame, TweenInfo.new(0.3), {BackgroundTransparency = 1})
    fadeTween:Play()
    task.wait(0.3)
    ScreenGui:Destroy()
end)

local Container = Instance.new("ScrollingFrame")
Container.Name = "ButtonContainer"
Container.Size = UDim2.new(1, -20, 1, -55)
Container.Position = UDim2.new(0, 10, 0, 50)
Container.BackgroundTransparency = 1
Container.BorderSizePixel = 0
Container.ScrollBarThickness = 4
Container.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = Container

local function CreateMenuButton(text, order, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 0, 45)
    Button.BackgroundColor3 = Theme.Button
    Button.BorderSizePixel = 0
    Button.Text = text
    Button.TextColor3 = Theme.Text
    Button.TextSize = 14
    Button.Font = Enum.Font.SourceSansBold
    Button.LayoutOrder = order
    Button.Parent = Container

    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 6)
    ButtonCorner.Parent = Button

    Button.MouseEnter:Connect(function()
        Button.BackgroundColor3 = Theme.ButtonHover
    end)
    Button.MouseLeave:Connect(function()
        Button.BackgroundColor3 = Theme.Button
    end)
    Button.MouseButton1Click:Connect(callback)
    
    return Button
end

CreateMenuButton("SET SPEED MULTIPLIER (4x)", 1, function()
    local character = LocalPlayer.Character
    if character then
        LocalPlayer:SetAttribute("FishingSpeedMultiplier", 4)
    end
end)

CreateMenuButton("CLEAR LAGGY ROLLUI", 2, function()
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")
    if PlayerGui then
        for _, ui in ipairs(PlayerGui:GetChildren()) do
            if ui.Name == "Rollui" or ui.Name == "RollUIold" then
                ui:Destroy()
            end
        end
    end
end)

CreateMenuButton("TELEPORT TO BEACH", 3, function()
    local character = LocalPlayer.Character
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
    if rootPart then
        rootPart.CFrame = CFrame.new(85, 9, -362)
    end
end)
