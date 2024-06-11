-- Utopia Games - Slashers
--
-- @Author: Guilhem PECH
-- @Date:   2017-07-26T15:18:58+02:00
-- @Last Modified by:   Garrus2142
-- @Last Modified time: 2017-07-26 22:32:05



local NOTICON_ICON = Material("icons/icon_exit.png")
local noticonData = {}

net.Receive( "notificationSlasher", function()
	 local NotifText = net.ReadTable()
	 local NotifType = net.ReadString()
	 notificationPanel(GAMEMODE.LANG:GetString(unpack(NotifText)),NotifType)

end )

concommand.Add( "Notice", function(a,b,c,argStr)
	notificationPanel('materials/icons/icon_exit.png',argStr)
	end )

function notificationPanel(notifText,notificationType)

	-- Type differenciation
	Type = notificationType..".png"
	if (notificationType ) then
		iconPath = "materials/icons/icon_"..Type
	else
		iconPath = "materials/icons/icon_caution.png"
	end

	-- Container panel
	local BackGroundPanel = vgui.Create( "DPanel" )
	BackGroundPanel:SetSize( 512, 128 )
	BackGroundPanel:AlignBottom(-128)
	BackGroundPanel:AlignRight(250)
	BackGroundPanel:SetPaintBackground( false )
	BackGroundPanel:SetTerm( 4.7 )
	if (!CounterActiveNotif || CounterActiveNotif == 0)  then
		CounterActiveNotif = 1
	else
		CounterActiveNotif = CounterActiveNotif + 1
	end

	-- Blood background
	local img_bg = vgui.Create( "DImage", BackGroundPanel )
	img_bg:SetSize( BackGroundPanel:GetSize() )
	img_bg:SetImage( "materials/icons/scoreboard_line.png" )

	--- Check image
	local img_check = vgui.Create( "DImage", BackGroundPanel )
	img_check:SetSize( 50,50 )
	img_check:SetPos(40,10)
	img_check:SetImage( iconPath )

	--- Text
	local Text = vgui.Create( "DLabel", BackGroundPanel )
	Text:SetText( notifText )
	Text:SetTextColor( Color( 255, 255, 255 ) )
	Text:SetPos( 95, -30 )
	Text:SetContentAlignment(5)
	Text:SetFont( "Bohemian typewriter" )
	Text:SetSize( 402,128 )

	---

	ToThisPosUp = BackGroundPanel.y - (CounterActiveNotif * 100)
	ToThisPosDown = BackGroundPanel.y + (CounterActiveNotif * 100)

	-- Animation
	BackGroundPanel:MoveTo( BackGroundPanel.x, ToThisPosUp, 1, 0) -- Slide up
	BackGroundPanel:MoveTo(BackGroundPanel.x,ToThisPosDown, 0.7, 4, -1)   -- Slide Down

	if notificationType == "cross" then
		surface.PlaySound( "slashers/effects/invalid.wav" )
	elseif (notificationType == "safe" || notificationType == "exit" || notificationType =="question")  then
		surface.PlaySound( "slashers/effects/notif_2.wav" )
	end


	timer.Simple( 4.7, function() CounterActiveNotif = 0
	end )

end

function noticon(pos, icon, length)
	local data = {pos = pos, icon = NOTICON_ICON, timer = CurTime() + length}

	table.insert(noticonData, data)
end

net.Receive("noticonSlashers", function(len, ply)
	noticon(net.ReadVector(), net.ReadString(), net.ReadInt(32))
end)

hook.Add("HUDPaint", "notification_HUDPaint", function()

	for k, v in ipairs(noticonData) do
		local pos1 = v.pos:ToScreen()
		surface.SetDrawColor(Color(255, 255, 255))
		surface.SetMaterial(v.icon)
		surface.DrawTexturedRect(pos1.x - 64, pos1.y - 64, 128, 128)

		if v.timer && v.timer < CurTime() then
			table.remove(noticonData, k)
		end
	end
end)
