-- =====================================================
-- 💗 HEART MENU - ALL IN ONE
-- BEN DU THUYEN 101 (ALPHA)
-- =====================================================

local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")

-- ===== ADMIN =====
local ADMINS = {
	["HanGia"] = true
}

-- ===== REMOTES =====
local function newRemote(name)
	local r = RS:FindFirstChild(name)
	if not r then
		r = Instance.new("RemoteEvent")
		r.Name = name
		r.Parent = RS
	end
	return r
end

local TeleAll = newRemote("TeleAll")
local TeleRadius = newRemote("TeleRadius")
local GodMode = newRemote("GodMode")
local Heal = newRemote("Heal")
local AutoChest = newRemote("AutoChest")

-- ===== STORAGE =====
local STORAGE_POS = Vector3.new(0,6,300)

-- ===== TELE ALL =====
TeleAll.OnServerEvent:Connect(function(player)
	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("BasePart") and (obj.Name=="Wood" or obj.Name=="Scrap") then
			obj.CFrame = CFrame.new(STORAGE_POS)
		end
	end
end)

-- ===== TELE RADIUS =====
TeleRadius.OnServerEvent:Connect(function(player, radius)
	local char = player.Character
	if not char or not char.PrimaryPart then return end
	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("BasePart") and (obj.Name=="Wood" or obj.Name=="Scrap") then
			if (obj.Position - char.PrimaryPart.Position).Magnitude <= radius then
				obj.CFrame = CFrame.new(STORAGE_POS)
			end
		end
	end
end)

-- ===== GOD MODE =====
GodMode.OnServerEvent:Connect(function(player, state)
	if not ADMINS[player.Name] then return end
	local hum = player.Character and player.Character:FindFirstChild("Humanoid")
	if hum then
		if state then
			hum.MaxHealth = math.huge
			hum.Health = hum.MaxHealth
		else
			hum.MaxHealth = 100
			hum.Health = hum.MaxHealth
		end
	end
end)

-- ===== HEAL =====
Heal.OnServerEvent:Connect(function(player)
	local hum = player.Character and player.Character:FindFirstChild("Humanoid")
	if hum then hum.Health = hum.MaxHealth end
end)

-- ===== AUTO OPEN CHEST =====
AutoChest.OnServerEvent:Connect(function(player)
	local chest = workspace:FindFirstChild("Chest")
	if chest then
		local stats = player:FindFirstChild("leaderstats")
		if stats and stats:FindFirstChild("Coins") then
			stats.Coins.Value += 100
		end
	end
end)

-- ===== AUTO KILL MONSTER =====
task.spawn(function()
	local NPC = workspace:WaitForChild("GuardNPC")
	while task.wait(1) do
		for _, mob in pairs(workspace:GetChildren()) do
			if mob.Name=="Monster" and mob:FindFirstChild("Humanoid") and mob.PrimaryPart then
				if (NPC.PrimaryPart.Position - mob.PrimaryPart.Position).Magnitude < 80 then
					mob.Humanoid:TakeDamage(30)
				end
			end
		end
	end
end)

-- ===== UI =====
Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function()
		task.wait(1)
		local gui = Instance.new("ScreenGui", player.PlayerGui)
		gui.Name = "HeartMenu"

		local btn = Instance.new("TextButton", gui)
		btn.Size = UDim2.new(0,60,0,60)
		btn.Position = UDim2.new(0,20,0,200)
		btn.Text = "💗"
		btn.TextScaled = true
		btn.BackgroundColor3 = Color3.fromRGB(255,80,120)

		btn.MouseButton1Click:Connect(function()
			TeleAll:FireServer()
		end)
	end)
end)

print("💗 HEART MENU ALL-IN-ONE LOADED")
