-- Utopia Games - Slashers
--
-- @Author: Garrus2142
-- @Date:   2017-07-25 16:15:50
<<<<<<< HEAD
-- @Last Modified by:   Daryl_Winters
-- @Last Modified time: 2017-08-09T20:01:34+02:00
=======
-- @Last Modified by:   Garrus2142
-- @Last Modified time: 2017-08-07T18:37:28+02:00
>>>>>>> dbb4416ea1ad7e8b6f1f214c6c763e0a0888ca08

local GM = GM or GAMEMODE
local exit_police

local ICON_EXITHELP = Material("icons/icon_exit.png")


sound.Add({
	name = "killerhelp.heartbeat",
	channel = CHAN_STATIC,
	sound = "slashers/effects/heartbeat_loop.wav"
})

local function AddExit()
	local pos, endtime
	pos = net.ReadVector()
	if LocalPlayer().ClassID != CLASS_SURV_POPULAR then return end
	if !LocalPlayer():Alive() then return end

	exit_police = pos
end
net.Receive("sls_popularhelp_AddExit", AddExit)

local function HUDPaintBackground()
	local curtime = CurTime()

	-- Popularhelp
	if  LocalPlayer():Team() != TEAM_KILLER && exit_police then
		if !GM.ROUND.Active then
			exit_police = nil
		else
			local pos1 = exit_police:ToScreen()
			surface.SetDrawColor(Color(255, 255, 255))
			surface.SetMaterial(ICON_EXITHELP)
			surface.DrawTexturedRect(pos1.x - 64, pos1.y - 64, 128, 128)
		end
	end
<<<<<<< HEAD

	-- Victim Myers
	if LocalPlayer():Team() == TEAM_KILLER && LocalPlayer().ClassID == CLASS_KILL_MYERS && GM.ROUND.Active && victimPos then
		local pos2 = victimPos:ToScreen()
		surface.SetDrawColor(Color(255, 255, 255))
		surface.SetMaterial(ICON_VICTIM)
		surface.DrawTexturedRect(pos2.x - 64, pos2.y - 64, 128, 128)
	end
=======
>>>>>>> dbb4416ea1ad7e8b6f1f214c6c763e0a0888ca08
end
hook.Add("HUDPaintBackground", "sls_killerhelp_HUDPaintBackground", HUDPaintBackground)


local function Think()
	if !GM.ROUND.Active || !GM.ROUND.Survivors || LocalPlayer():Team() != TEAM_KILLER then return end
	for _, v in ipairs(GM.ROUND.Survivors) do
		if v:GetNWBool("killerhelp_camp") && !v.kh_play then
			v:EmitSound("killerhelp.heartbeat")
			v.kh_play = true
		elseif !v:GetNWBool("killerhelp_camp") && v.kh_play then
			v:StopSound("killerhelp.heartbeat")
			v.kh_play = false
		end
	end
end
hook.Add("Think", "sls_killerhelp_Think", Think)

local function Reset()
	doors = {}
	steps = {}
	victimPos = nil

	for _, v in ipairs(player.GetAll()) do
		if v.kh_play then
			v:StopSound("killerhelp.heartbeat")
			v.kh_play = false
		end
	end
end
hook.Add("sls_round_PreStart", "sls_killerhelp_PreStart", Reset)
hook.Add("sls_round_End", "sls_killerhelp_End", Reset)
<<<<<<< HEAD

local function Wallhack()
	local tempPos = net.ReadVector()
	if tempPos == Vector(42, 42, 42) then
		victimPos = nil
	else
		victimPos = tempPos
	end
end
net.Receive("sls_killerhelp_Wallhack", Wallhack)

/** PROXYHELP **/

local PlyInvisible = false

net.Receive( "sls_Invisible", function( len, pl )
	PlyInvisible = net.ReadBool()
end )

local RED = Color(255,0,0,255)
local GREEN = Color(0,255,0,255)
local Visible

local function isVisible()
	Visible = net.ReadBool()

end
net.Receive("sls_InvisibleIndic", isVisible)

local function InvisibleVision()
	if !GM.ROUND.Active || !GM.ROUND.Survivors || LocalPlayer():Team() != TEAM_KILLER then return end

	if PlyInvisible and LocalPlayer():Alive() then

		DrawMaterialOverlay( "effects/dodge_overlay.vmt", -0.42 )
		DrawSharpen( 1.2, 1.2 )
	end
end
hook.Add( "RenderScreenspaceEffects", "BinocDraw", InvisibleVision )


local enableKeyActivated = false
local menuKey = getMenuKey()
local function enableAbilityI()
	if !GM.ROUND.Active || !GM.ROUND.Survivors || LocalPlayer():Team() != TEAM_KILLER then return end
	if GM.ROUND.Killer.ClassID ~= CLASS_KILL_PROXY then return end
	if input.IsButtonDown( menuKey ) and !enableKeyActivated then

		net.Start( "sls_EnableInvisibility" )
		net.WriteEntity(LocalPlayer())
		net.SendToServer()
		enableKeyActivated = true

	else
		if !input.IsButtonDown( menuKey ) then
			enableKeyActivated = false
		end
	end
end
hook.Add ("HUDPaint","CheckEnableKey",enableAbilityI)

local TimerView = 0
local function CheckKillerInSight()
	local v = team.GetPlayers(TEAM_KILLER)[1]
	local curtime = CurTime()
	local ply = LocalPlayer()

	if !ply:IsLineOfSightClear( v )  or !v:IsValid() or v == ply then return end


	local TargetPosMax= v:GetPos()+ v:OBBMaxs() - Vector(10,0,0)
	local TargetPosCenter = v:GetPos()+v:OBBCenter()
	local TargetPosMin = v:GetPos()+ v:OBBMins() + Vector(10,0,0)

	local ScreenPosMax = TargetPosMax:ToScreen()
	local ScreenPosCenter = TargetPosCenter:ToScreen()
	local ScreenPosMin = TargetPosMin:ToScreen()

	posPlayer = ply:GetPos()
	if ( TimerView < curtime) and (posPlayer:Distance( v:GetPos()) < 150) then
			net.Start( "sls_survivorseekiller" )
				net.WriteFloat( curtime )
			net.SendToServer()
			TimerView = curtime + 0.2


	elseif (TimerView < curtime) and (ScreenPosMax.x < ScrW() and ScreenPosMax.y < ScrH() and ScreenPosMin.x > 0 and ScreenPosMin.y > 0) then
			-- print("KILLERSIGHT")
			net.Start( "sls_survivorseekiller" )
				net.WriteFloat( curtime )
			net.SendToServer()
			TimerView = curtime + 0.2
	end
end
hook.Add ("Think","sls_IHaveTheKillerInView",CheckKillerInSight)


-- Shy girl proxy
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
	surface.SetMaterial(GM.CLASS.Killers[CLASS_KILL_PROXY].icon)
	surface.DrawTexturedRect(pos.x - 64, pos.y - 64, 64, 64)
end
hook.Add("HUDPaintBackground","sls_proxyicon_draw",drawIconOnProxy)

-- Shy girl traps
local trapsEntity = {}
local function getEntityToDrawHalo()
	trapsEntity = net.ReadTable()
end
net.Receive("sls_trapspos",getEntityToDrawHalo)

hook.Add( "PreDrawHalos", "AddHalos", function()
	if LocalPlayer().ClassID != CLASS_SURV_SHY then return end
	halo.Add( trapsEntity, Color( 255, 0, 0 ), 5, 5, 2 )
end )
=======
>>>>>>> dbb4416ea1ad7e8b6f1f214c6c763e0a0888ca08
