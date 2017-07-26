-- Utopia Games - Slashers
--
-- @Author: Garrus2142
-- @Date:   2017-07-25 16:15:48
-- @Last Modified by:   Garrus2142
-- @Last Modified time: 2017-07-26 14:45:37

local GM = GM or GAMEMODE
local folder = "slashers/"

function GM.ROUND:ChooseKiller()
	local tbl = {}
	local winkey = 0
	for _, v in ipairs(player.GetAll()) do
		if !tbl[v.choosekiller] then
			tbl[v.choosekiller] = {}
		end
		table.insert(tbl[v.choosekiller], v)
	end
	for k, _ in pairs(tbl) do
		winkey = math.max(winkey, k)
	end
	return table.Random(tbl[winkey])
end

local function PlayerLoad(ply)
	if !IsValid(ply) then return end
	if ply:IsBot() then ply.choosekiller = 100 return end
	if !file.Exists(folder .. ply:SteamID64(), "DATA") then
		file.CreateDir(folder .. ply:SteamID64())
	end
	if !file.Exists(folder .. ply:SteamID64() .. "/choosekiller.txt", "DATA") then
		file.Write(folder .. ply:SteamID64() .. "/choosekiller.txt", "100")
		ply.choosekiller = 100
	end
	if !ply.choosekiller then
		ply.choosekiller = tonumber(file.Read(folder .. ply:SteamID64() .. "/choosekiller.txt", "DATA"))
	end
end

local function PlayerSave(ply)
	if !IsValid(ply) || ply:IsBot() then return end
	if !file.Exists(folder .. ply:SteamID64(), "DATA") then
		file.CreateDir(folder .. ply:SteamID64())
	end
	file.Write(folder .. ply:SteamID64() .. "/choosekiller.txt", ply.choosekiller or "100")
end

local function PlayerInitialSpawn(ply)
	PlayerLoad(ply)
end
hook.Add("PlayerInitialSpawn", "sls_choosekiller_PlayerInitialSpawn", PlayerInitialSpawn)

local function PostStart()
	if IsValid(GM.ROUND.Killer) then
		GM.ROUND.Killer.choosekiller = 0
		PlayerSave(GM.ROUND.Killer)
	end
end
hook.Add("sls_round_PostStart", "sls_choosekiller_PostStart", PostStart)

local function OnTeamWin()
	for _, v in ipairs(GM.ROUND.Survivors) do
		if IsValid(v) then
			v.choosekiller = math.Min(100, v.choosekiller + GM.CONFIG["round_choosekiller_add"])
			PlayerSave(v)
		end
	end
end
hook.Add("sls_round_OnTeamWin", "sls_choosekiller_OnTeamWin", OnTeamWin)