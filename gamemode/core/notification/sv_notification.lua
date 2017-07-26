-- Utopia Games - Slashers
--
-- @Author: Guilhem PECH
-- @Date:   2017-07-26T13:50:55+02:00
-- @Last Modified by:   Guilhem PECH
-- @Last Modified time: 2017-07-26T15:16:09+02:00



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
