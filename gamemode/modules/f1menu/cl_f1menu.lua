-- Utopia Games - Slashers
--
-- @Author: Guilhem PECH
-- @Date:   2017-07-26T13:50:55+02:00
-- @Last Modified by:   Guilhem PECH
-- @Last Modified time: 2017-07-26T15:16:06+02:00



local active
local GM = GAMEMODE or GM

function ShowPlayerScreen(TeamName,TeamText,CharacName,CharacText,ImageCharac,Time,isOpen,active)
	active = true
	local BGPanel = vgui.Create( "DPanel" )
	BGPanel:SetSize( ScrW(),ScrH() )
	BGPanel:Dock(FILL)
	BGPanel:SetDrawBackground( true )

	local PersoPANEL = vgui.Create("DPanel",BGPanel)
	PersoPANEL:SetPaintBackground( true )
	BGPanel:SetBackgroundColor(Color( 0, 0, 0, 140 ))
	PersoPANEL:SetBackgroundColor(Color( 0, 0, 0, 150 ))
	PersoPANEL:SetSize(ScrW(),0)
	PersoPANEL:Center()

	local img_charac = vgui.Create( "DImage", PersoPANEL )
	--img_charac:SetSize( (1/1.5)*ScrH(),((1/1.5)*ScrH())*1.0932 )

	img_charac:SetImage( ImageCharac )
	img_charac:SetTall((1/1.5)*ScrH())
	img_charac:SetWide((1/1.5)*ScrH()/1080*987)
	img_charac:Center()
	PersoPANEL:MoveTo(0, (ScrH()/2) - ((1/1.5)*ScrH())/2 ,0.5,0,1)
	img_charac:MoveTo((ScrW() /2) - (img_charac:GetWide()/2), 0  ,0.5,0,1)

	PersoPANEL:SizeTo( ScrW(), (1/1.5)*ScrH(), 0.5, 0, -1,  function ()

		img_charac:MoveTo( 0, 0, 0.3,0,1,function()

			--PersoPANEL:SetPaintBackground( true )

			DescriptionBox = vgui.Create("DPanel",PersoPANEL)
			DescriptionBox:StretchToParent( (1/1.45)*ScrH() , 5, 5, 5 )
			DescriptionBox:SetContentAlignment( 7 )
			DescriptionBox:SetPaintBackground( false )


			local TitleSpe = vgui.Create("DLabel",DescriptionBox)
			TitleSpe:SetText("You are "..CharacName)
			TitleSpe:SetFont( "Bohemian typewriter TITLE" )
			TitleSpe:SetColor(Color(168,0,0,255))
			TitleSpe:SizeToContents()
			TitleSpe:SetWrap( true )
			TitleSpe:SetAutoStretchVertical( true )
			TitleSpe:SetWidth((1/1.45)*ScrH())

			local SpecificDescription = vgui.Create("DLabel",DescriptionBox)
			SpecificDescription:SetText(CharacText)
			SpecificDescription:SetFont( "Bohemian typewriter SA" )
			SpecificDescription:MoveBelow( TitleSpe, 5 )
			SpecificDescription:SizeToContents()
			SpecificDescription:SetWidth((1/1.45)*ScrH())
			SpecificDescription:SetWrap( true )
			SpecificDescription:SetAutoStretchVertical( true )


			local TitleGen = vgui.Create("DLabel",DescriptionBox)
			--Title1:Dock(TOP)
			TitleGen:SetText("You are " .. TeamName)
			TitleGen:MoveBelow( SpecificDescription, 1/4*ScrH() )
			TitleGen:SetFont( "Bohemian typewriter TITLE" )
			TitleGen:SetColor(Color(168,0,0,255))
			TitleGen:SizeToContents()
			TitleGen:SetWrap( true )
			TitleGen:SetAutoStretchVertical( true )
			TitleGen:SetWidth((1/1.45)*ScrH())

			local GenericDescription = vgui.Create("DLabel",DescriptionBox)
			GenericDescription:SetText(TeamText)
			GenericDescription:SetFont( "Bohemian typewriter SA" )
			GenericDescription:MoveBelow( TitleGen, 5 )
			GenericDescription:SizeToContents()
			GenericDescription:SetWrap( true )
			GenericDescription:SetAutoStretchVertical( true )
			GenericDescription:SetWidth((1/1.45)*ScrH())
		end )
end)

