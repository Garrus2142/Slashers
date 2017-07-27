-- Utopia Games - Slashers
--
-- @Author: Garrus2142
-- @Date:   2017-07-25 16:15:48
-- @Last Modified by:   Garrus2142
-- @Last Modified time: 2017-07-26 14:45:36

local GM = GM or GAMEMODE
local MAPS_LIST

util.AddNetworkString("sls_round_PreStart")
util.AddNetworkString("sls_round_PostStart")
util.AddNetworkString("sls_round_StartWaitingPolice")
util.AddNetworkString("sls_round_StartEscape")
util.AddNetworkString("sls_round_OnTeamWin")
util.AddNetworkString("sls_round_End")
util.AddNetworkString("sls_round_Update")
util.AddNetworkString("sls_round_WaitingPlayers")
util.AddNetworkString("sls_round_PlayerConnect")
util.AddNetworkString("sls_round_SetupCamera")
util.AddNetworkString("sls_round_Camera")
util.AddNetworkString("sls_round_UpdateEndTime")

function GM.ROUND:ViewInitCam(enable)
	GM.ROUND.CameraEnable = enable
	net.Start("sls_round_Camera")
		net.WriteBool(GM.ROUND.CameraEnable)
	net.Broadcast()

	if enable then
		for _, v in ipairs(player.GetAll()) do
			if IsValid(v) then
				v:SetPos(GM.ROUND.CameraPos)
			end
		end
	end
end

