local bullet = {}
bullet.Spread = Vector()

--[[ 
Function Name:  ToggleAkimbo
Syntax: self:ToggleAkimbo( ). 
Returns:   Nothing.
Notes:    Used to toggle the akimbo value.
Purpose:  Bullet
]]--

function SWEP:ToggleAkimbo()

	if self.Callback.ToggleAkimbo then
		local val = self.Callback.ToggleAkimbo(self)
		if val then return val end
	end
	
	if self.Akimbo then
		self.AnimCycle = 1-self.AnimCycle
	end

end

--[[ 
Function Name:  ShootBulletInformation
Syntax: self:ShootBulletInformation( ). 
Returns:   Nothing.
Notes:    Used to generate a bullet table which is then sent to self:ShootBullet, and also to call shooteffects.
Purpose:  Bullet
]]--

function SWEP:ShootBulletInformation( ifp )

	if self.Callback.ShootBulletInformation then
		local val = self.Callback.ShootBulletInformation(self, ifp)
		if val then return val end
	end
	
	self.lastbul = nil
	self.lastbulnoric = false
	
	self.ConDamageMultiplier = GetConVar("sv_tfa_damage_multiplier"):GetFloat()
	if (CLIENT and !game.SinglePlayer()) and !ifp then return end
	
	if SERVER and game.SinglePlayer() and self.Akimbo then self:CallOnClient("ToggleAkimbo","") end
	
	self:ToggleAkimbo()

	local CurrentDamage
	local CurrentCone, CurrentRecoil = self:CalculateConeRecoil()
	
	local tmpranddamage = math.Rand(GetConVarNumber("sv_tfa_damage_mult_min",0.95),GetConVarNumber("sv_tfa_damage_mult_max",1.05))
	
	basedamage = self.ConDamageMultiplier * self.Primary.Damage
	CurrentDamage = basedamage * tmpranddamage
	
	--[[
	if self.DoMuzzleFlash and ( (SERVER) or ( CLIENT and !self.AutoDetectMuzzleAttachment ) or (CLIENT and !self:IsFirstPerson() ) ) then
		self:ShootEffects()
	end
	]]--
	
	if !self.AutoDetectMuzzleAttachment then
		self:ShootEffectsCustom( ifp )
	end
	
	self:ShootBullet(CurrentDamage, CurrentRecoil, self.Primary.NumShots, CurrentCone)
end

--[[ 
Function Name:  ShootBullet
Syntax: self:ShootBullet(damage, recoil, number of bullets, spray cone, disable ricochet, override the generated bullet table with this value if you send it). 
Returns:   Nothing.
Notes:    Used to shoot a bullet.
Purpose:  Bullet
]]--

local soundspeed = 1125.33 * 16

local TracerName

function SWEP:ShootBullet(damage, recoil, num_bullets, aimcone, disablericochet, bulletoverride)

	if self.Callback.ShootBullet then
		local val = self.Callback.ShootBullet(self, damage, recoil, num_bullets, aimcone, disablericochet, bulletoverride)
		if val then return val end
	end

	if (CLIENT and !game.SinglePlayer()) and !IsFirstTimePredicted() then return end
	
	num_bullets 		= num_bullets or 1
	aimcone 			= aimcone or 0
	
	if self.ProjectileEntity then
		if SERVER then
			local i=0
			local shots = {}
			
			for i=1,num_bullets do
				local ent = ents.Create(self.ProjectileEntity)
				local dir
				local ang = self.Owner:EyeAngles()
				ang:RotateAroundAxis(ang:Right(),-aimcone/2 + math.Rand(0,aimcone))
				ang:RotateAroundAxis(ang:Up(),-aimcone/2 + math.Rand(0,aimcone))
				dir = ang:Forward()
				ent:SetPos(self.Owner:GetShootPos())
				ent.Owner = self.Owner
				ent:SetAngles(self.Owner:EyeAngles())
				ent.damage = self.Primary.Damage
				ent.mydamage = self.Primary.Damage
				if self.ProjectileModel then
					ent:SetModel(self.ProjectileModel)
				end
				ent:Spawn()
				ent:SetVelocity(dir * self.ProjectileVelocity )
				local phys = ent:GetPhysicsObject()
				
				if IsValid(phys) then
					phys:SetVelocity(dir*self.ProjectileVelocity)
				end
				
				if self.ProjectileModel then
					ent:SetModel(self.ProjectileModel)
				end
				
				ent:SetOwner(self.Owner)
				
				ent.Owner = self.Owner
			end
			
		end		
	else
		
		if self.Tracer == 1 then
			TracerName = "Ar2Tracer"
		elseif self.Tracer == 2 then
			TracerName = "AirboatGunHeavyTracer"
		else
			TracerName = "Tracer"
		end
		if self.TracerName and self.TracerName != "" then
			TracerName = self.TracerName
		end
		
		bullet.Attacker 		= self.Owner
		bullet.Inflictor 		= self
		bullet.Num 		= num_bullets
		bullet.Src 		= self.Owner:GetShootPos()			-- Source
		bullet.Dir 		= self.Owner:GetAimVector()			-- Dir of bullet
		bullet.HullSize = self.Primary.HullSize or 0
		bullet.Spread.x=aimcone-- Aim Cone X
		bullet.Spread.y=aimcone-- Aim Cone Y
		bullet.Tracer	= self.TracerCount and self.TracerCount or 3		-- Show a tracer on every x bullets
		bullet.TracerName = TracerName
		bullet.PenetrationCount = 0
		bullet.AmmoType = self:GetPrimaryAmmoType()
		bullet.Force	= damage/3 * math.sqrt((self.Primary.KickUp+self.Primary.KickDown+self.Primary.KickHorizontal )) * GetConVarNumber("sv_tfa_force_multiplier",1) * self:GetAmmoForceMultiplier()				-- Amount of force to give to phys objects
		bullet.Damage	= damage
		bullet.HasAppliedRange = false
		
		if self.CustomBulletCallback then
			bullet.Callback = self.CustomBulletCallback
		else
			bullet.Callback = function(a,b,c)
				if IsValid(self) then
					bullet:Penetrate(a,b,c,self)
				end
			end
		end
		
		self.Owner:FireBullets(bullet)
	
	end
