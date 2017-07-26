 
ENT.Type = "anim"
ENT.Base = "base_gmodentity"
 
ENT.PrintName		= "TFBow Arrow"
ENT.Author			= "TheForgottenArchitect"
ENT.Contact			= "Don't"
ENT.Purpose			= "Arrow Entity"
ENT.Instructions	= "Spawn this with a velocity, get rich"

function GetBoneCenter(ent, bone)
	local bonechildren = ent:GetChildBones( bone )
	if #bonechildren<=0 then
		return ent:GetBonePosition(bone)
	else
		local bonepos=ent:GetBonePosition(bone)
		local tmppos=bonepos
		if tmppos then
			for i = 1 , #bonechildren do
				local childpos,childrot=ent:GetBonePosition(bonechildren[i])
				if childpos then
					tmppos=(tmppos+childpos)/2
				end
			end
		else
			return ent:GetPos()
		end
		
		return tmppos
	end
end

function ENT:GetClosestBonePos(ent, pos)
	local i, count, cbone, dist, ppos
	i=1
	count=ent:GetBoneCount()
	cbone=0
	dist=99999999
	ppos=ent:GetPos()
	while(i<count) do
		local bonepos,boneang=GetBoneCenter(ent,i)
		if bonepos:Distance(pos)<dist then
			dist=bonepos:Distance(pos)
			cbone=i
			ppos=bonepos
		end
		i=i+1
	end
	return ppos
end

function ENT:Initialize()
	if SERVER then
		if !IsValid(self.myowner) then
			self.myowner=self.Owner
			if !IsValid(myowner) then
				self.myowner=self.Entity
			end
		end
		
		timer.Simple(0,function()
			if self.model then
				self:SetModel(self.model)
			end
		end)
		
		if GetConVarNumber("sv_tfbow_arrow_lifetime",-1)!=-1 then
			timer.Simple(GetConVarNumber("sv_tfbow_arrow_lifetime",30)+5, function()
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
			if self.velocity then
				phys:SetVelocityInstantaneous(self.velocity)
			end
			phys:EnableCollisions(false)
			self:StartMotionController()
			self:PhysicsUpdate(phys,0.1*GetConVarNumber("host_timescale"))
		end
	end
	self:SetNWVector("lastpos",self:GetPos())
	
	if !self.mydamage then
		self.mydamage = 60
	end
	
	if !self.gun then
		if IsValid(self.Owner) and self.Owner:IsPlayer() then
			self:UpdateGun()
		else
			timer.Simple(0,function()
				if IsValid(self) and IsValid(self.Owner) and self.Owner:IsPlayer() then
					self:UpdateGun()
				end			
			end)
		end
	end
	
end

function ENT:UpdateGun()
	local wep = self.Owner:GetActiveWeapon()
	if IsValid(wep) then self.gun = wep:GetClass() end
end

function ENT:Think()
	
	local wl=self:WaterLevel()
	if !self.prevwaterlevel then
		self.prevwaterlevel=wl
	end
	
	if self.prevwaterlevel!=wl and wl-self.prevwaterlevel>=1 then
		--print(wl)
		local ef = EffectData()
		ef:SetOrigin( self:GetPos() )
		util.Effect("watersplash",ef)
	end
	
	self.prevwaterlevel=wl
	
	if wl>=2 then
		local phys=self:GetPhysicsObject()
		if IsValid(phys) then
			phys:SetVelocity((phys:GetVelocity()*math.sqrt(9/10)))
		end
	end
	
	local tracedata = {}
	tracedata.start = self:GetNWVector("lastpos",self:GetPos()) 
	tracedata.endpos = self:GetPos()
	tracedata.mask=MASK_SOLID
	tracedata.filter = {self.myowner,self.Owner,self}
	local tr=util.TraceLine(tracedata)
	
	--self:SetAngles((((tracedata.endpos-tracedata.start):GetNormalized()+self:GetAngles():Forward())/2):Angle())
	if (tr.Hit and tr.Fraction<1 and tr.Fraction>0) then
		debugoverlay.Line( tracedata.start, tr.HitPos, 10, Color(255,0,0,255), true)
		debugoverlay.Cross( tr.HitPos, 5, 10, Color(255,0,0,255), true)
		if SERVER then
			--[[
			local bul ={}
			bul.Attacker=self.Owner and self.Owner or self:GetOwner()
			bul.Spread=vector_origin
			bul.Src=tracedata.start
			bul.Force=self.mydamage*0.25*GetConVarNumber("sv_tfbow_force_multiplier",1)
			bul.Damage=self.mydamage
			bul.Tracer	= 0							-- Show a tracer on every x bullets
			bul.TracerName = "None"
			bul.Dir=((tr.HitPos-bul.Src):GetNormalized())
			
			bul.Attacker:FireBullets( bul )
			]]--
			
			local bul ={}
			bul.Attacker=self.Owner and self.Owner or self:GetOwner()
			bul.Spread=vector_origin
			bul.Src=tracedata.start
			bul.Force=self.mydamage*0.25*GetConVarNumber("sv_tfa_force_multiplier",1)
			bul.Damage=self.mydamage
			
			bul.Tracer	= 0							-- Show a tracer on every x bullets
			bul.TracerName = "None"
			bul.Dir=((tr.HitPos-bul.Src):GetNormalized())
			
			bul.Callback = function(a,b,c)
				c:SetDamageType(bit.bor(DMG_NEVERGIB,DMG_CLUB))
				if IsValid(self) and IsValid(self.Owner) then
					if tr.HitWorld then
						local arrowstuck=ents.Create("tfbow_arrow_stuck")
						arrowstuck:SetModel(self:GetModel())
						arrowstuck.gun=self.gun
						arrowstuck:SetPos(tr.HitPos)
						local phys=self:GetPhysicsObject()
						arrowstuck:SetAngles((phys:GetVelocity()):Angle())
						arrowstuck:Spawn()
					else
						if IsValid(tr.Entity) then
							if (!tr.Entity:IsWorld()) then
								local arrowstuck=ents.Create("tfbow_arrow_stuck_clientside")
								arrowstuck:SetModel(self:GetModel())
								arrowstuck:SetPos(tr.HitPos)
								local ang=self:GetAngles()
								arrowstuck.gun=self.gun
								arrowstuck:SetAngles(ang)
								arrowstuck.targent=tr.Entity
								arrowstuck.targphysbone=tr.PhysicsBone
								arrowstuck:Spawn()
							else
								local arrowstuck=ents.Create("tfbow_arrow_stuck")
								arrowstuck:SetModel(self:GetModel())
								arrowstuck.gun=self.gun
								arrowstuck:SetPos(tr.HitPos)
								arrowstuck:SetAngles(self:GetAngles())
								arrowstuck:Spawn()
							end
						end
					end
				
					self:Remove()
				elseif IsValid(self) then
				
					self:Remove()
				
				end
		
			end
			
			bul.Attacker:FireBullets( bul )
		
		end
		
		return
	end
	
	self:SetNWVector("lastpos",self:GetPos())
end