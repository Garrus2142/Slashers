ACT_VM_FIDGET_EMPTY = ACT_VM_FIDGET_EMPTY or ACT_CROSSBOW_FIDGET_UNLOADED

function SWEP:UpdateLastAct(arg1)
	self.lastact = tonumber(arg1)
end

--[[ 
Function Name:  AnimForce
Syntax: self:AnimForce(tostring(ACT_VM_IDLE)).
Returns:  Nil
Notes:  Fixes client/server disparity in singleplayer.
Purpose:  Animation / Utility
]]--

function SWEP:AnimForce(str) 
	

	if !str then return end
	local ply = LocalPlayer and LocalPlayer() or self.Owner
	local vm = ply:GetViewModel()
	if IsValid(vm) then
		local strnum = tonumber(str)
		if !strnum then return end
		local nm = vm:SelectWeightedSequence(strnum)
		if !nm then return end
		vm:SendViewModelMatchingSequence(nm)
	end
	--self:ResetEvents()
end

--[[ 
Function Name:  ChooseDrawAnim
Syntax: self:ChooseDrawAnim().
Returns:  Could we successfully find an animation?  Which action?
Notes:  Requires autodetection or otherwise the list of valid anims.
Purpose:  Animation / Utility
]]--

function SWEP:ChooseDrawAnim()
	if !self:OwnerIsValid() then return end
	--self:ResetEvents()
	local tanim = ACT_VM_DRAW
	local success = true
	
	if self.SequenceEnabled[ACT_VM_DRAW_SILENCED] and self:GetSilenced() then
		tanim=ACT_VM_DRAW_SILENCED
	elseif self.SequenceEnabled[ACT_VM_DRAW_EMPTY] and (self:Clip1()==0) then
		tanim=ACT_VM_DRAW_EMPTY
	else
		tanim = ACT_VM_DRAW
	end
	
	self:SendWeaponAnim(tanim)
	
	if game.SinglePlayer() then
		self:CallOnClient("AnimForce",tanim)
	end
	
	self.lastact = tanim
	self:CallOnClient("UpdateLastAct",tostring(self.lastact))
	return success, tanim
end
--[[ 
Function Name:  ChooseInspectAnim
Syntax: self:ChooseInspectAnim().
Returns:  Could we successfully find an animation?  Which action?
Notes:  Requires autodetection or otherwise the list of valid anims.
Purpose:  Animation / Utility
]]--

function SWEP:ChooseInspectAnim()
	if !self:OwnerIsValid() then return end
	--self:ResetEvents()
	local tanim = ACT_VM_FIDGET
	local success = true
	if self.SequenceEnabled[ACT_VM_FIDGET_EMPTY] and math.Round(self:Clip1())==0 then
		self:SendWeaponAnim(ACT_VM_FIDGET_EMPTY)
		tanim=ACT_VM_FIDGET_EMPTY		
	elseif self.SequenceEnabled[ACT_VM_FIDGET] then
		--[[
		local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
			vm:SetSequence(vm:SelectWeightedSequence(ACT_VM_FIDGET))
			print(vm:SelectWeightedSequence(ACT_VM_FIDGET))
		end
		]]--
		self:SendWeaponAnim(ACT_VM_FIDGET)
		tanim=ACT_VM_FIDGET
	else
		local _,tanim2 = self:ChooseIdleAnim()
		tanim = tanim2
		success=false
	end
	
	if game.SinglePlayer() then
		self:CallOnClient("AnimForce",tanim)
	end
	
	self.lastact = tanim
	self:CallOnClient("UpdateLastAct",tostring(self.lastact))
	
	return success, tanim
end

--[[ 
Function Name:  ChooseHolsterAnim
Syntax: self:ChooseHolsterAnim().
Returns:  Could we successfully find an animation?  Which action?
Notes:  Requires autodetection or otherwise the list of valid anims.
Purpose:  Animation / Utility
]]--

