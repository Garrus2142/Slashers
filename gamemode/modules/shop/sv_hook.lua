-- Utopia Games - Slashers
--
-- @Author: Garrus2142
-- @Date:   2017-07-25 16:15:51
-- @Last Modified by:   Guilhem PECH
-- @Last Modified time: 2017-07-26 22:53:25

util.AddNetworkString("shop_OpenShop")

local function OpenShop(ply)
	if IsValid(ply) then
		net.Start("shop_OpenShop")
		net.Send(ply)
	end
end
hook.Add("ShowSpare2", "shop_ShowSpare2", OpenShop)
