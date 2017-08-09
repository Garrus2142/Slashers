-- Utopia Games - Slashers
--
-- @Author: Garrus2142
-- @Date:   2017-07-25 16:15:50
-- @Last Modified by:   Garrus2142
-- @Last Modified time: 2017-08-07T18:52:38+02:00

local GM = GM or GAMEMODE

util.AddNetworkString("sls_popularhelp_AddExit")

local function AddExit(pos)
	if !GM.ROUND.Active || !IsValid(GM.ROUND.Killer) then return end
	net.Start("sls_popularhelp_AddExit")
		net.WriteVector(pos)
	net.Send(GM.ROUND.Survivors)
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

end
hook.Add("Think", "sls_killerhelp_Think", Think)

local function PlayerDeath(ply)
	ply:SetNWBool("killerhelp_camp", false)
end
hook.Add("PlayerDeath", "sls_killerhelp_PlayerDeath", PlayerDeath)

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
