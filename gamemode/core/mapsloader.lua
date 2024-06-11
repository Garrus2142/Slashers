-- Utopia Games - Slashers
--
-- @Author: Garrus2142
-- @Date:   2017-08-07T19:23:20+02:00
-- @Last modified by:   Guilhem PECH
-- @Last modified time: 21-Oct-2018

local GM = GM or GAMEMODE

local currentMap = game.GetMap()
local mapsLuaPath = "slashers/gamemode/maps"
local mapsLua = file.Find(mapsLuaPath .. "/*.lua", "LUA")
local mapsPath = "maps/"
local maps = file.Find(mapsPath .. "/*.bsp", "GAME")

GM.MAPS = {}
GM.MAP = {}
GM.MAP.Killer = {}

function GM.MAP.Killer:UseAbility( ply ) end

-- Get list of valid maps
for _, v in ipairs(mapsLua) do
	if table.HasValue(maps, string.StripExtension(v) .. ".bsp") then
		table.insert(GM.MAPS, string.StripExtension(v))
	end
end


local function loadMapsData()
	if SERVER then
		util.AddNetworkString("sls_mapsloader_useability")

		if !table.HasValue(GM.MAPS, game.GetMap()) then
			timer.Create("sls_error_map", 5, 0, function()
				print("ERROR: The current map isn't supported by gamemode.")
			end)
		else
			print("Loading Slashers map data " .. game.GetMap())
			AddCSLuaFile(mapsLuaPath .. "/" .. game.GetMap() .. ".lua")
			include(mapsLuaPath .. "/" .. game.GetMap() .. ".lua")
		end
	else

		if !table.HasValue(GM.MAPS, game.GetMap()) then
			timer.Create("sls_error_map", 5, 0, function()
				print("ERROR: The current map isn't supported by gamemode.")
			end)
		else
			print("Loading Slashers map data " .. game.GetMap())
			include(mapsLuaPath .. "/" .. game.GetMap() .. ".lua")
		end
	end
end
hook.Add("PostGamemodeLoaded","sls_mapsloadData",loadMapsData)

if SERVER then

	local function UseAbility(len, ply)
		GM.MAP.Killer:UseAbility( ply )
	end
	net.Receive("sls_mapsloader_UseAbility", UseAbility)

else

	local function getMenuKey()
		local cpt = 0
		while input.LookupKeyBinding( cpt ) != "+menu" && cpt < 159 do
			 cpt = cpt + 1
		end
		return  cpt
	end

	local function PlayerButtonDown(ply, button)
		if !IsFirstTimePredicted() then return end

		if GM.ROUND.Active && ply:Team() == TEAM_KILLER && button == getMenuKey() then
			net.Start("sls_mapsloader_useability")
			net.SendToServer()
			GM.MAP.Killer:UseAbility( ply )
		end
	end
	hook.Add("PlayerButtonDown", "sls_mapsloader_PlayerButtonDown", PlayerButtonDown)
end
