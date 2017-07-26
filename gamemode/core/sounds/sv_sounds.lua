-- Utopia Games - Slashers
--
-- @Author: Garrus2142
-- @Date:   2017-07-25 16:15:48
-- @Last Modified by:   Garrus2142
-- @Last Modified time: 2017-07-26 14:45:55

local metaplayer = FindMetaTable("Player")
util.AddNetworkString("sls_sounds_PlaySound")

function metaplayer:PlaySound(sound)
	net.Start("sls_sounds_PlaySound")
		net.WriteString(sound)
	net.Send(self)
end