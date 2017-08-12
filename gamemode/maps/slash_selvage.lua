-- Utopia Games - Slashers
--
-- @Author: Garrus2142
-- @Date:   2017-08-09 16:33:11
-- @Last Modified by:   Daryl_Winters
-- @Last Modified time: 2017-08-12T19:27:38+02:00

local GM = GM or GAMEMODE

GM.MAP.Name = "Selvage"
GM.MAP.EscapeDuration = 60
GM.MAP.StartMusic = "slashers_start_game_myers.wav"
GM.MAP.ChaseMusic = "slashers/ambient/chase_myers.wav"
GM.MAP.Goal = {
	Jerrican = {
		{type="sls_jerrican", pos=Vector( 	-22.718750, -1.750000, 31.187500	 ), ang=Angle(	0.264, 130.913, -0.088	),},
		{type="sls_jerrican", pos=Vector( 	-2128.093750, -65.156250, 42.468750	 ), ang=Angle(	-0.659, 92.373, 0.000	),},
		{type="sls_jerrican", pos=Vector( 	32.312500, 77.531250, 303.187500	 ), ang=Angle(	0.220, -32.783, -0.088	),},
		{type="sls_jerrican", pos=Vector( 	26.750000, -15.468750, 439.218750	 ), ang=Angle(	-0.176, 15.381, -0.044	),},
		{type="sls_jerrican", pos=Vector( 	-1571.218750, 26.093750, 42.375000	 ), ang=Angle(	-0.176, 160.225, -0.088	),},
		{type="sls_jerrican", pos=Vector( 	1698.062500, 1318.000000, 15.156250	 ), ang=Angle(	0.308, 162.422, -0.088	),},
		{type="sls_jerrican", pos=Vector( 	-2130.500000, 1292.531250, 42.468750	 ), ang=Angle(	0.000, 84.595, 0.396	),},
		{type="sls_jerrican", pos=Vector( 	591.656250, 2252.843750, 16.468750	 ), ang=Angle(	2.505, -57.437, 0.527	),},
		{type="sls_jerrican", pos=Vector( 	-1562.312500, 1261.875000, 42.468750	 ), ang=Angle(	0.571, -139.746, 0.000	),},
		{type="sls_jerrican", pos=Vector( 	-814.156250, 1813.937500, 16.187500	 ), ang=Angle(	-0.308, 42.275, -0.088	),},
		{type="sls_jerrican", pos=Vector( 	-2038.218750, 1886.656250, 15.312500	 ), ang=Angle(	0.000, 170.244, 0.088	),},
		{type="sls_jerrican", pos=Vector( 	-1835.062500, -1205.500000, 16.156250	 ), ang=Angle(	0.527, 138.735, -0.088	),},
		{type="sls_jerrican", pos=Vector( 	476.031250, 1293.156250, 15.031250	 ), ang=Angle(	-0.747, 39.902, -0.044	),},
		{type="sls_jerrican", pos=Vector( 	-934.343750, 941.343750, 16.187500	 ), ang=Angle(	-0.088, -45.571, 0.044	),},
		{type="sls_jerrican", pos=Vector( 	-996.750000, -1449.562500, 15.250000	 ), ang=Angle(	-1.187, 124.980, 0.176	),},
		{type="sls_jerrican", pos=Vector( 	-1035.125000, 269.562500, 15.250000	 ), ang=Angle(	0.923, -93.076, 0.088	),},
		{type="sls_jerrican", pos=Vector( 	218.000000, 1820.906250, 16.281250	 ), ang=Angle(	0.835, 32.344, -0.176	),},
		{type="sls_jerrican", pos=Vector( 	-309.656250, 1814.968750, 16.187500	 ), ang=Angle(	-0.352, 16.260, -0.088	),},
		{type="sls_jerrican", pos=Vector( 	-1279.156250, 1816.406250, 17.312500	 ), ang=Angle(	1.538, 37.529, 1.099	),},
		{type="sls_jerrican", pos=Vector( 	784.843750, -1120.968750, 65.281250	 ), ang=Angle(	-3.691, 15.029, -0.659	),},
		{type="sls_jerrican", pos=Vector( 	-1432.718750, -1383.218750, 16.187500	 ), ang=Angle(	0.264, -154.072, -0.088	),},
		{type="sls_jerrican", pos=Vector( 	-1910.125000, -688.000000, 16.187500	 ), ang=Angle(	0.264, 123.003, -0.088	),},
		{type="sls_jerrican", pos=Vector( 	581.312500, -277.406250, 15.343750	 ), ang=Angle(	0.308, -98.789, -0.835	),},
		{type="sls_jerrican", pos=Vector( 	1301.500000, 1955.375000, 23.156250	 ), ang=Angle(	0.352, -126.431, -0.264	),},

	},


	Generator = {
		{type="sls_generator", pos=Vector( 	-1579.18,-822.45,0.33	 ), ang=Angle(	-0.148,-43.391,0.011	),},
		{type="sls_generator", pos=Vector( 	-1235.22,-780.76,0.66	 ), ang=Angle(	-0.016,101.245,-0.434	),},
		{type="sls_generator", pos=Vector( 	529.88,2080.05,1.25	 ), ang=Angle(	-0.077,0.478,-0.005	),},
		{type="sls_generator", pos=Vector( 	-1094.93,877.88,0.22	 ), ang=Angle(	-0.088,-88.149,0.000	),},
		{type="sls_generator", pos=Vector( 	-1280.27,1848.75,2.64	 ), ang=Angle(	-0.714,-128.655,-1.313	),},
		{type="sls_generator", pos=Vector( 	-2200.02,821.98,9.21	 ), ang=Angle(	1.934,90.379,-1.571	),},
		{type="sls_generator", pos=Vector( 	-846.46,926.66,1.29	 ), ang=Angle(	-0.082,-179.863,-0.038	),},
		{type="sls_generator", pos=Vector( 	1756.17,1139.51,0.20	 ), ang=Angle(	-0.088,-89.995,0.000	),},
		{type="sls_generator", pos=Vector( 	-1666.80,-1133.94,0.24	 ), ang=Angle(	-0.126,89.896,-0.022	),},
		{type="sls_generator", pos=Vector( 	-1802.76,-201.91,0.29	 ), ang=Angle(	-0.005,13.804,0.000	),},
		{type="sls_generator", pos=Vector( 	-640.50,-1504.13,0.27	 ), ang=Angle(	-0.011,90.324,0.038	),},
		{type="sls_generator", pos=Vector( 	794.23,1749.65,0.24	 ), ang=Angle(	-0.077,0.132,-0.011	),},

	},

	Radio = {
		{type="sls_radio", pos=Vector( 	31.81,1029.38,50.84	 ), ang=Angle(	0.044,180.000,0.000	),},
		{type="sls_radio", pos=Vector( 	-482.13,1799.31,50.88	 ), ang=Angle(	0.352,-177.891,-0.044	),},
		{type="sls_radio", pos=Vector( 	-1767.28,1608.22,50.84	 ), ang=Angle(	-0.044,-179.692,0.044	),},
		{type="sls_radio", pos=Vector( 	-763.16,646.91,50.84	 ), ang=Angle(	0.220,-0.044,0.088	),},
		{type="sls_radio", pos=Vector( 	-90.81,109.41,424.41	 ), ang=Angle(	-0.044,179.912,-0.220	),},
		{type="sls_radio", pos=Vector( 	640.31,2025.31,48.53	 ), ang=Angle(	0.044,-90.000,0.000	),},
		{type="sls_radio", pos=Vector( 	-1835.47,-480.56,50.84	 ), ang=Angle(	0.044,0.000,0.000	),},
		{type="sls_radio", pos=Vector( 	-1038.66,-611.44,50.84	 ), ang=Angle(	-0.088,154.600,-0.088	),},
		{type="sls_radio", pos=Vector( 	510.50,1689.53,43.34	 ), ang=Angle(	0.044,90.000,0.000	),},
		{type="sls_radio", pos=Vector( 	673.06,1776.63,50.91	 ), ang=Angle(	-0.044,-90.000,0.044	),},
		{type="sls_radio", pos=Vector( 	-1848.84,-1568.44,48.47	 ), ang=Angle(	-0.088,90.000,-0.044	),},
		{type="sls_radio", pos=Vector( 	-1793.53,-1270.00,50.84	 ), ang=Angle(	0.000,-6.987,0.000	),},

	}
}

