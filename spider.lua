local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local climbSpeed = 20 -- Speed at which the character climbs
local climbKey = Enum.KeyCode.E -- Key to toggle climbing
local climbDistance = 3 -- Distance from the wall to start climbing

local climbing = false
local originalGravity = Workspace.Gravity

local function isNearWall()
    local ray = Ray.new(rootPart.Position, rootPart.CFrame.lookVector * climbDistance)
    local hit, position = Workspace:FindPartOnRay(ray, character)
    return hit ~= nil
end

local function onInputBegan(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == climbKey then
        climbing = not climbing
        if climbing then
            Workspace.Gravity = 0 -- Disable gravity
        else
            Workspace.Gravity = originalGravity -- Re-enable gravity
        end
    end
end

local function onRenderStepped()
    if climbing and isNearWall() then
        local moveDirection = Vector3.new()
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            moveDirection = moveDirection + rootPart.CFrame.lookVector * climbSpeed
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            moveDirection = moveDirection - rootPart.CFrame.lookVector * climbSpeed
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            moveDirection = moveDirection - rootPart.CFrame.rightVector * climbSpeed
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            moveDirection = moveDirection + rootPart.CFrame.rightVector * climbSpeed
        end

        rootPart.Velocity = moveDirection
    end
end

local function onCharacterAdded(character)
    humanoid = character:WaitForChild("Humanoid")
    rootPart = character:WaitForChild("HumanoidRootPart")
    UserInputService.InputBegan:Connect(onInputBegan)
    RunService.RenderStepped:Connect(onRenderStepped)
end

onCharacterAdded(character)
player.CharacterAdded:Connect(onCharacterAdded)

UserInputService.InputBegan:Connect(onInputBegan)
RunService.RenderStepped:Connect(onRenderStepped)