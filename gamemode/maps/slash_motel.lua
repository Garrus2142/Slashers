-- @Author: Guilhem PECH <Daryl_Winters>
-- @Date:   05-Jan-2018
-- @Email:  guilhempech@gmail.com
-- @Project: Slashers
-- @Last modified by:   Guilhem PECH
-- @Last modified time: 21-Oct-2018
local GM = GM or GAMEMODE



GM.MAP.Name = "Motel"
GM.MAP.EscapeDuration = 90
GM.MAP.StartMusic = "slashers_start_game_bates.wav"
GM.MAP.ChaseMusic = "slashers/ambient/chase_bates.wav"

GM.MAP.Goal = {
	Jerrican = {
		{
			type = "sls_jerrican",
			pos = Vector(-132.72776794434, 1096.9440917969, -46.418460845947),
			ang = Angle(-11.512167930603, -17.985958099365, -0.28103637695313)
		},
		{
			type = "sls_jerrican",
			pos = Vector(123.1305847168, 960.47161865234, -20.908155441284),
			ang = Angle(-0.83715111017227, 152.2551574707, -0.34161376953125)
		},
		{
			type = "sls_jerrican",
			pos = Vector(-434.62466430664, -977.69158935547, -255.93627929688),
			ang = Angle(-85.384300231934, -129, 106.13331604004)
		},
		{
			type = "sls_jerrican",
			pos = Vector(-250.34573364258, -1045.3840332031, -249.05012512207),
			ang = Angle(-89.269607543945, -20.53507232666, -58.782928466797)
		},
		{
			type = "sls_jerrican",
			pos = Vector(250.06280517578, -2957.9208984375, -283.96633911133),
			ang = Angle(-3.1291873455048, -44.645122528076, 0.069202430546284)
		},
		{
			type = "sls_jerrican",
			pos = Vector(1117.3536376953, 228.73536682129, -164.76811218262),
			ang = Angle(0.76776641607285, -85.551902770996, -0.00201416015625)
		},
		{
			type = "sls_jerrican",
			pos = Vector(1042.9167480469, 102.60068511963, -132.91305541992),
			ang = Angle(0.0029051210731268, 125.01371002197, 0.049701131880283)
		},
		{
			type = "sls_jerrican",
			pos = Vector(1130.7811279297, 352.00085449219, -164.88528442383),
			ang = Angle(0.33160337805748, 134.03518676758, -0.088836669921875)
		},
		{
			type = "sls_jerrican",
			pos = Vector(1532.0753173828, 401.02243041992, -190.75386047363),
			ang = Angle(-0.35057589411736, 150.84475708008, 0.19333827495575)
		},
		{
			type = "sls_jerrican",
			pos = Vector(-10.897481918335, -1617.4521484375, -250.09585571289),
			ang = Angle(-87.549354553223, -47.964279174805, 141.82122802734)
		},
		{
			type = "sls_jerrican",
			pos = Vector(-460.42602539063, -2192.0817871094, -284.11688232422),
			ang = Angle(-26.21688079834, 90.1982421875, -0.027374267578125)
		},
		{
			type = "sls_jerrican",
			pos = Vector(3103.1127929688, -6156.3852539063, 378.30126953125),
			ang = Angle(0.47352004051208, 134.45399475098, -0.0120849609375)
		}
	},
	Radio = {
		{
			type = "sls_radio",
			pos = Vector(478.4401550293, -1266.5806884766, -247.88885498047),
			ang = Angle(0.062253076583147, -179.25592041016, 0.13994246721268)
		},
		{
			type = "sls_radio",
			pos = Vector(403.36065673828, -1300.5260009766, -241.02865600586),
			ang = Angle(0.080258369445801, 90.004638671875, 0.079702265560627)
		},
		{
			type = "sls_radio",
			pos = Vector(177.14535522461, -1513.4949951172, -257.55368041992),
			ang = Angle(-0.0058267875574529, -85.650054931641, 0.00013644844875671)
		},
		{
			type = "sls_radio",
			pos = Vector(198.41107177734, -2267.7893066406, -257.55194091797),
			ang = Angle(-0.0035855418536812, 98.675651550293, 0.0048219640739262)
		},
		{
			type = "sls_radio",
			pos = Vector(-36.193283081055, -2901.6440429688, -247.77038574219),
			ang = Angle(0.01403109356761, 76.468772888184, -0.01080322265625)
		},
		{
			type = "sls_radio",
			pos = Vector(1318.7042236328, 334.52438354492, 20.178447723389),
			ang = Angle(-0.40564346313477, 171.32048034668, 0.055375158786774)
		},
		{
			type = "sls_radio",
			pos = Vector(978.34875488281, 209.58619689941, 183.30209350586),
			ang = Angle(-1.5395933132822e-06, -4.6450867652893, 0.20672005414963)
		},
		{
			type = "sls_radio",
			pos = Vector(1514.5386962891, 473.43273925781, 178.69873046875),
			ang = Angle(-0.049126088619232, -121.3890838623, 0.018864806741476)
		},
		{
			type = "sls_radio",
			pos = Vector(1211.291015625, 458.81875610352, 27.832090377808),
			ang = Angle(-0.084948137402534, 90.007133483887, -0.004180908203125)
		}
	},
	Generator = {
		{
			type = "sls_generator",
			pos = Vector(1361.044921875, 284.83706665039, -205.71798706055),
			ang = Angle(-0.079552337527275, -65.23762512207, -0.090576171875)
		},
		{
			type = "sls_generator",
			pos = Vector(133.97138977051, -3001.6188964844, -299.79745483398),
			ang = Angle(-0.080492347478867, -66.50919342041, -0.0030517578125)
		},
		{
			type = "sls_generator",
			pos = Vector(75.01806640625, 1272.2097167969, -66.514503479004),
			ang = Angle(0.60224843025208, 19.975690841675, 1.6436053514481)
		},
		{
			type = "sls_generator",
			pos = Vector(3291.0981445313, -6158.21875, 296.88793945313),
			ang = Angle(2.6277825832367, -73.653427124023, 10.224415779114)
		}
	}
}

