-- =====================================================
-- 💗 HEART MENU - CLIENT VERSION (LOADSTRING)
-- BEN DU THUYEN 101 (ALPHA)
-- =====================================================

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

-- ===== UI =====
local gui = Instance.new("ScreenGui")
gui.Name = "HeartMenu"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local btn = Instance.new("TextButton")
btn.Parent = gui
btn.Size = UDim2.new(0,60,0,60)
btn.Position = UDim2.new(0,20,0,200)
btn.Text = "💗"
btn.TextScaled = true
btn.BackgroundColor3 = Color3.fromRGB(255,80,120)
btn.BorderSizePixel = 0
btn.Draggable = true
btn.Active = true

-- ===== FUNCTIONS =====
local function TeleAll()
	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("BasePart") and (obj.Name == "Wood" or obj.Name == "Scrap") then
			obj.CFrame = char.PrimaryPart.CFrame * CFrame.new(0,0,-5)
		end
	end
end

local function GodMode()
	local hum = char:FindFirstChildOfClass("Humanoid")
	if hum then
		hum.MaxHealth = math.huge
		hum.Health = hum.MaxHealth
	end
end

-- ===== BUTTON ACTION =====
btn.MouseButton1Click:Connect(function()
	pcall(function()
		GodMode()
		TeleAll()
	end)
end)

print("💗 HEART MENU CLIENT LOADED")
