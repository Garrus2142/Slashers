-- Utopia Games - Slashers
--
-- @Author: Garrus2142
-- @Date:   2017-08-09 14:19:18
-- @Last Modified by:   Daryl_Winters
-- @Last Modified time: 2017-08-13T14:30:13+02:00

local GM = GM or GAMEMODE

GM.MAP.Name = "Subway"
GM.MAP.EscapeDuration = 90
GM.MAP.StartMusic = "slashers_start_game_proxy.wav"
GM.MAP.ChaseMusic = "slashers/ambient/chase_proxy.wav"
GM.MAP.Goal = {
	Generator = {
		{type="sls_generator", pos=Vector( 	1555.2901611328	,	625.43389892578	,	-475.79974365234	 ), ang=Angle(	-0.047894809395075	,	77.103637695313	,	-0.008544921875	),},
		 {type="sls_generator", pos=Vector( 	-27.053987503052	,	1899.8416748047	,	-241.46769714355	 ), ang=Angle(	7.4849977493286	,	-108.44499969482	,	15.359950065613	),},
		 {type="sls_generator", pos=Vector( 	-115.12114715576	,	692.62139892578	,	0.28063523769379	 ), ang=Angle(	-0.052496179938316	,	151.79542541504	,	-0.08978271484375	),},
		 {type="sls_generator", pos=Vector( 	-994.54235839844	,	1617.1469726563	,	2.3400411605835	 ), ang=Angle(	-0.12257574498653	,	17.577541351318	,	-0.078582763671875	),},
		 {type="sls_generator", pos=Vector( 	-434.90289306641	,	587.71307373047	,	-315.77716064453	 ), ang=Angle(	-0.077189855277538	,	-121.88777160645	,	-0.095794677734375	),}, 			 {type="sls_generator", pos=Vector( 	-438.56158447266	,	-319.31164550781	,	320.11373901367	 ), ang=Angle(	-0.08602774143219	,	101.84964752197	,	-0.00921630859375	),},

	},

	Jerrican = {
		{type="sls_jerrican", pos=Vector( 	626.16522216797	,	978.21575927734	,	-301.35067749023	 ), ang=Angle(	0.2825101017952	,	-56.027549743652	,	-0.11691284179688	),},
		 {type="sls_jerrican", pos=Vector( 	57.623382568359	,	1715.7739257813	,	-204.49980163574	 ), ang=Angle(	-0.053893469274044	,	157.1390838623	,	-0.028656005859375	),},
		 {type="sls_jerrican", pos=Vector( 	204.26774597168	,	730.41949462891	,	32.883777618408	 ), ang=Angle(	0.31352365016937	,	175.91879272461	,	0	),},
		 {type="sls_jerrican", pos=Vector( 	201.55532836914	,	769.17071533203	,	32.805271148682	 ), ang=Angle(	-0.14990532398224	,	-136.18208312988	,	-0.083343505859375	),},
		 {type="sls_jerrican", pos=Vector( 	-528.13140869141	,	740.76495361328	,	22.293134689331	 ), ang=Angle(	-0.55816996097565	,	-53.010009765625	,	9.742344263941e-005	),},
		 {type="sls_jerrican", pos=Vector( 	-583.650390625	,	727.88604736328	,	22.216133117676	 ), ang=Angle(	-0.42867341637611	,	-49.91722869873	,	-0.23440551757813	),},
		 {type="sls_jerrican", pos=Vector( 	-527.84094238281	,	575.70422363281	,	-304.81637573242	 ), ang=Angle(	-0.12804166972637	,	-45.465091705322	,	0.01888744905591	),},
		 {type="sls_jerrican", pos=Vector( 	-574.06182861328	,	601.32495117188	,	82.604270935059	 ), ang=Angle(	-1.4654284715652	,	179.92671203613	,	-0.14865112304688	),},
		 {type="sls_jerrican", pos=Vector( 	116.79051971436	,	301.06945800781	,	-300.64437866211	 ), ang=Angle(	0.082407273352146	,	-146.74432373047	,	-0.05096435546875	),},
		 {type="sls_jerrican", pos=Vector( 	-1038.6672363281	,	1765.6499023438	,	51.416213989258	 ), ang=Angle(	-0.25170168280602	,	-25.032375335693	,	-0.056060791015625	),},
		 {type="sls_jerrican", pos=Vector( 	-275.04010009766	,	612.37969970703	,	82.932144165039	 ), ang=Angle(	0.51139938831329	,	-177.54315185547	,	-0.006683349609375	),},
		 {type="sls_jerrican", pos=Vector( 	216.0818939209	,	1093.6666259766	,	127.23754882813	 ), ang=Angle(	0.22192484140396	,	139.56953430176	,	-0.05523681640625	),},
		 {type="sls_jerrican", pos=Vector( 	-129.18214416504	,	-265.31353759766	,	-304.75549316406	 ), ang=Angle(	0.20723016560078	,	-17.678632736206	,	-0.0511474609375	),},
		 {type="sls_jerrican", pos=Vector( 	1557.6387939453	,	444.23175048828	,	-334.78649902344	 ), ang=Angle(	0.23139935731888	,	-128.82534790039	,	-0.067047119140625	),},
		 {type="sls_jerrican", pos=Vector( 	-1881.3670654297	,	1112.0368652344	,	-48.667213439941	 ), ang=Angle(	-0.0010715052485466	,	-15.994430541992	,	-0.00372314453125	),},
		 {type="sls_jerrican", pos=Vector( 	815.59448242188	,	-156.20213317871	,	-332.60510253906	 ), ang=Angle(	-0.17519058287144	,	64.292091369629	,	-0.093109130859375	),},
		 {type="sls_jerrican", pos=Vector( 	-1271.2581787109	,	1404.2322998047	,	51.441509246826	 ), ang=Angle(	-0.12189055234194	,	29.987237930298	,	-0.064788818359375	),},
		 {type="sls_jerrican", pos=Vector( 	59.894622802734	,	605.23504638672	,	335.27548217773	 ), ang=Angle(	-0.12458427250385	,	-30.171409606934	,	0.054602038115263	),},
		 {type="sls_jerrican", pos=Vector( 	705.19323730469	,	1387.4677734375	,	15.413906097412	 ), ang=Angle(	-27.819969177246	,	-53.936729431152	,	0.014400095678866	),},
		 {type="sls_jerrican", pos=Vector( 	603.20422363281	,	-23.656675338745	,	-368.80438232422	 ), ang=Angle(	-0.20530983805656	,	107.16015625	,	-0.11239624023438	),},
		 {type="sls_jerrican", pos=Vector( 	220.83174133301	,	1646.5212402344	,	-240.78668212891	 ), ang=Angle(	0.28037625551224	,	-158.69053649902	,	-0.0692138671875	),},
		 {type="sls_jerrican", pos=Vector( 	-1067.35546875	,	585.49768066406	,	-304.80004882813	 ), ang=Angle(	0.31165599822998	,	-60.914974212646	,	-0.076934814453125	),},
		 {type="sls_jerrican", pos=Vector( 	-2510.9274902344	,	191.55288696289	,	-208.78524780273	 ), ang=Angle(	0.27691656351089	,	-22.900365829468	,	-0.07110595703125	),},
		 {type="sls_jerrican", pos=Vector( 	275.57260131836	,	1508.1104736328	,	-223.22032165527	 ), ang=Angle(	-0.65892493724823	,	133.19429016113	,	-0.18496704101563	),},
		 {type="sls_jerrican", pos=Vector( 	-2498.2856445313	,	488.92660522461	,	-208.79452514648	 ), ang=Angle(	0.29896232485771	,	-14.056406021118	,	-0.076812744140625	),},
		 {type="sls_jerrican", pos=Vector( 	676.99542236328	,	853.88385009766	,	-368.67318725586	 ), ang=Angle(	-29.379922866821	,	-174.07354736328	,	0.1349038630724	),},
		 {type="sls_jerrican", pos=Vector( 	-1390.9174804688	,	-825.71905517578	,	-208.76564025879	 ), ang=Angle(	0.23098495602608	,	118.17189788818	,	-0.059326171875	),},
		 {type="sls_jerrican", pos=Vector( 	-2041.5080566406	,	173.8415222168	,	-191.3046875	 ), ang=Angle(	-0.36626592278481	,	59.490589141846	,	-0.1151123046875	),},

	},

	Radio = {
		 {type="sls_radio", pos=Vector( 	154.13287353516	,	1127.8270263672	,	44.406784057617	 ), ang=Angle(	-0.1512143611908	,	-76.766105651855	,	0.0056725949980319	),},
		 {type="sls_radio", pos=Vector( 	-458.69750976563	,	817.68774414063	,	71.051460266113	 ), ang=Angle(	-0.068640872836113	,	-16.761373519897	,	-0.132568359375	),},
		 {type="sls_radio", pos=Vector( 	-1000.5646972656	,	-185.62091064453	,	-187.50686645508	 ), ang=Angle(	0.095139645040035	,	160.14253234863	,	-0.12103271484375	),},
		 {type="sls_radio", pos=Vector( 	557.31671142578	,	800.15716552734	,	-347.28604125977	 ), ang=Angle(	9.1530294454856e-009	,	53.593162536621	,	0	),},
		 {type="sls_radio", pos=Vector( 	88.159790039063	,	1564.6361083984	,	-219.41606140137	 ), ang=Angle(	0.026577176526189	,	120.38227844238	,	0.010600571520627	),},
		 {type="sls_radio", pos=Vector( 	-1038.0050048828	,	1808.8616943359	,	36.571212768555	 ), ang=Angle(	0.018387120217085	,	-44.639591217041	,	0.017833599820733	),},
		 {type="sls_radio", pos=Vector( 	-2350.1330566406	,	280.68765258789	,	-191.60224914551	 ), ang=Angle(	0.26568999886513	,	121.80404663086	,	0.086083844304085	),},
		 {type="sls_radio", pos=Vector( 	762.38952636719	,	1462.7406005859	,	36.656219482422	 ), ang=Angle(	-0.1281670331955	,	-34.088413238525	,	0.31091442704201	),},
	}
}

