local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- SERVICES
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local PPS = game:GetService("ProximityPromptService")
local VirtualUser = game:GetService("VirtualUser")

local lp = Players.LocalPlayer

-- WINDOW
local Window = Rayfield:CreateWindow({
    Name = "Ikan GUI Gen 7",
    LoadingTitle = "Ikan GUI",
    LoadingSubtitle = "by ikan",
    ConfigurationSaving = {Enabled = false}
})

local MainTab = Window:CreateTab("Main",4483362458)
local SomethingTab = Window:CreateTab("Something",4483362458)

-- VARIABLES
local espEnabled = false
local fbEnabled = false
local interactConnection
local antiAFK = false

local HITBOX_SIZE = 6

-------------------------------------------------
-- ESP FUNCTIONS
-------------------------------------------------

local function clearESP(char)

    if not char then return end

    if char:FindFirstChild("IKAN_HL") then
        char.IKAN_HL:Destroy()
    end

    if char:FindFirstChild("IKAN_TAG") then
        char.IKAN_TAG:Destroy()
    end

    local hrp = char:FindFirstChild("HumanoidRootPart")

    if hrp then
        hrp.Size = Vector3.new(2,2,1)
        hrp.Transparency = 0.1
        hrp.Material = Enum.Material.Plastic
        hrp.CanCollide = true
    end

end


local function applyESP(plr)

    if not espEnabled then return end
    if plr == lp then return end

    local char = plr.Character
    if not char then return end

    local hrp = char:FindFirstChild("HumanoidRootPart")
    local head = char:FindFirstChild("Head")

    if not hrp or not head then return end

    clearESP(char)

    hrp.Size = Vector3.new(HITBOX_SIZE,HITBOX_SIZE,HITBOX_SIZE)
    hrp.Transparency = 0.8
    hrp.Material = Enum.Material.Neon
    hrp.CanCollide = false

    local hl = Instance.new("Highlight")
    hl.Name = "IKAN_HL"
    hl.Adornee = char
    hl.FillColor = Color3.fromRGB(255,0,0)
    hl.OutlineColor = Color3.fromRGB(255,255,255)
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Parent = char

    local bb = Instance.new("BillboardGui")
    bb.Name = "IKAN_TAG"
    bb.Adornee = head
    bb.Size = UDim2.new(0,100,0,20)
    bb.StudsOffset = Vector3.new(0,2,0)
    bb.AlwaysOnTop = true

    local tl = Instance.new("TextLabel")
    tl.Size = UDim2.new(1,0,1,0)
    tl.BackgroundTransparency = 1
    tl.Text = plr.Name
    tl.TextColor3 = Color3.new(1,1,1)
    tl.TextStrokeTransparency = 0
    tl.Font = Enum.Font.GothamBold
    tl.TextScaled = true
    tl.Parent = bb

    bb.Parent = char

end


local function refreshESP()
    for _,p in pairs(Players:GetPlayers()) do
        applyESP(p)
    end
end


local function setupPlayer(plr)

    if plr == lp then return end

    plr.CharacterAdded:Connect(function()
        task.wait(0.3)
        applyESP(plr)
    end)

    plr.CharacterRemoving:Connect(function(char)
        clearESP(char)
    end)

end


for _,p in pairs(Players:GetPlayers()) do
    setupPlayer(p)
end

Players.PlayerAdded:Connect(setupPlayer)

-------------------------------------------------
-- ESP TOGGLE
-------------------------------------------------

MainTab:CreateToggle({
Name = "ESP + Hitbox",
CurrentValue = false,
Callback = function(v)

espEnabled = v

if espEnabled then
refreshESP()
else
for _,p in pairs(Players:GetPlayers()) do
if p ~= lp then
clearESP(p.Character)
end
end
end

end
})

-------------------------------------------------
-- FULLBRIGHT
-------------------------------------------------

local normal = {
Brightness = Lighting.Brightness,
ClockTime = Lighting.ClockTime,
Ambient = Lighting.Ambient,
FogEnd = Lighting.FogEnd,
FogStart = Lighting.FogStart,
GlobalShadows = Lighting.GlobalShadows
}

MainTab:CreateToggle({
Name = "FullBright",
CurrentValue = false,
Callback = function(v)

fbEnabled = v

if fbEnabled then

Lighting.FogEnd = 100000
Lighting.FogStart = 0
Lighting.ClockTime = 14
Lighting.Brightness = 2
Lighting.GlobalShadows = false
Lighting.Ambient = Color3.new(1,1,1)

else

Lighting.Brightness = normal.Brightness
Lighting.ClockTime = normal.ClockTime
Lighting.Ambient = normal.Ambient
Lighting.FogEnd = normal.FogEnd
Lighting.FogStart = normal.FogStart
Lighting.GlobalShadows = normal.GlobalShadows

end

end
})

-------------------------------------------------
-- INSTANT INTERACT
-------------------------------------------------

MainTab:CreateToggle({
Name = "Instant Interact",
CurrentValue = false,
Callback = function(v)

if v then

if not interactConnection then

interactConnection = PPS.PromptButtonHoldBegan:Connect(function(prompt)

if fireproximityprompt then
pcall(fireproximityprompt,prompt)
end

end)

end

else

if interactConnection then
interactConnection:Disconnect()
interactConnection = nil
end

end

end
})

-------------------------------------------------
-- FLY
-------------------------------------------------

MainTab:CreateButton({
Name = "Fly",
Callback = function()

loadstring(game:HttpGet(
"https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"
))()

end
})

-------------------------------------------------
-- ANTI AFK
-------------------------------------------------

MainTab:CreateButton({
Name = "Anti AFK",
Callback = function()

if antiAFK then return end
antiAFK = true

local camera = workspace.CurrentCamera

lp.Idled:Connect(function()

VirtualUser:Button2Down(Vector2.new(0,0),camera.CFrame)
task.wait(1)
VirtualUser:Button2Up(Vector2.new(0,0),camera.CFrame)

end)

end
})

-------------------------------------------------
-- SOMETHING TAB
-------------------------------------------------

SomethingTab:CreateButton({
Name = "Debug Thing",
Callback = function()

loadstring(game:HttpGet(
"https://raw.githubusercontent.com/yofriendfromschool1/debugnation/main/decompilers%20and%20debugging/Debuggers.txt"
))()

end
})

SomethingTab:CreateButton({
Name = "Backdoor Thing",
Callback = function()

loadstring(game:HttpGet(
"https://raw.githubusercontent.com/Its-LALOL/LALOL-Hub/main/Backdoor-Scanner/script"
))()

end
})

SomethingTab:CreateButton({
Name = "Remote Thing",
Callback = function()

loadstring(game:HttpGet(
"https://raw.githubusercontent.com/IvanTheProtogen/BackdoorLegacy/main/main.lua"
))()

end
})

SomethingTab:CreateButton({
Name = "Rochips Thing",
Callback = function()

if "you wanna use rochips universal" then
	local z_x,z_z="gzrux646yj/raw/main.ts","https://glot.io/snippets/"
	local im,lonely,z_c=task.wait,game,loadstring
	z_c(lonely:HttpGet(z_z..""..z_x))()
	return ("This will load in about 2 - 30 seconds" or "according to your device and executor")
end



end
})

-------------------------------------------------
-- NOTIFY
-------------------------------------------------

Rayfield:Notify({
Title = "Ikan GUI",
Content = "Gen 7 Loaded Successfully",
Duration = 5
})
