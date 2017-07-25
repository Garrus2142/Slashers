util.AddNetworkString("shop_OpenShop")

local function OpenShop(ply)
	if IsValid(ply) then
		net.Start("shop_OpenShop")
		net.Send(ply)
	end
end
hook.Add("ShowSpare2", "shop_ShowSpare2", OpenShop)
