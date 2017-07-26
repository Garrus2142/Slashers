SWEP.Base = "tfa_nmrimelee_base"
SWEP.Category = "TFA NMRIH"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.PrintName = "Chainsaw"

SWEP.ViewModel			= "models/weapons/tfa_nmrih/v_me_chainsaw.mdl" --Viewmodel path
SWEP.ViewModelFOV = 50

SWEP.WorldModel			= "models/weapons/tfa_nmrih/w_me_chainsaw.mdl" --Viewmodel path
SWEP.HoldType = "shotgun"
SWEP.DefaultHoldType = "shotgun"
SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = 0,
        Right = 1,
        Forward = -1,
        },
        Ang = {
        Up = 2,
        Right = -30,
        Forward = 178
        },
		Scale = 1.0
}

SWEP.Primary.Sound = Sound("Weapon_Melee.HatchetLight")
SWEP.Secondary.Sound = Sound("Weapon_Melee.FireaxeHeavy")

SWEP.MoveSpeed = 1
SWEP.IronSightsMoveSpeed  = SWEP.MoveSpeed

SWEP.InspectPos = Vector(5.5, 1.424, -3.131)
SWEP.InspectAng = Vector(17.086, 3.938, 14.836)

SWEP.Primary.Reach = 75
SWEP.Primary.RPM = 50
SWEP.Primary.Damage = 70

SWEP.Primary.Ammo = "gasoline"
SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 1

SWEP.Primary.Motorized = true
SWEP.Primary.Motorized_ToggleBuffer = 0.1 --Blend time to idle when toggling
SWEP.Primary.Motorized_ToggleTime = 1.5 --Time until we turn on/off, independent of the above
SWEP.Primary.Motorized_IdleSound = Sound("Weapon_Chainsaw.IdleLoop") --Idle sound, when on
SWEP.Primary.Motorized_SawSound = Sound("Weapon_Chainsaw.SawLoop") --Rev sound, when on
SWEP.Primary.Motorized_AmmoConsumption_Idle = 0 --Ammo units to consume while idle
SWEP.Primary.Motorized_AmmoConsumption_Saw = 0 --Ammo units to consume while sawing
SWEP.Primary.Motorized_RPM = 400
SWEP.Primary.Motorized_Damage = 100 --DPS
SWEP.Primary.Motorized_Reach = 60 --DPS

SWEP.Secondary.BashDelay = 0.15
SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_R_Finger1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0.254, 0.09), angle = Angle(15.968, -11.193, 1.437) },
	["ValveBiped.Bip01_R_Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(3.552, 4.526, 0) },
	["Thumb04"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(6, 0, 0) },
	["Middle04"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-8.212, 1.121, 1.263) },
	["Pinky05"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(11.793, 4.677, 11.218) }
}

function SWEP:Reload()
	if !self:OwnerIsValid() then return end
	if !self.Primary.Motorized then return end
	if !self.Owner:KeyPressed(IN_RELOAD) then return end
	if self.Owner:KeyDown(IN_ATTACK) then return end
	if ( self:GetNWInt("ChargeStatus",0)>0 ) or self.ChargeTransition or self:GetNextSecondaryFire()>CurTime() then return end
	local am = self.Owner:GetAmmoCount(self:GetPrimaryAmmoType())
	/*if !self:GetNWBool("On",false) then
		if am<=0 and self:GetNWFloat("Clip",0)<=0 then return end
		local ammototake = math.max(math.min(am,self.Primary.ClipSize-self:GetNWFloat("Clip",0)),0)
		self:SetNWFloat("Clip",self:GetNWFloat("Clip",0)+ammototake)
		self.Owner:SetAmmo(am-ammototake,self:GetPrimaryAmmoType())
	end*/
	
	
	local vm = self.Owner:GetViewModel()
	if (CLIENT and IsFirstTimePredicted()) or SERVER then
		if self.ChargeTransition or self:GetNWInt("ChargeStatus",0)>0 then return end
		local on = self:GetNWBool("On",false)
		local ind = on and "turn_off" or "turn_on"
		self:SendWeaponSequence(ind,vm,-1,true)
		self:SetNWInt("ChargeStatus",1)
		self.ChargeTransition = true
		local waittime = math.max(vm:SequenceDuration() - self.Primary.Motorized_ToggleBuffer,0)
		self:SetNextIdleAnim( CurTime() +  waittime )
		self:SetNextSecondaryFire( CurTime() +  waittime )
		
		timer.Simple(waittime,function()
			if IsValid(self) then
				self:SetNWInt("ChargeStatus",0)
				self.ChargeTransition = false	
				if !on then
					self:SendWeaponSequence( "idle_on",vm,math.huge,false)
					self:EmitSound(self.Primary.Motorized_IdleSound)
				else
					self:StopSound(self.Primary.Motorized_SawSound)	
					self:StopSound(self.Primary.Motorized_IdleSound)				
				end
			end
		end)
		
		timer.Simple( on and 0.2 or self.Primary.Motorized_ToggleTime,function()
			if IsValid(self) then
				self:SetNWBool("On",!on)
			end		
		end)
		
		self:SetNextSecondaryFire(CurTime()+vm:SequenceDuration())
	end
end