-- Utopia Games - Slashers
--
-- @Author: Guilhem PECH <Daryl_Winters>
-- @Date:   2017-08-06T09:43:46+02:00
-- @Last Modified by:   Garrus2142
-- @Last Modified time: 2017-08-06T20:53:07+02:00


local GM = GAMEMODE or GM

local slashersMaps = {}
net.Receive("slash_sendmaplist",function ()
  slashersMaps = net.ReadTable()
end)

local backVote
local horizonBar

local function openVotemap()
  backVote = vgui.Create( "DPanel" )
  backVote.isOpen = true
  local scrw = ScrW()
  local scrh = ScrH()

  backVote:SetSize( scrw , scrh - 300 ) -- Set the size of the panel

  backVote:SetBackgroundColor( Color( 0, 0, 0, 180 ) )

  gui.EnableScreenClicker( backVote.isOpen )

  local titleLabel = vgui.Create( "DLabel", backVote )
  titleLabel:SetFont("Friday13 title")
  titleLabel:SetText( GM.LANG:GetString("votemap_title" ))
  titleLabel:Dock(TOP)
  titleLabel:SizeToContents()
  titleLabel:SetContentAlignment( 5 )

  local exitButton = vgui.Create("DImageButton",backVote,"exit_button")
  exitButton:SetImage("votemap/votemap_exiticon.png","vgui/avatar_default")
  exitButton:SetSize(43,45)
  exitButton:AlignTop( 20 )
  exitButton:AlignRight( 100 )
  exitButton.DoClick= function()
    backVote.isOpen = false
    backVote:Remove()
    gui.EnableScreenClicker( backVote.isOpen )
  end

  horizonBar = vgui.Create("DPanel",backVote,"horBar")
  horizonBar:SetDrawBackground(false)

  local index

  local oneMap = vgui.Create("DPanel",horizonBar,"extend")
  oneMap:SetDrawBackground(false)
  local oneMapImage = vgui.Create("DImageButton",oneMap,"extend_button")
  oneMapImage:SetImage("votemap/votemap_extend.png","vgui/avatar_default")
  oneMapImage:SetSize(192,512)

  local mapLabel = vgui.Create("DLabel",oneMap,"extend_label")
  mapLabel:SetFont("Friday13 mapLabel")
  mapLabel:SetText(GM.LANG:GetString("votemap_extend" ))
  mapLabel:SizeToContentsY()
  mapLabel:SetWide(oneMapImage:GetWide())
  mapLabel:SetContentAlignment(5)
  mapLabel:MoveBelow(oneMap:GetChildren()[oneMap:ChildCount() -1],10)
  oneMap:SizeToChildren(true,true)

  oneMapImage.DoClick = function()
    net.Start("slash_summitvote")
    net.WriteString("extend")
    net.WriteEntity(LocalPlayer())
    net.SendToServer()
  end

  for k,v in pairs(slashersMaps) do

    if v != game.GetMap()..".bsp" then
      oneMap = vgui.Create("DPanel",horizonBar,v)
      oneMap:SetDrawBackground(false)
      oneMapImage = vgui.Create("DImageButton",oneMap,v.."_button")
      local indexToSplit = string.find( v, "_")
      oneMapImage:SetImage("votemap/votemap"..string.StripExtension( string.sub( v, indexToSplit ) )..".png","vgui/avatar_default")
      oneMapImage:SetSize(192,512)
      index = horizonBar:ChildCount() -1

      if index != 0 then
        oneMap:MoveRightOf( horizonBar:GetChildren()[index], 25 )
      end

      mapLabel = vgui.Create("DLabel",oneMap,v.."_label")
      mapLabel:SetFont("Friday13 mapLabel")
      mapLabel:SetText(string.StripExtension( string.sub( v, indexToSplit+1 ) ))
      mapLabel:SizeToContentsY()
      mapLabel:SetWide(oneMapImage:GetWide())
      mapLabel:SetContentAlignment(5)
      mapLabel:MoveBelow(oneMap:GetChildren()[oneMap:ChildCount() -1],10)
      oneMapImage.DoClick = function()
        net.Start("slash_summitvote")
        net.WriteString(v)
        net.WriteEntity(LocalPlayer())
        net.SendToServer()
      end

      oneMap:SizeToChildren(true,true)

    end
  end

  oneMap = vgui.Create("DPanel",horizonBar,"random")
  oneMap:SetDrawBackground(false)
  oneMapImage = vgui.Create("DImageButton",oneMap,"random_button")
  oneMapImage:SetImage("votemap/votemap_random.png","vgui/avatar_default")
  oneMapImage:SetSize(192,512)
  oneMap:MoveRightOf( horizonBar:GetChildren()[index+1], 25 )
  mapLabel = vgui.Create("DLabel",oneMap,"random_label")
  mapLabel:SetFont("Friday13 mapLabel")
  mapLabel:SetText(GM.LANG:GetString("votemap_random" ))
  mapLabel:SizeToContentsY()
  mapLabel:SetWide(oneMapImage:GetWide())
  mapLabel:SetContentAlignment(5)
  mapLabel:MoveBelow(oneMap:GetChildren()[oneMap:ChildCount() -1],10)
  oneMap:SizeToChildren(true,true)
  oneMapImage.DoClick = function()
    net.Start("slash_summitvote")
    net.WriteString("random")
    net.WriteEntity(LocalPlayer())
    net.SendToServer()
  end

  horizonBar:SizeToChildren(true,true)
  horizonBar:MoveBelow(titleLabel,  30)
  horizonBar:CenterHorizontal(0.5)

  backVote:SizeToChildren( false, true )
  backVote:SetPos( (ScrW() - backVote:GetWide())/2, (ScrH() - backVote:GetTall())/2 ) -- Set the position of the panel

  net.Start("slash_summitvote")
  net.SendToServer()
