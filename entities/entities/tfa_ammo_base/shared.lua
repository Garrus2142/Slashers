ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName		= "AmmoBase"
ENT.Category		= "TFA Ammunition"

ENT.Spawnable		= false
ENT.AdminSpawnable	= false

ENT.Class=""
ENT.MyModel = "models/props_junk/popcan01a.mdl"
ENT.ImpactSound = "Default.ImpactSoft"
ENT.AmmoCount = 100
ENT.AmmoType = "357"
ENT.TextPosition = Vector( -2.5, -3.3, 4)
ENT.TextAngles = Vector(48, -90, 0)
ENT.TextColor = Color(240, 35, 35, 255)
ENT.DrawText = false
ENT.ShouldDrawShadow = true
ENT.ImpactSound = "Default.ImpactSoft"
ENT.DamageThreshold = 80
ENT.ExplosionOffset = Vector(0,0,10)
ENT.Damage = 30
ENT.TextOffX = 30
ENT.TextOffY = -20
ENT.TextScale = 1
if SERVER then

	AddCSLuaFile()

	function ENT:SpawnFunction(ply, tr, classname)

		if (!tr.Hit) then return end
		
		local pos = tr.HitPos + tr.HitNormal*4
		
		local ent = ents.Create(classname)
		
		ent:SetPos(pos)
		ent:Spawn()
		ent:Activate()
		
		ent.Class = classname
		
		ent.Spawner = ply
		
		return ent
	end

	function ENT:Initialize()

		local model = self.MyModel
		
		self.Class = self:GetClass()
		
		self:SetModel(model)
		
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:DrawShadow(self.ShouldDrawShadow)
		self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		self:SetUseType(SIMPLE_USE)
		self:SetHealth(self.DamageThreshold)
		self:SetNWBool("ShouldRemove",false)
		local phys = self:GetPhysicsObject()
		
		if (phys:IsValid()) then
			phys:Wake()
		end
	end

	function ENT:PhysicsCollide(data, physobj)
		if (data.Speed > 60 and data.DeltaTime > 0.2) then
			self:EmitSound(self.ImpactSound)
		end
	end

	function ENT:Use(activator, caller)
		if IsValid(activator) and (activator:IsPlayer()) then
			activator:GiveAmmo(self.AmmoCount, self.AmmoType)
			self:SetNWBool("ShouldRemove",true)
		end
	end
	
	local bul={}
	local randvec = Vector(0,0,0)
	bul.Tracer=3
	bul.Num=1
	bul.TracerName="Tracer"
	bul.Spread = Vector(0,0,0)
	
	function ENT:OnTakeDamage(dmginfo)
		if !IsValid(self) then return end
		
		local at = dmginfo:GetInflictor()
		
		local shouldtakedamage = true
		
		if IsValid(at) then
			local base=at.Base
			if (base and string.find(base,"tfa_ammo_base") ) or string.find(at:GetClass(),"tfa_ammo_") then 
				if GetConVarNumber("sv_tfa_ammo_detonation_chain",1)==0 then
					shouldtakedamage = false
				end
			end
		end
		
		if dmginfo:GetDamage()<1 then
			shouldtakedamage = false
		end
		
		self.Attacker = at
		
		if shouldtakedamage then
			self:SetHealth(self:Health()-dmginfo:GetDamage())
		end
		
		self:EmitSound(self.ImpactSound)
		
		local phy=self:GetPhysicsObject()
		
		if IsValid(phy) then
			local f = dmginfo:GetDamageForce()
			local p = dmginfo:GetDamagePosition()
			if f and p then
				phy:ApplyForceOffset(f/4,p)
			end
		end
	end
	
	function ENT:Think()
		if self:GetNWBool("ShouldRemove",false) then
			self:Remove()
			return false
		end
		
		if GetConVarNumber("sv_tfa_ammo_detonation", 1) == 0 then
			return true
		end
		
		if self:Health()<=0 then
		
			self:EmitSound(self.ImpactSound)
			
			local adm=GetConVarNumber("sv_tfa_ammo_detonation_mode",2)
			bul.AmmoType=self.AmmoType
			bul.Damage=self.Damage
			bul.Force=math.Max(self.Damage/25,0.1)
			
			
			bul.Attacker=self
			
			if IsValid(self.Attacker) then
				bul.Attacker=self.Attacker
			end
			
			local upang=self:GetAngles():Up()
			bul.Dir=upang+randvec*0.75
			local numbuls = math.random( math.Round(self.AmmoCount*0.25),math.Round(self.AmmoCount*0.75))
			local i=1
			
			if adm==2 then
				bul.Damage=bul.Damage/2
			end
			
			bul.Dir= ( upang+randvec*0.75 ):GetNormalized()
			bul.Src=self:GetPos()
			
			self:FireBullets(bul) 
			
			if adm!=1 then
				while i<=math.Clamp(numbuls,1,35) do
				
					randvec.x=math.Rand(-1,1)
					randvec.y=math.Rand(-1,1)
					randvec.z=math.Rand(-1,1)
					bul.Dir= ( upang+randvec*0.75 ):GetNormalized()
					bul.Src=self:GetPos()
					self:FireBullets(bul) 
					
					i=i+1
				end
			end
			
			local effectdata = EffectData()
			effectdata:SetOrigin(self:GetPos())
			effectdata:SetMagnitude(0.1)
			effectdata:SetScale(0.5)
			
			if adm==1 then
				bul.Damage = bul.Damage * 3/4
			end
			
			if adm>0 then
				util.BlastDamage(bul.Attacker,bul.Attacker,bul.Src,(bul.Damage*6 + 128)/2,bul.Damage*2)
				util.Effect("Explosion", effectdata)
			end
			
			if adm!=1 then
				util.Effect("cball_explode", effectdata)
			end
			
			self:SetNWBool("ShouldRemove",true)
		end
	end
end

if CLIENT then

	function ENT:Initialize()
		self.Class = self:GetClass()
	end
	
	function ENT:Draw()
		self:DrawModel()
		if self.TextPosition and self.TextAngles and self.DrawText then

			local pos = self:GetPos() + (self:GetUp() * self.TextPosition.z) + (self:GetRight() * self.TextPosition.x) + (self:GetForward() * self.TextPosition.y)

			local ang = self:GetAngles()
			
			ang:RotateAroundAxis(ang:Right(), self.TextAngles.x)
			ang:RotateAroundAxis(ang:Up(), self.TextAngles.y)
			ang:RotateAroundAxis(ang:Forward(), self.TextAngles.z)
			
			if !self.Text then
				self.Text = string.upper(self.AmmoType)
			end
			
			cam.Start3D2D(pos, ang, .07 * self.TextScale)
				draw.SimpleText(self.Text, "DermaLarge", self.TextOffX, self.TextOffY, self.TextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			cam.End3D2D()
		end
	end

end