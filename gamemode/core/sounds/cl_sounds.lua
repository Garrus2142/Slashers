-- Utopia Games - Slashers
--
-- @Author: Garrus2142
-- @Date:   2017-07-25 16:15:48
-- @Last Modified by:   Garrus2142
-- @Last Modified time: 2017-07-26 14:45:56

local function PlaySound()
	local sound = net.ReadString()
	surface.PlaySound(sound)
end
net.Receive("sls_sounds_PlaySound", PlaySound)