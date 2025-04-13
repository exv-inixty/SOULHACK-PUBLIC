local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local jumpKey = Enum.KeyCode.Space -- Key to trigger the jump
local jumpCooldown = 0.1 -- Cooldown between jumps in seconds
local lastJumpTime = 0

local function canJump()
    return tick() - lastJumpTime >= jumpCooldown
end

local function onInputBegan(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == jumpKey then
        if canJump() and (humanoid.FloorMaterial == Enum.Material.Air or humanoid.MoveDirection.Magnitude > 0) then
            lastJumpTime = tick()
            humanoid.PlatformStand = true
            wait()
            humanoid.PlatformStand = false
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end

local function onCharacterAdded(character)
    humanoid = character:WaitForChild("Humanoid")
    rootPart = character:WaitForChild("HumanoidRootPart")
    UserInputService.InputBegan:Connect(onInputBegan)
end

onCharacterAdded(character)
player.CharacterAdded:Connect(onCharacterAdded)