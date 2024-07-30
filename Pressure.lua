local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Limpan's Pressure", "Synapse")

local MainTab = Window:NewTab("Main")
local LightingSection = MainTab:NewSection("Lighting")
local BasicSection = MainTab:NewSection("Basics")
local ExtraSection = MainTab:NewSection("Extras")

-- Fullbright feature
LightingSection:NewButton("Fullbright", "", function()
    if not _G.FullBrightExecuted then

        _G.FullBrightEnabled = false

        _G.NormalLightingSettings = {
            Brightness = game:GetService("Lighting").Brightness,
            ClockTime = game:GetService("Lighting").ClockTime,
            FogEnd = game:GetService("Lighting").FogEnd,
            GlobalShadows = game:GetService("Lighting").GlobalShadows,
            Ambient = game:GetService("Lighting").Ambient
        }

        game:GetService("Lighting"):GetPropertyChangedSignal("Brightness"):Connect(function()
            if game:GetService("Lighting").Brightness ~= 1 and game:GetService("Lighting").Brightness ~= _G.NormalLightingSettings.Brightness then
                _G.NormalLightingSettings.Brightness = game:GetService("Lighting").Brightness
                if not _G.FullBrightEnabled then
                    repeat
                        wait()
                    until _G.FullBrightEnabled
                end
                game:GetService("Lighting").Brightness = 1
            end
        end)

        game:GetService("Lighting"):GetPropertyChangedSignal("ClockTime"):Connect(function()
            if game:GetService("Lighting").ClockTime ~= 12 and game:GetService("Lighting").ClockTime ~= _G.NormalLightingSettings.ClockTime then
                _G.NormalLightingSettings.ClockTime = game:GetService("Lighting").ClockTime
                if not _G.FullBrightEnabled then
                    repeat
                        wait()
                    until _G.FullBrightEnabled
                end
                game:GetService("Lighting").ClockTime = 12
            end
        end)

        game:GetService("Lighting"):GetPropertyChangedSignal("FogEnd"):Connect(function()
            if game:GetService("Lighting").FogEnd ~= 786543 and game:GetService("Lighting").FogEnd ~= _G.NormalLightingSettings.FogEnd then
                _G.NormalLightingSettings.FogEnd = game:GetService("Lighting").FogEnd
                if not _G.FullBrightEnabled then
                    repeat
                        wait()
                    until _G.FullBrightEnabled
                end
                game:GetService("Lighting").FogEnd = 786543
            end
        end)

        game:GetService("Lighting"):GetPropertyChangedSignal("GlobalShadows"):Connect(function()
            if game:GetService("Lighting").GlobalShadows ~= false and game:GetService("Lighting").GlobalShadows ~= _G.NormalLightingSettings.GlobalShadows then
                _G.NormalLightingSettings.GlobalShadows = game:GetService("Lighting").GlobalShadows
                if not _G.FullBrightEnabled then
                    repeat
                        wait()
                    until _G.FullBrightEnabled
                end
                game:GetService("Lighting").GlobalShadows = false
            end
        end)

        game:GetService("Lighting"):GetPropertyChangedSignal("Ambient"):Connect(function()
            if game:GetService("Lighting").Ambient ~= Color3.fromRGB(178, 178, 178) and game:GetService("Lighting").Ambient ~= _G.NormalLightingSettings.Ambient then
                _G.NormalLightingSettings.Ambient = game:GetService("Lighting").Ambient
                if not _G.FullBrightEnabled then
                    repeat
                        wait()
                    until _G.FullBrightEnabled
                end
                game:GetService("Lighting").Ambient = Color3.fromRGB(178, 178, 178)
            end
        end)

        game:GetService("Lighting").Brightness = 1
        game:GetService("Lighting").ClockTime = 12
        game:GetService("Lighting").FogEnd = 786543
        game:GetService("Lighting").GlobalShadows = false
        game:GetService("Lighting").Ambient = Color3.fromRGB(178, 178, 178)

        local LatestValue = true
        spawn(function()
            repeat
                wait()
            until _G.FullBrightEnabled
            while wait() do
                if _G.FullBrightEnabled ~= LatestValue then
                    if not _G.FullBrightEnabled then
                        game:GetService("Lighting").Brightness = _G.NormalLightingSettings.Brightness
                        game:GetService("Lighting").ClockTime = _G.NormalLightingSettings.ClockTime
                        game:GetService("Lighting").FogEnd = _G.NormalLightingSettings.FogEnd
                        game:GetService("Lighting").GlobalShadows = _G.NormalLightingSettings.GlobalShadows
                        game:GetService("Lighting").Ambient = _G.NormalLightingSettings.Ambient
                    else
                        game:GetService("Lighting").Brightness = 1
                        game:GetService("Lighting").ClockTime = 12
                        game:GetService("Lighting").FogEnd = 786543
                        game:GetService("Lighting").GlobalShadows = false
                        game:GetService("Lighting").Ambient = Color3.fromRGB(178, 178, 178)
                    end
                    LatestValue = not LatestValue
                end
            end
        end)
    end

    _G.FullBrightExecuted = true
    _G.FullBrightEnabled = not _G.FullBrightEnabled
end)

