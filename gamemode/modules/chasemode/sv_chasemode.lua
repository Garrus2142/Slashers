-- Utopia Games - Slashers
--
-- @Author: Guilhem PECH
-- @Date:   2017-07-26T13:54:42+02:00
-- @Last Modified by:   Guilhem PECH
-- @Last Modified time: 2017-07-26T15:15:58+02:00



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
