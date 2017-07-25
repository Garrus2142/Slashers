include("shared.lua")

SWEP.Slot = 1
SWEP.SlotPos = 1

SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
 
language.Add("Undone_beartrap","Undone Beartrap")

local beartrap_holo = nil;

function SWEP:Deploy()
	if not IsFirstTimePredicted() then return true end
	beartrap_holo = ClientsideModel("models/zerochain/props_industrial/beartrap/beartrap.mdl", 9)
	beartrap_holo:SetRenderMode(4)
	return true
end

function SWEP:Holster()
	if not IsFirstTimePredicted() or !IsValid(beartrap_holo) then return true end
	beartrap_holo:Remove()
	return true
end

function SWEP:Think()
	if !IsValid(beartrap_holo) then return end

	local beartrap_pos, beartrap_angle = slashers_beartrap_place(LocalPlayer(), beartrap_holo)

	local tracedata = {}
	tracedata.start = Vector(LocalPlayer():GetEyeTrace().HitPos)
	tracedata.endpos = Vector(LocalPlayer():GetEyeTrace().HitPos)
	tracedata.endpos.z = tracedata.endpos.z - 5
	if LocalPlayer():GetPos():Distance(LocalPlayer():GetEyeTrace().HitPos) > self.MaxDistance then
		beartrap_holo:SetNoDraw(true)
	else
		beartrap_holo:SetNoDraw(false)
		if self:Ammo1() <= 0 then
			beartrap_holo:SetColor(Color(100, 100, 100, 150))
		elseif util.TraceLine(tracedata).HitWorld  and (beartrap_angle.pitch % 360) < 45 then
			beartrap_holo:SetColor(Color(0, 255, 0, 150))
		else
			beartrap_holo:SetColor(Color(255, 0, 0, 150))
		end
	end

end

function SWEP:PrimaryAttack()

end

function SWEP:SecondaryAttack()

end

function SWEP:OnRemove()
	if !IsValid(beartrap_holo) then return end
	beartrap_holo:Remove()
end

function SWEP:GetViewModelPosition(pos, ang)
    pos = pos + ang:Right() * 30 + ang:Up() * -20 + ang:Forward() * 50
  	ang.pitch = ang.pitch - 60
    return pos, ang
end

function SWEP:DrawWorldModel()
	local hand_pos = self.Owner:GetBonePosition(self.Owner:LookupBone("ValveBiped.Bip01_R_Hand"))
	local hand_ang = Angle(self.Owner:EyeAngles().pitch + 90, self.Owner:EyeAngles().yaw - 30, 0)
	hand_pos = hand_pos + hand_ang:Up() * 3 + hand_ang:Right() * -4
	self:SetRenderOrigin(hand_pos)
	self:SetRenderAngles(hand_ang)
	self:SetModelScale(0.5)
	self:DrawModel()
end