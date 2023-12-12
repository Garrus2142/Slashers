-- @Author: Guilhem PECH <Daryl_Winters>
-- @Date:   2018-01-09 10:40:07
-- @Email:  guilhempech@gmail.com
-- @Project: Slashers
-- @Last modified by:   Guilhem PECH
-- @Last modified time: 2018-01-09 18:37:18


SWEP.Author = "Daryl Winters"

SWEP.Category = "Bates"

SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.AutoSwitchTo = false
SWEP.PrintName = "Mother"

SWEP.HoldType = "duel"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.UseHands = false
SWEP.ViewModel = "models/skeleton/skeleton_torso.mdl"
SWEP.WorldModel = "models/props/debris/skeleton/cr_skel_pose03.mdl"
SWEP.ShowViewModel = true


SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "ammo_batesmum"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.MaxDistance = 120

game.AddAmmoType( {
	name = "ammo_batesmum",
	dmgtype = DMG_BULLET,
	tracer = TRACER_LINE,
	plydmg = 0,
	npcdmg = 0,
	force = 2000,
	minsplash = 10,
	maxsplash = 5
} )

function SWEP:Initialize()
	self:SetHoldType( self.HoldType )
end

function SWEP:Think(  )
	local holdType = self:GetHoldType()
	if (self:Ammo1() == 0 && holdType != 'normal' ) then
		self:SetHoldType('normal')
		return
	elseif (self:Ammo1() > 0 && holdType == 'normal') then
		self:SetHoldType('duel')
	end
end

function slashers_batesmum_place(ply, ent)
	local batesmum_pos = ply:GetEyeTrace().HitPos + Vector(0,0,10)
	local batesmum_angle = ply:GetEyeTrace().HitNormal:Angle()

	ent:SetPos(batesmum_pos)
	batesmum_angle.pitch = batesmum_angle.pitch + 90
	ent:SetAngles(batesmum_angle)

	return batesmum_pos, batesmum_angle
end


