local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local ServerBrowser = ReplicatedStorage:WaitForChild("__ServerBrowser")

local WEBHOOK_URL = "https://discord.com/api/webhooks/1376090071505305670/iv8Bs1Ovdqfw2o9M8hF8OSFZI3TwGW0oUuMr9gcZbjnotVfle_SnxR9BWNUeKk5aRwX7" -- Replace with your Discord webhook

local adjectives = {
    "Big", "Small", "Large", "Strong", "Powerful", "Weak", "Overpowered", "Bad", "Odd", "Rich",
    "Short", "Adorable", "Alive", "Colorful", "Angry", "Good", "Beautiful", "Ugly", "Hot", "Cold",
    "Evil", "Famous", "Original", "Unoriginal", "Kind", "Nice", "Real", "Expensive", "Wild", "Wide",
    "Fake", "Proud", "Super", "Strange", "Wrong", "Right", "Talented", "Complex", "Pure", "Fancy",
    "Lucky", "Fresh", "Fantastic", "Dull", "Dizzy", "Eternal", "Mental", "Infinite", "Rogue"
}

local nouns = {
    "TAWG", "Robson", "Krazy", "Fruit", "Realm", "World", "Place", "Experience", "Dog", "Cat",
    "Guy", "Bird", "Legion", "Gank", "Family", "Sun", "Moon", "Gun", "Sword", "Melee", "Defense",
    "Bomb", "Spike", "Chop", "Spring", "Smoke", "Flame", "Ice", "Sand", "Dark", "Light", "Rubber",
    "Barrier", "Magma", "Leopard", "Quake", "Buddha", "Spider", "Phoenix", "Rumble", "Love", "Door",
    "Paw", "Gravity", "Dough", "Venom", "Control", "Dragon", "Falcon", "Diamond", "Kilo", "Shark",
    "Human", "Angel", "Rabbit", "Spin", "Topic", "Red", "Blue", "Green", "Yellow", "Soul", "Shadow"
}

local function getName(jobId)
    local seed = tonumber("0x" .. jobId:gsub("-", ""):sub(1, 7)) or 0
    local random = Random.new(seed)
    local first = adjectives[random:NextInteger(1, #adjectives)]
    local second = nouns[random:NextInteger(1, #nouns)]
    local uniqueNumber = string.format("%04d", random:NextInteger(1, 9999))
    return first .. " " .. second .. " #" .. uniqueNumber
end

local function sendToWebhook(serverName)
    local data = {
        username = "Test1",
        content = "Generated Server Name: **" .. serverName .. "**"
    }
    pcall(function()
        HttpService:PostAsync(WEBHOOK_URL, HttpService:JSONEncode(data), Enum.HttpContentType.ApplicationJson)
    end)
end

local function getsrv()
    local jobId = ServerBrowser:InvokeServer("getjob")
    if jobId then
        local serverName = getName(jobId)
        sendToWebhook(serverName)
        return serverName
    else
        sendToWebhook("unknown err idk")
        return "unknown err idk"
    end
end

print("name:", getsrv())
