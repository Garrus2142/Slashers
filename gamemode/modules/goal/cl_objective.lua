AddCSLuaFile()



concommand.Add( "Objective", function(a,b,c,argStr)
	objectivePanel(argStr,'question')
	end )

---
net.Receive( "objectiveSlasher", function()
	 local NotifText = net.ReadString()
	 local NotifType = net.ReadString()
	 objectivePanel(NotifText,NotifType)

end )
---
net.Receive( "activateProgressionSlasher", function()
	 local value = net.ReadFloat()
	 ProgressBar(value)

end )

---


net.Receive( "modifyObjectiveSlasher", function()
	if objText then
		objText:SetText( net.ReadString() )
	end
end )


local function inQuad( fraction, beginning, change )
	return change * ( fraction ^ 2 ) + beginning
end

local EntityAlreadyActivited = false

function ProgressBar(fraction)
	if (!EntityAlreadyActivited) then

		DProgress = vgui.Create( "DPanel" )
		DProgress:AlignBottom(100) -- Set the position of the panel
		DProgress:CenterHorizontal(0.4)
		DProgress:SetSize( 300, 10 ) -- Set the size of the panel

		DProgressBar = vgui.Create( "DProgress" , DProgress)
		DProgressBar:Dock(FILL)
		DProgressBar:SetFraction(fraction)


		EntityAlreadyActivited = true
	else
		if (fraction <= 1) then
			DProgress:Show()
			DProgressBar:SetFraction(fraction)
			timer.Create( "Hide", 1, 1, function()
				DProgress:Hide()

			end )
			timer.Start( "Hide" )


		end


		if (fraction == 2 ) then
			timer.Remove("Hide")
			DProgress:Remove()
			EntityAlreadyActivited = false
			ProgressShowed = false
		end

	end

end




ObjectiveAlreadySet = false

function objectivePanel(objTextn,objType)
	if (!ObjectiveAlreadySet && objTextn=='') then 
		return
	end
-- Move down and the previous objective first
if (ObjectiveAlreadySet) then
	img_check:SetImage("materials/icons/icon_safe.png")

	OBJPanel:SetTerm(6) -- Remove it
	if(objTextn=='')then

			OBJPanel:MoveTo( OBJPanel.x+619, OBJPanel.y, 0.4, 5)
			ObjectiveAlreadySet = false;
			ObjectiveAlreadySet = false;
			return
	else
		OBJPanel:MoveTo( OBJPanel.x, OBJPanel.y + 100, 1, 0)
		OBJPanel:MoveTo( OBJPanel.x+619, OBJPanel.y + 100, 0.4, 5)

	end
end

ObjectiveAlreadySet = true



-- Type differenciation
Type = objType..".png"
if (objType ) then
	iconPath = "materials/icons/icon_"..Type
else
	iconPath = "materials/icons/icon_caution.png"
end



	-- Container panel
  OBJPanel = vgui.Create( "DPanel" )
	OBJPanel:SetSize( 512, 128 )
	OBJPanel:AlignTop(-128)
	OBJPanel:AlignRight(100)
	OBJPanel:SetDrawBackground( false )


	-- Blood background
	local img_bg = vgui.Create( "DImage", OBJPanel )
	img_bg:SetSize( OBJPanel:GetSize() )
	img_bg:SetImage( "materials/icons/scoreboard_line.png" )


	--- Check image
	img_check = vgui.Create( "DImage", OBJPanel )
	img_check:SetSize( 50,50 )
	img_check:SetPos(40,10)
	img_check:SetImage( iconPath )

	--- objText
	objText = vgui.Create( "DLabel", OBJPanel )
	objText:SetText( objTextn )
	objText:SetTextColor( Color( 255, 255, 255 ) )
	objText:SetPos( 95, -30 )
	objText:SetContentAlignment(5)
	objText:SetFont( "Bohemian typewriter" )
	objText:SetSize( 402,128 )

	---

	ToThisPosUp = OBJPanel.y +  180


	-- Animation coming
	OBJPanel:MoveTo( OBJPanel.x, ToThisPosUp, 1.5, 0) -- Slide up
	-- OBJPanel:MoveTo(OBJPanel.x,ToThisPosDown,0.7,4,-1)   -- Slide Down


		surface.PlaySound( "slashers/effects/objective_complete.wav" )


end
