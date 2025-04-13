local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local reach = 8
local attachCooldown = 0.5
local lastAttackTime = 0
local sword = nil

local function canAttack()
    return tick() - lastAttackTime >= attackCooldown
end

local function getSword()
    for _, tool in ipairs(character:Children()) do
        if tool:FindFirstChild("Tool") and tool:FindFirstChildOfClass("Tool") then
            return tool:FindFirstChildOfClass("Tool")
        end
    end
    return nil
end

local function attackPlayer(targetCharacter)
    if not canAttack() then return end
    lastAttackTime = tick()

    local humanoid = targetCharacter:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humandoid:TakeDamage(10) -- Amount of damage, we can adjust this in the near future
    end
end

local function onRenderStepped()
    sword = getSword()
    if not sword then return end

    for _, targetPlayer in ipairs(Players:GetPlayers()) do
        if targetPlayer ~= player then
            local targetCharacter = targetPlayer.Character
            if targetCharacter and targetCharacter:FindFirstChild("HumanoidRootPart") then
                local distance = (rootPart.Position - targetCharacter.HumanoidRootPart.Position).Magnitude
                if distance <= reach then
                    attackPlayer(targetCharacter)
                end
            end
        end
    end
end

RunService.RenderStepped:Connect(onRenderStepped)

player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    humanoid = character:WaitForChild("Humanoid")
    rootPart = character:WaitForChild("HumanoidRootPart")
end)