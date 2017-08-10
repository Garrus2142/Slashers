-- Utopia Games - Slashers
--
-- @Author: Guilhem PECH <Daryl_Winters>
-- @Date:   2017-08-06T09:44:00+02:00
-- @Last Modified by:   Garrus2142
-- @Last Modified time: 2017-08-10T16:25:03+02:00

util.AddNetworkString("slash_sendvotedata")
util.AddNetworkString("slash_summitvote")
util.AddNetworkString("slash_openvotemap")
util.AddNetworkString("slash_sendmaplist")

local GM = GAMEMODE or GM

local currentVote = {}
local countVote = {}

local function sendCurrentVoteStat(ply)
  net.Start("slash_sendmaplist")
    net.WriteTable(GM.MAPS)
  net.Send(ply)
end
hook.Add("PlayerInitialSpawn", "slash_sendmaplist", sendCurrentVoteStat)


local function receiveVote(len, player)
  local map = net.ReadString()
  if map != "" then
    currentVote[player] = map
  end
  for k,v in pairs(GM.MAPS) do
    countVote[v] = #table.KeysFromValue(currentVote,v)
  end
    countVote["extend"] = #table.KeysFromValue(currentVote,"extend")
    countVote["random"] = #table.KeysFromValue(currentVote,"random")
  net.Start("slash_sendvotedata")
    net.WriteTable(countVote)
  net.Broadcast()
end
net.Receive("slash_summitvote",receiveVote)

local function openVoteMap(ply, imput)
  if (imput == KEY_F2) then
    net.Start("slash_openvotemap")
    net.Send(ply)
  end
end
hook.Add("PlayerButtonDown","slash_openvotemap",openVoteMap )

local function changeMap()
  if !GM.ROUND.Active && GM.ROUND.NextStart && CurTime() >= GM.ROUND.NextStart && GM.ROUND.Count >= GetConVar("slashers_round_max"):GetInt()  then
		local winner = table.GetWinningKey( countVote )
    countVote = {}
    currentVote = {}
    if winner == "extend" then
      winner = game.GetMap()
      GM.ROUND.Count = 0
      PrintMessage( HUD_PRINTTALK, "Map extended !" )
      return
    elseif winner == "random" then
      winner = GM.MAPS[ math.random( #GM.MAPS ) ]
    end
		GM.ROUND.NextStart = nil
		RunConsoleCommand("changelevel", string.StripExtension( winner))
	end
end
hook.Add("Think", "sls_votemap_Think", changeMap)

local function autoOpen()
  if GM.ROUND.Count == GetConVar("slashers_round_max"):GetInt() then
    net.Start("slash_openvotemap")
    net.Broadcast()
  end
end
hook.Add("sls_round_End","sls_autoOpen",autoOpen)

local rtvCount = {}

local function removeDisconnectVote(ply)
  if currentVote[ply] then
    currentVote[ply] = nil
  end
end
hook.Add("PlayerDisconnected","sls_remove_disconnectedvote",removeDisconnectVote)
