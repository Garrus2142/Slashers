-- Utopia Games - Slashers
--
-- @Author: Guilhem PECH
-- @Date:   2017-07-26T18:34:04+02:00
-- @Last Modified by:   Guilhem PECH
-- @Last Modified time: 2017-07-26T18:50:32+02:00



local WorkShopAddonIDList = {"788009163","857992903"}

function WorkshopDownloadCheck()
	local AlreadyDownloaded = true
	for k, v in pairs(WorkShopAddonIDList) do
		if !steamworks.IsSubscribed(v) then
			AlreadyDownloaded = false
		end
	end
	if AlreadyDownloaded then return end
	local Frame = vgui.Create( "DFrame" )
	Frame:Center()
	Frame:SetSize( 300, 75 )
	Frame:SetTitle( "Steam Workshop" )
	Frame:SetVisible( true )
	Frame:SetDraggable( true )
	Frame:ShowCloseButton( true )
	Frame:MakePopup()

	local DLabel = vgui.Create( "DLabel", Frame )
	DLabel:SetPos( 5, 25 )
	DLabel:SetText( "You may need extra content from the Steam Workshop." )
	DLabel:SizeToContents()

	local WSButton = vgui.Create( "DButton", Frame )
	WSButton:SetText( "Take me to it!" )
	WSButton:SetTextColor( Color( 0, 0, 0 ) )
	WSButton:SetPos( 5, 40 )
	WSButton:SetSize( 100, 30 )
	WSButton.DoClick = function()
		steamworks.ViewFile("1090847479") --set your workshop content url here, or your FastDL link.
		Frame:Close()
	end

	local CloseButton = vgui.Create( "DButton", Frame )
	CloseButton:SetText( "I'd rather not." )
	CloseButton:SetTextColor( Color( 0, 0, 0 ) )
	CloseButton:SetPos( 195, 40 )
	CloseButton:SetSize( 100, 30 )
	CloseButton.DoClick = function()
		Frame:Close()
	end
end
concommand.Add("OpenWSDL", WorkshopDownloadCheck)
net.Receive("slash_WorkShopCheck",WorkshopDownloadCheck)
