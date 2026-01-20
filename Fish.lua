-- generasi 4
-- SERVICES
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local PPS = game:GetService("ProximityPromptService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

local lp = Players.LocalPlayer

--==================================================
-- GUI UTAMA
--==================================================
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "IkanGuiGen3"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 220, 0, 260)
Frame.Position = UDim2.new(0.05, 0, 0.3, 0)
Frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
Frame.Active = true
Frame.Draggable = true

local BG = Instance.new("ImageLabel", Frame)
BG.Size = UDim2.new(1,0,1,0)
BG.BackgroundTransparency = 1
BG.ImageTransparency = 0.25
BG.Image = "rbxassetid://176345216"

local function MakeButton(txt, y)
    local b = Instance.new("TextButton", Frame)
    b.Size = UDim2.new(1, -20, 0, 35)
    b.Position = UDim2.new(0, 10, 0, y)
    b.BackgroundColor3 = Color3.fromRGB(35,35,35)
    b.TextColor3 = Color3.new(1,1,1)
    b.Text = txt
    b.Font = Enum.Font.SourceSansBold
    b.TextSize = 18
    return b
end

local ESPbtn  = MakeButton("ESP: OFF", 10)
local FBbtn   = MakeButton("FullBright: OFF", 55)
local INTbtn  = MakeButton("Instant Interact: OFF", 100)
local FLYbtn  = MakeButton("Fly: RUN", 145)
local AAFKbtn = MakeButton("Anti-AFK: RUN", 190)

--==================================================
-- VAR
--==================================================
local espEnabled = false
local fbEnabled = false
local iiEnabled = false

--==================================================
-- ESP + NAMETAG + HITBOX
--==================================================
local ESPFolder = Instance.new("Folder", CoreGui)
ESPFolder.Name = "IKAN_ESP"

local HITBOX_SIZE = 6

local function clearESP(char)
    if not char then return end
    if char:FindFirstChild("IKAN_HL") then
        char.IKAN_HL:Destroy()
    end
    if char:FindFirstChild("IKAN_TAG") then
        char.IKAN_TAG:Destroy()
    end
    if char:FindFirstChild("HumanoidRootPart") then
        local hrp = char.HumanoidRootPart
        hrp.Size = Vector3.new(2,2,1)
        hrp.Transparency = 0.1
        hrp.Material = Enum.Material.Plastic
        hrp.CanCollide = true
    end
end

local function applyESP(plr)
    if plr == lp then return end
    if not plr.Character then return end
    local char = plr.Character
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local head = char:FindFirstChild("Head")
    if not hrp or not head then return end

    -- HITBOX
    hrp.Size = Vector3.new(HITBOX_SIZE, HITBOX_SIZE, HITBOX_SIZE)
    hrp.Transparency = 0.8
    hrp.Material = Enum.Material.Neon
    hrp.CanCollide = false

    -- HIGHLIGHT
    local hl = Instance.new("Highlight")
    hl.Name = "IKAN_HL"
    hl.Adornee = char
    hl.FillColor = Color3.fromRGB(255,0,0)
    hl.OutlineColor = Color3.fromRGB(255,255,255)
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Parent = char

    -- NAMETAG
    local bb = Instance.new("BillboardGui")
    bb.Name = "IKAN_TAG"
    bb.Adornee = head
    bb.Size = UDim2.new(0,100,0,20)
    bb.StudsOffset = Vector3.new(1,1,1)
    bb.AlwaysOnTop = true

    local tl = Instance.new("TextLabel", bb)
    tl.Size = UDim2.new(0.5,0,0.5,0)
    tl.BackgroundTransparency = 1
    tl.Text = plr.Name
    tl.TextColor3 = Color3.new(1,1,1)
    tl.TextStrokeTransparency = 0
    tl.Font = Enum.Font.GothamBold
    tl.TextScaled = true

    bb.Parent = char
end

local function refreshESP()
    for _,p in pairs(Players:GetPlayers()) do
        if p.Character then
            clearESP(p.Character)
            if espEnabled then
                applyESP(p)
            end
        end
    end
end

ESPbtn.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    ESPbtn.Text = "ESP: " .. (espEnabled and "ON" or "OFF")
    refreshESP()
end)

Players.PlayerAdded:Connect(function(p)
    p.CharacterAdded:Connect(function()
        task.wait(0.5)
        if espEnabled then
            applyESP(p)
        end
    end)
end)

--==================================================
-- FULLBRIGHT
--==================================================
local normal = {
    Brightness = Lighting.Brightness,
    ClockTime = Lighting.ClockTime,
    Ambient = Lighting.Ambient
}

FBbtn.MouseButton1Click:Connect(function()
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
end)

--==================================================
-- INSTANT INTERACT
--==================================================
INTbtn.MouseButton1Click:Connect(function()
    iiEnabled = not iiEnabled
    INTbtn.Text = "Instant Interact: " .. (iiEnabled and "ON" or "OFF")
    if iiEnabled then
        PPS.PromptButtonHoldBegan:Connect(function(prompt)
            pcall(fireproximityprompt, prompt)
        end)
    end
end)

--==================================================
-- FLY
--==================================================
FLYbtn.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
end)

--==================================================
-- ANTI AFK
--==================================================
AAFKbtn.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet(
        "https://raw.githubusercontent.com/evxncodes/mainroblox/main/anti-afk",
        true
    ))()
end)

--==================================================
-- TOGGLE GUI BUTTON (FIX)
--==================================================
local ToggleGui = Instance.new("ScreenGui", CoreGui)
ToggleGui.Name = "IkanGuiToggle"

local TBtn = Instance.new("TextButton", ToggleGui)
TBtn.Size = UDim2.new(0,45,0,45)
TBtn.Position = UDim2.new(0,10,0.5,-22)
TBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
TBtn.Text = "🐟"
TBtn.TextColor3 = Color3.new(1,1,1)
TBtn.Font = Enum.Font.GothamBold
TBtn.TextSize = 24
TBtn.Active = true
TBtn.Draggable = true

Instance.new("UICorner", TBtn).CornerRadius = UDim.new(1,0)

local visible = true
TBtn.MouseButton1Click:Connect(function()
    visible = not visible
    ScreenGui.Enabled = visible
end)

print("IKAN GUI GEN 3 FIXED")
