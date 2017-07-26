-- Utopia Games - Slashers
--
-- @Author: Garrus2142
-- @Date:   2017-07-25 16:15:49
-- @Last Modified by:   Garrus2142
-- @Last Modified time: 2017-07-26 14:48:04

local function FindBySteamID(steamid)
	if !steamid then return end
	for _, v in ipairs(player.GetAll()) do
		if v:SteamID() == steamid then
			return v
		end
	end
end

concommand.Add("sls_restartround", function(ply, cmd, args)
	if !ply:IsSuperAdmin() then return end
	local ply = FindBySteamID(args[1])
	GAMEMODE.ROUND:Start(ply)
end)

concommand.Add("sls_changelevel", function(ply, cmd, args)
	if !ply:IsSuperAdmin() then return end
	if !args || !args[1] then return end
	RunConsoleCommand("changelevel", args[1])
end)