-- Utopia Games - Slashers
--
-- @Author: Vyn
-- @Date:   2017-07-26 00:55:25
-- @Last Modified by:   Vyn
-- @Last Modified time: 2017-07-26 15:21:35

if CLIENT then
	local button_E_last = CurTime()
	local button_E_current = 0
	local beartrap_progessbar = Material("bnz_ui/progress_forground.png")
	local beartrap_pressE = {}
	beartrap_pressE[0] = Material("icons/bouton_down.png")
	beartrap_pressE[1] = Material("icons/bouton_up.png")
	local beartrap_pressECurrent;
	local x = (ScrW() / 2) - (beartrap_progessbar:Width() / 2);
	local y = ScrH() - 300;
	local tapleft = 0
	hook.Add( "HUDPaint", "hud_slashers_beartrap", function()
		if (tapleft > 0) then
			surface.SetDrawColor(255, 0, 0)
			surface.DrawRect( x + 15, y + 15, (beartrap_progessbar:Width() - 30) * ((slashers_beartrap_maxtap - tapleft) / slashers_beartrap_maxtap), beartrap_progessbar:Height() - 30)
			surface.SetMaterial(beartrap_progessbar)
			surface.DrawTexturedRect( x, y, beartrap_progessbar:Width(), beartrap_progessbar:Height())
			beartrap_pressECurrent = beartrap_pressE[button_E_current]
			if (CurTime() - button_E_last > 0.25) then
				button_E_last = CurTime()
				if button_E_current == 1 then button_E_current = 0
				elseif button_E_current == 0 then button_E_current = 1 end
			end
			surface.SetMaterial(beartrap_pressECurrent)
			surface.DrawTexturedRect( x + (beartrap_progessbar:Width() / 2) - (beartrap_pressECurrent:Width() / 2), (y - beartrap_pressECurrent:Height()) - 20, beartrap_pressECurrent:Width(), beartrap_pressECurrent:Height())
		end
	end)

	net.Receive("slashers_beartrap_tap", function( len, pl )
		tapleft = net.ReadInt(32)
	end )
end

if SERVER then
	hook.Add( "PlayerDeath", "slashers_beartrap_playerdeath", function(victim, inflictor, attacker)
		if (victim.beartrap) then
			victim.beartrap:DesactivateOnPlayer(victim, victim.beartrap)
		end
	end)
end