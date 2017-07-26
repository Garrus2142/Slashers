-- Utopia Games - Slashers
--
-- @Author: Garrus2142
-- @Date:   2017-07-25 16:15:47
-- @Last Modified by:   Garrus2142
-- @Last Modified time: 2017-07-26 14:45:38

local GM = GM or GAMEMODE

GM.ROUND = {}
GM.ROUND.Count = 0
GM.ROUND.Active = false
GM.ROUND.WaitingPlayers = true
GM.ROUND.CameraEnable = true
GM.ROUND.WaitingPolice = false
GM.ROUND.Escape = false

function GM.ROUND:GetSurvivorsAlive()
	local alive = {}
	if GM.ROUND.Survivors then
		for _, v in ipairs(GM.ROUND.Survivors) do
			if IsValid(v) && v:Alive() then
				table.insert(alive, v)
			end
		end
	end
	return alive
end