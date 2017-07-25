util.AddNetworkString("sls_f1_menu")

local function F1Menu(ply)
	if ply:Alive() && GAMEMODE.ROUND.Active then
		net.Start("sls_f1_menu")
		net.Send(ply)
	end
end
hook.Add( "ShowHelp", "sls_F1MenuShow", F1Menu )