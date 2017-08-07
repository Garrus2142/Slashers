-- Utopia Games - Slashers
--
-- @Author: Garrus2142
-- @Date:   2017-07-25 16:15:50
-- @Last Modified by:   Daryl_Winters
-- @Last Modified time: 2017-08-07T18:37:28+02:00

local GM = GM or GAMEMODE
local doors = {}
local exit_police
local steps = {}
local victimPos

local ICON_DOOR = Material("icons/icon_door.png")
local ICON_STEP = Material("icons/footsteps.png")
local ICON_VICTIM = Material("icons/icon_target.png")
local ICON_EXITHELP = Material("icons/icon_exit.png")

sound.Add({
	name = "killerhelp.heartbeat",
	channel = CHAN_STATIC,
	sound = "slashers/effects/heartbeat_loop.wav"
})

local function AddDoor()
	local pos, endtime
	pos = net.ReadVector()
	endtime = net.ReadInt(16)

	table.insert(doors, {
		pos = pos,
		endtime = endtime
	})
end
net.Receive("sls_killerhelp_AddDoor", AddDoor)

local function AddExit()
	local pos, endtime
	pos = net.ReadVector()
	if LocalPlayer().ClassID != CLASS_SURV_POPULAR then return end
	if !LocalPlayer():Alive() then return end

	exit_police = pos
end
net.Receive("sls_popularhelp_AddExit", AddExit)

local function getMenuKey()
	local cpt = 0
	while input.LookupKeyBinding( cpt ) ~= "+menu" && cpt < 159 do
		 cpt = cpt + 1
	end
	return  cpt
end


local function requestPosSurvivor(ply, button)
	 if GM.ROUND.Active && GM.ROUND.Survivors && ply:Team() == TEAM_KILLER &&  button == getMenuKey() then
		net.Start("sls_myers_request")
		net.SendToServer()
	end
end
hook.Add("PlayerButtonDown","sls_killerhelp_myersRequest",requestPosSurvivor)

local function updateMyersAbility()
		local status = net.ReadInt(2)
		if status == 2 then
			-- Available !
		elseif status == 1 then
			-- Activated !
		elseif status == 0 then
			-- Deactivated !
		end
end
net.Receive("sls_update_myersability",updateMyersAbility)

local function HUDPaintBackground()
	local curtime = CurTime()

	-- Killerhelp
	if LocalPlayer():Team() == TEAM_KILLER then
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

	-- Victim Myers
	if LocalPlayer():Team() == TEAM_KILLER && LocalPlayer().ClassID == CLASS_KILL_MYERS && GM.ROUND.Active && victimPos then
		local pos2 = victimPos:ToScreen()
		surface.SetDrawColor(Color(255, 255, 255))
		surface.SetMaterial(ICON_VICTIM)
		surface.DrawTexturedRect(pos2.x - 64, pos2.y - 64, 128, 128)
		surface.DrawTexturedRect(ScrW()-110,10,100,100)
	end
end
hook.Add("HUDPaintBackground", "sls_killerhelp_HUDPaintBackground", HUDPaintBackground)

local function AddStep()
	local ply, pos, ang, endtime

	ply = net.ReadEntity()
	pos = net.ReadVector()
	ang = net.ReadAngle()
	endtime = net.ReadInt(16)

	ang.p = 0
	ang.r = 0

	local fpos = pos
	if ply.LastFoot then
		fpos = fpos + ang:Right() * 5
	else
		fpos = fpos + ang:Right() * -5
	end
	ply.LastFoot = !ply.LastFoot

	local trace = {}
	trace.start = fpos
	trace.endpos = trace.start + Vector(0, 0, -10)
	trace.filter = ply
	local tr = util.TraceLine(trace)

	if tr.Hit then
		local tbl = {}
		tbl.pos = tr.HitPos
		tbl.foot = foot
		tbl.endtime = endtime
		tbl.angle = ang.y
		tbl.normal = Vector(0, 0, 1)
		table.insert(steps, tbl)
	end
end
net.Receive("sls_killerhelp_AddStep", AddStep)

local maxDistance = 600 ^ 2
local function PostDrawTranslucentRenderables()
	if LocalPlayer().ClassID != CLASS_KILL_JASON then return end

	local pos = EyePos()

	cam.Start3D(pos, EyeAngles())
		render.SetMaterial(ICON_STEP)
		for k, v in ipairs(steps) do
			if CurTime() > v.endtime then
				table.remove(steps, k)
				continue
			end
			if (v.pos - pos):LengthSqr() < maxDistance then
				render.DrawQuadEasy(v.pos + v.normal, v.normal, 10, 20, Color(255, 255, 255), v.angle)
			end
		end
	cam.End3D()
end
hook.Add("PostDrawTranslucentRenderables", "sls_killerhelp_PostDrawTranslucentRenderables", PostDrawTranslucentRenderables)


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
