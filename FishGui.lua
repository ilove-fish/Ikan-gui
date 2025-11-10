local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 220, 0, 260)
Frame.Position = UDim2.new(0.05, 0, 0.3, 0)
Frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
Frame.Active = true
Frame.Draggable = true

local BG = Instance.new("ImageLabel", Frame)
BG.Size = UDim2.new(1,0,1,0)
BG.Position = UDim2.new(0,0,0,0)
BG.Image = "rbxassetid://176345216"
BG.BackgroundTransparency = 1
BG.ImageTransparency = 0.25

function MakeButton(txt, y)
    local b = Instance.new("TextButton", Frame)
    b.Size = UDim2.new(1, -20, 0, 35)
    b.Position = UDim2.new(0, 10, 0, y)
    b.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    b.TextColor3 = Color3.new(1,1,1)
    b.Text = txt
    b.Font = Enum.Font.SourceSansBold
    b.TextSize = 18
    return b
end

local ESPbtn = MakeButton("ESP: OFF", 10)
local FBbtn = MakeButton("FullBright: OFF", 55)
local INTbtn = MakeButton("Instant Interact: OFF", 100)
local FLYbtn = MakeButton("Fly: RUN", 145)

------------------------------------------------
-- VARIABEL
local espEnabled = false
local fbEnabled = false
local iiEnabled = false

-------------------------------------------------
-- ESP SYSTEM
local Players = game:GetService("Players")
local Holder = Instance.new("Folder", game.CoreGui)
Holder.Name = "ESP_Holder"

local function AddESP(player)
    player.CharacterAdded:Connect(function(char)
        repeat task.wait() until char:FindFirstChild("HumanoidRootPart")

        if not espEnabled then return end

        local highlight = Instance.new("Highlight", char)
        highlight.FillColor = Color3.fromRGB(255,0,0)
        highlight.OutlineColor = Color3.fromRGB(255,255,255)
        highlight.Adornee = char
    end)
end

local function ToggleESP()
    espEnabled = not espEnabled
    ESPbtn.Text = "ESP: " .. (espEnabled and "ON" or "OFF")

    if not espEnabled then
        for _,plr in pairs(Players:GetPlayers()) do
            if plr.Character and plr.Character:FindFirstChild("Highlight") then
                plr.Character.Highlight:Destroy()
            end
        end
        return
    end

    for _,plr in pairs(Players:GetPlayers()) do
        AddESP(plr)
        if plr.Character then
            local highlight = Instance.new("Highlight", plr.Character)
            highlight.FillColor = Color3.fromRGB(255,0,0)
            highlight.OutlineColor = Color3.fromRGB(255,255,255)
            highlight.Adornee = plr.Character
        end
    end
end

for _,plr in pairs(Players:GetPlayers()) do AddESP(plr) end
Players.PlayerAdded:Connect(AddESP)

ESPbtn.MouseButton1Click:Connect(ToggleESP)

-------------------------------------------------
-- FULLBRIGHT
local Lighting = game:GetService("Lighting")
local normal = {
    Brightness = Lighting.Brightness,
    ClockTime = Lighting.ClockTime,
    Ambient = Lighting.Ambient
}

local function ToggleFB()
    fbEnabled = not fbEnabled
    FBbtn.Text = "FullBright: " .. (fbEnabled and "ON" or "OFF")

    if fbEnabled then
        Lighting.Brightness = 1
        Lighting.ClockTime = 12
        Lighting.Ambient = Color3.new(1,1,1)
    else
        Lighting.Brightness = normal.Brightness
        Lighting.ClockTime = normal.ClockTime
        Lighting.Ambient = normal.Ambient
    end
end

FBbtn.MouseButton1Click:Connect(ToggleFB)

-------------------------------------------------
-- INSTANT INTERACT
local PPS = game:GetService("ProximityPromptService")

local function ToggleII()
    iiEnabled = not iiEnabled
    INTbtn.Text = "Instant Interact: " .. (iiEnabled and "ON" or "OFF")

    if iiEnabled then
        PPS.PromptButtonHoldBegan:Connect(function(prompt)
            pcall(fireproximityprompt, prompt)
        end)
    end
end

INTbtn.MouseButton1Click:Connect(ToggleII)

-------------------------------------------------
-- FLY BUTTON
FLYbtn.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
end)
