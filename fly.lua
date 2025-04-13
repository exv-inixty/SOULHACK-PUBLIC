local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

local flying = false
local bodyGyro, bodyVelocity
local flightConnection

-- GUI setup
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "FlyTimerGui"

local timerLabel = Instance.new("TextLabel", screenGui)
timerLabel.Size = UDim2.new(0, 200, 0, 50)
timerLabel.Position = UDim2.new(0.5, -100, 1, -60)
timerLabel.BackgroundTransparency = 0.3
timerLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
timerLabel.TextColor3 = Color3.new(1, 0, 0)
timerLabel.TextScaled = true
timerLabel.Visible = false
timerLabel.Text = ""
timerLabel.Font = Enum.Font.GothamBold

local function stopFlying()
	flying = false
	if bodyGyro then bodyGyro:Destroy() end
	if bodyVelocity then bodyVelocity:Destroy() end
	if flightConnection then flightConnection:Disconnect() end
	timerLabel.Visible = false
end

local function startFlying()
	flying = true
	timerLabel.Visible = true

	bodyGyro = Instance.new("BodyGyro")
	bodyGyro.P = 9e4
	bodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
	bodyGyro.CFrame = hrp.CFrame
	bodyGyro.Parent = hrp

	bodyVelocity = Instance.new("BodyVelocity")
	bodyVelocity.velocity = Vector3.new(0, 0, 0)
	bodyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)
	bodyVelocity.Parent = hrp

	local startTime = tick()
	local duration = 2.5
	local hue = 0

	flightConnection = RunService.RenderStepped:Connect(function()
		if not flying then return end

		local elapsed = tick() - startTime
		local remaining = math.max(0, duration - elapsed)

		timerLabel.Text = string.format("Flying: %.1f sec left", remaining)
		timerLabel.TextColor3 = Color3.fromHSV(hue, 1, 1)
		hue = (hue + 0.01) % 1

		local camera = workspace.CurrentCamera
		bodyGyro.CFrame = camera.CFrame
		bodyVelocity.velocity = camera.CFrame.LookVector * 20

		if elapsed >= duration then
			stopFlying()
		end
	end)
end

-- Press F to toggle flying
UIS.InputBegan:Connect(function(input, processed)
	if processed then return end
	if input.KeyCode == Enum.KeyCode.F then
		if flying then
			stopFlying()
		else
			startFlying()
		end
	end
end)