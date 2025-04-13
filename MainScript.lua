local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local toggleKey = Enum.KeyCode.M -- Changed to "M" key

local function loadModule(moduleName)
    local module = require(game.ServerScriptService:WaitForChild(moduleName))
    return module
end

local function onInputBegan(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == toggleKey then
        local menu = loadModule("UI.Menu")
        menu:Toggle()
    end
end

UserInputService.InputBegan:Connect(onInputBegan)