if Time ~= 0 then
	timer.Simple( Time-0.3, function()
		img_charac:MoveTo((ScrW() /2) - (img_charac:GetWide()/2)  ,0,0.5,0,1)
		DescriptionBox:MoveTo((ScrW() /2) - (DescriptionBox:GetWide()/2.5)  ,0,0.5,0,1)
		DescriptionBox:MoveToBefore(img_charac)
		DescriptionBox:SizeTo( 0, DescriptionBox:GetTall(), 0.4, 0, -1,  function ()
			PersoPANEL:MoveBy(0,PersoPANEL:GetTall() /2,0.5,0.1,1)
			PersoPANEL:SizeTo(PersoPANEL:GetWide(),0,0.5,0.1,1)
			img_charac:MoveBy(0,-(PersoPANEL:GetTall()/2),0.5,0.1,1,function()
				BGPanel:Remove()
				isOpen = false
			end)
		end)

	end )
end
if Time == 0 then

	local CloseB = vgui.Create( "DButton" )
	CloseB:MakePopup()
	CloseB:MoveToFront()
	CloseB:SetPos( 40, 40 )
	CloseB:SetText( "X" )

	CloseB:SetSize( 20, 20 )
	CloseB.DoClick = function()
		img_charac:MoveTo((ScrW() /2) - (img_charac:GetWide()/2)  ,0,0.5,0,1)
		DescriptionBox:MoveTo((ScrW() /2) - (DescriptionBox:GetWide()/2.5)  ,0,0.5,0,1)
		DescriptionBox:MoveToBefore(img_charac)
		DescriptionBox:SizeTo( 0, DescriptionBox:GetTall(), 0.4, 0, -1,  function ()
			PersoPANEL:MoveBy(0,PersoPANEL:GetTall() /2,0.5,0.1,1)
			PersoPANEL:SizeTo(PersoPANEL:GetWide(),0,0.5,0.1,1)
			img_charac:MoveBy(0,-(PersoPANEL:GetTall()/2),0.5,0.1,1,function() BGPanel:Remove() end)
		end)
		CloseB:Remove()
		active = false
	end
end

end

net.Receive( "sls_f1_menu", function ()
	active = false
	local TeamName
	local TeamText
	local ImageCharac
	local CharacName

	if LocalPlayer():Team() == 2 then

		TeamName = "a Survivor"
		TeamText = "Each survivor has a special perk. Your goal is to find jerrycans (number varying with the amount of player) to fill the generator so you can turn on the radio then call the police for help. Each element you have to find has many possible spawn points and spawns randomly on the map. The teamplay and a moderate use of your flashlight are the key of surviving."
		ImageCharac = "/characteres/"..string.lower(GAMEMODE.CLASS.Survivors[LocalPlayer().ClassID].name)..".png"
		CharacName = GAMEMODE.CLASS.Survivors[LocalPlayer().ClassID].dispname
		CharacText = GAMEMODE.CLASS.Survivors[LocalPlayer().ClassID].description

	elseif LocalPlayer():Team() == 1 then
		TeamName = "the Killer"
		TeamText = "You are a killer from a slasher movie and you are immortal. Your goal is to kill every survivors before they can escape. You are randomly given one of the following weapons ; the axe, the machete or the chainsaw (which turns on by pushing R) To give a harder hit, you can hold left click and release. You can hear survivors' heartbeat when they're not moving, just follow the sound and you'll find them."
		ImageCharac = "/characteres/"..string.lower(GAMEMODE.CLASS.Killers[LocalPlayer().ClassID].name)..".png"
		CharacName = GM.CLASS.Killers[LocalPlayer().ClassID].name
		CharacText = GAMEMODE.CLASS.Killers[LocalPlayer().ClassID].description
	end

	if (!active) then
		ShowPlayerScreen(TeamName,TeamText,CharacName,CharacText,ImageCharac,0,active)
	end
end)

function ShowTitle(Title,Second)
	local BGPanel = vgui.Create( "DPanel" )
	BGPanel:SetSize( ScrW(),ScrH() )

	BGPanel:Dock(FILL)
	BGPanel:SetDrawBackground( true )
	BGPanel:SetBackgroundColor(Color( 0, 0, 0, 250 ))
	BGPanel:SetTerm( 5.5 )
	surface.PlaySound( "/slashers/effects/notif_2.wav" )
	BGPanel:Center()

	local LABEL = vgui.Create("DLabel",BGPanel)
	LABEL:Center()
	LABEL:SetFont( "Friday13" )
	LABEL:Dock(FILL)
	LABEL:SetContentAlignment( 5 )

	LABEL:SetText( Title )

	timer.Simple( Second-0.3, function()

		LABEL:SlideUp( 0.2 )
		timer.Simple( 0.3, function()
			BGPanel:Remove()
		end)
	end )
end
