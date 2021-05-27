-- Utopia Games - Slashers
--
-- @Author: Garrus2142
-- @Date:   2017-07-25 16:15:51
-- @Last Modified by:   Garrus2142
-- @Last Modified time: 2017-07-26 14:49:15

local GM = GM or GAMEMODE
local map = game.GetMap()

local start_soundsList = {
	"slasher_start_game_01.wav",
	"slasher_start_game_02.wav",
	"slasher_start_game_03.wav",
	"slasher_start_game_04.wav",
}

-- Jumpscare
local jumpscare = {}

jumpscare.cooldown = 10

jumpscare.low = {
	"scare_low_1.wav",
	"scare_low_2.wav",
	"scare_low_3.wav",
}

jumpscare.mid = {
	"scare_mid_1.wav",
	"scare_mid_2.wav",
	"scare_mid_3.wav",
}

jumpscare.high = {
	"scare_high_1.wav",
	"scare_high_2.wav",
	"scare_high_3.wav",
}

local ambient

local function GetPercentSurvivorDead()
	local survivors = table.Count(GM.ROUND.Survivors)
	local dead = 0
	local percent = 0

	for _,v in pairs(GM.ROUND.Survivors) do
		if IsValid(v) && not v:Alive() then
			dead = dead + 1
		end
	end

	percent = (dead / survivors) * 100

	if percent < 25 then
		return 0
	elseif percent < 50 then
		return 25
	elseif percent < 75 then
		return 50
	else
		return 75
	end
end

local function StartAmbient(level)
	sound.PlayFile("sound/slashers/ambient/loop_" .. level .. "_percent.wav", "noplay", function(station)
		if IsValid(station) then
			ambient = station
			station:SetVolume(0.6)
			station:Play()
			timer.Create("sls_sambient", station:GetLength() + 0.1, 0, function()
				local percent = GetPercentSurvivorDead()

				if level != percent then
					timer.Remove("sls_sambient")
					StartAmbient(percent)
				else
					station:Play()
				end
			end)
		end
	end)
end

local function StartRound()
	-- Suppression du timer sambient
	if timer.Exists("sls_sambient") then timer.Remove("sls_sambient") end

	-- Start round sound
	sound.PlayFile("sound/slashers/ambient/" .. GAMEMODE.MAP.StartMusic, "noplay", function(station)
		if IsValid(station) then
			station:SetVolume(0.5)
			station:Play()

			-- Ambiance progressive
			timer.Simple(station:GetLength() + 0.5, function()
				if GAMEMODE.ROUND.Active then
					StartAmbient(0)
				end
			end)
		end
	end)
end
hook.Add("sls_round_PostStart", "sls_soundscape_PostStart", StartRound)

local function EndRound()
	-- Suppression du timer sambient
	timer.Remove("sls_sambient")
	if IsValid(ambient) then ambient:Stop() end
end
hook.Add("sls_round_OnTeamWin", "sls_soundscape_OnTeamWin", EndRound)
hook.Add("sls_round_End", "sls_soundscape_End", EndRound)
hook.Add("sls_round_PreStart", "sls_soundscape_PreStart", EndRound)

local function JumpScare()
	local killer = team.GetPlayers(TEAM_KILLER)[1]
	if !killer then return end
	if !LocalPlayer():Alive() then return end
	if !IsValid(killer) then return end
	if killer:GetColor().a == 0 then return end

	local shootPos = LocalPlayer():GetShootPos()
	local hisPos = killer:GetShootPos()
	local aimVec = LocalPlayer():GetAimVector()
	local distance = hisPos:DistToSqr(shootPos)

	if distance < 3000000 then
		local pos = hisPos - shootPos
		local unitPos = pos:GetNormalized()
		if unitPos:Dot(aimVec) > 0.80 then
			local trace = util.QuickTrace(shootPos, pos, LocalPlayer())
			if trace.Hit and trace.Entity ~= killer then return end
			if LocalPlayer().lastJumpscare && LocalPlayer().lastJumpscare + jumpscare.cooldown > CurTime() then return end

			if distance <= 100000 then
				-- High
				surface.PlaySound("slashers/scares/" .. jumpscare.high[math.random(1, #jumpscare.high)])
			elseif distance <= 1000000 then
				-- Mid
				surface.PlaySound("slashers/scares/" .. jumpscare.mid[math.random(1, #jumpscare.mid)])
			else
				-- Low
				surface.PlaySound("slashers/scares/" .. jumpscare.low[math.random(1, #jumpscare.low)])
			end

			LocalPlayer().lastJumpscare = CurTime()
		end
	end
end
hook.Add("Think", "sls_soundscape_JumpScare", JumpScare)
