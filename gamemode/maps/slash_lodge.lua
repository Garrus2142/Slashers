-- Utopia Games - Slashers
--
-- @Author: Garrus2142
-- @Date:   2017-08-07T18:00:56+02:00
-- @Last Modified by:   Daryl_Winters
-- @Last Modified time: 2017-08-10T14:43:00+02:00

local GM = GM or GAMEMODE

GM.MAP.Name = "Lodge"
GM.MAP.EscapeDuration = 60
GM.MAP.StartMusic = "slasher_start_game_intruder.wav"
GM.MAP.ChaseMusic = "slashers/ambient/chase_intruder.wav"
GM.MAP.Goal = {
	Jerrican = {
		 {type="sls_jerrican", pos=Vector( -430.8125,-909.71875,15.15625 ), ang=Angle(0.3076171875,40.693359375,-0.087890625),},
		 {type="sls_jerrican", pos=Vector( -554.78125,-410.09375,15.21875 ), ang=Angle(-0.703125,107.841796875,-0.0439453125),},
		 {type="sls_jerrican", pos=Vector( 716.875,494.4375,15.21875 ), ang=Angle(0.263671875,-74.5751953125,-0.0439453125),},
		 {type="sls_jerrican", pos=Vector( 787.71875,-63.875,219.46875 ), ang=Angle(-0.2197265625,173.9794921875,-0.087890625),},
		 {type="sls_jerrican", pos=Vector( -616.21875,-1127.03125,215.1875 ), ang=Angle(0.263671875,-20.390625,-0.087890625),},
		 {type="sls_jerrican", pos=Vector( 501.1875,-457,215.21875 ), ang=Angle(0.2197265625,55.1953125,-0.0439453125),},
		 {type="sls_jerrican", pos=Vector( -128.09375,-291.53125,-160.78125 ), ang=Angle(-0.17578125,139.21875,-0.087890625),},
		 {type="sls_jerrican", pos=Vector( 507.875,-525.78125,-134.5625 ), ang=Angle(-0.1318359375,-169.27734375,-0.087890625),},
		 {type="sls_jerrican", pos=Vector( 793.78125,31.5,-160.75 ), ang=Angle(-0.1318359375,141.9873046875,-0.087890625),},
		 {type="sls_jerrican", pos=Vector( -169.53125,-1200.21875,-160.75 ), ang=Angle(0.263671875,56.337890625,-0.0439453125),},
		 {type="sls_jerrican", pos=Vector( 834.34375,-1197.8125,-134.53125 ), ang=Angle(0.1318359375,84.462890625,-0.0439453125),},
		 {type="sls_jerrican", pos=Vector( 267.28125,-755.1875,-160.75 ), ang=Angle(-0.1318359375,-158.5546875,-0.087890625),},
		 {type="sls_jerrican", pos=Vector( 321.5625,-76.5625,215.21875 ), ang=Angle(-0.1318359375,146.2939453125,-0.0439453125),},
		 {type="sls_jerrican", pos=Vector( 410.6875,-601.125,15.1875 ), ang=Angle(0.3076171875,-35.068359375,-0.087890625),},

	},

	Radio = {
		 {type="sls_radio", pos=Vector( 659,306.34375,42.4375 ), ang=Angle(-0.3955078125,-156.4013671875,0),},
		 {type="sls_radio", pos=Vector( -254.71875,174.0625,26.125 ), ang=Angle(0.3515625,179.6923828125,0),},
		 {type="sls_radio", pos=Vector( -363.90625,-916.0625,41.9375 ), ang=Angle(-0.17578125,90,0),},
		 {type="sls_radio", pos=Vector( 464.875,-1119.4375,25.625 ), ang=Angle(0,24.3896484375,0),},
		 {type="sls_radio", pos=Vector( 229.21875,-367.1875,225.65625 ), ang=Angle(0,-164.00390625,0),},
		 {type="sls_radio", pos=Vector( 498.5625,-346.25,-140.71875 ), ang=Angle(0,-148.271484375,0),},
		 {type="sls_radio", pos=Vector( 500.71875,-831.9375,-149.375 ), ang=Angle(0.0439453125,-135.17578125,0),},
		 {type="sls_radio", pos=Vector( -259.3125,286.78125,241.0625 ), ang=Angle(-0.17578125,-116.279296875,0.17578125),},
		 {type="sls_radio", pos=Vector( 201.625,220.75,236.625 ), ang=Angle(-0.3515625,-83.1884765625,-0.2197265625),},
		 {type="sls_radio", pos=Vector( -659.6875,-206.8125,48.34375 ), ang=Angle(0.0439453125,-13.6669921875,0),},

	},

	Generator = {
		 {type="sls_generator", pos=Vector( -541.0625,-1289.0625,0.21875 ), ang=Angle(-0.087890625,-7.91015625,0),},
		 {type="sls_generator", pos=Vector( -325.71875,395.625,200.25 ), ang=Angle(-0.087890625,37.0458984375,0),},
		 {type="sls_generator", pos=Vector( -313,-1327.125,200.21875 ), ang=Angle(-0.087890625,-93.4716796875,-0.0439453125),},
		 {type="sls_generator", pos=Vector( 235.59375,-561.75,-175.75 ), ang=Angle(-0.087890625,-11.5576171875,-0.0439453125),},

	}
}

-- Killer
GM.MAP.Killer.Name = "the Intruder"
GM.MAP.Killer.Model = "models/steinman/slashers/intruder_pm.mdl"
GM.MAP.Killer.WalkSpeed = 200
GM.MAP.Killer.RunSpeed = 200
GM.MAP.Killer.ExtraWeapons = {"weapon_beartrap", "weapon_alertropes", "weapon_dooraxe"}

if CLIENT then
	GM.MAP.Killer.Desc = GM.LANG:GetString("class_desc_intruder")
	GM.MAP.Killer.Icon = Material("icons/icon_intruder.png")
	local trapsEntity = {}
	local function getEntityToDrawHalo()
		trapsEntity = net.ReadTable()
	end
	net.Receive("sls_trapspos",getEntityToDrawHalo)

	hook.Add( "PreDrawHalos", "AddHalos", function()
		if LocalPlayer().ClassID != CLASS_SURV_SHY then return end
		halo.Add( trapsEntity, Color( 255, 0, 0 ), 5, 5, 2 )
	end )
else
	util.AddNetworkString("sls_trapspos")
	local timerTrap = 0
	local function sendTrapProximity()
			if IsValid(GM.ROUND.Killer) and GM.ROUND.Killer.ClassID == CLASS_KILL_INTRUDER &&   GM.ROUND.Active && timerTrap < CurTime()  then
			timerTrap = CurTime() + 1
			local shygirl = getSurvivorByClass(CLASS_SURV_SHY)
			if !shygirl then return end
			local entsAround = ents.FindInSphere( shygirl:GetPos(), 700 )
			local trapsAround = {}
			for k,v in pairs(entsAround) do
				if v:GetClass() == "beartrap" or  v:GetClass() == "alertropes" or  v.trapeddoor == 1 then
						table.insert( trapsAround, v )
				end
			end
			net.Start("sls_trapspos")
				net.WriteTable(trapsAround)
			net.Send(shygirl)
		end
	end
	hook.Add("Think","sls_detectProximityTraps",sendTrapProximity)
end
