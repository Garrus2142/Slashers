local cyc, seq, act

function SWEP:UpdateViewModel()
	if !self.OwnerViewModel then self.OwnerViewModel=self.Owner:GetViewModel() end
end

function SWEP:SetUnpredictedHolstering( val )
	self.IsHolsteringCL = val
end

function SWEP:GetUnpredictedHolstering( )
	return ( self.IsHolsteringCL == nil ) and false or self.IsHolsteringCL
end

function SWEP:StopClientHolstering()
	if SERVER and IsValid(self.Owner) then
		self:CallOnClient("StopClientHolstering","")
	else
		self:SetHolstering(false)
		self:SetUnpredictedHolstering(false)
	end
end

--[[ 
Function Name:  CanChamber
Syntax: self:CanChamber().
Returns:  If we can't chamber.
Notes:
Purpose:  You ain't no muslim, bruv
]]--

function SWEP:CanChamber()
	if self.DisableChamberingNew!=nil then
		return !self.DisableChamberingNew
	else
		if self.Category == "TFA Pistols" and self.HoldType == "revolver" then self.Revolver = true end
		self.DisableChamberingNew = self.BoltAction or self.Shotgun or self.Revolver or self.DisableChambering
		return !self.DisableChamberingNew
	end
end


--[[ 
Function Name:  GetType
Syntax: self:GetType()
Returns:  The weapon type ("shotgun","rifle","pistol","smg","sniper","dmr", or custom).
Notes:  Sets the proper viewmodel bodygroups.
Purpose:  You ain't no muslim, bruv
]]--

function SWEP:GetType()
	if self.Type then return self.Type end
	
	local at = string.lower(self.Primary.Ammo or "")
	
	local ht = string.lower( (self.DefaultHoldType or self.HoldType) or "")
	
	local rpm = self.Primary.RPM or 600
	
	if self.Shotgun or at=="buckshot" then
		self.Type="Shotgun"
		return self:GetType()
	end
	
	if self.Pistol or ( at=="pistol" and ht == "pistol" ) then
		self.Type="Pistol"
		return self:GetType()
	end
	
	if self.SMG or ( at=="smg1" and ( ht=="smg" or ht == "pistol" ) ) then
		self.Type="Sub-Machine Gun"
		return self:GetType()
	end
	
	if self.Revolver or ( at=="357" and ht=="revolver" ) then
		self.Type="Revolver"
		return self:GetType()
	end
	--Detect Sniper Type
	
	if ( self.Scoped or self.Scoped_3D ) and rpm<600 then
		if rpm>180 then
			self.Type = "Designated Marksman Rifle"
			return self:GetType()
		else
			self.Type = "Sniper Rifle"
			return self:GetType()
		end
	end
	
	--Detect based on holdtype
	
	if ht=="pistol" then
		self.Type="Pistol"
		return self:GetType()
	end
	
	if ht=="revolver" then
		self.Type="Revolver"
		return self:GetType()
	end
	
	if ht=="duel" then
		if at=="pistol" then
			self.Type = "Dual Pistols"
			return self:GetType()
		elseif at=="357" then
			self.Type = "Dual Revolvers"
			return self:GetType()
		elseif at=="smg1" then
			self.Type = "Dual Sub-Machine Guns"
			return self:GetType()
		else
			self.Type = "Dual Guns"
			return self:GetType()
		end
	end
	
	--If it's using rifle ammo, it's a rifle or a carbine
	
	if at=="ar2" then
		if ht=="ar2" or ht=="shotgun" then
			self.Type = "Rifle"
			return self:GetType()
		else
			self.Type = "Carbine"
			return self:GetType()
		end	
	end
	
	--Check SMG one last time
	
	if ht=="smg" or at=="smg1" then
		self.Type="Sub-Machine Gun"
		return self:GetType()
	end
	
	--Fallback to generic
	
	self.Type = "Weapon"
	
	return self:GetType()
	
end

--[[ 
Function Name:  GetProceduralReloading
Syntax: self:GetProceduralReloading()
Returns:  Are we reloading, procedurally?.
Notes:  
Purpose: 
]]--

function SWEP:GetProceduralReloading()
	return self.DoProceduralReload and self:GetReloading()
end

--[[ 
Function Name:  DoBodyGroups
Syntax: self:DoBodyGroups().  Should be called only once for best performance.
Returns:  Nothing.
Notes:  Sets the proper viewmodel bodygroups.
Purpose:  You ain't no muslim, bruv
]]--

