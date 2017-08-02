-- Utopia Games - Slashers
--
-- @Author: Garrus2142
-- @Date:   2017-07-26 01:30:34
-- @Last Modified by:   Garrus2142
-- @Last Modified time: 2017-07-26 14:48:13

local scrW, scrH = ScrW(), ScrH()

surface.CreateFont("Arial Big", {
	font = "Arial",
	size = 48
})

local function formatSeconde(sec)
	local minutes
	local secondes

	sec = math.floor(sec)
	minutes = math.floor(sec / 60)
	secondes = sec % 60

	if secondes <= 9 then
		secondes = "0" .. secondes
	end

	return minutes .. ":" .. secondes
end

local alpha_bg = 0
local function HUDPaint()
	local text
	if LocalPlayer():GetNWInt("afk_warn") == 0 && alpha_bg == 0 then return end
	if LocalPlayer():GetNWInt("afk_warn") == 0 then
		alpha_bg = Lerp(0.05, alpha_bg, 0)
	else
		alpha_bg = Lerp(0.05, alpha_bg, 225)
	end

	text = "You're about to be kicked out of the server for inactivity in " .. formatSeconde(LocalPlayer():GetNWInt("afk_warn") - CurTime())

	surface.SetDrawColor(Color(0, 0, 0, alpha_bg))
	surface.DrawRect(0, 0, scrW, scrH)

	if LocalPlayer():GetNWInt("afk_warn") != 0 && LocalPlayer():GetNWInt("afk_warn") > CurTime() then
		surface.SetTextColor(Color(255, 255, 255, 255))
		surface.SetFont("Arial Big")
		local tw, th = surface.GetTextSize(text)
		surface.SetTextPos(scrW / 2 - tw / 2, scrH / 2 - th / 2)
		surface.DrawText(text)
	end
end
hook.Add("HUDPaint", "antiafk_HUDPaint", HUDPaint)