-- Killer
GM.MAP.Killer.Name = "Norman Bates"
GM.MAP.Killer.Model = "models/steinman/slashers/bates_pm.mdl"
GM.MAP.Killer.WalkSpeed = 200
GM.MAP.Killer.RunSpeed = 200
GM.MAP.Killer.ExtraWeapons = {"weapon_batesmother"}

if CLIENT then
	GM.MAP.Killer.Desc = GM.LANG:GetString("class_desc_bates")
	GM.MAP.Killer.Icon = Material("icons/icon_bates.png")
end

-- Convars
CreateConVar("slashers_bates_far_radius", 400, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Set the first radius (far).")
CreateConVar("slashers_bates_medium_radius", 200, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Set the second radius (medium).")
CreateConVar("slashers_bates_close_radius", 100, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Set the third radius (close).")

-- Ability
-------------------The other part of the ability code is in the 'Mother' entity code
if CLIENT then
	function GM:playSoundMother(file)
		if IsValid(GM.SoundPlayed) then
			GM.SoundPlayed:Stop()
		end
		sound.PlayFile( file, "", function( station,num,err )
			if ( IsValid( station ) ) then
				station:Play()
				station:EnableLooping(true)
				GM.SoundPlayed = station
			end
		end)
	end

	function autoEnd()
		if IsValid(GM.SoundPlayed) then
			GM.SoundPlayed:Stop()
		end
	end
	hook.Add('sls_round_End',"sls_musicEndRound", autoEnd)
	hook.Add('sls_round_End',"sls_musicEndRound", autoEnd)

	function GM:SoundToPlay(level)
		if(LocalPlayer():Team() == 1) then return end
		if level == 3 then
			GM:playSoundMother("sound/slashers/effects/whisper_loop_high.wav")
		elseif level == 2 then
			GM:playSoundMother("sound/slashers/effects/whisper_loop_medium.wav")
		elseif level == 1 then
			GM:playSoundMother("sound/slashers/effects/whisper_loop_small.wav")
		else
			if GM.SoundPlayed then
				GM.SoundPlayed:Stop()
			end
		end
	end

	net.Receive( "sls_motherradar", function( len, ply )
		local distLevel = net.ReadUInt(2)
		if GM.oldLevel != distLevel then
			GM.oldLevel = distLevel
			GM:SoundToPlay(distLevel)
		end
	end)
end
