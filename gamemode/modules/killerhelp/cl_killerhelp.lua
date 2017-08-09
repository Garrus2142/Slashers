-- Utopia Games - Slashers
--
-- @Author: Garrus2142
-- @Date:   2017-07-25 16:15:50
-- @Last Modified by:   Garrus2142
-- @Last Modified time: 2017-08-07T18:37:28+02:00

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
