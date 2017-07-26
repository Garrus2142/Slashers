-- Utopia Games - Slashers
--
-- @Author: Garrus2142
-- @Date:   2017-07-26 01:30:34
-- @Last Modified by:   Garrus2142
-- @Last Modified time: 2017-07-26 14:48:12

local AFK_WARN_DELAY = 60
local AFK_KICK_DELAY = 80
local AFK_DIST_RESET = 10000

local function PlayerSpawn(ply)
	ply.lastpos = ply:GetPos()
	ply.lastang = ply:EyeAngles()
	ply.afktime = CurTime()

end
hook.Add("PlayerSpawn", "antiafk_PlayerSpawn", PlayerSpawn)

local function Think()
	local curtime = CurTime()

	for _, v in ipairs(player.GetAll()) do
		if !v:Alive() || v:IsBot() then 
			v.afktime = curtime
			continue
		end

		-- Reset
		if v.lastpos != v:GetPos() || v.lastang != v:EyeAngles() then
			v.afktime = curtime
			v.lastpos = v:GetPos()
			v.lastang = v:EyeAngles()
			v:SetNWInt("afk_warn", 0)

		elseif curtime > v.afktime + AFK_KICK_DELAY then
			-- Kick
			//v:Kill("Vous avez été kick par le système d'anti AFK")
			v:Kill()
			v.afktime = CurTime()
			v:SetNWInt("afk_warn", 0)
			v:ChatPrint("[Anti-AFK] You're killed by anti-afk system !")

		elseif v:GetNWInt("afk_warn") == 0 && curtime > v.afktime + AFK_WARN_DELAY then
			-- Warning
			v:SetNWInt("afk_warn", v.afktime + AFK_KICK_DELAY)
		end
	end
end
hook.Add("Think", "antiafk_Think", Think)