ACT_VM_HOLSTER_SILENCED = ACT_VM_HOLSTER_SILENCED or ACT_CROSSBOW_HOLSTER_UNLOADED

function SWEP:ChooseHolsterAnim()
	if !self:OwnerIsValid() then return end
	--self:ResetEvents()
	local tanim = ACT_VM_IDLE
	local success = true
	if self:GetSilenced() and self.SequenceEnabled[ACT_VM_HOLSTER_SILENCED] then
		tanim = ACT_VM_HOLSTER_SILENCED
	elseif self.SequenceEnabled[ACT_VM_HOLSTER_EMPTY] and self:Clip1()==0 then
		tanim = ACT_VM_HOLSTER_EMPTY		
	elseif self.SequenceEnabled[ACT_VM_HOLSTER] then
		tanim = ACT_VM_HOLSTER
	end
	
	if tanim!=ACT_VM_IDLE then
		self:SendWeaponAnim(tanim)
		
		if game.SinglePlayer() then
			self:CallOnClient("AnimForce",tanim)
		end
	end
	
	self.lastact = tanim
	self:CallOnClient("UpdateLastAct",tostring(self.lastact))
	
	return true, tanim
end

--[[ 
Function Name:  ChooseProceduralReloadAnim
Syntax: self:ChooseProceduralReloadAnim().
Returns:  Could we successfully find an animation?  Which action?
Notes:  Uses some holster code
Purpose:  Animation / Utility
]]--


function SWEP:ChooseProceduralReloadAnim()
	if !self:OwnerIsValid() then return end
	
	if self.Callback.ChooseProceduralReloadAnim then
		local retval = self.Callback.ChooseProceduralReloadAnim(self)
		if retval != nil then return retval end
	end
	
	if !self.DisableIdleAnimations then
		self:SendWeaponAnim(ACT_VM_IDLE)
	end
	
	return true, ACT_VM_IDLE
end

--[[ 
Function Name:  ChooseReloadAnim
Syntax: self:ChooseReloadAnim().
Returns:  Could we successfully find an animation?  Which action?
Notes:  Requires autodetection or otherwise the list of valid anims.
Purpose:  Animation / Utility
]]--

function SWEP:ChooseReloadAnim()
	if !self:OwnerIsValid() then return end
	
	if self.Callback.ChooseReloadAnim then
		local retval = self.Callback.ChooseReloadAnim(self)
		if retval != nil then return retval end
	end
	
	--self:ResetEvents()
	local tanim
	local success = true
	
	if self.SequenceEnabled[ACT_VM_RELOAD_SILENCED] and self:GetSilenced() then
		tanim=ACT_VM_RELOAD_SILENCED
	elseif self.SequenceEnabled[ACT_VM_RELOAD_EMPTY] and (self:Clip1()==0) then
		tanim=ACT_VM_RELOAD_EMPTY
	else
		tanim = ACT_VM_RELOAD
	end
	
	self:SendWeaponAnim(tanim)
	
	if game.SinglePlayer() then
		self:CallOnClient("AnimForce",tanim)
	end
	
	self.lastact = tanim
	self:CallOnClient("UpdateLastAct",tostring(self.lastact))
	return success, tanim
end

--[[ 
Function Name:  ChooseReloadAnim
Syntax: self:ChooseReloadAnim().
Returns:  Could we successfully find an animation?  Which action?
Notes:  Requires autodetection or otherwise the list of valid anims.
Purpose:  Animation / Utility
]]--