end
net.Receive("slash_openvotemap",function ()

if IsValid(backVote) then
		backVote.isOpen = false
		backVote:Remove()
		gui.EnableScreenClicker( backVote.isOpen )
		return
	end

openVotemap()

end)

local function receiveVoteStat()
  local voteData = net.ReadTable()

  if !IsValid(backvote) or !backVote.isOpen or !backVote:IsVisible() then return end
  for k,v in pairs(backVote:GetChildren()[3]:GetChildren()) do

    local nbCurVote = voteData[v:GetName()] or 0


    if v:ChildCount() == 3 then
      v:GetChild(2):Remove()
    end
    if nbCurVote <= 5 and nbCurVote > 0 then

      local count = vgui.Create("DImage",v,"vote_"..v:GetName().."_nbCurVote")
      count:SetImage("votemap/votemap_"..nbCurVote  ..".png","vgui/avatar_default")
      count:SetSize(120,120)
      count:SetKeepAspect( true )
      count:MoveBelow(v:GetChildren()[2], -30)
      count:CenterHorizontal(0.5)

    elseif nbCurVote > 5 then
      local count1 = vgui.Create("DImage",v,"vote_"..v:GetName().."_nbCurVote")
      count1:SetImage("votemap/votemap_5.png","vgui/avatar_default")
      count1:SetKeepAspect( true )
      count1:SetSize(120,120)
      count1:MoveBelow(v:GetChildren()[2],-20)

      local count = vgui.Create("DImage",v,"vote_"..v:GetName().."_nbCurVote")
      count:SetImage("votemap/votemap_"..nbCurVote - 5 ..".png","vgui/avatar_default")
      count:SetKeepAspect( true )
      count:SetSize(100,100)
      count:MoveRightOf(count1,0)
    end

    horizonBar:SizeToChildren(false,true)

    v:SetPaintBackground(false)
    v:SizeToChildren(true,true)
    backVote:SizeToChildren( false, true )
    backVote:SetPos( (ScrW() - backVote:GetWide())/2, (ScrH() - backVote:GetTall())/2 ) -- Set the position of the panel

  end
end
net.Receive("slash_sendvotedata",receiveVoteStat)
