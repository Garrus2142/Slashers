-- Utopia Games - Slashers
--
-- @Author: Garrus2142
-- @Date:   2017-07-25 16:15:47
-- @Last Modified by:   Garrus2142
-- @Last Modified time: 2017-07-26 14:45:38

local GM = GM or GAMEMODE
local scrw, scrh = ScrW(), ScrH()

local function HUDPaint()
	local curtime = CurTime()
	if GM.ROUND.Active && GM.ROUND.EndTime && GM.ROUND.EndTime > curtime then
		local text
		if GM.ROUND.WaitingPolice then
			text = LocalPlayer():Team() == TEAM_SURVIVORS and "Police arrives in " or "Kill them all "
		elseif GM.ROUND.Escape then
			text = LocalPlayer():Team() == TEAM_SURVIVORS and "Escape " or "Don't let them go "
		else
			text = LocalPlayer():Team() == TEAM_SURVIVORS and "Complete the objectives  " or "Kill them all "
		end
		text = text .. math.floor((GM.ROUND.EndTime - curtime) / 60) .. ":" .. format.Seconde(math.floor(GM.ROUND.EndTime - curtime) % 60)
		surface.SetFont("horror2")
		local tw = surface.GetTextSize(text)
		surface.SetTextColor(Color(220, 220, 220, 255))
		surface.SetTextPos(scrw / 2 - tw / 2, 40)
		surface.DrawText(text)
	end

	-- Waiting for player
	if GM.ROUND.WaitingPlayers then
		local text = "Waiting for players " .. #player.GetAll() .. "/" .. GM.CONFIG["round_min_player"]
		surface.SetFont("horror1")
		local tw = surface.GetTextSize(text)
		surface.SetTextColor(Color(255, 255, 255))
		surface.SetTextPos(scrw / 2 - tw / 2, 200)
		surface.DrawText(text)
	end

end
hook.Add("HUDPaint", "sls_round_HUDPaint", HUDPaint)

local function PostStart()
	ShowTitle("SLASHERS",4)
	timer.Simple(4, function()

		local TeamName
		local TeamText
		local ImageCharac
		local CharacName
		local CharacText
		if LocalPlayer():Team() == 1001 then return end
		if LocalPlayer():Team() == TEAM_SURVIVORS then

			TeamName = "a Survivor"
			TeamText = "Each survivor has a special perk. Your goal is to find jerrycans (number varying with the amount of player) to fill the generator so you can turn on the radio then call the police for help. Each element you have to find has many possible spawn points and spawns randomly on the map. The teamplay and a moderate use of your flashlight are the key of surviving."
			ImageCharac = "/characteres/"..string.lower(GAMEMODE.CLASS.Survivors[LocalPlayer().ClassID].name)..".png"
			CharacName = GAMEMODE.CLASS.Survivors[LocalPlayer().ClassID].dispname
			CharacText = GAMEMODE.CLASS.Survivors[LocalPlayer().ClassID].description
		elseif LocalPlayer():Team() == TEAM_KILLER then
			TeamName = "the Killer"
			TeamText = "You are a killer from a slasher movie and you are immortal. Your goal is to kill every survivors before they can escape. You are randomly given one of the following weapons ; the axe, the machete or the chainsaw (which turns on by pushing R) To give a harder hit, you can hold left click and release. You can hear survivors' heartbeat when they're not moving, just follow the sound and you'll find them."
			ImageCharac = "/characteres/"..string.lower(GAMEMODE.CLASS.Killers[LocalPlayer().ClassID].name)..".png"
			CharacName = GAMEMODE.CLASS.Killers[LocalPlayer().ClassID].name
			CharacText = GAMEMODE.CLASS.Killers[LocalPlayer().ClassID].description
		end

		ShowPlayerScreen(TeamName,TeamText,CharacName,CharacText,ImageCharac,GM.CONFIG["round_freeze_start"]-3)
	end)
end
hook.Add("sls_round_PostStart", "sls_round_PostStart", PostStart)

local function StartWaitingPolice()
	if LocalPlayer():Team() == TEAM_SURVIVORS then
		messages.PrintFade("Survive until the police arrival !", scrh / 2, 5, 2, Color(255, 255, 255), "horror1")
	end
end
hook.Add("sls_round_StartWaitingPolice", "sls_round_StartWaitingPolice", StartWaitingPolice)

local function StartEscape()
	messages.PrintFade(LocalPlayer():Team() == TEAM_SURVIVORS and "Escape" or "Don't let them go", scrh / 2, 5, 2, Color(255, 255, 255), "horror1")
end
hook.Add("sls_round_StartEscape", "sls_round_StartEscape", StartEscape)

local function OnTeamWin(winner)
	local text
	if winner == TEAM_SURVIVORS then
		text = "The survivors have escaped... for now"
		surface.PlaySound("slashers/ambient/survivors_win.wav")
	else
		text = "The survivors have been eradicated"
		surface.PlaySound("slashers/ambient/killer_win.wav")
	end

	messages.PrintFade(text, scrh / 2, 10, 3, Color(255, 255, 255), "horror1")
end
hook.Add("sls_round_OnTeamWin", "sls_round_OnTeamWin", function(winner) timer.Simple(0.1, function() OnTeamWin(winner) end) end)

local function CalcView(ply, pos, ang)
	if GM.ROUND.CameraEnable && GM.ROUND.CameraPos && GM.ROUND.CameraAng then
		-- Start camera
		local view = {}
		view.origin = GM.ROUND.CameraPos
		view.angles = GM.ROUND.CameraAng
		return view
	end
end
hook.Add("CalcView", "sls_round_CalcView", CalcView)