-- Killer
GM.MAP.Killer.Name = "the Proxy"
GM.MAP.Killer.Model = "models/slender_arrival/chaser.mdl"
GM.MAP.Killer.WalkSpeed = 200
GM.MAP.Killer.RunSpeed = 200
GM.MAP.Killer.ExtraWeapons = {}

if CLIENT then
	GM.MAP.Killer.Desc = GM.LANG:GetString("class_desc_proxy")
	GM.MAP.Killer.Icon = Material("icons/icon_proxy.png")
end


-- Ability

if CLIENT then
	local PlyInvisible = false

	net.Receive( "sls_kability_Invisible", function( len, pl )
		PlyInvisible = net.ReadBool()
	end )

	local RED = Color(255,0,0,255)
	local GREEN = Color(0,255,0,255)
	local Visible

	local function isVisible()
		Visible = net.ReadBool()

	end
	net.Receive("sls_kability_InvisibleIndic", isVisible)

	local function InvisibleVision()
		if !GM.ROUND.Active || !GM.ROUND.Survivors || LocalPlayer():Team() != TEAM_KILLER then return end

		if PlyInvisible and LocalPlayer():Alive() then

			DrawMaterialOverlay( "effects/dodge_overlay.vmt", -0.42 )
			DrawSharpen( 1.2, 1.2 )
		end
	end
	hook.Add( "RenderScreenspaceEffects", "sls_kability_BinocDraw", InvisibleVision )

	local TimerView = 0
	local function CheckKillerInSight()
		local v = team.GetPlayers(TEAM_KILLER)[1]
		local curtime = CurTime()
		local ply = LocalPlayer()

		if !ply:Alive() or !ply:IsLineOfSightClear( v )  or !v:IsValid() or v == ply then return end


		local TargetPosMax= v:GetPos()+ v:OBBMaxs() - Vector(10,0,0)
		local TargetPosCenter = v:GetPos()+v:OBBCenter()
		local TargetPosMin = v:GetPos()+ v:OBBMins() + Vector(10,0,0)

		local ScreenPosMax = TargetPosMax:ToScreen()
		local ScreenPosCenter = TargetPosCenter:ToScreen()
		local ScreenPosMin = TargetPosMin:ToScreen()

		posPlayer = ply:GetPos()
		if ( TimerView < curtime) and (posPlayer:Distance( v:GetPos()) < 150) then
				net.Start( "sls_kability_survivorseekiller" )
					net.WriteFloat( curtime )
				net.SendToServer()
				TimerView = curtime + 0.2


		elseif (TimerView < curtime) and (ScreenPosMax.x < ScrW() and ScreenPosMax.y < ScrH() and ScreenPosMin.x > 0 and ScreenPosMin.y > 0) then
				-- print("KILLERSIGHT")
				net.Start( "sls_kability_survivorseekiller" )
					net.WriteFloat( curtime )
				net.SendToServer()
				TimerView = curtime + 0.2
		end
	end
	hook.Add ("Think","sls_kability_IHaveTheKillerInView",CheckKillerInSight)

	local proxyPos
	local showProxy
	local function receiveProxyPos()

		proxyPos = net.ReadVector()
		showProxy = net.ReadBool()

	end
	net.Receive("sls_proxy_sendpos",receiveProxyPos)

	local function drawIconOnProxy()
		if !showProxy or !proxyPos  then return end
		local pos = proxyPos:ToScreen()
		surface.SetDrawColor(Color(255, 255, 255))
		surface.SetMaterial(GM.MAP.Killer.Icon)
		surface.DrawTexturedRect(pos.x - 64, pos.y - 64, 64, 64)
	end
	hook.Add("HUDPaintBackground","sls_proxyicon_draw",drawIconOnProxy)

