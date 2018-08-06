-- @Author: Guilhem PECH <Daryl_Winters>
-- @Date:   2018-01-09 10:40:07
-- @Email:  guilhempech@gmail.com
-- @Project: Slashers
-- @Last modified by:   Guilhem PECH
-- @Last modified time: 2018-01-11 15:50:02

include("shared.lua")
SWEP.Slot = 1
SWEP.SlotPos = 1
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
language.Add("Undone_batesmum", "Undone batesmum")
SWEP.Instructions = "Left click to place it on the floor"
local batesmum_holo = nil

function SWEP:Initialize()
	self.m_bInitialized = true
	
end

function SWEP:Think()
	if ( not self.m_bInitialized ) then
		self:Initialize()
	end
end



function SWEP:Holster()
  
end


function SWEP:PrimaryAttack()

end

function SWEP:SecondaryAttack()
end

function SWEP:OnRemove()
 
end

function SWEP:GetViewModelPosition(pos, ang)
    pos = pos + ang:Right() * 30 + ang:Up() * -20 + ang:Forward() * 50
  	ang.pitch = ang.pitch - 10
  	ang.row = ang.row + 15
  	if(self:Ammo1() == 0) then  		
  		return -pos, -ang
  	end
    return pos, ang
end

function SWEP:DrawWorldModel()
	local holdType = self:GetHoldType()
	if(holdType != 'normal') then
		local bone = self.Owner:LookupBone("ValveBiped.Bip01_R_Hand")
		if !bone then return end
		local hand_pos = self.Owner:GetBonePosition(bone)
		local hand_ang = Angle(-30 , self.Owner:EyeAngles().yaw - 90, 0)
		hand_pos = hand_pos + hand_ang:Forward() * - 18 + hand_ang:Right() * 3
		self:SetRenderOrigin(hand_pos)
		self:SetRenderAngles(hand_ang)
		self:SetModelScale(0.8)
		self:DrawModel()
	end
end