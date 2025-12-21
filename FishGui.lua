
---

-- [1] IKAN GUI GENERASI 2
local Players = game:GetService("Players")
local lp = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "CenterTextGui"
gui.Parent = game.CoreGui

local text = Instance.new("TextLabel")
text.Parent = gui
text.Size = UDim2.new(0, 400, 0, 80)
text.Position = UDim2.new(0.5, -200, 0.5, -40)
text.BackgroundTransparency = 1
text.Text = "yang baca suka femboy"
text.TextColor3 = Color3.fromRGB(255, 255, 255)
text.TextScaled = true
text.Font = Enum.Font.GothamBold
text.TextStrokeTransparency = 0.3
text.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
text.ZIndex = 10

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

local ESPbtn  = MakeButton("ESP: OFF", 10)
local FBbtn   = MakeButton("FullBright: OFF", 55)
local INTbtn  = MakeButton("Instant Interact: OFF", 100)
local FLYbtn  = MakeButton("Fly: RUN", 145)
local AAFKbtn = MakeButton("Anti-AFK: RUN", 190)


---

-- VARIABEL

local espEnabled = false
local fbEnabled = false
local iiEnabled = false


---

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


---

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


---

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


---

-- FLY BUTTON

FLYbtn.MouseButton1Click:Connect(function()
loadstring(game:HttpGet(
"https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"
))()
end)


---

-- ANTI AFK BUTTON

AAFKbtn.MouseButton1Click:Connect(function()
loadstring(game:HttpGet(
"https://raw.githubusercontent.com/evxncodes/mainroblox/main/anti-afk",
true
))()
end)


---

-- [2] TOGGLE GUI (SEMBUNYI / MUNCUL)

local CoreGui = game:GetService("CoreGui")

local TargetGui
for _,v in pairs(CoreGui:GetChildren()) do
if v:IsA("ScreenGui") then
local f = v:FindFirstChildOfClass("Frame")
if f and f.Size == UDim2.new(0,220,0,260) then
TargetGui = v
break
end
end
end

if not TargetGui then
warn("GUI target tidak ditemukan")
return
end

local ToggleGui = Instance.new("ScreenGui", CoreGui)
ToggleGui.Name = "GuiToggleBtn"

local Btn = Instance.new("TextButton", ToggleGui)
Btn.Size = UDim2.new(0, 45, 0, 45)
Btn.Position = UDim2.new(0, 10, 0.5, -22)
Btn.BackgroundColor3 = Color3.fromRGB(30,30,30)
Btn.Text = "🐟"
Btn.TextColor3 = Color3.new(1,1,1)
Btn.Font = Enum.Font.GothamBold
Btn.TextSize = 24
Btn.Active = true
Btn.Draggable = true

Instance.new("UICorner", Btn).CornerRadius = UDim.new(1,0)

local visible = true
Btn.MouseButton1Click:Connect(function()
visible = not visible
TargetGui.Enabled = visible
end)

print("gatau mau nulis apa")
