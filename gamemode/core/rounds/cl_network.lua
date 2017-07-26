-- Utopia Games - Slashers
--
-- @Author: Garrus2142
-- @Date:   2017-07-25 16:15:47
-- @Last Modified by:   Garrus2142
-- @Last Modified time: 2017-07-26 14:45:39

local GM = GM or GAMEMODE

local function PreStart()
	GM.ROUND.Active = false
	GM.ROUND.WaitingPolice = false
	GM.ROUND.Escape = false
	hook.Run("sls_round_PreStart")
end
net.Receive("sls_round_PreStart", PreStart)

local function PostStart()
	GM.ROUND.Active = true
	GM.ROUND.Count = net.ReadInt(16)
	GM.ROUND.EndTime = net.ReadInt(16)
	GM.ROUND.Survivors = net.ReadTable()
	GM.ROUND.Killer = net.ReadEntity()
	for _, v in ipairs(net.ReadTable()) do
		v.ply.ClassID = v.ClassID
	end
	hook.Run("sls_round_PostStart")
end
net.Receive("sls_round_PostStart", PostStart)

local function StartWaitingPolice()
	GM.ROUND.WaitingPolice = true
	GM.ROUND.EndTime = net.ReadInt(16)
	hook.Run("sls_round_StartWaitingPolice")
end
net.Receive("sls_round_StartWaitingPolice", StartWaitingPolice)

local function StartEscape()
	GM.ROUND.WaitingPolice = false
	GM.ROUND.Escape = true
	GM.ROUND.EndTime = net.ReadInt(16)
	hook.Run("sls_round_StartEscape")
end
net.Receive("sls_round_StartEscape", StartEscape)

local function OnTeamWin()
	local winTeam
	GM.ROUND.Active = false
	winTeam = net.ReadInt(4)
	hook.Run("sls_round_OnTeamWin", winTeam)
end
net.Receive("sls_round_OnTeamWin", OnTeamWin)

local function End()
	local winTeam

	GM.ROUND.Active = false
	GM.ROUND.WaitingPolice = false
	GM.ROUND.Escape = false
	GM.ROUND.Survivors = {}
	GM.ROUND.Killer = nil
	GM.ROUND.EndTime = nil
	winTeam = net.ReadInt(4)
	hook.Run("sls_round_End", winTeam)
end
net.Receive("sls_round_End", End)

local function WaitingPlayers()
	GM.ROUND.WaitingPlayers = net.ReadBool()
	hook.Run("sls_round_WaitingPlayers")
end
net.Receive("sls_round_WaitingPlayers", WaitingPlayers)

local function Update()
	GM.ROUND.Survivors = net.ReadTable()
end
net.Receive("sls_round_Update", Update)

local function PlayerConnect()
	GM.ROUND.Active = true
	GM.ROUND.Count = net.ReadInt(16)
	GM.ROUND.EndTime = net.ReadInt(16)
	GM.ROUND.Survivors = net.ReadTable()
	GM.ROUND.Killer = net.ReadEntity()
	GM.ROUND.WaitingPlayers = net.ReadBool()
	GM.ROUND.WaitingPolice = net.ReadBool()
	GM.ROUND.Escape = net.ReadBool()
	for _, v in ipairs(net.ReadTable()) do
		v.ply.ClassID = v.ClassID
	end
end
net.Receive("sls_round_PlayerConnect", PlayerConnect)

local function SetupCamera()
	GM.ROUND.CameraPos = net.ReadVector()
	GM.ROUND.CameraAng = net.ReadAngle()
	GM.ROUND.CameraEnable = true
end
net.Receive("sls_round_SetupCamera", SetupCamera)

local function Camera()
	GM.ROUND.CameraEnable = net.ReadBool()
end
net.Receive("sls_round_Camera", Camera)

local function UpdateEndTime()
	GM.ROUND.EndTime = net.ReadInt(16)
	hook.Run("sls_round_UpdateEndTime")
end
net.Receive("sls_round_UpdateEndTime", UpdateEndTime)