 
ENT.Type = "anim"
ENT.Base = "base_gmodentity"
 
ENT.PrintName		= "TFBow Arrow Stuck"
ENT.Author			= "TheForgottenArchitect"
ENT.Contact			= "Don't"
ENT.Purpose			= "Arrow Entity"
ENT.Instructions	= "Arrow that's stuck in ground"

function ENT:Initialize()
	if SERVER then
		
			if GetConVarNumber("sv_tfa_arrow_lifetime",-1)!=-1 then
				timer.Simple(GetConVarNumber("sv_tfa_arrow_lifetime",30), function()
					if IsValid(self) then
						self:Remove()
					end
				end)
			end
			
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		
		local phys = self:GetPhysicsObject()

		if (phys:IsValid()) then
			phys:Wake()
			phys:SetMass(2)
		end
		
		if IsValid(self) then
			if self.SetUseType then
				self:SetUseType(SIMPLE_USE)
			end
		end
		
	end
	
	if (self:GetModel() and self:GetModel() == "") then
		self:SetModel("models/weapons/w_tfa_arrow.mdl")
	end
	self:SetOwner(nil)
	
	self.PhysicsCollide = function() end

	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		
		local phys = self:GetPhysicsObject()

		if (phys:IsValid()) then
			phys:Sleep()
		end
end

function ENT:Use(activator, caller)
	if (activator:IsPlayer()) and activator:GetWeapon(self.gun)then
		activator:GiveAmmo(1,activator:GetWeapon(self.gun):GetPrimaryAmmoType(),false)
		self:Remove()
	end
end