else
	util.AddNetworkString( "sls_kability_Invisible" )
	util.AddNetworkString( "sls_kability_InvisibleIndic" )
	util.AddNetworkString( "sls_kability_survivorseekiller" )
	util.AddNetworkString("sls_proxy_sendpos")


	local KInvisible = Color(255,255,255,0)
	local KNormal = Color(255,255,255,255)
	local InitialSpawnK = false
	--local keyPressed = false
	local KillerInView
	local LastKillerInView = 0

	local function CandisapearV2()
		local curtime = CurTime()


		if LastKillerInView > curtime - 0.5 then
			KillerInView = true
		else
			KillerInView = false
		end

	end
	hook.Add("Think","sls_kability_UpdateKillerInView",CandisapearV2)


	function ResponsePlayerSeeKiller()
		LastKillerInView = net.ReadFloat()
	end
	net.Receive("sls_kability_survivorseekiller", ResponsePlayerSeeKiller)

	function GM.MAP.Killer:UseAbility(ply)
		local PlayerWeapon = ply:GetActiveWeapon()
		if KillerInView then
			net.Start( "notificationSlasher" )
				net.WriteTable({"killerhelp_cant_use_ability"})
				net.WriteString("cross")
			net.Send(ply)
			return
		end

		if !ply.InvisibleActive  and !KillerInView then

			ply:EmitSound( "slashers/effects/proxy_power_on.wav" )

			timer.Simple( 0.6, function ()

				ply:SetColor(KInvisible )
				ply:SetWalkSpeed( 400 )
				ply:SetRunSpeed(400)
				ply:StripWeapon(PlayerWeapon:GetClass())

				ply:SetRenderMode(RENDERMODE_NONE )
				ply:DrawShadow( false )
				ply:AddEffects(EF_NOSHADOW)
				ply.InvisibleActive = true
				ply:CrosshairDisable()

				net.Start("sls_kability_Invisible")
						net.WriteBool(true)
				net.Send(ply)

			end)

		elseif ply.InvisibleActive and !KillerInView  then
			ply:EmitSound( "slashers/effects/proxy_power_off.wav" )

			timer.Simple( 1, function ()
			--	ply:AddKey( IN_ATTACK )
			--	ply:AddKey( IN_ZOOM )
				ply:Give(ply.InitialWeapon)
				ply:SetColor( KNormal )
				ply:SetRunSpeed( 400 )
				ply:DrawShadow( true )
				ply:SetWalkSpeed(GM.MAP.Killer.WalkSpeed)
				ply:SetRunSpeed(GM.MAP.Killer.RunSpeed)
				ply:SetRenderMode(RENDERMODE_TRANSALPHA )

				ply.InvisibleActive = false

				net.Start("sls_kability_Invisible")
					net.WriteBool(false)
				net.Send(ply)

			end)
		end
	end


	local function ResetVisibility()
	for k,v in pairs(player.GetAll()) do
		v:DrawShadow( true )
		if IsValid(GAMEMODE.CLASS.Killers) and GM.ROUND.Killer:Team() == TEAM_KILLER then
			v:SetWalkSpeed(GAMEMODE.CLASS.Killers[CLASS_KILL_PROXY].walkspeed)
			v:SetRunSpeed(GAMEMODE.CLASS.Killers[CLASS_KILL_PROXY].walkspeed)
			GM.ROUND.Killer.InvisibleActive = false
		end
		v:SetRenderMode(RENDERMODE_TRANSALPHA )
		v:SetColor(Color(255,255,255))
	end
	if (!GAMEMODE.ROUND.Killer) then return end
		net.Start("sls_kability_Invisible")
			net.WriteBool(false)
		net.Send(GAMEMODE.ROUND.Killer)
	end
