-- Utopia Games - Slashers
--
-- @Author: Guilhem PECH
-- @Date:   2017-07-27 13:26:23
-- @Last Modified by:   Guilhem PECH
-- @Last Modified time: 2017-07-27 13:33:18


-- The gamemode CANNOT handle more than 10 players !
hook.Add( "CheckPassword", "max_players", function(  steamID64, ipAddress, svPassword, clPassword, name  )
	if player.GetCount() >= 10 then
    return false, "# GameUI_ServerRejectServerFull"
  end
end )
