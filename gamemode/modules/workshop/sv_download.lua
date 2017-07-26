-- Utopia Games - Slashers
--
-- @Author: Guilhem PECH
-- @Date:   2017-07-26T18:35:23+02:00
-- @Last Modified by:   Guilhem PECH
-- @Last Modified time: 2017-07-26 22:32:22


util.AddNetworkString( "slash_WorkShopCheck" )
function WSDLCheckOpen(ply)
    net.Start("slash_WorkShopCheck")
	net.Send(ply)
end
hook.Add("PlayerInitialSpawn", "WSDLCheckOpen", WSDLCheckOpen)
