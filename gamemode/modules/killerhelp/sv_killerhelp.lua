-- Utopia Games - Slashers
--
-- @Author: Garrus2142
-- @Date:   2017-07-25 16:15:50
-- @Last Modified by:   Garrus2142
-- @Last Modified time: 2017-07-26 14:48:34

local GM = GM or GAMEMODE

util.AddNetworkString("sls_killerhelp_AddDoor")
util.AddNetworkString("sls_killerhelp_AddStep")
util.AddNetworkString("sls_killerhelp_Wallhack")
util.AddNetworkString("sls_popularhelp_AddExit")
util.AddNetworkString("sls_EnableInvisibility")

local VictimMyers
local Timer1 = 0

local function AddDoor(pos, endtime)
	if !GM.ROUND.Active || !IsValid(GM.ROUND.Killer) then return end

	net.Start("sls_killerhelp_AddDoor")
		net.WriteVector(pos)
		net.WriteInt(endtime, 16)
	net.Send(GM.ROUND.Killer)
end

local function AddExit(pos)
	if !GM.ROUND.Active || !IsValid(GM.ROUND.Killer) then return end
	net.Start("sls_popularhelp_AddExit")
		net.WriteVector(pos)
	net.Send(GM.ROUND.Survivors)
end

local function findVictim()
	for _, v in ipairs(GM.ROUND:GetSurvivorsAlive()) do
		if v.ClassID != CLASS_SURV_SHY then
			return v
		end
	end
end

function FindNearestEntity( Name, pos, range )
    local nearestEnt;

	for i, entity in ipairs( ents.FindByName( Name ) ) do
		local distance = pos:Distance( entity:GetPos() )
		if( distance <= range ) then
			nearestEnt = entity
			range = distance
		end
	end

	return nearestEnt
end

local function ExitAppear()
	if !IsValid(GM.ROUND.EscapeButton) then return end

	local ButtonPos
	local EscapePos

	ButtonPos = GM.ROUND.EscapeButton:GetPos()

	-- door_exit*
	-- brush_car_1
	-- prop_car_*

	local Escape = FindNearestEntity("door_exit*",ButtonPos,9000)
	if (Escape == nil ) then
		Escape = FindNearestEntity("prop_car_*",ButtonPos,9000)
		EscapePos = Escape:GetPos()

	else
		EscapePos = Escape:GetPos()

	end

	AddExit(Vector(EscapePos))

end
hook.Add("sls_round_StartEscape", "sls_round_exitIcon", ExitAppear)

local function PlayerUse(ply, ent)
	if !GM.ROUND.Active || !IsValid(GM.ROUND.Killer) || GM.ROUND.Killer.ClassID != CLASS_KILL_GHOSTFACE then return end
	if ply:Team() != TEAM_SURVIVORS then return end
	if GAMEMODE.CLASS.Survivors[ply.ClassID].name == "Shy girl" then return end
	if !table.HasValue(GM.CONFIG["killerhelp_door_entities"], ent:GetClass()) then return end
	if ply.kh_use && ply.kh_use[ent:EntIndex()] && CurTime() <= ply.kh_use[ent:EntIndex()] then return end

	ply.kh_use = ply.kh_use or {}
	ply.kh_use[ent:EntIndex()] = CurTime() + GM.CONFIG["killerhelp_door_duration"]

	AddDoor(ent:GetPos(), CurTime() + GM.CONFIG["killerhelp_door_duration"])
end
hook.Add("PlayerUse", "sls_killerhelp_PlayerUse", PlayerUse)

local function PlayerFootstep(ply, pos, foot, sound, volume, filter)
	if ply:GetColor() == Color(255,255,255,0) then return true end
	if !GM.ROUND.Active || !IsValid(GM.ROUND.Killer) || GM.ROUND.Killer.ClassID != CLASS_KILL_JASON  then return end
	if ply:Team() != TEAM_SURVIVORS then return end
	if GAMEMODE.CLASS.Survivors[ply.ClassID].name == "Shy girl" then return end

	net.Start("sls_killerhelp_AddStep")
		net.WriteEntity(ply)
		net.WriteVector(pos)
		net.WriteAngle(ply:GetAimVector():Angle())
		net.WriteInt(CurTime() + GM.CONFIG["killerhelp_step_duration"], 16)
	net.Send(GM.ROUND.Killer)
end
hook.Add("PlayerFootstep", "sls_killerhelp_PlayerFootstep", PlayerFootstep)

local DIST_RESET = 350 ^ 2
local CAMP_DELAY = 15
local function Think()
	if !GM.ROUND.Active || !IsValid(GM.ROUND.Killer) || !GM.ROUND.Survivors then return end

	local curtime = CurTime()

	-- Anti camp
	for _, v in ipairs(GM.ROUND.Survivors) do
		if IsValid(v) && v:Alive() then
			if !v.kh_lastpos then
				v.kh_lastpos = v:GetPos()
				v.kh_camptime = curtime
			end
			-- Reset
			if v.kh_lastpos:DistToSqr(v:GetPos()) > DIST_RESET then
				v.kh_camptime = curtime
				v.kh_lastpos = v:GetPos()
				v:SetNWBool("killerhelp_camp", false)

			elseif curtime > v.kh_camptime + CAMP_DELAY && !v:GetNWBool("killerhelp_camp") && GAMEMODE.CLASS.Survivors[v.ClassID].name != "Emo" then
				-- Camp
				v:SetNWBool("killerhelp_camp", true)
			end
		end
	end

	-- Help Myers
	local curtime = CurTime()
	if !GM.ROUND.Active || !IsValid(GM.ROUND.Killer) || !GM.ROUND.Survivors  then return end
	if GM.ROUND.Killer.ClassID == CLASS_KILL_MYERS && Timer1 < curtime && IsValid(VictimMyers) && VictimMyers.ClassID != CLASS_SURV_SHY then
		net.Start("sls_killerhelp_Wallhack")
			net.WriteVector(VictimMyers:GetPos() + Vector(0, 0, 50))
		net.Send(GM.ROUND.Killer)
		Timer1 = curtime + 0.5
	end
