-- Utopia Games - Slashers
--
-- @Author: Garrus2142
-- @Date:   2017-08-09 16:16:18
-- @Last Modified by:   Garrus2142
-- @Last Modified time: 2017-08-09 16:16:18

local GM = GM or GAMEMODE

GM.MAP.Name = "Highschool"
GM.MAP.EscapeDuration = 60
GM.MAP.StartMusic = "slashers_start_game_ghostface.wav"
GM.MAP.ChaseMusic = "slashers/ambient/chase_ghostface.wav"
GM.MAP.Goal = {
	Generator = {
		{type="sls_generator", pos=Vector( 	-230.557007, 567.435425, 0.243941	 ), ang=Angle(	-0.104, 179.841, 0.022	),spw=false,},
		{type="sls_generator", pos=Vector( -3185.97,1998.87,-255.78 ), ang=Angle( -0.082,-88.412,-0.005 ),spw=false,},
		{type="sls_generator", pos=Vector( 	1631.988892, 3082.173340, -39.728069	 ), ang=Angle(	-0.082, 89.379, 0.005	),spw=false,},
	},

	Jerrican = {
		{type="sls_jerrican", pos=Vector( 	1640.621338, 1963.723511, 22.168455	 ), ang=Angle(	0.709, -69.340, -0.005	),spw = false,},
		{type="sls_jerrican", pos=Vector( 	1098.769043, 1996.015015, 22.516426	 ), ang=Angle(	-0.330, -130.836, -0.038	),spw = false,},
		{type="sls_jerrican", pos=Vector( 	-3158.965576, 1744.980957, -240.749039	 ), ang=Angle(	-0.187, 25.686, -0.044	),spw = false,},
		{type="sls_jerrican", pos=Vector( 	-1658.887451, 1844.536011, 16.802458	 ), ang=Angle(	0.247 ,89.824, -0.005	),spw = false,},
		{type="sls_jerrican", pos=Vector( 	1096.024292, 1857.869507, 16.578562	 ), ang=Angle(	24.620, 142.581, 0.137	),spw = false,},
		{type="sls_jerrican", pos=Vector( 	1645.787231, 1854.194824, 16.291689	 ), ang=Angle(	0.588, 177.220, 0.000	),spw = false,},
		{type="sls_jerrican", pos=Vector( 	-2149.268555, 1830.002563, 16.219990	 ), ang=Angle(	0.450, 75.817, -0.275	),spw = false,},
		{type="sls_jerrican", pos=Vector( 	-2158.761230, -486.748199, 16.207558	 ), ang=Angle(	-0.275, 45.851, -0.027	),spw = false,},
		{type="sls_jerrican", pos=Vector( 	-2145.092529, 488.334808, 16.342915	 ), ang=Angle(	-0.060, 44.769, -0.280	),spw = false,},
		{type="sls_jerrican", pos=Vector( 	-1650.676758, 485.838318, 16.260302	 ), ang=Angle(	-0.159, -23.676, -0.088	),spw = false,},
		{type="sls_jerrican", pos=Vector( 	-1133.220459, 488.161591, 16.258362	 ), ang=Angle(	-0.159, -15.315, -0.088	),spw = false,},
		{type="sls_jerrican", pos=Vector( 	-620.295959, 490.353088, 16.198181	 ), ang=Angle(	0.258, -11.217, -0.071	),spw = false,},
		{type="sls_jerrican", pos=Vector( 	-615.532837, -489.418457, 16.191908	 ), ang=Angle(	0.269, 1.758, -0.077	),spw = false,},
		{type="sls_jerrican", pos=Vector( 	-1131.976807 ,-487.101868, 16.207989	 ), ang=Angle(	0.242, 3.521, -0.066	),spw = false,},
	},

	Radio = {
		{type="sls_radio", pos=Vector( 	-1015.359558, 1984.683960, 40.387001 ), ang=Angle(	0.016, 179.989, 0.055	),spw = false,},
		{type="sls_radio", pos=Vector( 	1081.431396, -323.156342, 31.447535	 ), ang=Angle(	-0.176, -87.693, -0.005	),spw = false,},
		{type="sls_radio", pos=Vector( 	649.651917, -313.385010, 36.436779	 ), ang=Angle(	0.280, -79.052, -0.093	),spw = false,},
		{type="sls_radio", pos=Vector( 	1079.011475, 230.000366, 32.502056	 ), ang=Angle(	-0.137,-96.757, 0.044	),spw = false,},
		{type="sls_radio", pos=Vector( 	-206.554825, 1439.213135, 40.607414	 ), ang=Angle(	-0.104, -79.629, 0.027	),spw = false,},
	}
}

