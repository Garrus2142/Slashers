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