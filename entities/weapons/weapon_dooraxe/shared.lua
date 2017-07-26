-- Utopia Games - Slashers
--
-- @Author: Vyn
-- @Date:   2017-07-26 00:53:34
-- @Last Modified by:   Vyn
-- @Last Modified time: 2017-07-26 15:21:12

SWEP.Author = "Vyn"
 
SWEP.Category = "Trap"

SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.AutoSwitchTo = false
SWEP.PrintName = "Door Axe"

SWEP.ViewModel = "models/props_c17/pulleywheels_small01.mdl"
SWEP.WorldModel = "models/props_c17/pulleywheels_small01.mdl"

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "ammo_dooraxe"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.MaxDistance = 150

game.AddAmmoType( {
	name = "ammo_dooraxe",
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

function slashers_dooraxe_place(ply, pulleywheel, axe)
	local dooraxe_pos = Vector(ply:GetEyeTrace().Entity:GetPos())
	local dooraxe_angle = Angle(ply:GetEyeTrace().HitNormal:Angle())
	dooraxe_angle.pitch = dooraxe_angle.pitch + 0
	dooraxe_angle.roll = dooraxe_angle.roll + 00
	dooraxe_angle.yaw = dooraxe_angle.yaw + 90
	pulleywheel:SetAngles(dooraxe_angle)

	dooraxe_pos.z = dooraxe_pos.z + 60
	dooraxe_pos = dooraxe_pos + dooraxe_angle:Right() * 19
	dooraxe_pos = dooraxe_pos + ply:GetEyeTrace().Entity:GetAngles():Right() * -25
	pulleywheel:SetPos(dooraxe_pos)

	local axe_pos = Vector(dooraxe_pos)
	axe_pos.z = axe_pos.z - 10
	axe:SetPos(axe_pos)

	local axe_angle = Angle(dooraxe_angle)
	axe_angle.roll = axe_angle.roll + 90
	axe_angle.pitch = axe_angle.pitch + 90
	axe:SetAngles(axe_angle)

	return dooraxe_pos, dooraxe_angle, axe_pos, axe_angle
end

function slashers_dooraxe_canplace(ply)
	local tracedata = {}

	tracedata.start = Vector(ply:GetEyeTrace().Entity:GetPos()) + ply:GetEyeTrace().Entity:GetAngles():Right() * -30
	tracedata.endpos = Vector(ply:GetEyeTrace().Entity:GetPos()) + ply:GetEyeTrace().Entity:GetAngles():Right() * -50
	tracedata.filter = {ply:GetEyeTrace().Entity}

	local traceresulte = util.TraceLine(tracedata)
	
--	if IsValid(traceresulte.Entity) then
--		if traceresulte.Entity:GetClass() == "prop_door_rotating" then return true end
--	end
	if traceresulte.HitWorld then return true end
	return false 
end