function SWEP:DoBodyGroups()
	if SERVER then self:CallOnClient("DoBodyGroups","") end
	
	if !IsValid(self) then return end
	
	if !self.WMBodyGroups then
		self.WMBodyGroups = self.BodyGroups
	end
	
	if self.WMBodyGroups and #self.WMBodyGroups>0 then
		for k,v in pairs(self.WMBodyGroups) do
			if type(k)=="number" then
				self:SetBodygroup(k,v)
			end
		end
	end
	
	if !self:OwnerIsValid() then return end
	local vm = self.OwnerViewModel
	
	if !self.VMBodyGroups then
		self.VMBodyGroups = self.BodyGroups
	end
	
	if self.VMBodyGroups and #self.VMBodyGroups>0 then
		for k,v in pairs(self.VMBodyGroups) do
			if type(k)=="number" then
				vm:SetBodygroup(k,v)
			end
		end
	end
	
end


--[[ 
Function Name:  ResetVMBodyGroups
Syntax: self:DoBodyGroups().  Should be called only once for best performance.
Returns:  Nothing.
Notes:  Sets the proper viewmodel bodygroups.
Purpose:  Bruv
]]--

function SWEP:ResetVMBodyGroups()
	
	if !IsValid(self) then return end
	
	if !self:OwnerIsValid() then return end
	
	local vm = self.OwnerViewModel
	
	if !self.VMBodyGroups then
		self.VMBodyGroups = self.BodyGroups
	end
	
	if self.VMBodyGroups and #self.VMBodyGroups>0 then
		for k,v in pairs(self.VMBodyGroups) do
			if type(k)=="number" then
				vm:SetBodygroup(k,0)
			end
		end
	end
	
end

--[[ 
Function Name:  IsHidden
Syntax: self:IsHidden( ). 
Returns:   Should we hide self?.
Notes:    
Purpose:  Utility
]]--

function SWEP:IsHidden()
	if !self:OwnerIsValid() then return true end
	local vm = self.OwnerViewModel
	if !IsValid(vm) then return true end
	cyc = vm:GetCycle()
	seq = vm:GetSequence()
	act = vm:GetSequenceActivity(seq or 0)
	local heldentindex = self.Owner:GetNWInt("LastHeldEntityIndex",-1)
	local heldent = Entity(heldentindex)
	if heldentindex!=-1 and IsValid(heldent) and heldent.IsPlayerHolding and !heldent:IsPlayerHolding() then
		self.Owner:SetNWInt("LastHeldEntityIndex",-1)
		heldent = nil
	end
	
	return self:IsCurrentlyScoped() or ( IsValid(heldent) and (!heldent.IsPlayerHolding or heldent:IsPlayerHolding() ) ) or ( (act==ACT_VM_HOLSTER or act==ACT_VM_HOLSTER_EMPTY) and cyc>0.9) or ( (act==ACT_VM_DRAW or act==ACT_VM_DRAW_EMPTY or act==ACT_VM_DRAW_SILENCED) and cyc<0.05 and cyc!=0 )
end

--[[ 
Function Name:  UpdateConDamage
Syntax: self:UpdateConDamage( ). 
Returns:   Nothing.
Notes:    Used to update damage multiplier.
Purpose:  Utility
]]--

function SWEP:UpdateConDamage()
	
	if !IsValid(self) then return end
	
	if !self.DamageConVar then
		self.DamageConVar = GetConVar("sv_tfa_damage_multiplier")
	end
	
	if self.DamageConVar and self.DamageConVar.GetFloat then
		self.ConDamageMultiplier = self.DamageConVar:GetFloat()
	end
end

--[[ 
Function Name:  ResetSightsProgress
Syntax: self:ResetSightsProgress( ). 
Returns:   Nothing.
Notes:    Used to reset the progress of some stuff , idk, can you read?
Purpose:  Utility
]]--

