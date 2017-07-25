if SERVER then
	util.AddNetworkString("sls_flashlight")
end

SWEP.Base = "tfa_nmrimelee_base"
SWEP.Category = "TFA NMRIH"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.PrintName = "Maglite"

SWEP.ViewModel			= "models/weapons/tfa_nmrih/v_item_maglite.mdl" --Viewmodel path
SWEP.ViewModelFOV = 50
//SWEP.RenderGroup = RENDERGROUP_BOTH

SWEP.WorldModel			= "models/weapons/tfa_nmrih/w_item_maglite.mdl" --Viewmodel path
SWEP.HoldType = "slam"
SWEP.DefaultHoldType = "slam"
SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -0.5,
        Right = 2,
        Forward = 5.5,
        },
        Ang = {
        Up = -1,
        Right = 5,
        Forward = 178
        },
		Scale = 1.2
}

SWEP.Primary.Sound = Sound("Weapon_Melee.CrowbarLight")
SWEP.Secondary.Sound = Sound("Weapon_Melee.CrowbarHeavy")

SWEP.MoveSpeed = 1.0
SWEP.IronSightsMoveSpeed  = SWEP.MoveSpeed

SWEP.InspectPos = Vector(8.418, 0, 15.241)
SWEP.InspectAng = Vector(-9.146, 9.145, 17.709)

SWEP.Primary.Blunt = true
SWEP.Primary.Damage = 25
SWEP.Primary.Reach = 40
SWEP.Primary.RPM = 90
SWEP.Primary.SoundDelay = 0
SWEP.Primary.Delay = 0.3
SWEP.Primary.Window = 0.2
SWEP.Primary.Automatic = false

SWEP.Secondary.Blunt = true
SWEP.Secondary.RPM = 60 -- Delay = 60/RPM, this is only AFTER you release your heavy attack
SWEP.Secondary.Damage = 60
SWEP.Secondary.Reach = 40	
SWEP.Secondary.SoundDelay = 0.0
SWEP.Secondary.Delay = 0.2
SWEP.Secondary.Automatic = false

SWEP.Secondary.BashDamage = 50
SWEP.Secondary.BashDelay = 0.35
SWEP.Secondary.BashLength = 40

SWEP.MoveSpeed = 1
SWEP.AllowViewAttachment = false

local matLight = Material( "sprites/light_ignorez" )

function SWEP:PrimaryAttack()
	if CLIENT then return end
	if !IsValid(self) || !IsValid(self.Owner) || !self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() != self then return end

	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self.Owner:EmitSound("slashers/effects/flashlight_toggle.wav", 75, 100, 0.6)

	if !IsValid(self.projectedLight) then
		self:BuildLight()
		return
	end

	self.Active = !self.Active
	if self.Active then
		self.projectedLight:Fire("TurnOn")
	else
		self.projectedLight:Fire("TurnOff")
	end

	net.Start("sls_flashlight")
	net.Send(self.Owner)
end

function SWEP:SecondaryAttack()
	self:AltAttack()
end

function SWEP:Reload()

end

function SWEP:PrimarySlash()

end

function SWEP:Holster()
	SafeRemoveEntity(self.projectedLight)
	self.Owner:SetNWEntity("FL_Flashlight", nil)
	self.Active = false

	return true
end

function SWEP:BuildLight()
	if CLIENT then return end
	if !IsValid(self) || !IsValid(self.Owner) || !self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() != self then return end

	self.projectedLight = ents.Create( "env_projectedtexture" )
	self.projectedLight:SetLagCompensated(true)
	self.projectedLight:SetPos( self.Owner:EyePos() )
	self.projectedLight:SetAngles( self.Owner:EyeAngles() )
	self.projectedLight:SetKeyValue( "enableshadows", 1 )
	self.projectedLight:SetKeyValue( "farz", 1477 )
	self.projectedLight:SetKeyValue( "nearz", 1 )
	self.projectedLight:SetKeyValue( "lightfov", 60 )
	self.projectedLight:SetKeyValue( "lightcolor", "150 255 255 255" )
	self.projectedLight:Spawn()
	self.projectedLight:Input( "SpotlightTexture", NULL, NULL, "effects/flashlight001" )

	self.Owner:SetNWEntity("FL_Flashlight", self.projectedLight)

	self.Active = true
