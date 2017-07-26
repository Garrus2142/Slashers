-- Utopia Games - Slashers
--
-- @Author: Garrus2142
-- @Date:   2017-07-25 16:15:50
-- @Last Modified by:   Garrus2142
-- @Last Modified time: 2017-07-26 14:48:44

local scrW, scrH = ScrW(), ScrH()

local function HUDPaint()
	local target = LocalPlayer():GetObserverTarget()

	if IsValid(target) then
		-- Observer target
		surface.SetFont("horrormid")
		surface.SetTextColor(Color(255, 255, 255))
		local tw, th = surface.GetTextSize(target:Name())
		surface.SetTextPos(scrW / 2 - tw / 2, scrH - (th + 20))
		surface.DrawText(target:Name())
	end
end
hook.Add("HUDPaint", "observer_HUDPaint", HUDPaint)