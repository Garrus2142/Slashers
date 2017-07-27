-- Utopia Games - Slashers
--
-- @Author: Vyn
-- @Date:   2017-07-26 14:08:23
-- @Last Modified by:   Vyn
-- @Last Modified time: 2017-07-27 18:27:04

include("shared.lua")

SWEP.Slot = 1
SWEP.SlotPos = 2

SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false

SWEP.Instructions = "Left click to place them, Reload to take back the first hook if you lost it"
 
language.Add("Undone_alertropes","Undone Alert Ropes")

local alertropes_holo = nil;

function SWEP:Deploy()
	if not IsFirstTimePredicted() then return true end
	alertropes_holo = ClientsideModel("models/props_junk/meathook001a.mdl", 9)
	alertropes_holo:SetModelScale(0.2)
	alertropes_holo:SetRenderMode(4)
	return true	
end

function SWEP:Holster()
	if not IsFirstTimePredicted() or !IsValid(alertropes_holo) then return true end
	alertropes_holo:Remove()
	return true
end

function SWEP:Think()
	if !IsValid(alertropes_holo) then return end

	local eyetrace = LocalPlayer():GetEyeTrace()

	slashers_alertropes_place(LocalPlayer(), alertropes_holo)

	if LocalPlayer():GetPos():Distance(eyetrace.HitPos) > self.MaxDistance then
		alertropes_holo:SetNoDraw(true)
	else
		alertropes_holo:SetNoDraw(false)
		if self:Ammo1() <= 0 then
			alertropes_holo:SetColor(Color(100, 100, 100, 150))
		elseif eyetrace.HitWorld then
			alertropes_holo:SetColor(Color(0, 255, 0, 150))
		else
			alertropes_holo:SetColor(Color(255, 0, 0, 150))
		end
	end

end

function SWEP:PrimaryAttack()

end

function SWEP:SecondaryAttack()

end

function SWEP:OnRemove()
	if !IsValid(alertropes_holo) then return end
	alertropes_holo:Remove()
end

function SWEP:GetViewModelPosition(pos, ang)
    pos = pos + ang:Right() * 30 + ang:Up() * -20 + ang:Forward() * 50
  	ang.roll = ang.roll + 180
    return pos, ang
end

function SWEP:DrawWorldModel()
	local bone = self.Owner:LookupBone("ValveBiped.Bip01_R_Hand")
	if !bone then return end
	local hand_pos = self.Owner:GetBonePosition(bone)
	local hand_ang = Angle(self.Owner:EyeAngles().pitch + 180, self.Owner:EyeAngles().yaw - 30, 0)
	hand_pos = hand_pos + hand_ang:Forward() * -3 + hand_ang:Right() * -2
	self:SetRenderOrigin(hand_pos)
	self:SetRenderAngles(hand_ang)
	self:SetModelScale(0.2)
	self:DrawModel()
end