-- UI/Menu.lua
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FeatureMenu"
screenGui.Parent = playerGui

local function createButton(text, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 200, 0, 50)
    button.Position = UDim2.new(0, 10, 0, 10 + (button.Size.Y.Offset + 10) * #screenGui:GetChildren())
    button.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Text = text
    button.Parent = screenGui

    button.MouseButton1Click:Connect(callback)
end

local function toggle()
    if screenGui.Enabled then
        screenGui.Enabled = false
    else
        screenGui.Enabled = true
    end
end

local function loadModule(moduleName)
    local module = require(game.ServerScriptService:WaitForChild(moduleName))
    return module
end

createButton("Autoclicker", function()
    loadModule("autoclicker")
end)

createButton("ESP", function()
    loadModule("esp")
end)

createButton("Fly (Bind: F)", function()
    loadModule("fly")
end)

createButton("Infinite Jump", function()
    loadModule("infinitejump")
end)

createButton("Killaura", function()
    loadModule("killaura")
end)

createButton("Lagmachine", function()
    loadModule("lagmachine")
end)

createButton("Spider", function()
    loadModule("spider")
end)

return {
    Toggle = toggle
}