-- Killer
GM.MAP.Killer.Name = "Ghostface"
GM.MAP.Killer.Model = "models/player/screamplayermodel/scream/scream.mdl"
GM.MAP.Killer.WalkSpeed = 190
GM.MAP.Killer.RunSpeed = 240
GM.MAP.Killer.ExtraWeapons = {}

if CLIENT then
	GM.MAP.Killer.Desc = GM.LANG:GetString("class_desc_ghostface")
	GM.MAP.Killer.Icon = Material("icons/icon_ghostface.png")
end

-- Convars
CreateConVar("slashers_ghostface_door_duration", 3, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Set duration when the door is displayed for Ghostface.")
CreateConVar("slashers_ghostface_door_radius", 1400, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Set Ghostface's ability radius. (0 to disable radius)")

-- Ability

if CLIENT then
	local ICON_DOOR = Material("icons/icon_door.png")
	local doors = {}

	local function AddDoor()
		local pos, endtime
		pos = net.ReadVector()
		endtime = net.ReadInt(16)

		table.insert(doors, {
			pos = pos,
			endtime = endtime
		})
	end
	net.Receive("sls_kability_AddDoor", AddDoor)

	local function HUDPaintBackground()
		if LocalPlayer():Team() != TEAM_KILLER then return end
		local curtime = CurTime()

		for k, v in ipairs(doors) do
			if curtime > v.endtime then
				table.remove(doors, k)
				continue
			end
			local pos1 = v.pos:ToScreen()
			surface.SetDrawColor(Color(255, 255, 255))
			surface.SetMaterial(ICON_DOOR)
			surface.DrawTexturedRect(pos1.x - 64, pos1.y - 64, 128, 128)
		end
	end
	hook.Add("HUDPaintBackground", "sls_kability_HUDPaintBackground", HUDPaintBackground)

	local function Reset()
		doors = {}
	end
	hook.Add("sls_round_PreStart", "sls_kability_PreStart", Reset)
	hook.Add("sls_round_End", "sls_kability_End", Reset)

else
	util.AddNetworkString("sls_kability_AddDoor")

	local function AddDoor(pos, endtime)
		if !GM.ROUND.Active || !IsValid(GM.ROUND.Killer) then return end
		local CV_Radius = GetConVar("slashers_ghostface_door_radius")

		if CV_Radius:GetInt() != 0 then
			local entsNerby = ents.FindInSphere( pos, CV_Radius:GetInt()	 )
			local isKillerNerby = table.HasValue( entsNerby, GM.ROUND.Killer )
			if !isKillerNerby then return end
		end

		net.Start("sls_kability_AddDoor")
			net.WriteVector(pos)
			net.WriteInt(endtime, 16)
		net.Send(GM.ROUND.Killer)
	end

	local function PlayerUse(ply, ent)
		if !GM.ROUND.Active || !IsValid(GM.ROUND.Killer) then return end
		if ply:Team() != TEAM_SURVIVORS then return end
		if ply.ClassID == CLASS_SURV_SHY then return end
		if !table.HasValue(GM.CONFIG["killerhelp_door_entities"], ent:GetClass()) then return end
		if ply.kh_use && ply.kh_use[ent:EntIndex()] && CurTime() <= ply.kh_use[ent:EntIndex()] then return end
		local CV_DoorDuration = GetConVar("slashers_ghostface_door_duration")

		ply.kh_use = ply.kh_use or {}
		ply.kh_use[ent:EntIndex()] = CurTime() + CV_DoorDuration:GetFloat()
		AddDoor(ent:GetPos(), CurTime() + CV_DoorDuration:GetFloat())
	end
	hook.Add("PlayerUse", "sls_kability_PlayerUse", PlayerUse)
end
