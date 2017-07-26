-- Utopia Games - Slashers
--
-- @Author: Vyn
-- @Date:   2017-07-26 00:51:28
-- @Last Modified by:   Vyn
-- @Last Modified time: 2017-07-26 15:20:35

SWEP.Author = "Vyn"
 
SWEP.Category = "Trap"

SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.AutoSwitchTo = false
SWEP.PrintName = "Alert Ropes"

SWEP.ViewModel = "models/props_junk/meathook001a.mdl"
SWEP.WorldModel = "models/props_junk/meathook001a.mdl"

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "ammo_alertropes"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.MaxDistance = 150

game.AddAmmoType( {
	name = "ammo_alertropes",
	dmgtype = DMG_BULLET,
	tracer = TRACER_LINE,
	plydmg = 0,
	npcdmg = 0,
	force = 2000,
	minsplash = 10,
	maxsplash = 5
} )

function SWEP:Initialize()
	self:SetHoldType("slam")
end

function slashers_alertropes_place(ply, ent)
	local alertropes_pos = ply:GetEyeTrace().HitPos
	local alertropes_angle = ply:GetEyeTrace().HitNormal:Angle()

	ent:SetPos(alertropes_pos)
	
	alertropes_angle.pitch = alertropes_angle.pitch + (90 + 180)
	ent:SetAngles(alertropes_angle)

	return alertropes_pos, alertropes_angle
end