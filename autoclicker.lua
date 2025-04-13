local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local mouse = play:GetMouse()

local clickInterval = 0.001
local isClicking = false

local function onInputBegan(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isClicking = true
        spawn(function()
            while isClicking do
                mouse:Click()
                wait(clickInterval)
            end
        end)
    end
end

local function onInputEnded(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isClicking = false
    end
end

UserInputService.InputBegan:Connect(onInputBegan)
UserInputService.InputBegan:Connect(onInputEnded)