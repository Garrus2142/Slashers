include("shared.lua")

SWEP.Slot = 1
SWEP.SlotPos = 3

SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
 
language.Add("Undone_alertropes","Undone Alert Ropes")

local pulleywheel_holo = nil;
local axe_holo = nil;

function SWEP:Deploy()
	if not IsFirstTimePredicted() then return true end
	pulleywheel_holo = ClientsideModel("models/props_c17/pulleywheels_small01.mdl", 9)
	pulleywheel_holo:SetModelScale(0.5)
	pulleywheel_holo:SetRenderMode(4)
	axe_holo = ClientsideModel("models/weapons/tfa_nmrih/w_me_axe_fire.mdl", 9)
	axe_holo:SetRenderMode(4)
	return true	
end

function SWEP:Holster()
	if not IsFirstTimePredicted() or !IsValid(pulleywheel_holo) or !IsValid(axe_holo) then return true end
	pulleywheel_holo:Remove()
	axe_holo:Remove()
	return true
end

function SWEP:Think()
	if !IsValid(pulleywheel_holo) or !IsValid(axe_holo) then return end
	if !IsValid(LocalPlayer():GetEyeTrace().Entity) then
		pulleywheel_holo:SetNoDraw(true)
		axe_holo:SetNoDraw(true)
		return
	end
	if LocalPlayer():GetEyeTrace().Entity:GetClass() ~= "prop_door_rotating" then
		pulleywheel_holo:SetNoDraw(true)
		axe_holo:SetNoDraw(true)
		return
	end

	local dooraxe_pos, dooraxe_angle, axe_pos, axe_angle = slashers_dooraxe_place(LocalPlayer(), pulleywheel_holo, axe_holo)

	if LocalPlayer():GetPos():Distance(LocalPlayer():GetEyeTrace().HitPos) > self.MaxDistance then
		pulleywheel_holo:SetNoDraw(true)
		axe_holo:SetNoDraw(true)
	else
		pulleywheel_holo:SetNoDraw(false)
		axe_holo:SetNoDraw(false)
		if self:Ammo1() <= 0 then
			pulleywheel_holo:SetColor(Color(100, 100, 100, 150))
			axe_holo:SetColor(Color(100, 100, 100, 150))
		elseif slashers_dooraxe_canplace(LocalPlayer()) == true then
			pulleywheel_holo:SetColor(Color(0, 255, 0, 150))
			axe_holo:SetColor(Color(0, 255, 0, 150))
		else
			pulleywheel_holo:SetColor(Color(255, 0, 0, 150))
			axe_holo:SetColor(Color(255, 0, 0, 150))
		end
	end

end

function SWEP:PrimaryAttack()

end

function SWEP:SecondaryAttack()

end

function SWEP:OnRemove()
	if !IsValid(pulleywheel_holo) then return end
	pulleywheel_holo:Remove()
	if !IsValid(axe_holo) then return end
	axe_holo:Remove()
end

function SWEP:GetViewModelPosition(pos, ang)
    pos = pos + ang:Right() * 30 + ang:Up() * -20 + ang:Forward() * 50
  	ang.pitch = ang.pitch - 0
  	ang.roll = ang.roll + 180
    return pos, ang
end

function SWEP:DrawWorldModel()
	local hand_pos = self.Owner:GetBonePosition(self.Owner:LookupBone("ValveBiped.Bip01_R_Hand"))
	local hand_ang = Angle(self.Owner:EyeAngles().pitch + 180, self.Owner:EyeAngles().yaw - 30, 0)
	hand_pos = hand_pos + hand_ang:Forward() * -3 + hand_ang:Right() * -7
	self:SetRenderOrigin(hand_pos)
	self:SetRenderAngles(hand_ang)
	self:SetModelScale(0.5)
	self:DrawModel()
end