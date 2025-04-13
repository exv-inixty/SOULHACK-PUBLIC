local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

repeat wait() until player.Character and player.Character:FindFirstChild("HumanoidRootPart")
local mouse = player:GetMouse()
local character = player.Character
local hrp = character:WaitForChild("HumanoidRootPart")

local attachmentStart = Instance.new("Attachment", hrp)
attachmentStart.Name = "StartAttachment"

local attachmentEnd = Instance.new("Attachment", workspace)
attachmentEnd.Name = "EndAttachment"

local beam = Instance.new("Beam")
beam.Attachment0 = attachmentStart
beam.Attachment1 = attachmentEnd
beam.FaceCamera = true
beam.Width0 = 0.1
beam.Width1 = 0.1
beam.Color = ColorSequence.new(Color3.new(173, 216, 230))
beam.Transparency = NumberSequence.new(0)
beam.Parent = hrp

RunService.RenderStepped:Connect(function()
    if mouse and mouse.Target then
        local targetPos = mouse.Hit.Position
        attachmentEnd.WorldPosition = targetPos
    end
end)