-- Killer
GM.MAP.Killer.Name = "Michael Myers"
GM.MAP.Killer.Model = "models/player/dewobedil/mike_myers/default_p.mdl"
GM.MAP.Killer.WalkSpeed = 200
GM.MAP.Killer.RunSpeed = 200
GM.MAP.Killer.ExtraWeapons = {}

if CLIENT then
	GM.MAP.Killer.Desc = GM.LANG:GetString("class_desc_myers")
	GM.MAP.Killer.Icon = Material("icons/icon_myers.png")
end

-- Convars
CreateConVar("slashers_myers_wallhack_cooldown", 10, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Set Myers's wallhack cooldown.")
CreateConVar("slashers_myers_wallhack_duration", 10, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Set Myers's wallhack duration.")

-- Ability

if CLIENT then
	local ICON_VICTIM = Material("icons/icon_target.png")
	local victimPos

	local function updateMyersAbility()
		local status = net.ReadInt(2)
		if status == 2 then
			-- Available !
		elseif status == 1 then
			surface.PlaySound("slashers/effects/michael_ability_on.wav")
		elseif status == 0 then
			-- Deactivated !
		end
	end
	net.Receive("sls_kability_update_myersability",updateMyersAbility)

	local function HUDPaintBackground()
		if LocalPlayer():Team() != TEAM_KILLER || !GM.ROUND.Active || !victimPos then return end
		local curtime = CurTime()

		local pos = victimPos:ToScreen()
		surface.SetDrawColor(Color(255, 255, 255))
		surface.SetMaterial(ICON_VICTIM)
		surface.DrawTexturedRect(pos.x - 64, pos.y - 64, 128, 128)
		surface.DrawTexturedRect(ScrW()-110,10,100,100)
	end
	hook.Add("HUDPaintBackground", "sls_kability_HUDPaintBackground", HUDPaintBackground)

	local function Reset()
		victimPos = nil
	end
	hook.Add("sls_round_PreStart", "sls_kability_PreStart", Reset)
	hook.Add("sls_round_End", "sls_kability_End", Reset)

	local function Wallhack()
		local tempPos = net.ReadVector()
		if tempPos == Vector(42, 42, 42) then
			victimPos = nil
		else
			victimPos = tempPos
		end
	end
	net.Receive("sls_kability_Wallhack", Wallhack)

else
	util.AddNetworkString("sls_kability_update_myersability")
	util.AddNetworkString("sls_kability_Wallhack")

	local VictimMyers
	local Timer1 = 0

	local function findVictim()
		for _, v in ipairs(GM.ROUND:GetSurvivorsAlive()) do
			if v.ClassID != CLASS_SURV_SHY then
				return v
			end
		end
	end

	local lastRequestMyers = 0
	local myersAbilityActivated = false
	function GM.MAP.Killer:UseAbility( ply )
		if CurTime() - lastRequestMyers < GetConVar("slashers_myers_wallhack_cooldown"):GetFloat()  then
			net.Start( "notificationSlasher" )
				net.WriteTable({"killerhelp_cant_use_ability"})
				net.WriteString("cross")
				net.Send(ply)
			return
		end
		if myersAbilityActivated then return end
		net.Start("sls_kability_update_myersability")
		net.WriteInt(1,2)
		net.Send(ply)
		myersAbilityActivated = true
		timer.Simple(GetConVar("slashers_myers_wallhack_duration"):GetFloat(),function ()
			if !GM.ROUND.Active then return end

			myersAbilityActivated = false
			lastRequestMyers = CurTime()
			net.Start("sls_kability_update_myersability")
			net.WriteInt(0,2)
			net.Send(GM.ROUND.Killer)
		end)
	end

	local function Think()
		local curtime = CurTime()

		if !GM.ROUND.Active || !IsValid(GM.ROUND.Killer) then return end

		if Timer1 < curtime && IsValid(VictimMyers) && VictimMyers.ClassID != CLASS_SURV_SHY  then
			if myersAbilityActivated then
				net.Start("sls_kability_Wallhack")
					net.WriteVector(VictimMyers:GetPos() + Vector(0, 0, 50))
				net.Send(GM.ROUND.Killer)
			else
				net.Start("sls_kability_Wallhack")
					net.WriteVector(Vector(42, 42, 42))
				net.Send(GM.ROUND.Killer)
			end
			Timer1 = curtime + 0.5
		end
		if  CurTime() - lastRequestMyers == GM.CONFIG["myers_cooldown"] then
			net.Start("sls_kability_update_myersability") --Send a message if the ability is available again
			net.WriteInt(2,2)
			net.Send(GM.ROUND.Killer)
		end

	end
	hook.Add("Think", "sls_kability_Think", Think)

	local function PostPlayerDeath(ply)
		-- Help Myers
		if GM.ROUND.Active && IsValid(GM.ROUND.Killer) && GM.ROUND.Killer:Team() == TEAM_KILLER && ply == VictimMyers then
			VictimMyers = findVictim()
			if !IsValid(VictimMyers) then
				net.Start("sls_kability_Wallhack")
					net.WriteVector(Vector(42, 42, 42))
				net.Send(GM.ROUND.Killer)
			end
		end
	end
	hook.Add("PostPlayerDeath", "sls_kability_PostPlayerDeath", PostPlayerDeath)

	local function PostStart()
		if !GM.ROUND.Killer then return end

		VictimMyers = findVictim()
	end
	hook.Add("sls_round_PostStart", "sls_kability_PostStart", PostStart)

	local function resetEndRound()
		myersAbilityActivated = false
		lastRequestMyers = 0
	end
	hook.Add("sls_round_End","sls_kreset_myersamility",resetEnRound)
end
