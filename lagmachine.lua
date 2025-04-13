local Players = game:GetService("Players")
local ChatService = game:GetService("Chat")
local Workspace = game:GetService("Workspace")

local function onPlayerChatted(player, message)
    local atgs = message:split(" ")
    if args[1] == ";lagmachine" and args[2] then
        local targetPlayer = Players:FindFirstChild(args[2])
        if targetPlayer then
            spawn(function()
                while true do
                    if targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        local humanoidRootPart = targetPlayer.Character.HumanoidRootPart
                        local part = Instance.new("Part")
                        part.Size = Vector3.new(1, 1, 1)
                        part.Position = humanoidRootPart.Position + Vector3.new(math.random(-5, 5), math.random(-5, 5), math.random(-5, 5))
                        part.Anchored = true
                        part.Parent = Workspace
                        game.Debris:AddItem(part, 5) -- Remove the part after 5 seconds
                    end
                    wait (0.1)
                end
            end)
        else
            player:SendNotification("Player not found", "The specified player was not found.")
        end
    end
end

Players.PlayerAdded:Connect(function(player)
    player.Chatted:Connect(function(message)
        onPlayerChatted(player, message)
    end)
end)

for _, player in ipairs(Players:GetPlayers()) do
    player.Chatted:Connect(function(message)
        onPlayerChatted(player, message)
    end)
end