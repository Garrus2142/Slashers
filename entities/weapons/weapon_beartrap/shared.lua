SWEP.Author = "Vyn"
 
SWEP.Category = "Trap"

SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.AutoSwitchTo = false
SWEP.PrintName = "Bear Trap"

SWEP.ViewModel = "models/zerochain/props_industrial/beartrap/beartrap.mdl"
SWEP.WorldModel = "models/zerochain/props_industrial/beartrap/beartrap.mdl"

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "ammo_beartrap"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.MaxDistance = 70

game.AddAmmoType( {
	name = "ammo_beartrap",
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

function slashers_beartrap_place(ply, ent)
	local beartrap_pos = ply:GetEyeTrace().HitPos
	local beartrap_angle = ply:GetEyeTrace().HitNormal:Angle()
	if SERVER then
		beartrap_pos.z = beartrap_pos.z + 5
	end 
	ent:SetPos(beartrap_pos)
	beartrap_angle.pitch = beartrap_angle.pitch + 90
	ent:SetAngles(beartrap_angle)

	return beartrap_pos, beartrap_angle
end