end

function SWEP:Think()
	if SERVER && IsValid(self.projectedLight) then
		self.projectedLight:SetPos( self.Owner:EyePos() + self.Owner:GetAimVector() * 2 );
		self.projectedLight:SetAngles( self.Owner:EyeAngles() );
	end
end

local function UpdateFlashlight()
	local pjs = LocalPlayer():GetNWEntity("FL_Flashlight")
	if IsValid( pjs ) then
		if IsValid(LocalPlayer():GetActiveWeapon()) and LocalPlayer():GetActiveWeapon():GetClass() == "weapon_flashlight" then
			local bid = LocalPlayer():GetViewModel():LookupBone( "Maglite" )
			local bp, ba = LocalPlayer():GetViewModel():GetBonePosition( bid )
			ba:RotateAroundAxis(ba:Up(), -90)
			pjs:SetPos( bp +ba:Forward() * -3.5 );
			pjs:SetAngles( ba );
			pjs:SetParent(LocalPlayer():GetViewModel(), LocalPlayer():GetViewModel():LookupAttachment("light"))
		end
	end
end
net.Receive("sls_flashlight", UpdateFlashlight)

function SWEP:CalcViewModelView( ent, oldPos, oldAng, pos, ang )
	if SERVER then return end
	if LocalPlayer():Team() == TEAM_SURVIVORS then
		local pjs = LocalPlayer():GetNWEntity( 'FL_Flashlight' )
		if IsValid( pjs ) then
			local bid = LocalPlayer():GetViewModel():LookupAttachment("light")
			local bp = LocalPlayer():GetViewModel():GetAttachment(bid)
			local ang = bp.Ang
			local pos = bp.Pos
			--ba:RotateAroundAxis(ba:Up(), -90)
			pjs:SetPos( pos +ang:Forward() * -5 );
			pjs:SetAngles( ang );
		end
	end
end

//function SWEP:DrawWorldModel()
	//if SERVER then return end
	//self:DrawModel()
	/*local LightNrm = self.Owner:GetViewModel():GetAngles():Forward()
	local ViewNormal = self.Owner:GetViewModel():GetPos() - EyePos()
	local Distance = ViewNormal:Length()
	ViewNormal:Normalize()
	local ViewDot = ViewNormal:Dot( LightNrm * -1 )
	local LightPos = self.Owner:GetViewModel():GetPos() + LightNrm * 5*/

	//if ( ViewDot >= 0 ) then

		//render.SetMaterial( matLight )
		//local Visibile = util.PixelVisible( LightPos, 16, self.PixVis )

		//if ( !Visibile ) then return end

		//local Size = math.Clamp( Distance * Visibile * ViewDot * 2, 64, 512 )

		/*Distance = math.Clamp( Distance, 32, 800 )
		local Alpha = math.Clamp( ( 1000 - Distance ) * Visibile * ViewDot, 0, 100 )
		local Col = Color(150, 255, 255, 255)
		Col.a = Alpha

		render.DrawSprite( LightPos, Size, Size, Col, Visibile * ViewDot )
		render.DrawSprite( LightPos, Size * 0.4, Size * 0.4, Color( 150, 255, 255, Alpha ), Visibile * ViewDot )*/

		//render.DrawSprite(self.Owner:GetAttachment(3).Pos, 25, 25, Color(150, 255, 255))

	//end
//end

-- if SERVER then
-- 	local function EntityTakeDamage(target, dmg)
-- 		if !target:IsPlayer() || !dmg:GetAttacker() || !dmg:GetAttacker():GetActiveWeapon() ||
-- 			dmg:GetAttacker():GetActiveWeapon():GetClass() != "weapon_flashlight" then return end
-- 		return true
-- 		if target:Team() == TEAM_SURVIVORS then return true end
-- 	end
-- 	hook.Add("EntityTakeDamage", "sls_flashlight_EntityTakeDamage", EntityTakeDamage)
-- end