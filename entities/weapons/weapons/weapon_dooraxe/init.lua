AddCSLuaFile ("shared.lua")
AddCSLuaFile ("cl_init.lua")

include("shared.lua")

SWEP.Weight = 5
 
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

function SWEP:Equip(NewOwner)
	NewOwner:GiveAmmo(1, "ammo_dooraxe", true)
end
 
function SWEP:PrimaryAttack()

	if self:Ammo1() <= 0 then return end

	if !IsValid(self.Owner:GetEyeTrace().Entity) then return end

	if self.Owner:GetEyeTrace().Entity:GetClass() == "prop_door_rotating" then

		if self.Owner:GetEyeTrace().Entity.trapeddoor and self.Owner:GetEyeTrace().Entity.trapeddoor > 0 then return end

		if !slashers_dooraxe_canplace(self.Owner) then return end

		self.Owner:GetEyeTrace().Entity.trapeddoor = 1
		self.Owner:SetAmmo(self:Ammo1() - 1, "ammo_dooraxe") 

		local pulleywheel = ents.Create("prop_physics")
		pulleywheel:SetModel("models/props_c17/pulleywheels_small01.mdl")
		pulleywheel:SetModelScale(0.5)
		
		local axe = ents.Create("prop_physics")
		axe:SetModel("models/weapons/tfa_nmrih/w_me_axe_fire.mdl")
		
		local dooraxe_pos, dooraxe_angle, axe_pos, axe_angle = slashers_dooraxe_place(self.Owner, pulleywheel, axe)
		pulleywheel:Spawn()
		axe:Spawn()
		pulleywheel:GetPhysicsObject():EnableMotion(false) -- Freeze trap entity
		axe:GetPhysicsObject():EnableMotion(false) -- Freeze trap entity

		self.Owner:GetEyeTrace().Entity.pulleywheel = pulleywheel
		self.Owner:GetEyeTrace().Entity.axe = axe

		pulleywheel:SetCollisionGroup(COLLISION_GROUP_WORLD)
		axe:SetCollisionGroup(COLLISION_GROUP_WORLD)

		constraint.Rope( pulleywheel, axe, 0, 0, Vector(0, -4, 0), Vector(0, 0, 12), 60, 0, 0, 1, "cable/cable.vmt", false)
		constraint.Rope( pulleywheel, axe, 0, 0, Vector(0, 15, -10), Vector(0, 0, -15), 1, 0, 0, 1, "cable/cable.vmt", false)
		constraint.Rope( pulleywheel, self.Owner:GetEyeTrace().Entity, 0, 0, Vector(0, 4, 0), Vector(0, 45, -10), 100, 0, 0, 1, "cable/cable.vmt", false)
	end

end

function SWEP:Reload()

end

function SWEP:SecondaryAttack()

end