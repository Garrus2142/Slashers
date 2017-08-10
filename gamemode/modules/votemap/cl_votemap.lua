-- Utopia Games - Slashers
--
-- @Author: Guilhem PECH <Daryl_Winters>
-- @Date:   2017-08-06T09:43:46+02:00
-- @Last Modified by:   Daryl_Winters
-- @Last Modified time: 2017-08-10T18:22:57+02:00


local GM = GAMEMODE or GM

local slashersMaps = {}
net.Receive("slash_sendmaplist",function ()
  slashersMaps = net.ReadTable()
end)


local horizonBar
local oneMaps = {}

local function openVotemap()
  oneMaps = {}
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
    net.SendToServer()
  end

  local voteCountPanel = vgui.Create("DPanel",oneMap)
  voteCountPanel:SetTall(120)
  voteCountPanel:SetDrawBackground(false)
  voteCountPanel:MoveBelow(oneMap:GetChildren()[2], -30)
  voteCountPanel:CenterHorizontal(0.5)

  table.insert( oneMaps, oneMap )

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
        net.SendToServer()
      end

      oneMap:SizeToChildren(true,true)
      voteCountPanel = vgui.Create("DPanel",oneMap)
      voteCountPanel:SetTall(120)
      voteCountPanel:SetDrawBackground(false)
      voteCountPanel:MoveBelow(oneMap:GetChildren()[2], -30)
      voteCountPanel:CenterHorizontal(0.5)
      table.insert( oneMaps, oneMap )
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
    net.SendToServer()
  end
  voteCountPanel = vgui.Create("DPanel",oneMap)
  voteCountPanel:SetTall(120)
  voteCountPanel:SetDrawBackground(true)
  voteCountPanel:MoveBelow(oneMap:GetChildren()[2], -30)

  table.insert( oneMaps, oneMap )

  for k,v in pairs(oneMaps) do
    local votePanelCount = v:GetChild(2)
    votePanelCount:SetWide(v:GetWide())
    votePanelCount:AlignLeft(0)
    local count1 = vgui.Create("DImage",votePanelCount)
    count1:SetImage("votemap/votemap_1.png","vgui/avatar_default")
    count1:SetKeepAspect( true )
    count1:SetSize(120,120)



    local count = vgui.Create("DImage",votePanelCount)
    count:SetImage("votemap/votemap_1.png","vgui/avatar_default")
    count:SetKeepAspect( true )
    count:SetSize(120,120)
    count:MoveRightOf(count1,0)


    votePanelCount:SizeToChildren(true,false)
    votePanelCount:SetDrawBackground(false)
    count1:Hide()
    count:Hide()
  end


  horizonBar:SizeToChildren(true,true)
  horizonBar:MoveBelow(titleLabel,  30)
  horizonBar:CenterHorizontal(0.5)

  backVote:SizeToChildren( false, true )
  backVote:SetPos( (ScrW() - backVote:GetWide())/2, (ScrH() - backVote:GetTall())/2 ) -- Set the position of the panel

  net.Start("slash_summitvote")
  	net.WriteString("")
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
  if !IsValid(backVote) then return end
  if !backVote.isOpen then return end
  for k,v in pairs(oneMaps) do

    local nbCurVote = voteData[v:GetName()] or 0
    local votePanelCount = v:GetChild(2)


    if nbCurVote == 0 then
      votePanelCount:GetChild(1):Hide()
      votePanelCount:GetChild(0):Hide()
    end

    if nbCurVote <= 5 and nbCurVote > 0 then

      votePanelCount:GetChild(0):SetImage("votemap/votemap_"..nbCurVote ..".png","vgui/avatar_default")
      votePanelCount:GetChild(0):Show()
      votePanelCount:GetChild(0):Center()
      votePanelCount:GetChild(1):Hide()


    elseif nbCurVote > 5 then

      votePanelCount:GetChild(0):SetImage("votemap/votemap_5.png","vgui/avatar_default")
      votePanelCount:GetChild(0):AlignLeft(0)
      votePanelCount:GetChild(0):Show()

      votePanelCount:GetChild(1):SetImage("votemap/votemap_"..nbCurVote - 5 ..".png","vgui/avatar_default")
      votePanelCount:GetChild(1):MoveRightOf(votePanelCount:GetChild(0),-20)
      votePanelCount:GetChild(1):Show()
    end

    horizonBar:SizeToChildren(false,true)

    v:SetPaintBackground(false)
    v:SizeToChildren(true,true)
    backVote:SizeToChildren( false, true )
    backVote:SetPos( (ScrW() - backVote:GetWide())/2, (ScrH() - backVote:GetTall())/2 ) -- Set the position of the panel

  end
end
net.Receive("slash_sendvotedata",receiveVoteStat)