function GM.ROUND:Start(forceKiller)
	GM.ROUND.Survivors = {}
	GM.ROUND.Killer = nil
	GM.ROUND.EndTime = nil
	GM.ROUND.WaitingPolice = false
	GM.ROUND.Escape = false
	GM.ROUND.NextStart = nil

	local playersCount = 0
	for _, v in ipairs(player.GetAll()) do
		if v.initialKill then
			playersCount = playersCount + 1
		end
	end
	if playersCount < GM.CONFIG["round_min_player"] then
		GM.ROUND.WaitingPlayers = true
		net.Start("sls_round_WaitingPlayers")
			net.WriteBool(true)
		net.Broadcast()
		return false
	end

	if GM.ROUND.Active then
		GM.ROUND:End(true)
	end

	hook.Run("sls_round_PreStart")
	net.Start("sls_round_PreStart")
	net.Broadcast()

	-- Setup players
	if IsValid(forceKiller) then
		GM.ROUND.Killer = forceKiller
	else
		GM.ROUND.Killer = GM.ROUND:ChooseKiller()
	end

	local i = 0
	for _, v in ipairs(player.GetAll()) do
		if i > 10 then break end
		if GM.ROUND.Killer != v then
			table.insert(GM.ROUND.Survivors, v)
		end
		i = i + 1
	end
	GM.ROUND:ViewInitCam(false)

	local spawnpoints = ents.FindByClass("info_player_counterterrorist")
	for _, v in ipairs(GM.ROUND.Survivors) do
		v:Spawn()
		v:SetPos(table.Random(spawnpoints):GetPos())
		v:Freeze(true)
		v:ScreenFade(SCREENFADE.IN, Color(0, 0, 0), 2, GM.CONFIG["round_freeze_start"] - 2)
		v:SetNWBool("Escaped", false)
	end
	GM.CLASS:SetupSurvivors()

	if IsValid(GM.ROUND.Killer) then
		GM.ROUND.Killer:Spawn()
		GM.ROUND.Killer:SetKillClass(GM.CONFIG["killer_class_map"][game.GetMap()])
		GM.ROUND.Killer:SetPos(table.Random(ents.FindByClass("info_player_terrorist")):GetPos())
		GM.ROUND.Killer:Freeze(true)
		GM.ROUND.Killer:ScreenFade(SCREENFADE.IN, Color(0, 0, 0), 2, GM.CONFIG["round_freeze_start"] - 2)
		GM.ROUND.Killer:SetNWBool("Escaped", false)
	end

	game.CleanUpMap()

	GM.ROUND.Active = true
	GM.ROUND.Count = GM.ROUND.Count + 1
	GM.ROUND.EndTime = CurTime() + GM.CONFIG["round_freeze_start"] + GM.CONFIG["round_duration_base"] + (#GM.ROUND.Survivors * GM.CONFIG["round_duration_add"])

	hook.Run("sls_round_PostStart")
	net.Start("sls_round_PostStart")
		net.WriteInt(GM.ROUND.Count, 16)
		net.WriteInt(GM.ROUND.EndTime, 16)
		net.WriteTable(GM.ROUND.Survivors)
		net.WriteEntity(GM.ROUND.Killer)
		net.WriteTable(GM.CLASS:GetClassIDTable())
	net.Broadcast()

	timer.Simple(GM.CONFIG["round_freeze_start"],
		function()
			if GM.ROUND.Survivors then
				for _, v in ipairs(GM.ROUND.Survivors) do
					v:Freeze(false)
				end
			end
			if IsValid(GM.ROUND.Killer) then
				GM.ROUND.Killer:Freeze(false)
			end
		end
	)

	print("Start round " .. GM.ROUND.Count .. "/" .. GM.CONFIG["round_count_nextmap"])
end

function GM.ROUND:StartWaitingPolice()
	GM.ROUND.WaitingPolice = true
	GM.ROUND.EndTime = CurTime() + GM.CONFIG["round_freeze_start"] + GM.CONFIG["round_duration_waitingpolice_base"] +
		(#GM.ROUND:GetSurvivorsAlive() * GM.CONFIG["round_duration_waitingpolice_add"])

	hook.Run("sls_round_StartWaitingPolice")
	net.Start("sls_round_StartWaitingPolice")
		net.WriteInt(GM.ROUND.EndTime, 16)
	net.Broadcast()
end

function GM.ROUND:StartEscape()
	objectifComplete()
	GM.ROUND.WaitingPolice = false
	GM.ROUND.Escape = true
	GM.ROUND.EndTime = CurTime() + (GM.CONFIG["round_duration_escape"][game.GetMap()] or 60)

	-- Button escape
	GM.ROUND.EscapeButton = table.Random(ents.FindByName("button_escape"))
	GM.ROUND.EscapeButton:Fire("Press")

	hook.Run("sls_round_StartEscape")
	net.Start("sls_round_StartEscape")
		net.WriteInt(GM.ROUND.EndTime, 16)
	net.Broadcast()
end

function GM.ROUND:End(nowin)
	local winTeam

	GM.ROUND.Active = false
	GM.ROUND.WaitingPolice = false
	GM.ROUND.Escape = false
	if !nowin then
		winTeam = TEAM_KILLER
		for _, v in ipairs(GM.ROUND.Survivors) do
			if v:GetNWBool("Escaped") then
				winTeam = TEAM_SURVIVORS
				break
			end
		end

		hook.Run("sls_round_OnTeamWin", winTeam)
		net.Start("sls_round_OnTeamWin")
			net.WriteInt(winTeam, 4)
		net.Broadcast()
		print("Winner - " .. (winTeam == TEAM_SURVIVORS and "Survivors" or "Killer"))
	end

	for _, v in ipairs(player.GetAll()) do
		v:KillSilent()
	end
	GM.ROUND:ViewInitCam(true)

	GM.ROUND.Survivors = {}
	GM.ROUND.Killer = nil
	GM.ROUND.EndTime = nil
	GM.ROUND.NextStart = CurTime() + (nowin and 8 or GM.CONFIG["round_duration_end"])

	if #player.GetAll() < GM.CONFIG["round_min_player"] then
		GM.ROUND.WaitingPlayers = true
		net.Start("sls_round_WaitingPlayers")
			net.WriteBool(true)
		net.Broadcast()
		hook.Run("sls_round_WaitingPlayers")
	end

	hook.Run("sls_round_End")
	net.Start("sls_round_End")
	net.Broadcast()
	print("Round End")
end

function GM.ROUND:UpdateEndTime(endtime)
	GM.ROUND.EndTime = endtime
	net.Start("sls_round_UpdateEndTime")
		net.WriteInt(GM.ROUND.EndTime, 16)
	net.Broadcast()
end

function GM:PlayerSpawn(ply)
	if !ply.initialKill then
		local camera = ents.FindByName("camera_view")[1]

		ply:KillSilent()
		ply.initialKill = true

		net.Start("sls_round_SetupCamera")
			net.WriteVector(GM.ROUND.CameraPos)
			net.WriteAngle(GM.ROUND.CameraAng)
		net.Send(ply)
		ply:SetPos(GM.ROUND.CameraPos)

		-- Send data
		if GM.ROUND.Active then
			net.Start("sls_round_PlayerConnect")
				net.WriteInt(GM.ROUND.Count, 16)
				net.WriteInt(GM.ROUND.EndTime, 16)
				net.WriteTable(GM.ROUND.Survivors)
				net.WriteEntity(GM.ROUND.Killer)
				net.WriteBool(GM.ROUND.WaitingPlayers)
				net.WriteBool(GM.ROUND.WaitingPolice)
				net.WriteBool(GM.ROUND.Escape)
				net.WriteTable(GM.CLASS:GetClassIDTable())
			net.Send(ply)
		end
	end
end

local function PlayerDK(ply)
	if !GM.ROUND.Active then return end
	if #GM.ROUND:GetSurvivorsAlive() == 0 then
		GM.ROUND:End()
	end
	if ply:Team() == TEAM_KILLER then
		GM.ROUND:End(true)
	end

	print("left survivors: ", #GM.ROUND:GetSurvivorsAlive())
end
hook.Add("PostPlayerDeath", "sls_round_PostPlayerDeath", PlayerDK)

local function PlayerDisconnected(ply)
	if !GM.ROUND.Survivors then return end
	if !IsValid(ply) || !ply:IsValid() then return end

	table.RemoveByValue(GM.ROUND.Survivors, ply)
	net.Start("sls_round_Update")
		net.WriteTable(GM.ROUND.Survivors)
	net.Broadcast()

	PlayerDK(ply)
end
hook.Add("PlayerDisconnected", "sls_round_PlayerDisconnected", PlayerDisconnected)

local function Think()
	local curtime = CurTime()

	if GM.ROUND.Active && GM.ROUND.EndTime && curtime > GM.ROUND.EndTime then
		-- Escape
		if GM.ROUND.WaitingPolice then
			GM.ROUND:StartEscape()
		else
			GM.ROUND:End()
		end
	end

	-- Check NextMap
	if !GM.ROUND.Active && GM.ROUND.NextStart && curtime >= GM.ROUND.NextStart && GM.ROUND.Count >= GM.CONFIG["round_count_nextmap"] then
		local mapindex = table.KeyFromValue(MAPS_LIST, game.GetMap())
		GM.ROUND.NextStart = nil
		RunConsoleCommand("changelevel", mapindex == #MAPS_LIST and MAPS_LIST[1] or MAPS_LIST[mapindex + 1])
	end

	-- Waiting Players
	if GM.ROUND.WaitingPlayers && (!GM.ROUND.NextStart || curtime >= GM.ROUND.NextStart) then
		local count = 0
		for _, v in ipairs(player.GetAll()) do
			if v.initialKill then
				count = count + 1
			end
		end
		if count >= GM.CONFIG["round_min_player"] then
			GM.ROUND.WaitingPlayers = false
			timer.Simple(1, function()
				if #player.GetAll() < GM.CONFIG["round_min_player"] then
					GM.ROUND.WaitingPlayers = true
					return
				end

				net.Start("sls_round_WaitingPlayers")
					net.WriteBool(false)
				net.Broadcast()
				GM.ROUND:Start()
			end)
		end
	end

	-- Auto restart
	if !GM.ROUND.Active && GM.ROUND.NextStart && curtime >= GM.ROUND.NextStart then
		GM.ROUND:Start()
	end
end
hook.Add("Think", "sls_round_Think", Think)

local function InitPostEntity()
	-- Create zones
	for _, v in ipairs(ents.FindByName("trigger_escape")) do
		local zone
		local vec1, vec2

		vec1 = v:LocalToWorld(v:OBBMins())
		vec2 = v:LocalToWorld(v:OBBMaxs())
		zone = CreateZone(vec1, vec2)

		function zone:OnPlayerEnter(ply)
			if !GM.ROUND.Escape then return end
			if ply:Team() != TEAM_SURVIVORS then return end
			ply:SetNWBool("Escaped", true)
			ply:KillSilent()
		end
	end

	-- Get Cam pos
	local camera = ents.FindByName("camera_view")[1]
	GM.ROUND.CameraPos = camera:GetPos()
	GM.ROUND.CameraAng = camera:GetAngles()
end
hook.Add("InitPostEntity", "sls_round_InitPostEntity", InitPostEntity)

-- List all maps slashers
do
	local files = file.Find("maps/*.bsp", "GAME")
	MAPS_LIST = {}
	for _, v in ipairs(files) do
		if string.sub(v, 1, 6) == "slash_" && GM.CONFIG["killer_class_map"][string.StripExtension(v)] != nil then
			table.insert(MAPS_LIST, string.StripExtension(v))
		end
	end
end
