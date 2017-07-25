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