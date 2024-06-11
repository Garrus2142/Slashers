-- @Author: Guilhem PECH
-- @Date:   21-Oct-2018
-- @Email:  guilhempech@gmail.com
-- @Project: Slashers
-- @Last modified by:   Guilhem PECH
-- @Last modified time: 21-Oct-2018


util.AddNetworkString( "sls_killerseesurvivor" )
util.AddNetworkString( "sls_chaseactivated" )

local function relayChase()
	local ply = net.ReadEntity()
	local color = net.ReadUInt(8)
	local time = CurTime()
	if !IsValid(GAMEMODE.ROUND.Killer) then return end
	if color != 0 then

	net.Start( "sls_chaseactivated" )
		net.WriteFloat(time)
	net.Send(ply)

	end
end
net.Receive( "sls_killerseesurvivor", relayChase)