function SWEP:ResetSightsProgress()

	if self.Callback.ResetSightsProgress then
		local val = self.Callback.ResetSightsProgress(self)
		if val then return val end
	end
		
	self.RunSightsProgress=0
	if CLIENT then
		self.CLNearWallProgress=0 --BASE DEPENDENT VALUE.  DO NOT CHANGE OR THINGS MAY BREAK.  NO USE TO YOU.
		self.CLRunSightsProgress=0 --BASE DEPENDENT VALUE.  DO NOT CHANGE OR THINGS MAY BREAK.  NO USE TO YOU.
		self.CLIronSightsProgress=0 --BASE DEPENDENT VALUE.  DO NOT CHANGE OR THINGS MAY BREAK.  NO USE TO YOU.
		self.CLCrouchProgress=0 --BASE DEPENDENT VALUE.  DO NOT CHANGE OR THINGS MAY BREAK.  NO USE TO YOU.
		self.CLJumpProgress=0 --BASE DEPENDENT VALUE.  DO NOT CHANGE OR THINGS MAY BREAK.  NO USE TO YOU.
		self.CLSpreadRatio=0 --BASE DEPENDENT VALUE.  DO NOT CHANGE OR THINGS MAY BREAK.  NO USE TO YOU.
		self.CLAmmoHUDProgress=0 --BASE DEPENDENT VALUE.  DO NOT CHANGE OR THINGS MAY BREAK.  NO USE TO YOU.
		self.ShouldDrawAmmoHUD=false
	end
	
	self:SetIronSightsRatio(0)	
	self:SetRunSightsRatio(0)
end

--[[ 
Function Name:  DoAmmoCheck
Syntax: self:DoAmmoCheck( ). 
Returns:   Nothing.
Notes:    Used to strip the weapon depending on convars set.
Purpose:  Utility
]]--

function SWEP:DoAmmoCheck()
	
	if IsValid(self) then

		if self.Callback.DoAmmoCheck then
			local val = self.Callback.DoAmmoCheck(self)
			if val then return val end
		end
	
		if SERVER and (GetConVar("sv_tfa_weapon_strip"):GetBool()) then 
			if self:Clip1() == 0 && self.Owner:GetAmmoCount( self:GetPrimaryAmmoType() ) == 0 then
				timer.Simple(.1, function()
					if SERVER then
						if IsValid(self) then
							if IsValid(self.Owner) then
								self.Owner:StripWeapon(self.Gun)
							end
						end
					end
				end)
			end
		end
	end
end

--[[ 
Function Name:  DoAmmoCheck
Syntax: self:DoAmmoCheck( sound table or string ). 
Returns:   Nothing.
Notes:    Used to play a sound table or string.
Purpose:  Utility
]]--

