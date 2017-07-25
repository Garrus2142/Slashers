local GM = GM or GAMEMODE

-- Son à la mort d'un joueur
local function PlayerDeath(victim, inflictor, attacker)
	if victim:Team() == TEAM_SURVIVORS then
		for _, v in ipairs(player.GetAll()) do
			if victim.ClassID != 0 then
				v:PlaySound(GM.CLASS.Survivors[victim.ClassID].die_sound)
			end
		end
	end
end
hook.Add("PlayerDeath", "shl_soundscape_PlayerDeath", PlayerDeath)