function SWEP:ChooseShotgunReloadAnim()
	if !self:OwnerIsValid() then return end
	--self:ResetEvents()
	local tanim = ACT_SHOTGUN_RELOAD_START
	local success = true
	if self.SequenceEnabled[ACT_VM_RELOAD_SILENCED] and self:GetSilenced() then
		self:SendWeaponAnim(ACT_VM_RELOAD_SILENCED)
		tanim=ACT_VM_RELOAD_SILENCED
	else
		if self.SequenceEnabled[ACT_VM_RELOAD_EMPTY] and self.KF2StyleShotgun then
			if (self:Clip1()==0) then
				self:SendWeaponAnim(ACT_VM_RELOAD_EMPTY)
				tanim=ACT_VM_RELOAD_EMPTY
				self.StartAnimInsertShell = true
			else
				if self.SequenceEnabled[ACT_SHOTGUN_RELOAD_START] then
					self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_START)
				else
					local _,tanim2 = self:ChooseIdleAnim()
					tanim = tanim2
					success=false
				end
			end
		else
			if self.SequenceEnabled[ACT_SHOTGUN_RELOAD_START] then
				self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_START)
			else
				local _,tanim2 = self:ChooseIdleAnim()
				tanim = tanim2
				success=false
			end
		end
	end
	
	if game.SinglePlayer() then
		self:CallOnClient("AnimForce",tanim)
	end
	
	self.lastact = tanim
	self:CallOnClient("UpdateLastAct",tostring(self.lastact))
	return success, tanim
end

--[[ 
Function Name:  ChooseIdleAnim
Syntax: self:ChooseIdleAnim().
Returns:  True,  Which action?
Notes:  Requires autodetection for full features.
Purpose:  Animation / Utility
]]--

function SWEP:ChooseIdleAnim()
	if !self:OwnerIsValid() then return end
	--self:ResetEvents()
	local tanim=ACT_VM_IDLE
	if self.SequenceEnabled[ACT_VM_IDLE_SILENCED]  and self:GetSilenced() then
		self:SendWeaponAnim(ACT_VM_IDLE_SILENCED)
		tanim=ACT_VM_IDLE_SILENCED
	else
		if self.SequenceEnabled[ACT_VM_IDLE_EMPTY] then
			if (self:Clip1()==0) then
				self:SendWeaponAnim(ACT_VM_IDLE_EMPTY)
				tanim=ACT_VM_IDLE_EMPTY
			else
				self:SendWeaponAnim(ACT_VM_IDLE)
			end
		else
			self:SendWeaponAnim(ACT_VM_IDLE)
		end
	end
	
	if game.SinglePlayer() then
		self:CallOnClient("AnimForce",tanim)
	end
	
	self.lastact = tanim
	self:CallOnClient("UpdateLastAct",tostring(self.lastact))
	return true, tanim
end

--[[ 
Function Name:  ChooseShootAnim
Syntax: self:ChooseShootAnim().
Returns:  Could we successfully find an animation?  Which action?
Notes:  Requires autodetection or otherwise the list of valid anims.
Purpose:  Animation / Utility
]]--

function SWEP:ChooseShootAnim( ifp )
	if !self:OwnerIsValid() then return end
	
	
	
	if !self.BlowbackEnabled or ( !self:GetIronSights() and self.Blowback_Only_Iron) then
	
		local tanim
		local success = true
		
		if self.LuaShellEject then
			self:MakeShellBridge( ifp )
		end		
		
		if self.SequenceEnabled[ACT_VM_PRIMARYATTACK_SILENCED]  and self:GetSilenced() then
			tanim = ACT_VM_PRIMARYATTACK_SILENCED
		elseif self:Clip1()==1 and self.SequenceEnabled[ACT_VM_PRIMARYATTACK_EMPTY]  and !self.ForceEmptyFireOff then
			tanim = ACT_VM_PRIMARYATTACK_EMPTY		
		elseif self:Clip1()==0 and self.SequenceEnabled[ACT_VM_DRYFIRE] and !self.ForceDryFireOff then
			tanim = ACT_VM_DRYFIRE		
		elseif self.Akimbo and self.SequenceEnabled[ACT_VM_SECONDARYATTACK] and self.AnimCycle==1 then
			tanim = ACT_VM_SECONDARYATTACK
		elseif self:GetIronSights() and self.SequenceEnabled[ACT_VM_PRIMARYATTACK_1] then
			tanim = ACT_VM_PRIMARYATTACK_1
		else
			tanim = ACT_VM_PRIMARYATTACK		
		end
		
		self:SendWeaponAnim( tanim )
		
		if game.SinglePlayer() then
			self:CallOnClient("AnimForce",tanim)
		end
		
		self.lastact = tanim
		return success, tanim
		
	else
	
		--self:SendWeaponAnim(-1)
		
		if game.SinglePlayer() and SERVER then
			self:CallOnClient("BlowbackFull","")
		end
		
		if ifp then
			self:BlowbackFull( ifp )
		end
		
		self:MakeShellBridge( ifp )
		
		self.lastact = -2
		self:CallOnClient("UpdateLastAct",tostring(self.lastact))
		
		return true, ACT_VM_IDLE
		
	end
	
