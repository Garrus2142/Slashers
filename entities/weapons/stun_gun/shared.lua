SWEP.Base = "tfa_nmrih_base"
SWEP.Category = "TFA NMRIH"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.Slot = 1

SWEP.PrintName = "Stun Gun"

SWEP.ViewModel			= "models/weapons/tfa_nmrih/v_fa_sw686.mdl" --Viewmodel path
SWEP.ViewModelFOV = 50

SWEP.WorldModel			= "models/weapons/tfa_nmrih/w_fa_sw686.mdl" --Viewmodel path
SWEP.HoldType = "revolver"
SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -3,
        Right = 3,
        Forward = -3,
        },
        Ang = {
        Up = -1,
        Right = -2,
        Forward = 178
        },
		Scale = 1.1
}

SWEP.Scoped = false

SWEP.Shotgun = false
SWEP.ShellTime = 0.75

SWEP.Revolver = true

SWEP.DisableChambering = true
SWEP.Primary.ClipSize = 6
SWEP.Primary.DefaultClip = 6

SWEP.Primary.Sound = "Weapon_686.Single"
SWEP.Primary.Ammo = "357"
SWEP.Primary.Automatic = false
SWEP.Primary.RPM = 120
SWEP.Primary.Damage = 80
SWEP.Primary.NumShots = 1
SWEP.Primary.Spread		= .0125					--This is hip-fire acuracy.  Less is more (1 is horribly awful, .0001 is close to perfect)
SWEP.Primary.IronAccuracy = .005	-- Ironsight accuracy, should be the same for shotguns

SWEP.Primary.KickUp			= 0.7					-- This is the maximum upwards recoil (rise)
SWEP.Primary.KickDown			= 0.6					-- This is the maximum downwards recoil (skeet)
SWEP.Primary.KickHorizontal			= 0.3					-- This is the maximum sideways recoil (no real term)
SWEP.Primary.StaticRecoilFactor = 0.8 	--Amount of recoil to directly apply to EyeAngles.  Enter what fraction or percentage (in decimal form) you want.  This is also affected by a convar that defaults to 0.5.

SWEP.Primary.SpreadMultiplierMax = 4.5 --How far the spread can expand when you shoot.
SWEP.Primary.SpreadIncrement = 1.2 --What percentage of the modifier is added on, per shot.
SWEP.Primary.SpreadRecovery = 3.5 --How much the spread recovers, per second.

SWEP.Secondary.IronFOV = 80 --Ironsights FOV (90 = same)
SWEP.BoltAction = false --Un-sight after shooting?
SWEP.BoltTimerOffset = 0.0 --How long do we remain in ironsights after shooting?

SWEP.IronSightsPos = Vector(-2.32, 0, 1.019)
SWEP.IronSightsAng = Vector(-0.076, 0.07, 0)

SWEP.RunSightsPos = Vector(1.3, 0, 1.406)
SWEP.RunSightsAng = Vector(-17.813, 3.454, -6.294)

SWEP.InspectionPos = Vector(11.112, -13.193, 1.041)
SWEP.InspectionAng = Vector(40, 38.693, 40)

SWEP.Primary.Range = 16*164.042*2.5 -- The distance the bullet can travel in source units.  Set to -1 to autodetect based on damage/rpm.
SWEP.Primary.RangeFalloff = 0.5 -- The percentage of the range the bullet damage starts to fall off at.  Set to 0.8, for example, to start falling off after 80% of the range.

SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_R_Finger1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0.254, 0.09), angle = Angle(15.968, -11.193, 1.437) },
	["ValveBiped.Bip01_R_Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(3.552, 4.526, 0) },
	["Thumb04"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(6, 0, 0) },
	["MagLite"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, -30), angle = Angle(0, 0, 0) }
}

SWEP.BlowbackEnabled = false
SWEP.BlowbackVector = Vector(0,-2.5,0)
SWEP.Blowback_PistolMode = true
SWEP.BlowbackBoneMods = {
	["Slide"] = { scale = Vector(1, 1, 1), pos = Vector(0, 2.509, 0), angle = Angle(0, 0, 0) }
}

SWEP.MoveSpeed = 0.95
SWEP.IronSightsMoveSpeed  = SWEP.MoveSpeed * 0.8

SWEP.LuaShellEject = false

SWEP.DrawCrosshair = false

function SWEP:DrawHUD()
end

if SERVER then
	local function EntityTakeDamage(target, dmg)
		if !target:IsPlayer() || !dmg:GetAttacker() || !dmg:GetAttacker().GetActiveWeapon || !dmg:GetAttacker():GetActiveWeapon() ||
			dmg:GetAttacker():GetActiveWeapon():GetClass() != "stun_gun" then return end
		if target:Team() == TEAM_SURVIVORS then return true end
		if target:Team() == TEAM_KILLER && !target.stun then
			timer.Create("stungun_" .. target:UniqueID(), math.random(2, 4), 1, function()
				if !IsValid(target) then return end
				if target:Alive() then 
					target:SetRunSpeed(target.stungun_runspeed)
					target:SetWalkSpeed(target.stungun_walkspeed)
				end
				target.stun = false
			end)
			
			target.stun = true
			target.stungun_runspeed = target:GetRunSpeed()
			target.stungun_walkspeed = target:GetWalkSpeed()
			target:SetRunSpeed(50)
			target:SetWalkSpeed(50)
		end
	end
	hook.Add("EntityTakeDamage", "stungun_EntityTakeDamage", EntityTakeDamage)
end