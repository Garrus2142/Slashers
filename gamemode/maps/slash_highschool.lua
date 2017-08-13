-- Utopia Games - Slashers
--
-- @Author: Garrus2142
-- @Date:   2017-08-09 16:16:18
-- @Last Modified by:   Daryl_Winters
-- @Last Modified time: 2017-08-12T21:52:21+02:00

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
		{type="sls_jerrican", pos=Vector( -337.61422729492,4208.5034179688,15.20546913147 ), ang=Angle(0.29911690950394,-107.67920684814,-0.076904296875),},
		{type="sls_jerrican", pos=Vector( -832.87280273438,3960.4450683594,15.211248397827 ), ang=Angle(-0.18193197250366,132.82957458496,-0.099609375),},
		{type="sls_jerrican", pos=Vector( -871.77398681641,3628.7075195313,143.23510742188 ), ang=Angle(-0.19817142188549,42.745780944824,0.0033673702273518),},
		{type="sls_jerrican", pos=Vector( -150.58769226074,2760.2993164063,15.171372413635 ), ang=Angle(0.31349492073059,177.90315246582,-0.090911865234375),},
		{type="sls_jerrican", pos=Vector( 363.51852416992,3913.6384277344,15.219017982483 ), ang=Angle(0.17899608612061,153.10092163086,-0.053466796875),},
		{type="sls_jerrican", pos=Vector( 954.73406982422,3905.7685546875,15.194498062134 ), ang=Angle(-0.17163632810116,122.43538665771,-0.075958251953125),},
		{type="sls_jerrican", pos=Vector( 1625.3060302734,2592.2314453125,-24.786474227905 ), ang=Angle(0.23140309751034,120.18731689453,-0.06707763671875),},
		{type="sls_jerrican", pos=Vector( -3191.2702636719,1714.2003173828,-240.66720581055 ), ang=Angle(-3.3803564292612e-05,58.764389038086,1.0351240234741e-05),},
		{type="sls_jerrican", pos=Vector( 1619.7426757813,3575.1896972656,-24.786474227905 ), ang=Angle(0.23146924376488,-93.160789489746,-0.067108154296875),},
		{type="sls_jerrican", pos=Vector( 1645.1494140625,1894.0163574219,15.282790184021 ), ang=Angle(-0.72208338975906,116.19367218018,-0.009307861328125),},
		{type="sls_jerrican", pos=Vector( 1097.1127929688,1895.4429931641,15.296053886414 ), ang=Angle(0.52100074291229,140.54516601563,-0.00146484375),},
		{type="sls_jerrican", pos=Vector( 159.30082702637,1925.9259033203,15.186881065369 ), ang=Angle(0.3425304889679,-52.143970489502,-0.088043212890625),},
		{type="sls_jerrican", pos=Vector( -1660.0640869141,2108.74609375,15.250699996948 ), ang=Angle(0.19297276437283,-24.351388931274,-0.04962158203125),},
		{type="sls_jerrican", pos=Vector( -1994.3056640625,1820.2613525391,15.238723754883 ), ang=Angle(0.22074890136719,126.39302062988,-0.05670166015625),},
		{type="sls_jerrican", pos=Vector( -2461.0461425781,2144.8525390625,-240.76989746094 ), ang=Angle(0.24104903638363,-122.06577301025,-0.05950927734375),},
		{type="sls_jerrican", pos=Vector( -1428.2978515625,1242.1107177734,49.071933746338 ), ang=Angle(0.25737193226814,144.17913818359,-0.060211181640625),},
		{type="sls_jerrican", pos=Vector( -968.86248779297,719.958984375,11.206244468689 ), ang=Angle(-0.074853546917439,-133.37257385254,0.05948481336236),},
		{type="sls_jerrican", pos=Vector( -2154.1550292969,440.65505981445,57.139801025391 ), ang=Angle(-0.19147573411465,-19.175411224365,-0.0435791015625),},
		{type="sls_jerrican", pos=Vector( -1715.4619140625,-164.66848754883,15.180100440979 ), ang=Angle(0.35804957151413,-154.51434326172,-0.09197998046875),},
		{type="sls_jerrican", pos=Vector( -1174.3892822266,284.01641845703,15.231330871582 ), ang=Angle(0.23807875812054,143.44622802734,-0.0611572265625),},
		{type="sls_jerrican", pos=Vector( -1267.7409667969,-499.57800292969,15.288521766663 ), ang=Angle(0.6395457983017,99.416877746582,-0.007659912109375),},
		{type="sls_jerrican", pos=Vector( -984.66259765625,159.22805786133,15.22987651825 ), ang=Angle(-0.15406642854214,129.9514465332,-0.0843505859375),},
		{type="sls_jerrican", pos=Vector( 748.11462402344,292.224609375,15.213750839233 ), ang=Angle(0.18704722821712,140.25053405762,-0.055694580078125),},
		{type="sls_jerrican", pos=Vector( 1029.4135742188,492.54858398438,15.237907409668 ), ang=Angle(0.14931757748127,-46.33683013916,-0.044525146484375),},
		{type="sls_jerrican", pos=Vector( 926.78326416016,-367.95364379883,15.196391105652 ), ang=Angle(-0.21430395543575,35.326824188232,-0.0638427734375),},
		{type="sls_jerrican", pos=Vector( 335.88238525391,-342.4338684082,70.468910217285 ), ang=Angle(-0.35885268449783,-81.489151000977,-0.078094482421875),},
		{type="sls_jerrican", pos=Vector( -3204.4877929688,4006.4453125,15.211122512817 ), ang=Angle(0.28541943430901,-44.340118408203,-0.07330322265625),},
		{type="sls_jerrican", pos=Vector( -2914.2302246094,2894.6203613281,15.195457458496 ), ang=Angle(-0.3221048116684,14.934867858887,-0.082733154296875),},
		{type="sls_jerrican", pos=Vector( -2755.4448242188,2460.5871582031,15.186882019043 ), ang=Angle(-0.34217804670334,120.43856048584,-0.087890625),},

	},

	Radio = {
		{type="sls_radio", pos=Vector( 1100.4357910156,-322.15875244141,31.403644561768 ), ang=Angle(0.1441543251276,-152.83665466309,-0.03436279296875),},
		{type="sls_radio", pos=Vector( 525.01519775391,261.17346191406,36.570552825928 ), ang=Angle(-0.051851563155651,133.30648803711,0.1021229326725),},
		{type="sls_radio", pos=Vector( -215.81350708008,1152.3334960938,40.713584899902 ), ang=Angle(0.38537296652794,64.633186340332,0.072013989090919),},
		{type="sls_radio", pos=Vector( -1008.4176025391,1979.8427734375,40.412010192871 ), ang=Angle(0.018851533532143,-177.70724487305,0.009365570731461),},
		{type="sls_radio", pos=Vector( -3027.1662597656,2556.5673828125,35.318096160889 ), ang=Angle(-0.082713477313519,67.031394958496,-0.058685302734375),},
		{type="sls_radio", pos=Vector( -1743.1160888672,988.11871337891,34.235912322998 ), ang=Angle(-0.12690305709839,-155.81369018555,0.00046024887706153),},
		{type="sls_radio", pos=Vector( 649.06811523438,-309.36059570313,36.332279205322 ), ang=Angle(0.068379744887352,-90.009872436523,0.05548570305109),},
		{type="sls_radio", pos=Vector( 1208.3638916016,1954.3370361328,40.485179901123 ), ang=Angle(0.021240957081318,155.72518920898,0.01632889918983),},
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