end

function SWEP:BlowbackFull()
	
	if IsValid(self) then
		self.lastact = -2
		self.BlowbackCurrent = 1
		self.BlowbackCurrentRoot = 1
	end
	
end

--[[ 
Function Name:  ChooseSilenceAnim
Syntax: self:ChooseSilenceAnim( true if we're silencing, false for detaching the silencer).
Returns:  Could we successfully find an animation?  Which action?
Notes:  Requires autodetection or otherwise the list of valid anims.  This is played when you silence or unsilence a gun.  
Purpose:  Animation / Utility
]]--

function SWEP:ChooseSilenceAnim( val )
	if !self:OwnerIsValid() then return end
	--self:ResetEvents()
	local tanim=ACT_VM_PRIMARYATTACK
	local success = false
	if val then
		if self.SequenceEnabled[ACT_VM_ATTACH_SILENCER] then
			self:SendWeaponAnim(ACT_VM_ATTACH_SILENCER)
			tanim=ACT_VM_ATTACH_SILENCER
			success=true
		end
	else
		if self.SequenceEnabled[ACT_VM_DETACH_SILENCER] then
			self:SendWeaponAnim(ACT_VM_DETACH_SILENCER)
			tanim=ACT_VM_DETACH_SILENCER
			success=true
		end
	end
	if !success then
		local _
		_, tanim = self:ChooseIdleAnim()
	end
	
	if game.SinglePlayer() then
		self:CallOnClient("AnimForce",tanim)
	end
	
	self.lastact = tanim
	self:CallOnClient("UpdateLastAct",tostring(self.lastact))
	return success, tanim
	
end

--[[ 
Function Name:  ChooseDryFireAnim
Syntax: self:ChooseDryFireAnim().
Returns:  Could we successfully find an animation?  Which action?
Notes:  Requires autodetection or otherwise the list of valid anims.  set SWEP.ForceDryFireOff to false to properly use.
Purpose:  Animation / Utility
]]--

function SWEP:ChooseDryFireAnim()
	if !self:OwnerIsValid() then return end
	--self:ResetEvents()
	local tanim=ACT_VM_DRYFIRE
	local success = true
	if self.SequenceEnabled[ACT_VM_DRYFIRE_SILENCED] and self:GetSilenced() and !self.ForceDryFireOff then
		self:SendWeaponAnim(ACT_VM_DRYFIRE_SILENCED)
		tanim=ACT_VM_DRYFIRE_SILENCED
	else
		if self.SequenceEnabled[ACT_VM_DRYFIRE] and !self.ForceDryFireOff then
			self:SendWeaponAnim(ACT_VM_DRYFIRE)
			tanim=ACT_VM_DRYFIRE
		else
			success=false
			local _
			_, tanim = nil, nil--self:ChooseIdleAnim()
		end
	end
	
	if game.SinglePlayer() then
		self:CallOnClient("AnimForce",tanim)
	end
	
	self.lastact = tanim
	self:CallOnClient("UpdateLastAct",tostring(self.lastact))
	return success, tanim
end
