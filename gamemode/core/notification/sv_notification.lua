util.AddNetworkString( "notificationSlasher" )
util.AddNetworkString( "objectiveSlasher" )
util.AddNetworkString( "activateProgressionSlasher" )
util.AddNetworkString( "noticonSlashers" )

hook.Add( "PlayerDeath", "WhenPlayerDie", function( ply, ent )
	local noteText = ply:Name() .. " is dead"
	net.Start( "notificationSlasher" )
		net.WriteString(noteText)
		net.WriteString("cross")
		net.Broadcast()
end )