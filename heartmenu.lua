-- =====================================
-- ❤️ HEART MENU FULL VERSION 4
-- BẾN DU THUYỀN 101 (ALPHA)
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
heart.Position = UDim2.new(0,20,0,20)
heart.BackgroundColor3 = Color3.fromRGB(255,80,120)
heart.Image = "rbxassetid://7072718367"
heart.BorderSizePixel = 0
Instance.new("UICorner", heart).CornerRadius = UDim.new(1,0)

-- ===== SCROLLABLE MENU =====
local menu = Instance.new("Frame", gui)
menu.Size = UDim2.new(0,300,0,400)
menu.Position = UDim2.new(0,90,0,20)
menu.BackgroundColor3 = Color3.fromRGB(30,30,30)
menu.Visible = false
menu.BorderSizePixel = 0
Instance.new("UICorner", menu).CornerRadius = UDim.new(0,12)

local scroll = Instance.new("ScrollingFrame", menu)
scroll.Size = UDim2.new(1,0,1,0)
scroll.CanvasSize = UDim2.new(0,0,0,700) -- Tăng nếu nhiều nút
scroll.ScrollBarThickness = 6
scroll.BackgroundTransparency = 1
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y

-- ===== TITLE =====
local title = Instance.new("TextLabel", scroll)
title.Size = UDim2.new(1,0,0,40)
title.Position = UDim2.new(0,0,0,0)
title.Text = "❤️ BẾN DU THUYỀN 101 - FULL V4"
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255,120,140)
title.Font = Enum.Font.GothamBold
title.TextSize = 16

-- ===== DRAG FUNCTION =====
local dragging, dragInput, dragStart, startPos
local function update(input)
	local delta = input.Position - dragStart
	menu.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
		startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

menu.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = menu.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

menu.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

RunService.Heartbeat:Connect(function()
	if dragging and dragInput then
		update(dragInput)
	end
end)

-- ===== BUTTON MAKER =====
local function makeBtn(text, y, callback)
	local b = Instance.new("TextButton", scroll)
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

-- ===== VARIABLES =====
local god = false
local autokill = false
local fireRun = false
local autoPick = false

-- ===== BUTTON FUNCTIONS =====

-- Kill All Quái
makeBtn("⚔️ Kill All Quái", 50, function()
	for _,m in pairs(workspace:GetChildren()) do
		if m.Name:lower():find("monster") and m:FindFirstChild("Humanoid") then
			m.Humanoid.Health = 0
		end
	end
end)

-- Dịch Chuyển Gỗ
makeBtn("📦 Dịch Chuyển Gỗ", 95, function()
	local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	if not hrp then return end
	for _,v in pairs(workspace:GetDescendants()) do
		if v:IsA("BasePart") and v.Name=="Wood" then
			v.Anchored = false
			v.CFrame = hrp.CFrame * CFrame.new(0,0,-4)
		end
	end
end)

-- Dịch Chuyển Phế Liệu
makeBtn("🗑️ Dịch Chuyển Phế Liệu", 140, function()
	local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	if not hrp then return end
	for _,v in pairs(workspace:GetDescendants()) do
		if v:IsA("BasePart") and v.Name=="Scrap" then
			v.Anchored = false
			v.CFrame = hrp.CFrame * CFrame.new(0,0,-4)
		end
	end
end)

-- Dịch Chuyển Thức Ăn
makeBtn("🍖 Dịch Chuyển Thức Ăn", 185, function()
	local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	if not hrp then return end
	for _,v in pairs(workspace:GetDescendants()) do
		if v:IsA("BasePart") and v.Name:lower():find("food") then
			v.Anchored = false
			v.CFrame = hrp.CFrame * CFrame.new(0,0,-4)
		end
	end
end)

-- Auto Mở Rương
makeBtn("🎁 Auto Mở Rương", 230, function()
	for _,c in pairs(workspace:GetDescendants()) do
		if c.Name:lower():find("chest") and c:IsA("Model") then
			local stats = player:FindFirstChild("leaderstats")
			if stats and stats:FindFirstChild("Coins") then
				stats.Coins.Value += 100
			end
		end
	end
end)

-- God Mode / Bất tử
makeBtn("🛡️ Bất Tử", 275, function()
	god = not god
	local hum = player.Character and player.Character:FindFirstChild("Humanoid")
	if hum then
		hum.MaxHealth = god and math.huge or 100
		hum.Health = hum.MaxHealth
	end
end)

-- Auto Kill
makeBtn("⚔️ Auto Kill Quái", 320, function()
	autokill = not autokill
end)

-- Lửa Cháy To
makeBtn("🔥 Lửa Cháy To", 365, function()
	fireRun = not fireRun
end)

-- Speed
makeBtn("⚡ Speed x2", 410, function()
	local hum = player.Character and player.Character:FindFirstChild("Humanoid")
	if hum then hum.WalkSpeed = 32 end
end)

-- Jump
makeBtn("🦘 Jump Cao", 455, function()
	local hum = player.Character and player.Character:FindFirstChild("Humanoid")
	if hum then hum.JumpPower = 120 end
end)

-- Auto Nhặt Hột Sò
makeBtn("🪙 Auto Nhặt Hột Sò", 500, function()
	autoPick = not autoPick
end)

-- ===== HEART BUTTON TOGGLE MENU =====
heart.MouseButton1Click:Connect(function()
	menu.Visible = not menu.Visible
end)

-- ===== UPDATE FUNCTION =====
RunService.Heartbeat:Connect(function()
	local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	if hrp then
		-- Auto Kill
		if autokill then
			for _,m in pairs(workspace:GetChildren()) do
				if m.Name:lower():find("monster") and m:FindFirstChild("Humanoid") and m:FindFirstChild("HumanoidRootPart") then
					if (m.HumanoidRootPart.Position - hrp.Position).Magnitude < 80 then
						m.Humanoid.Health = 0
					end
				end
			end
		end

		-- Lửa chạy + cháy to
		if fireRun then
			for _,v in pairs(workspace:GetDescendants()) do
				if v:IsA("BasePart") and v.Name:lower():find("fire") then
					local dx = math.random(-5,5)
					local dz = math.random(-5,5)
					v.CFrame = v.CFrame + Vector3.new(dx,0,dz)
					if v.Size.X < 10 then
						v.Size = v.Size + Vector3.new(0.2,0.2,0.2)
					end
				end
			end
		end

		-- Auto nhặt hột sò
		if autoPick then
			for _,v in pairs(workspace:GetDescendants()) do
				if v:IsA("BasePart") and (v.Name:lower():find("coin") or v.Name:lower():find("shell")) then
					if (v.Position - hrp.Position).Magnitude < 20 then
						local stats = player:FindFirstChild("leaderstats")
						if stats and stats:FindFirstChild("Coins") then
							stats.Coins.Value += 1
							v:Destroy()
						end
					end
				end
			end
		end
	end
end)

print("❤️ HEART MENU FULL V4 LOADED")
