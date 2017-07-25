DEFINE_BASECLASS("tfa_nmrih_base")

SWEP.LuaShellEject = false

SWEP.Primary.Blunt = false
SWEP.Primary.Damage = 60
SWEP.Primary.Reach = 75
SWEP.Primary.RPM = 60
SWEP.Primary.SoundDelay = 0.2
SWEP.Primary.Delay = 0.35
SWEP.Primary.Window = 0.3

SWEP.Secondary.Blunt = false
SWEP.Secondary.RPM = 45 -- Delay = 60/RPM, this is only AFTER you release your heavy attack
SWEP.Secondary.Damage = 120
SWEP.Secondary.Reach = 70
SWEP.Secondary.SoundDelay = 0.05
SWEP.Secondary.Delay = 0.25

SWEP.Secondary.BashDamage = 25
SWEP.Secondary.BashDelay = 0.2
SWEP.Secondary.BashLength = 65
SWEP.Secondary.BashDamageType = DMG_CLUB

SWEP.DisableChambering = true
SWEP.Primary.Motorized = true
SWEP.Primary.Motorized_ToggleBuffer = 0.1 --Blend time to idle when toggling
SWEP.Primary.Motorized_ToggleTime = 1.5 --Time until we turn on/off, independent of the above
SWEP.Primary.Motorized_IdleSound = Sound("Weapon_Chainsaw.IdleLoop") --Idle sound, when on
SWEP.Primary.Motorized_SawSound = Sound("Weapon_Chainsaw.SawLoop") --Rev sound, when on
SWEP.Primary.Motorized_AmmoConsumption_Idle = 100/120 --Ammo units to consume while idle
SWEP.Primary.Motorized_AmmoConsumption_Saw = 100/15 --Ammo units to consume while sawing
SWEP.Primary.Motorized_RPM = 600
SWEP.Primary.Motorized_Damage = 100 --DPS
SWEP.Primary.Motorized_Reach = 60 --DPS

SWEP.Slot = 0
SWEP.DrawCrosshair = false

SWEP.AnimSequences = {
	attack_quick = "Attack_Quick",
	--attack_quick2 = "Attack_Quick2",
	charge_begin = "Attack_Charge_Begin",
	charge_loop = "Attack_Charge_Idle",
	charge_end = "Attack_Charge_End",
	turn_on = "TurnOn",
	turn_off = "TurnOff",
	idle_on = "IdleOn",
	attack_enter = "Idle_To_Attack",
	attack_loop = "Attack_On",
	attack_exit = "Attack_To_Idle"
}

SWEP.Primary.Ammo = ""
SWEP.Primary.ClipSize = -1
SWEP.Primary.Sound = Sound("Weapon_Melee.FireaxeLight")
SWEP.Primary.HitSound_Flesh = {
	sharp = "Weapon_Melee_Sharp.Impact_Light",
	blunt = "Weapon_Melee_Blunt.Impact_Light"
}

SWEP.Secondary.Sound = Sound("Weapon_Melee.FireaxeHeavy")
SWEP.Secondary.HitSound_Flesh = {
	sharp = "Weapon_Melee_Sharp.Impact_Heavy",
	blunt = "Weapon_Melee_Blunt.Impact_Heavy"
}


SWEP.InspectPos = Vector(4.84, 1.424, -3.131)
SWEP.InspectAng = Vector(17.086, 3.938, 14.836)

SWEP.RunSightsPos = Vector(-2.15, 1.4, 0)
SWEP.RunSightsAng = Vector(-5, -0.301, -5)

--[[ Don't Edit Below ]]--

function SWEP:DoImpactEffect( tr, nDamageType )


end


SWEP.DamageType = DMG_SLASH

SWEP.MuzzleFlashEffect = "" --No muzzle
SWEP.DoMuzzleFlash = false --No muzzle
SWEP.WeaponLength = 1 --No nearwall

SWEP.Primary.Ammo			= ""			-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
SWEP.Primary.ClipSize			= 1		-- Size of a clip
SWEP.Primary.DefaultClip		= 1		-- Bullets you start with

SWEP.data 				= {} --No ironsights
SWEP.data.ironsights			= 0 --No ironsights

function SWEP:HitSound(mat,heavy,hitnpc)
	local snd = self.HitSounds[mat]
	if !snd then snd = self.HitSounds[-1] end
	if mat==MAT_FLESH or mat==MAT_ALIENFLESH or hitnpc then
		snd = heavy and self.Secondary.HitSound_Flesh[self.Secondary.Blunt and "blunt" or "sharp"] or self.Primary.HitSound_Flesh[self.Primary.Blunt and "blunt" or "sharp"] 
	end
	if snd and snd!="" then self:EmitSound(snd) end
end

function SWEP:SendWeaponSequence(seq,vm,idledelay,noidle)
	if !vm then vm = self.Owner:GetViewModel() end
	if !IsValid(vm) then return end
	
	local ind = seq
	if self.AnimSequences[seq] then
		ind = self.AnimSequences[seq]
		if type(ind) == "table" then
			math.randomseed(CurTime())
			ind = table.Random(ind)
		end
	end
	

	--[[
	if seq == "attack_on" and self.Primary.Motorized_SawSound then
		self:StopSound(self.Primary.Motorized_IdleSound)
		self:EmitSound(self.Primary.Motorized_SawSound)
	end
	]]--
	local seq2 = vm:LookupSequence(ind)
	if !seq2 or seq2<=-1 then return end
	vm:SendViewModelMatchingSequence(seq2)
		
	if game.SinglePlayer() then
		self:CallOnClient("AnimForce",ind)
	end
	
	timer.Simple( idledelay and (idledelay - 0.1) or (60/self.Primary.RPM-0.1),function()
		if IsValid(self) and !noidle then
			self:SendWeaponAnim(ACT_VM_IDLE)
		end
	end)
	
	timer.Simple( idledelay or (60/self.Primary.RPM),function()
		if IsValid(self) then
			if noidle then
				--self:SendWeaponSequence(seq2,vm,idledelay,noidle)
			else
				self:SendWeaponAnim(-1)
			end
		end
	end)
		
	self:SetNextIdleAnim(CurTime()+vm:SequenceDuration())
end

SWEP.Callback = {}
SWEP.Callback.Initialize = function(self)

end
SWEP.Callback.Deploy = function(self)
	
end
SWEP.Callback.Holster = function(self)
	
end
SWEP.Callback.OnDrop = function(self)

end
SWEP.Callback.OnRemove = function(self)

end

function SWEP:UpdateClip1()

end

function SWEP:Cough()


end

function SWEP:Reload()

end

function SWEP:PrimaryAttack()
	
end

function SWEP:SecondaryAttack()
	
end

function SWEP:Think()

end

function SWEP:PrimarySlash()
	
end

function SWEP:MotorSlash()
	
end

function SWEP:SecondarySlash()

end

function SWEP:ApplyForce(ent,dmg,pos,physbone)


end

function SWEP:AltAttack()

end

function SWEP:ToggleInspect()


end


SWEP.IsKnife = true