end

function SWEP:Recoil( recoil, ifp )
	
	math.randomseed( CurTime() + 1 )
	
	local tmprecoilang = Angle(math.Rand(self.Primary.KickDown,self.Primary.KickUp) * recoil * -1, math.Rand(-self.Primary.KickHorizontal,self.Primary.KickHorizontal) * recoil, 0)
	
	local maxdist =   math.min(math.max(0,  89 + self.Owner:EyeAngles().p - math.abs(self.Owner:GetViewPunchAngles().p * 2)),88.5)
	local tmprecoilangclamped = Angle(math.Clamp(tmprecoilang.p,-maxdist,maxdist),tmprecoilang.y,0)
	self.Owner:ViewPunch(tmprecoilangclamped * (1 - self.Primary.StaticRecoilFactor))
	
	
	if (game.SinglePlayer() and SERVER) or ( CLIENT and ifp ) then
		local neweyeang = self.Owner:EyeAngles() + tmprecoilang*self.Primary.StaticRecoilFactor
		neweyeang.p = math.Clamp(neweyeang.p,-90+math.abs(self.Owner:GetViewPunchAngles().p),90-math.abs(self.Owner:GetViewPunchAngles().p))
		self.Owner:SetEyeAngles( neweyeang )
	end
	
end

local decalbul = {
	Num 		= 1,
	Spread 	= vector_origin,
	Tracer	= 0,
	Force		= 0.5,
	Damage	= 0.1
}

local penetration_cvar = GetConVar("sv_tfa_bullet_penetration")
local ricochet_cvar = GetConVar("sv_tfa_bullet_ricochet")
local rngfac
local mfac
	
