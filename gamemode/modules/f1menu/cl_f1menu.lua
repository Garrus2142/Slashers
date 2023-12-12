-- Utopia Games - Slashers
--
-- @Author: Guilhem PECH
-- @Date:   2017-07-26T13:50:55+02:00
-- @Last Modified by:   Garrus2142
-- @Last Modified time: 2017-08-07T17:46:37+02:00

local GM = GAMEMODE or GM
local BackGroundPanel, timed

function ShowPlayerScreen(TeamName,TeamText,CharacName,CharacText,ImageCharac,Time,isOpen,active)

	if TeamName == nil or TeamText == nil or CharacName == nil or ImageCharac == nil then
		return
	end

	BackGroundPanel = vgui.Create( "DPanel" )
	BackGroundPanel:SetSize( ScrW(),ScrH() )
	BackGroundPanel:Dock(FILL)
	BackGroundPanel:SetDrawBackground( true )

	local PersoPANEL = vgui.Create("DPanel",BackGroundPanel)
	PersoPANEL:SetPaintBackground( true )
	BackGroundPanel:SetBackgroundColor(Color( 0, 0, 0, 140 ))
	PersoPANEL:SetBackgroundColor(Color( 0, 0, 0, 150 ))
	PersoPANEL:SetSize(ScrW(),0)
	PersoPANEL:Center()

	local img_charac = vgui.Create( "DImage", PersoPANEL )

	if !ImageCharac then
		ImageCharac = "/characteres/default.png"
	end
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
			TitleSpe:SetText(GM.LANG:GetString("f1menu_you_are", CharacName))
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
			TitleGen:SetText(GM.LANG:GetString("f1menu_you_are", TeamName))
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
		timed = true
		timer.Simple( Time-0.3, function()
			img_charac:MoveTo((ScrW() /2) - (img_charac:GetWide()/2)  ,0,0.5,0,1)
			DescriptionBox:MoveTo((ScrW() /2) - (DescriptionBox:GetWide()/2.5)  ,0,0.5,0,1)
			DescriptionBox:MoveToBefore(img_charac)
			DescriptionBox:SizeTo( 0, DescriptionBox:GetTall(), 0.4, 0, -1,  function ()
				PersoPANEL:MoveBy(0,PersoPANEL:GetTall() /2,0.5,0.1,1)
				PersoPANEL:SizeTo(PersoPANEL:GetWide(),0,0.5,0.1,1)
				img_charac:MoveBy(0,-(PersoPANEL:GetTall()/2),0.5,0.1,1,function()
					BackGroundPanel:Remove()
					isOpen = false
					timed = false
				end)
			end)
		end )
	else
		timed = false
	end
end

net.Receive( "sls_f1_menu", function ()
	local TeamName = " "
	local TeamText = " "
	local ImageCharac =  "materials/characteres/default.png"
	local CharacName = " "

	if timed then return end

	if IsValid(BackGroundPanel) then
		BackGroundPanel:Remove()
		return
	end

	if LocalPlayer():Team() == 2 then

		TeamName = GM.LANG:GetString("round_team_name_survivor")
		TeamText = GM.LANG:GetString("round_team_desc_survivor")
		ImageCharac = "materials/characteres/"..string.lower(GAMEMODE.CLASS.Survivors[LocalPlayer().ClassID].name)..".png"
		CharacName = GM.CLASS.Survivors[LocalPlayer().ClassID].dispname
		CharacText = GM.CLASS.Survivors[LocalPlayer().ClassID].description

	elseif LocalPlayer():Team() == 1 then
		TeamName = GM.LANG:GetString("round_team_name_killer")
		TeamText = GM.LANG:GetString("round_team_desc_killer")
		ImageCharac = "materials/characteres/"..string.lower(GAMEMODE.MAP.Killer.Name)..".png"
		CharacName = GM.MAP.Killer.Name
		CharacText = GM.MAP.Killer.Desc
  else
		TeamName = "unnafected"
		TeamText = "unaffected"
		ImageCharac = "materials/characteres/default.png"
		CharacName = "Unaffected"
		CharacText = "none"
	end

	ShowPlayerScreen(TeamName,TeamText,CharacName,CharacText,ImageCharac,0)
end)

function ShowTitle(Title,Second)
	local BackGroundPanel = vgui.Create( "DPanel" )
	BackGroundPanel:SetSize( ScrW(),ScrH() )

	BackGroundPanel:Dock(FILL)
	BackGroundPanel:SetDrawBackground( true )
	BackGroundPanel:SetBackgroundColor(Color( 0, 0, 0, 250 ))
	BackGroundPanel:SetTerm( 5.5 )
	surface.PlaySound( "slashers/effects/notif_2.wav" )
	BackGroundPanel:Center()

	local titleLabel = vgui.Create("DLabel",BackGroundPanel)
	titleLabel:Center()
	titleLabel:SetFont( "Friday13" )
	titleLabel:Dock(FILL)
	titleLabel:SetContentAlignment( 5 )

	titleLabel:SetText( Title )

	timer.Simple( Second-0.3, function()

		titleLabel:SlideUp( 0.2 )
		timer.Simple( 0.3, function()
			BackGroundPanel:Remove()
		end)
	end )
end
