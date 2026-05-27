local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Window = Rayfield:CreateWindow({
	Name = "Player GUI",
	LoadingTitle = "Player Selector",
	LoadingSubtitle = "by You",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "PlayerGUI",
		FileName = "Settings"
	}
})

local MainTab = Window:CreateTab("Main", 4483362458)

local SelectedPlayer = nil

-- プレイヤー一覧
local function GetPlayers()
	local tbl = {}

	for _, v in ipairs(Players:GetPlayers()) do
		if v ~= LocalPlayer then
			table.insert(tbl, v.Name)
		end
	end

	return tbl
end

MainTab:CreateDropdown({
	Name = "Select Player",
	Options = GetPlayers(),
	CurrentOption = {},
	MultipleOptions = false,
	Flag = "PlayerDropdown",
	Callback = function(Option)
		SelectedPlayer = Option[1]
	end,
})

-- 自分を選択プレイヤーの近くへTP
MainTab:CreateButton({
	Name = "Teleport To Player",
	Callback = function()
		if SelectedPlayer then
			local Target = Players:FindFirstChild(SelectedPlayer)

			if Target and Target.Character and LocalPlayer.Character then
				LocalPlayer.Character:PivotTo(
					Target.Character:GetPivot() * CFrame.new(0,3,0)
				)
			end
		end
	end,
})

-- プレイヤー更新
Players.PlayerAdded:Connect(function()
	Rayfield:Notify({
		Title = "Player Joined",
		Content = "Refresh GUI to update list",
		Duration = 3
	})
end)
