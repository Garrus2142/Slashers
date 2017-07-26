local function rvec(vec)
	vec.x=math.Round(vec.x)
	vec.y=math.Round(vec.y)
	vec.z=math.Round(vec.z)
	return vec
end

local blankvec = Vector(0,0,0)

local function partfunc(self)
	if IsValid(self.FollowEnt) then
		if self.Att then
			local angpos = self.FollowEnt:GetAttachment(self.Att)
			if angpos and angpos.Pos then
				self:SetPos(angpos.Pos)
				self:SetNextThink(CurTime())
			end
		end
	end
end

function EFFECT:Init( data )
	

	self.Position = blankvec
	self.WeaponEnt = data:GetEntity()
	self.WeaponEntOG = self.WeaponEnt
	self.Attachment = data:GetAttachment()
	self.Dir = data:GetNormal()
	local owent
	if IsValid(self.WeaponEnt) then
		owent = self.WeaponEnt.Owner or self.WeaponEnt:GetOwner()
	end
	if !IsValid(owent) then owent = self.WeaponEnt:GetParent() end
	if IsValid(owent) and owent:IsPlayer() then
		if owent!=LocalPlayer() or owent:ShouldDrawLocalPlayer() then
			self.WeaponEnt = owent:GetActiveWeapon()
			if !IsValid(self.WeaponEnt) then return end
		else
			self.WeaponEnt = owent:GetViewModel()
			local theirweapon = owent:GetActiveWeapon()
			if IsValid(theirweapon) then
				if theirweapon.ViewModelFlip or theirweapon.ViewModelFlipped then
					self.Flipped = true
				end
			end
			if !IsValid(self.WeaponEnt) then return end		
		end
	end
	
	if IsValid(self.WeaponEntOG) and self.WeaponEntOG.MuzzleAttachment then
		self.Attachment = self.WeaponEnt:LookupAttachment(self.WeaponEntOG.MuzzleAttachment)
		if !self.Attachment or self.Attachment<=0 then
			self.Attachment = 1
		end
	
		if self.WeaponEntOG.Akimbo then
			self.Attachment = 2-self.WeaponEntOG.AnimCycle
		end	
	end
	
	local angpos = self.WeaponEnt:GetAttachment(self.Attachment)
	
	if !angpos or !angpos.Pos then angpos = {Pos = bvec,Ang=uAng} end
	
	if self.Flipped then
		local tmpang = (self.Dir or angpos.Ang:Forward()):Angle()
		local localang = self.WeaponEnt:WorldToLocalAngles(tmpang)
		localang.y = localang.y + 180
		localang = self.WeaponEnt:LocalToWorldAngles(localang)
		--localang:RotateAroundAxis(localang:Up(),180)
		--tmpang:RotateAroundAxis(tmpang:Up(),180)
		self.Dir = localang:Forward()
	end
	
	-- Keep the start and end Pos - we're going to interpolate between them
	self.Position = self:GetTracerShootPos( angpos.Pos, self.WeaponEnt, self.Attachment )
	self.Norm = self.Dir or angpos.Ang:Forward()--angpos.Ang:Forward()
	
	self.vOffset = self.Position
	dir = self.Norm
	AddVel = vector_origin

	if IsValid(self.WeaponEnt) then
		dlight = DynamicLight(self.WeaponEnt:EntIndex())
	else
		dlight = DynamicLight(0)	
	end
	
	local fadeouttime = 0.2
    if (dlight) then
        dlight.Pos              = self.Position + dir * 1 - dir:Angle():Right()*5
        dlight.r                = 25
        dlight.g                = 200
        dlight.b                = 255
        dlight.Brightness = 4.0
        dlight.size     = 110
		dlight.decay = 1000
        dlight.DieTime  = CurTime() + fadeouttime
   end
	
	ParticleEffectAttach("tfa_muzzle_gauss",PATTACH_POINT_FOLLOW,self.WeaponEnt,data:GetAttachment())
	
end 

function EFFECT:Think( )
	return false
end

function EFFECT:Render()
end

 