function bullet:Penetrate( ply , traceres, dmginfo, weapon )
	
	if !IsValid(weapon) then return end
	
	local hitent = traceres.Entity
	
	if !self.HasAppliedRange then
		local bulletdistance =  ( ( traceres.HitPos - traceres.StartPos ):Length( ) )
		local damagescale = bulletdistance / weapon.Primary.Range
		damagescale = math.Clamp(damagescale - weapon.Primary.RangeFalloff,0,1)
		damagescale = math.Clamp(damagescale / math.max(1-weapon.Primary.RangeFalloff,0.01),0,1)
		damagescale = ( 1-GetConVarNumber("sv_tfa_range_modifier",0.5) ) + ( math.Clamp(1-damagescale,0,1) * GetConVarNumber("sv_tfa_range_modifier",0.5) )
		
		dmginfo:ScaleDamage(damagescale)
		self.HasAppliedRange = true
	end
	dmginfo:SetDamageType( weapon.DamageType or weapon.Primary.DamageType or DMG_BULLET )
	
	if SERVER and IsValid(ply) and ply:IsPlayer() and IsValid(hitent) and ( hitent:IsPlayer() or hitent:IsNPC() ) then
		net.Start("tfaHitmarker")
		net.Send(ply)
	end
	
	if weapon.DamageType then
		if dmginfo:IsDamageType(DMG_SHOCK) or dmginfo:IsDamageType(DMG_BLAST) then
			if traceres.Hit and IsValid(hitent) then
				if hitent:GetClass()=="npc_strider" then
					hitent:SetHealth(math.max(hitent:Health()-dmginfo:GetDamage(),2))
					if hitent:Health()<=3 then
						hitent:Extinguish()
						hitent:Fire("sethealth","-1",0.01)
						dmginfo:ScaleDamage(0)
					end
				end
			end
		end
		if dmginfo:IsDamageType(DMG_BURN) then
			if traceres.Hit and IsValid(hitent) and !traceres.HitWorld and !traceres.HitSky then
				if dmginfo:GetDamage()>1 then
					if hitent.Ignite then
						hitent:Ignite(dmginfo:GetDamage()/2,1)
					end
				end
			end
		end
		if dmginfo:IsDamageType(DMG_BLAST) then
			if traceres.Hit then
				local tmpdmg = dmginfo:GetDamage()
				util.BlastDamage(weapon,weapon.Owner,traceres.HitPos,tmpdmg/2,tmpdmg)
				local fx = EffectData()
				fx:SetOrigin(traceres.HitPos)
				fx:SetNormal(traceres.HitNormal)
				if tmpdmg>90 then
					util.Effect("Explosion",fx)
				elseif tmpdmg>45 then
					util.Effect("cball_explode",fx)				
				else
					util.Effect("ManhackSparks",fx)
				end
				dmginfo:ScaleDamage(0.15)
			end
		end
	end
	
	if penetration_cvar and !penetration_cvar:GetBool() then return end
	
	if self:Ricochet(ply,traceres,dmginfo,weapon) then return end
	
	if self.PenetrationCount > weapon.MaxPenetrationCounter then return end
	
	local mult = weapon:GetPenetrationMultiplier( traceres.MatType )
	
	penetrationoffset = traceres.Normal * math.Clamp( self.Force * mult, 0, 32 )
		
	local pentrace 	= {}
	pentrace.endpos 	= traceres.HitPos
	pentrace.start 	= traceres.HitPos + penetrationoffset
	pentrace.mask 		= MASK_SHOT
	pentrace.filter 	= {}
	   
	pentraceres 	= util.TraceLine(pentrace)

	if (pentraceres.StartSolid or pentraceres.Fraction >= 1.0 or pentraceres.Fraction <= 0.0) then return end
	
	self.Src 		= pentraceres.HitPos
	self.Dir 		= traceres.Normal
	if ( self.Num or 0 )<=1 then self.Spread = Vector(0,0,0) end
	self.Tracer 	= weapon.TracerName and 0 or 1
	
	rngfac = math.pow( pentraceres.HitPos:Distance(traceres.HitPos)/penetrationoffset:Length(), 2 )
	mfac = math.pow(mult/10,0.35)
	
	self.Force		= Lerp( rngfac , self.Force, self.Force * mfac )
	self.Damage		= Lerp( rngfac, self.Damage, self.Damage * mfac )
	self.PenetrationCount = self.PenetrationCount + 1
	
	decalbul.Src = pentraceres.HitPos + pentraceres.HitNormal
	decalbul.Dir = traceres.HitNormal * 64
	
	local fx = EffectData()
	fx:SetOrigin(self.Src)
	fx:SetNormal(self.Dir)
	fx:SetMagnitude(1)
	fx:SetEntity(weapon)
	util.Effect("tfa_penetrate",fx)
	
	if IsValid(ply) then
		ply:FireBullets( self )
		ply:FireBullets( decalbul )
	end
	
end

function bullet:Ricochet( ply, traceres, dmginfo, weapon)
	
	if ricochet_cvar and !ricochet_cvar:GetBool() then return end
	
	if self.PenetrationCount > weapon.MaxPenetrationCounter then
		return
	end
		
	--[[
	]]--
	
	local matname = weapon:GetMaterialConcise( traceres.MatType )
	local ricochetchance = 1
	local dir = (traceres.HitPos-traceres.StartPos)
	dir:Normalize()
	local dp =  dir:Dot(traceres.HitNormal*-1)
	if matname == "glass" then
		ricochetchance = 0
	elseif matname == "plastic" then
		ricochetchance = 0.01
	elseif matname == "dirt" then
		ricochetchance = 0.01
	elseif matname == "grass" then
		ricochetchance = 0.01
	elseif matname == "sand" then
		ricochetchance = 0.01
	elseif matname == "ceramic" then
		ricochetchance = 0.15
	elseif matname == "metal" then
		ricochetchance = 0.7
	elseif matname == "default" then
		ricochetchance = 0.5
	else
		ricochetchance = 0
	end
	
	ricochetchance = ricochetchance * 0.5 * weapon:GetAmmoRicochetMultiplier()
	
	local riccbak = ricochetchance / 0.7
	local ricothreshold = 0.6
	ricochetchance = math.Clamp(ricochetchance + ricochetchance * math.Clamp(1-(dp+ricothreshold),0,1) * 0.5,0,1)
	if dp<=ricothreshold then
		if math.Rand(0,1)<ricochetchance then
			
			self.Damage = self.Damage * 0.5
			self.Force = self.Force * 0.5
			self.Num = 1
			self.Spread = vector_origin
			self.Src=traceres.HitPos
			self.Dir=((2 * traceres.HitNormal * dp) + traceres.Normal) + (VectorRand() * 0.02)
			
			if GetTFARicochetEnabled() then
				local fx = EffectData()
				fx:SetOrigin(self.Src)
				fx:SetNormal(self.Dir)
				fx:SetMagnitude(riccbak)
				util.Effect("tfa_ricochet",fx)
			end
			
			timer.Simple(0,function()
				if IsValid(ply) then
					ply:FireBullets( self )
				end
			end)
			
			self.PenetrationCount = self.PenetrationCount + 1
			
			return true
		end
	end
	
end
