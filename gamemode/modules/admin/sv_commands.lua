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