-- Utopia Games - Slashers
--
-- @Author: Garrus2142
-- @Date:   2017-07-26 01:30:34
-- @Last Modified by:   Garrus2142
-- @Last Modified time: 2017-07-26 14:48:12

local CV_enable = GetConVar("slashers_antiafk_enable")
local CV_afktime = GetConVar("slashers_antiafk_afktime")
local CV_afkmsgtime = GetConVar("slashers_antiafk_afkmsgtime")

local function PlayerSpawn(ply)
	ply.lastpos = ply:GetPos()
	ply.lastang = ply:EyeAngles()
	ply.afktime = CurTime()
end
hook.Add("PlayerSpawn", "antiafk_PlayerSpawn", PlayerSpawn)

local function Think()
	local curtime = CurTime()

	if !CV_enable || !CV_afktime || !CV_afkmsgtime then return end
	if !CV_enable:GetBool() then return end

	for _, v in ipairs(player.GetAll()) do
		if !v:Alive() || v:IsBot() then
			v.afktime = curtime
			continue
		end

		-- Reset
		if v.lastpos != v:GetPos() || v.lastang != v:EyeAngles() then
			v.afktime = curtime
			v.lastpos = v:GetPos()
			v.lastang = v:EyeAngles()
			v:SetNWInt("afk_warn", 0)

		elseif curtime > v.afktime + (CV_afktime:GetInt() + CV_afkmsgtime:GetInt()) then
			-- Kick
			v:Kick("You're kicked by anti-afk system.")

		elseif v:GetNWInt("afk_warn") == 0 && curtime > v.afktime + CV_afktime:GetInt() then
			-- Warning
			v:SetNWInt("afk_warn", v.afktime + (CV_afktime:GetInt() + CV_afkmsgtime:GetInt()))
		end
	end
end
hook.Add("Think", "antiafk_Think", Think)