hook.Add("PostPlayerDeath","sls_kability_ResetViewKiller",ResetVisibility)
hook.Add("sls_round_PostStart","sls_kability_ResetViewKillerAfterEnd",ResetVisibility)

local timerSend = 0
local function sendPosWhenInvisible()
	if IsValid(GM.ROUND.Killer) &&   GM.ROUND.Active && timerSend < CurTime()  then
		timerSend = CurTime() + 0.5
		local shygirl = getSurvivorByClass(CLASS_SURV_SHY)
		if !shygirl then return end
		if !shygirl:IsLineOfSightClear(GM.ROUND.Killer) or  !GM.ROUND.Killer.InvisibleActive then
			net.Start("sls_proxy_sendpos")
			net.WriteVector(Vector(0,0,0))
			net.WriteBool(false)
			net.Send(shygirl)
			return
		end

		net.Start("sls_proxy_sendpos")
		net.WriteVector(GM.ROUND.Killer:GetPos())
		net.WriteBool(true)
		net.Send(shygirl)
	end
	if !GM.ROUND.Active && timerSend < CurTime() then
			timerSend = CurTime() + 1
			net.Start("sls_proxy_sendpos")
			net.WriteVector(Vector(0,0,0))
			net.WriteBool(false)
			net.Broadcast()
	end
end
hook.Add("Think","sls_sendposkillerwheninvisible",sendPosWhenInvisible)
end

local function initCol()
	local allentities = ents.GetAll()
	for k, v in pairs(allentities) do
		if (v:IsPlayer()) or (v:GetClass() == "prop_door_rotating") then
			v:SetCustomCollisionCheck( true )
		end
	end
end
hook.Add( "InitPostEntity", "sls_kability_CustomInit", initCol)
hook.Add("sls_round_PostStart","sls_kability_TestInit", initCol)


local function ShouldCollide( ent1, ent2 )
	if ent1:IsPlayer() and ent1:GetColor().a == 0 and  ent2:GetClass() == "prop_door_rotating" or
		ent2:IsPlayer() and ent2:GetColor().a == 0 and  ent1:GetClass() == "prop_door_rotating" then
		return false
	end
	if ent1:IsPlayer() and ent1:GetColor().a == 0 or
		ent2:IsPlayer() and ent2:GetColor().a == 0 then
		return false
	end
	return true
end
hook.Add("ShouldCollide", "sls_kability_ShouldCollide", ShouldCollide)