end
hook.Add("Think", "sls_killerhelp_Think", Think)

local function PlayerDeath(ply)
	ply:SetNWBool("killerhelp_camp", false)
end
hook.Add("PlayerDeath", "sls_killerhelp_PlayerDeath", PlayerDeath)

local function PostPlayerDeath(ply)
	-- Help Myers
	if GM.ROUND.Active && IsValid(GM.ROUND.Killer) && GM.ROUND.Killer.ClassID == CLASS_KILL_MYERS && ply == VictimMyers then
		VictimMyers = findVictim()
		if !IsValid(VictimMyers) then
			net.Start("sls_killerhelp_Wallhack")
				net.WriteVector(Vector(42, 42, 42))
			net.Send(GM.ROUND.Killer)
		end
	end
end
hook.Add("PostPlayerDeath", "sls_killerhelp_PostPlayerDeath", PostPlayerDeath)

local function PreStart()
	for _, v in ipairs(player.GetAll()) do
		if IsValid(v) then
			v.kh_lastpos = nil
			v.kh_camptime = nil
			v:SetNWBool("killerhelp_camp", false)
		end
	end
end
hook.Add("sls_round_PreStart", "sls_killerhelp_PreStart", PreStart)

local function PostStart()
	if !GM.ROUND.Killer then return end
	if GM.ROUND.Killer.ClassID == CLASS_KILL_MYERS then
		VictimMyers = findVictim()
	end
end
hook.Add("sls_round_PostStart", "sls_killerhelp_PostStart", PostStart)

/*** ProxyHelp **/

util.AddNetworkString( "sls_Invisible" )
util.AddNetworkString( "sls_InvisibleIndic" )
util.AddNetworkString("sls_survivorseekiller")

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
hook.Add("Think","UpdateKillerInView",CandisapearV2)


function ResponsePlayerSeeKiller()
	LastKillerInView = net.ReadFloat()
end
net.Receive("sls_survivorseekiller", ResponsePlayerSeeKiller)

local function disapearKiller()
	local KillerPly = GM.ROUND.Killer
	local PlayerWeapon = KillerPly:GetActiveWeapon()
	if KillerInView then
		net.Start( "notificationSlasher" )
			net.WriteTable({"killerhelp_cant_use_ability"})
			net.WriteString("cross")
			net.Send(KillerPly)
			return
	end

	if !KillerPly.InvisibleActive  and !KillerInView then

		KillerPly:EmitSound( "slashers/effects/proxy_power_on.wav" )

		timer.Simple( 0.6, function ()

			KillerPly:SetColor(KInvisible )
			KillerPly:SetWalkSpeed( 400 )
			KillerPly:SetRunSpeed(400)
			KillerPly:StripWeapon(PlayerWeapon:GetClass())

			KillerPly:SetRenderMode(RENDERMODE_NONE )
			KillerPly:DrawShadow( false )
			KillerPly:AddEffects(EF_NOSHADOW)
			KillerPly.InvisibleActive = true
			KillerPly:CrosshairDisable()

			net.Start("sls_Invisible")
					net.WriteBool(true)
			net.Send(KillerPly)

		end)

	elseif KillerPly.InvisibleActive and !KillerInView  then
		KillerPly:EmitSound( "slashers/effects/proxy_power_off.wav" )

		timer.Simple( 1, function ()
		--	KillerPly:AddKey( IN_ATTACK )
		--	KillerPly:AddKey( IN_ZOOM )
			KillerPly:Give(KillerPly.InitialWeapon)
			KillerPly:SetColor( KNormal )
			KillerPly:SetRunSpeed( 400 )
			KillerPly:DrawShadow( true )
			KillerPly:SetWalkSpeed(GAMEMODE.CLASS.Killers[CLASS_KILL_PROXY].walkspeed)
			KillerPly:SetRunSpeed(GAMEMODE.CLASS.Killers[CLASS_KILL_PROXY].walkspeed)
			KillerPly:SetRenderMode(RENDERMODE_TRANSALPHA )

			KillerPly.InvisibleActive = false

			net.Start("sls_Invisible")
					net.WriteBool(false)
			net.Send(KillerPly)

		end)
	end
end
net.Receive( "sls_EnableInvisibility", disapearKiller)


local function ResetVisibility()
	for k,v in pairs(player.GetAll()) do
	 v:DrawShadow( true )
		if IsValid(GAMEMODE.CLASS.Killers) and GM.ROUND.Killer.ClassID == CLASS_KILL_PROXY then
			v:SetWalkSpeed(GAMEMODE.CLASS.Killers[CLASS_KILL_PROXY].walkspeed)
			v:SetRunSpeed(GAMEMODE.CLASS.Killers[CLASS_KILL_PROXY].walkspeed)
			GM.ROUND.Killer.InvisibleActive = false
		end
		v:SetRenderMode(RENDERMODE_TRANSALPHA )
		v:SetColor(Color(255,255,255))
	end
	if (!GAMEMODE.ROUND.Killer) then return end
	net.Start("sls_Invisible")
		net.WriteBool(false)
	net.Send(GAMEMODE.ROUND.Killer)
end
hook.Add("PostPlayerDeath","sls_ResetViewKiller",ResetVisibility)
hook.Add("sls_round_PostStart","ResetViewKillerAfterEnd",ResetVisibility)
