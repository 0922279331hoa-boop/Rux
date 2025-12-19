-- =====================================
-- ❤️ HEART MENU - BEN DU THUYEN 101
-- =====================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- ===== GUI =====
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "HeartMenu"
gui.ResetOnSpawn = false

-- ===== HEART BUTTON =====
local heart = Instance.new("ImageButton", gui)
heart.Size = UDim2.new(0,60,0,60)
heart.Position = UDim2.new(0,20,0,200)
heart.BackgroundColor3 = Color3.fromRGB(255,80,120)
heart.Image = "rbxassetid://7072718367"
heart.BorderSizePixel = 0
Instance.new("UICorner", heart).CornerRadius = UDim.new(1,0)

-- ===== MENU =====
local menu = Instance.new("Frame", gui)
menu.Size = UDim2.new(0,240,0,300)
menu.Position = UDim2.new(0,100,0,180)
menu.BackgroundColor3 = Color3.fromRGB(30,30,30)
menu.Visible = false
menu.BorderSizePixel = 0
Instance.new("UICorner", menu).CornerRadius = UDim.new(0,12)

-- ===== TITLE =====
local title = Instance.new("TextLabel", menu)
title.Size = UDim2.new(1,0,0,40)
title.Text = "❤️ BẾN DU THUYỀN 101"
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255,120,140)
title.Font = Enum.Font.GothamBold
title.TextSize = 16

-- ===== BUTTON MAKER =====
local function makeBtn(text, y, callback)
	local b = Instance.new("TextButton", menu)
	b.Size = UDim2.new(1,-20,0,38)
	b.Position = UDim2.new(0,10,0,y)
	b.Text = text
	b.BackgroundColor3 = Color3.fromRGB(55,55,55)
	b.TextColor3 = Color3.new(1,1,1)
	b.Font = Enum.Font.Gotham
	b.TextSize = 13
	b.BorderSizePixel = 0
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)
	b.MouseButton1Click:Connect(callback)
end

-- ===== FUNCTIONS =====

-- Tele Wood + Scrap
makeBtn("📦 Tele Gỗ + Phế Liệu", 50, function()
	local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	if not hrp then return end
	for _,v in pairs(workspace:GetDescendants()) do
		if v:IsA("BasePart") and (v.Name=="Wood" or v.Name=="Scrap") then
			v.CFrame = hrp.CFrame * CFrame.new(0,0,-3)
		end
	end
end)

-- God Mode
local god = false
makeBtn("🛡️ God Mode (Bật/Tắt)", 95, function()
	god = not god
	local hum = player.Character and player.Character:FindFirstChild("Humanoid")
	if hum then
		hum.MaxHealth = god and math.huge or 100
		hum.Health = hum.MaxHealth
	end
end)

-- Auto Kill
local autokill = false
makeBtn("⚔️ Auto Kill Quái", 140, function()
	autokill = not autokill
end)

RunService.Heartbeat:Connect(function()
	if not autokill then return end
	local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	if not hrp then return end
	for _,m in pairs(workspace:GetChildren()) do
		if m.Name:lower():find("monster")
		and m:FindFirstChild("Humanoid")
		and m:FindFirstChild("HumanoidRootPart") then
			if (m.HumanoidRootPart.Position - hrp.Position).Magnitude < 80 then
				m.Humanoid.Health = 0
			end
		end
	end
end)

-- Auto Chest
makeBtn("🎁 Auto Mở Rương", 185, function()
	for _,c in pairs(workspace:GetDescendants()) do
		if c.Name:lower():find("chest") and c:IsA("Model") then
			player.Character.HumanoidRootPart.CFrame = c:GetModelCFrame()
			task.wait(0.3)
		end
	end
end)

-- ===== TOGGLE MENU =====
heart.MouseButton1Click:Connect(function()
	menu.Visible = not menu.Visible
end)

print("❤️ HEART MENU LOADED")
