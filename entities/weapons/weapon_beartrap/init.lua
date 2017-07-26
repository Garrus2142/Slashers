-- Utopia Games - Slashers
--
-- @Author: Vyn
-- @Date:   2017-07-26 00:51:16
-- @Last Modified by:   Vyn
-- @Last Modified time: 2017-07-26 15:20:52

AddCSLuaFile ("shared.lua")
AddCSLuaFile ("cl_init.lua")

include("shared.lua")

SWEP.Weight = 5
 
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

function SWEP:Equip(NewOwner)
	NewOwner:GiveAmmo(2, "ammo_beartrap", true)	
end
 
function SWEP:PrimaryAttack()

	if self:Ammo1() <= 0 then return end

	local ent = ents.Create("beartrap")
	local beartrap_pos, beartrap_angle = slashers_beartrap_place(self.Owner, ent)


	local tracedata = {}
	tracedata.start = Vector(self.Owner:GetEyeTrace().HitPos)
	tracedata.endpos = Vector(self.Owner:GetEyeTrace().HitPos)
	tracedata.endpos.z = tracedata.endpos.z - 5
	if self.Owner:GetPos():Distance(self.Owner:GetEyeTrace().HitPos) > self.MaxDistance or !util.TraceLine(tracedata).HitWorld  or (beartrap_angle.pitch % 360) > 45 then
		ent:Remove()
		return
	end
	ent:Spawn()

	cleanup.Add(self.Owner, "props", ent)
 
	undo.Create("beartrap")
		undo.AddEntity(ent)
		undo.SetPlayer(self.Owner)
	undo.Finish()

	self.Owner:SetAmmo(self:Ammo1() - 1, "ammo_beartrap") 
end

function SWEP:Reload()
	self:SetClip1(self:GetMaxClip1())
end

function SWEP:SecondaryAttack()

end