-- Noclip feature
BasicSection:NewButton("Noclip", "", function()
    local StealthMode = true

    local Indicator

    if not StealthMode then
        local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
        Indicator = Instance.new("TextLabel", ScreenGui)
        Indicator.AnchorPoint = Vector2.new(0, 1)
        Indicator.Position = UDim2.new(0, 0, 1, 0)
        Indicator.Size = UDim2.new(0, 200, 0, 50)
        Indicator.BackgroundTransparency = 1
        Indicator.TextScaled = true
        Indicator.TextStrokeTransparency = 0
        Indicator.TextColor3 = Color3.new(0, 0, 0)
        Indicator.TextStrokeColor3 = Color3.new(1, 1, 1)
        Indicator.Text = "Noclip: Enabled"
    end

    local noclip = true
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()

    while true do
        player = game.Players.LocalPlayer
        character = player.Character

        if noclip then
            for _, v in pairs(character:GetDescendants()) do
                pcall(function()
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end)
            end
        end

        game:GetService("RunService").Stepped:wait()
    end
end)

-- Monster Notification feature
ExtraSection:NewToggle("Notify Monster", "Toggle monster notifications", function(state)
    _G.MonsterNotify = state
end)

-- Key Chams feature
local KeyChams = {}
ExtraSection:NewToggle("Key Chams (Color Red)", "Toggle key chams", function(state)
    for i, v in pairs(KeyChams) do
        v.Enabled = state
    end
    _G.KeyChamsEnabled = state
end)

local function applykey(inst)
    task.wait()
    local Cham = Instance.new("Highlight")
    Cham.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Cham.FillColor = Color3.new(1, 0, 0) 
    Cham.FillTransparency = 0
    Cham.OutlineColor = Color3.new(1, 0, 0) 
    Cham.Parent = game:GetService("CoreGui")
    Cham.Adornee = inst
    Cham.Enabled = _G.KeyChamsEnabled
    Cham.RobloxLocked = true
    return Cham
end

local keycor = coroutine.create(function()
    workspace.Rooms.DescendantAdded:Connect(function(inst)
        if inst.Name == "NormalKeyCard" then
            table.insert(KeyChams, applykey(inst))
        end
    end)
end)

for i, v in ipairs(workspace.Rooms:GetDescendants()) do
    if v.Name == "NormalKeyCard" then
        table.insert(KeyChams, applykey(v))
    end
end
coroutine.resume(keycor)

-- Medkit Chams feature
local MedkitChams = {}
ExtraSection:NewToggle("Medkit Chams (Color Blue)", "Toggle medkit chams", function(state)
    for i, v in pairs(MedkitChams) do
        v.Enabled = state
    end
    _G.MedkitChamsEnabled = state
end)

local function applymedkit(inst)
    task.wait()
    local Cham = Instance.new("Highlight")
    Cham.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Cham.FillColor = Color3.new(0, 0, 1)
    Cham.FillTransparency = 0
    Cham.OutlineColor = Color3.new(0, 0, 1)
    Cham.Parent = game:GetService("CoreGui")
    Cham.Adornee = inst
    Cham.Enabled = _G.MedkitChamsEnabled
    Cham.RobloxLocked = true
    return Cham
end

local medkitcor = coroutine.create(function()
    workspace.Rooms.DescendantAdded:Connect(function(inst)
        if inst.Name == "Medkit" then
            table.insert(MedkitChams, applymedkit(inst))
        end
    end)
end)

for i, v in ipairs(workspace.Rooms:GetDescendants()) do
    if v.Name == "Medkit" then
        table.insert(MedkitChams, applymedkit(v))
    end
end
coroutine.resume(medkitcor)

-- Monster notification
workspace.ChildAdded:Connect(function(inst)
    local monsters = {
        ["Angler"] = "Angler",
        ["Froger"] = "Froger",
        ["A60"] = "A60",
        ["Pandemonium"] = "Pandemonium",
        ["Blitz"] = "Blitz",
        ["Chainsmoker"] = "Chainsmoker",
        ["Pinkie"] = "Pinkie"
    }

    if monsters[inst.Name] and _G.MonsterNotify then
        local StarterGui = game:GetService("StarterGui")
        StarterGui:SetCore("SendNotification", {
            Title = "Monster Alert",
            Text = "A " .. monsters[inst.Name] .. " has spawned! Go hide!",
            Duration = 5
        })
    end
end)
