-- Utopia Games - Slashers
--
-- @Author: Guilhem PECH
-- @Date:   2017-07-26T18:34:04+02:00
-- @Last Modified by:   Guilhem PECH
-- @Last Modified time: 2017-07-26 22:44:22



local WorkShopAddonIDList = {"788009163","857992903"}

function WorkshopDownloadCheck()
	local AlreadyDownloaded = true
	for k, v in pairs(WorkShopAddonIDList) do
		if !steamworks.IsSubscribed(v) then
			AlreadyDownloaded = false
		end
	end
	if AlreadyDownloaded then return end
	local MainFrame = vgui.Create( "DFrame" )
	MainFrame:Center()
	MainFrame:SetSize( 300, 75 )
	MainFrame:SetTitle( "Steam Workshop" )
	MainFrame:SetVisible( true )
	MainFrame:SetDraggable( true )
	MainFrame:ShowCloseButton( true )
	MainFrame:MakePopup()

	local InstructionLabel = vgui.Create( "InstructionLabel", MainFrame )
	InstructionLabel:SetPos( 5, 25 )
	InstructionLabel:SetText( "You may need extra content from the Steam Workshop." )
	InstructionLabel:SizeToContents()

	local WSButton = vgui.Create( "DButton", MainFrame )
	WSButton:SetText( "Take me to it!" )
	WSButton:SetTextColor( Color( 0, 0, 0 ) )
	WSButton:SetPos( 5, 40 )
	WSButton:SetSize( 100, 30 )
	WSButton.DoClick = function()
		steamworks.ViewFile("1090847479") --set your workshop content url here, or your FastDL link.
		MainFrame:Close()
	end

	local CloseButton = vgui.Create( "DButton", MainFrame )
	CloseButton:SetText( "I'd rather not." )
	CloseButton:SetTextColor( Color( 0, 0, 0 ) )
	CloseButton:SetPos( 195, 40 )
	CloseButton:SetSize( 100, 30 )
	CloseButton.DoClick = function()
		MainFrame:Close()
	end
end
concommand.Add("OpenWSDL", WorkshopDownloadCheck)
net.Receive("slash_WorkShopCheck",WorkshopDownloadCheck)