function SWEP:PlaySound( snd )

	if self.Callback.PlaySound then
		local val = self.Callback.PlaySound(self, snd)
		if val then return val end
	end
	
	if !snd then return end
	if type(snd)!="table" then
		self:EmitSound(snd)
	else
		local num = math.random(1,#snd)
		local snd2 = snd[num]
		self:EmitSound(snd2)
	end
end

--[[ 
Function Name:  GetFireModeName
Syntax: self:GetFireModeName( ). 
Returns:   Firemode name.
Notes:    Returns either the custom name you force or the autodetected one.
Purpose:  Utility
]]--

function SWEP:GetFireModeName()

	if self.Callback.GetFireModeName then
		local val = self.Callback.GetFireModeName(self)
		if val then return val end
	end
	
	local fm = self:GetFireMode()
	local fmn = string.lower(self.FireModes[fm])
	
	if string.find(fmn,"safe") or string.find(fmn,"holster") then
		return "Safety"
	end
	
	if self.FireModeName then
		return self.FireModeName
	end
	
	if string.find(fmn,"auto") then
		return "Full-Auto"
	end
	if string.find(fmn,"single") then
		if (self.Revolver or ( (self.DefaultHoldType and self.DefaultHoldType or self.HoldType) == "revolver" ) ) then
			if (self.BoltAction) then
				return "Single-Action"
			else
				return "Double-Action"
			end
		else
			if (self.BoltAction) then
				return "Bolt-Action"
			else
				if (self.Shotgun and self.Primary.RPM<250) then
					return "Pump-Action"
				else
					return "Semi-Auto"
				end
			end
		end
	end
	local bpos = string.find(fmn,"burst")
	if bpos then
		return string.sub(fmn,1,bpos-1) .. " Round Burst"
	end
end

--[[ 
Function Name:  IsSafety
Syntax: self:IsSafety( ). 
Returns:   Are we in safety firemode.
Notes:    Non.
Purpose:  Utility
]]--

function SWEP:IsSafety()

	if self.Callback.IsSafety then
		local val = self.Callback.IsSafety(self)
		if val then return val end
	end
	
	if !self.FireModes then return false end
	
	local fm = self.FireModes[self:GetFireMode()]
	local fmn = string.lower(fm and fm or self.FireModes[1] )
	
	if ( string.find(fmn,"safe") or string.find(fmn,"holster") ) then
		return true
	else
		return false
	end
end

--[[ 
Function Name:  FindEvenBurstNumber
Syntax: self:FindEvenBurstNumber( ). 
Returns:   The ideal burst count.
Notes:    This will result in a two round burst on guns like the glock.  Please check out the autodetect code for how to do things like three round burst in a 20 round clip.
Purpose:  Utility
]]--

function SWEP:FindEvenBurstNumber()

	if self.Callback.FindEvenBurstNumber then
		local val = self.Callback.FindEvenBurstNumber(self)
		if val then return val end
	end
	
	if (self.Primary.ClipSize % 3 ==0 ) then
		return 3
	elseif (self.Primary.ClipSize % 2 == 0 ) then
		return 2
	else
		local i=4
		while i<=7 do
			if self.Primary.ClipSize % i == 0 then
				return i
			end
			i=i+1
		end
	end
	return nil
end

--[[ 
Function Name:  GetAmmoReserve
Syntax: self:GetAmmoReserve( ). 
Returns:   How much ammo the owner has in reserve.
Notes:    Returns -1 if the owner isn't valid.
Purpose:  Utility
]]--

function SWEP:GetAmmoReserve()

	if self.Callback.GetAmmoReserve then
		local val = self.Callback.GetAmmoReserve(self)
		if val then return val end
	end

	local wep = self
	if ( !IsValid( wep ) ) then return -1 end
	
	local ply = self.Owner
	if ( !IsValid( ply ) ) then return -1 end
 
	return ply:GetAmmoCount( wep:GetPrimaryAmmoType() )
end

--[[ 
Function Name:  GetRPM
Syntax: self:GetRPM( ). 
Returns:   How many RPM.
Notes:    Returns 600 as default.
Purpose:  Utility
]]--

function SWEP:GetRPM()

	if self.Callback.GetRPM then
		local val = self.Callback.GetRPM(self)
		if val then return val end
	end
	
	if !self.Primary.Automatic then
		if self.Primary.RPM_Burst and string.find( string.lower( self.FireModes[self:GetFireMode()] or "" ), "burst" ) then
			return self.Primary.RPM_Burst
		elseif self.Primary.RPM_Semi then
			return self.Primary.RPM_Semi 
		end
	end
	
	if self.Primary.RPM then
		return self.Primary.RPM
	end
	
	return 600
end

--[[ 
Function Name:  GetBurstDelay
Syntax: self:GetBurstDelay( ). 
Returns:   How long we wait between bursts.
Notes:    Returns a delay equivalent to  RPM / 3.
Purpose:  Utility
]]--

function SWEP:GetBurstDelay( bur )

	if self.Callback.GetRPM then
		local val = self.Callback.GetRPM(self)
		if val then return val end
	end
	
	if !bur then bur = self:GetMaxBurst() end
	
	if bur<=1 then return 0 end
	
	if self.Primary.BurstDelay then return self.Primary.BurstDelay end
	 
	if self.Primary.RPM_Burst then
		return 60 / ( self.Primary.RPM_Burst * 3 )
	elseif self.Primary.RPM_Semi then
		return 60 / ( self.Primary.RPM_Semi  * 3 )
	elseif self.Primary.RPM then
		return 60 / ( self.Primary.RPM / 3 )
	end
	
	return 0.3
end

--[[ 
Function Name:  GetMaxBurst
Syntax: self:GetMaxBurst( ). 
Returns:   How many shots per burst
Notes:    
Purpose:  Utility
]]--

local bpos
SWEP.BurstCountCache = {}

function SWEP:GetMaxBurst()

	local fm = self.FireModes[self:GetFireMode()] or "3Burst"
	
	if !self.BurstCountCache[fm] then
		bpos = string.find(string.lower(fm),"Burst") or 2
		self.BurstCountCache[fm] = tonumber( string.sub(fm,1,bpos-1) ) or 1
	end
	
	return self.BurstCountCache[fm] or 1
end

--[[ 
Function Name:  IsCurrentlyScoped
Syntax: self:IsCurrentlyScoped( ). 
Returns:   Is the player scoped in enough to display the overlay?  true/false, returns a boolean.
Notes:    Change SWEP.ScopeOverlayThreshold to change when the overlay is displayed.
Purpose:  Utility
]]--

function SWEP:IsCurrentlyScoped()

	if self.Callback.IsCurrentlyScoped then
		local val = self.Callback.IsCurrentlyScoped(self)
		if val then return val end
	end
	
	if CLIENT then
		return ( (self.CLIronSightsProgress > self.ScopeOverlayThreshold)  and self.Scoped)
	else
		return ( (self:GetIronSightsRatio() > self.ScopeOverlayThreshold)  and self.Scoped)
	end
end

--[[ 
Function Name:  IsFirstPerson
Syntax: self:IsFirstPerson( ). 
Returns:   Is the owner in first person.
Notes:    Broken in singplayer because gary.
Purpose:  Utility
]]--

function SWEP:IsFirstPerson()

	if IsValid(self) and self.Callback.IsFirstPerson then
		local val = self.Callback.IsFirstPerson(self)
		if val then return val end
	end
	
	if !IsValid(self) or !self:OwnerIsValid() then return false end
	
	local gmsdlp
	
	if LocalPlayer then
		gmsldp = hook.Call("ShouldDrawLocalPlayer", GAMEMODE, self.Owner) 
	else
		gmsldp = false
	end
	
	if gmsdlp then return false end
	
	local vm = self.OwnerViewModel
	
	if IsValid(vm) then
		if vm:GetNoDraw() or vm:IsEffectActive(EF_NODRAW) then
			return false
		end
	end
	
	if !self:IsWeaponVisible() then
		return false
	end
	
	if self.Owner.ShouldDrawLocalPlayer and self.Owner:ShouldDrawLocalPlayer() then
		return false
	end
	
	return true
end

--[[ 
Function Name:  GetFPMuzzleAttachment
Syntax: self:GetFPMuzzleAttachment( ). 
Returns:   The firstperson/viewmodel muzzle attachment id.
Notes:    Defaults to the first attachment.
Purpose:  Utility
]]--
	
local muzzlepos,ply,fp,obj,vm

function SWEP:GetFPMuzzleAttachment( )

	if self.Callback.GetFPMuzzleAttachment then
		local val = self.Callback.GetFPMuzzleAttachment(self)
		if val then return val end
	end
	
	self:UpdateViewModel()
	
	vm = self.OwnerViewModel
	
	if IsValid(vm) then
		
		if self:GetSilenced() then
			if self.MuzzleAttachmentSilenced then
				obj = vm:LookupAttachment( self.MuzzleAttachmentSilenced )
			else
				obj = vm:LookupAttachment( "muzzle_silenced" )
			end
		else
			obj = vm:LookupAttachment( self.MuzzleAttachment or "1")
		end
		
		if self.MuzzleAttachmentRaw then
			obj=self.MuzzleAttachmentRaw
		end
		
	end
	
	obj = math.Clamp(obj or 1,1,128)
	
	return obj 
end

--[[ 
Function Name:  GetMuzzlePos
Syntax: self:GetMuzzlePos( hacky workaround that doesn't work anyways ). 
Returns:   The AngPos for the muzzle attachment.
Notes:    Defaults to the first attachment, and uses GetFPMuzzleAttachment
Purpose:  Utility
]]--

function SWEP:GetMuzzlePos( ignorepos )

	if self.Callback.GetMuzzlePos then
		local val = self.Callback.GetMuzzlePos(self, ignorepos)
		if val then return val end
	end
	
	fp = self:IsFirstPerson()
	vm = self.OwnerViewModel
	
	if fp then
		obj = self:GetFPMuzzleAttachment()
	else
		obj = self:LookupAttachment( self.MuzzleAttachment and self.MuzzleAttachment or "1")
	end
	
	obj = math.Clamp(obj or 1,1,128)
	
	if fp then
		muzzlepos = vm:GetAttachment( obj )
	else
		muzzlepos = self:GetAttachment( obj )
	end
	
	return muzzlepos 
end

--[[ 
Function Name:  GetAmmoForceMultiplier
Syntax: self:GetAmmoForceMultiplier( ). 
Returns:  The force multiplier for given ammo type.
Notes:    Only compatible with default ammo types, unless you/I mod that.  BMG ammotype is detected based on name and category.
Purpose:  Utility
]]--

function SWEP:GetAmmoForceMultiplier()

	if self.Callback.GetAmmoForceMultiplier then
		local val = self.Callback.GetAmmoForceMultiplier(self)
		if val then return val end
	end
	
	if !self.PrintName then
		self.PrintName = ""
	end
	
	-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
	--AR2=Rifle ~= Caliber>.308
	--SMG1=SMG ~= Small/Medium Calber ~= 5.56 or 9mm
	--357=Revolver ~= .357 through .50 magnum
	--Pistol = Small or Pistol Bullets ~= 9mm, sometimes .45ACP but rarely.  Generally light.
	--Buckshot = Buckshot = Light, barely-penetrating sniper bullets.
	--Slam = Medium Shotgun Round
	--AirboatGun = Heavy, Penetrating Shotgun Round
	--SniperPenetratedRound = Heavy Large Rifle Caliber ~= .50 Cal blow-yer-head-off
	local am = string.lower(self.Primary.Ammo)
	if ( am=="pistol" ) then
		return 0.4 --M1911 .45 ACP penetrates 2 inches of concrete or so max
	elseif ( am=="357" ) then
		return 0.6--To compensate for the detection algorithm giving revolvers super penetration power because of recoil
	elseif ( am=="smg1" ) then
		return 0.475 --P90 penetrates 3 inches of the ol' crete, and is very capable at penetrating wood or sheet metal.  It can go through about 6 inches of wood or about 2.28 inches of light metal (most in-game is aluminum or light steel.)
	elseif (am=="ar2") then
		if self.afmult_ismachinegun == nil then
			self.afmult_ismachinegun = (string.find(string.lower(self.PrintName),"machine") or string.find(string.lower(self.Category),"machine"))
		end
		
		if self.afmult_ismachinegun then
			return 1.1--50 BMG
		else
			return 0.6--.308
		end
	elseif (am=="buckshot") then
		return 0.5
	elseif (am=="slam") then
		return 0.5
	elseif (am=="airboatgun") then 
		return 0.7
	elseif (am=="sniperpenetratedround") then
		return 1 --Gotta compensate for 
	else
		return 1
	end
	
end

--[[ 
Function Name:  OwnerIsValid
Syntax: self:OwnerIsValid( ). 
Returns:  Is our owner valid and alive?
Notes:    Use this when possible.  Seems to work better than just IsValid(self.Owner).
Purpose:  Utility
]]--

function SWEP:OwnerIsValid()
	
	if !IsValid(self.Owner) then return false end
	if !self.Owner:IsPlayer() then return false end
	if !self.Owner:Alive() then return false end
	return true
end

--[[ 
Function Name:  GetAmmoRicochetMultiplier
Syntax: self:GetAmmoRicochetMultiplier( ). 
Returns:  The ricochet multiplier for our ammotype.  More is more chance to ricochet.
Notes:    Only compatible with default ammo types, unless you/I mod that.  BMG ammotype is detected based on name and category.
Purpose:  Utility
]]--

function SWEP:GetAmmoRicochetMultiplier()

	if self.Callback.GetAmmoRicochetMultiplier then
		local val = self.Callback.GetAmmoRicochetMultiplier(self)
		if val then return val end
	end
	
	local am = string.lower(self.Primary.Ammo)
	if ( am=="pistol" ) then
		return 1.25
	elseif ( am=="357" ) then
		return 0.75
	elseif ( am=="smg1" ) then
		return 1.1
	elseif (am=="ar2") then
		return 0.9
	elseif (am=="buckshot") then
		return 2
	elseif (am=="slam") then
		return 1.5
	elseif (am=="airboatgun") then 
		return 0.8
	elseif (am=="sniperpenetratedround") then
		return 0.5
	else
		return 1
	end
end

--[[ 
Function Name:  GetMaterialConcise
Syntax: self:GetMaterialConcise( ). 
Returns:  The string material name.
Notes:    Always lowercase.
Purpose:  Utility
]]--

local matnamec =  {
	[MAT_GLASS] = "glass",
	[MAT_GRATE] = "metal",
	[MAT_METAL] = "metal",
	[MAT_VENT] = "metal",
	[MAT_COMPUTER] = "metal",
	[MAT_CLIP] = "metal",
	[MAT_FLESH] = "flesh",
	[MAT_ALIENFLESH] = "flesh",
	[MAT_ANTLION] = "flesh",
	[MAT_FOLIAGE] = "foliage",
	[MAT_DIRT] = "dirt",
	[MAT_GRASS or MAT_DIRT] = "dirt",
	[MAT_EGGSHELL] = "plastic",
	[MAT_PLASTIC] = "plastic",
	[MAT_TILE] = "ceramic",
	[MAT_CONCRETE] = "ceramic",
	[MAT_WOOD] = "wood",
	[MAT_SAND] = "sand",
	[MAT_SNOW or 0] = "snow",
	[MAT_SLOSH] = "slime",
	[MAT_WARPSHIELD] = "energy",
	[89] = "glass",
	[-1] = "default"

}

function SWEP:GetMaterialConcise( mat ) 

	if self.Callback.GetMaterialConcise then
		local val = self.Callback.GetMaterialConcise(self, mat)
		if val then return val end
	end
	
	return matnamec[mat] or matnamec[-1]
end

--[[ 
Function Name:  GetPenetrationMultiplier
Syntax: self:GetPenetrationMultiplier( concise material name). 
Returns:  The multilier for how much you can penetrate through a material.
Notes:    Should be used with GetMaterialConcise.
Purpose:  Utility
]]--

local matfacs = {
	["metal"] =2.5, --Since most is aluminum and stuff
	["wood"] =8,
	["plastic"] =5,
	["flesh"] =8,
	["ceramic"] =1.5,
	["glass"] =10,
	["energy"] =0.05,
	["sand"] =0.7,
	["slime"] =0.7,
	["dirt"] =4, --This is plaster, not dirt, in most cases.
	["foliage"] =6.5,
	["default"] = 4
}
	
local mat
local fac

function SWEP:GetPenetrationMultiplier( matt )

	if self.Callback.GetPenetrationMultiplier then
		local val = self.Callback.GetPenetrationMultiplier(self, matt)
		if val then return val end
	end
	
	mat = isstring(matt) and matt or self:GetMaterialConcise( matt )
	fac = matfacs[ matt or "default" ] or 4
	
	return fac * (self.Primary.PenetrationMultiplier and self.Primary.PenetrationMultiplier or 1)
	
end

--[[ 
Function Name:  CanDustEffect
Syntax: self:CanDustEffect( concise material name ). 
Returns:  True/False
Notes:    Used for the impact effect.  Should be used with GetMaterialConcise.
Purpose:  Utility
]]--

function SWEP:CanDustEffect( mat )

	if self.Callback.CanDustEffect then
		local val = self.Callback.CanDustEffect(self, mat)
		if val then return val end
	end
	
	local n = self:GetMaterialConcise( mat )
	if n=="energy" or n=="dirt" or n=="ceramic" or n=="plastic" or n=="wood" then
		return true
	end
	return false
end


--[[ 
Function Name:  CanSparkEffect
Syntax: self:CanSparkEffect( concise material name ). 
Returns:  True/False
Notes:    Used for the impact effect.  Should be used with GetMaterialConcise.
Purpose:  Utility
]]--

function SWEP:CanSparkEffect( mat )

	if self.Callback.CanSparkEffect then
		local val = self.Callback.CanSparkEffect(self, mat)
		if val then return val end
	end
	
	local n = self:GetMaterialConcise( mat )
	if n=="default" or n=="metal" then
		return true
	end
	return false
end

--[[ 
Function Name:  CPTbl
Syntax: self:CPTbl( input table). 
Returns:  Unique output table.
Notes:    Always lowercase.
Purpose:  Utility
]]--

function SWEP:CPTbl( tabl )
	if (tabl == nil) then return end
	if (!tabl) then return end 

	if self.Callback.CPTbl then
		local val = self.Callback.CPTbl(self, tabl)
		if val then return val end
	end
	
	local result = {}
	
	for k, v in pairs( tabl ) do
		if (type(v) == "table") then
			if v != tabl then
				result[k] = self:CPTbl(v) --Recursion, without the stack overflow.
			end
		elseif (type(v) == "Vector") then
			result[k] = Vector(v.x, v.y, v.z)
		elseif (type(v) == "Angle") then
			result[k] = Angle(v.p, v.y, v.r)
		else
			result[k] = v
		end
	end
	
	return result
end
