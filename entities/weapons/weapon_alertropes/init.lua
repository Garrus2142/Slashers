-- Utopia Games - Slashers
--
-- @Author: Vyn
-- @Date:   2017-07-26 00:51:28
-- @Last Modified by:   Vyn
-- @Last Modified time: 2017-07-26 15:20:28

AddCSLuaFile ("shared.lua")
AddCSLuaFile ("cl_init.lua")

include("shared.lua")

SWEP.Weight = 5
 
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

function SWEP:Equip(NewOwner)
	NewOwner:GiveAmmo(5, "ammo_alertropes", true)
	self.firsthook = nil
end

local function traceline_hitworld(pos1, pos2)
	local tracedata = {};

	tracedata.start = Vector(pos1)
	tracedata.endpos = Vector(pos2)
	tracedata.filter = self

	local traceresult = util.TraceLine(tracedata)

	if traceresult.HitWorld then
		return true
	end
	return false
end
 
function SWEP:PrimaryAttack()

	if self:Ammo1() <= 0 then return end

	if self.Owner:GetPos():Distance(self.Owner:GetEyeTrace().HitPos) > self.MaxDistance or !self.Owner:GetEyeTrace().HitWorld then
		return
	end

	if IsValid(self.firsthook) then

		if traceline_hitworld(self.Owner:GetEyeTrace().HitPos, self.firsthook:GetPos()) or traceline_hitworld(self.firsthook:GetPos(), self.Owner:GetEyeTrace().HitPos)then
			--self.Owner:PrintMessage(HUD_PRINTCENTER, "Hit world") -- A remplacer par la notif (1/2)
			net.Start("notificationSlasher")
				net.WriteString("The rope hit the world")
				net.WriteString("cross")
			net.Send(self.Owner)
			return
		end
		
--		PrintMessage(HUD_PRINTTALK, "Current distance: "..self.firsthook:GetPos():Distance(self.Owner:GetEyeTrace().HitPos))

		if self.firsthook:GetPos():Distance(self.Owner:GetEyeTrace().HitPos) > 200 then
			--self.Owner:PrintMessage(HUD_PRINTCENTER, "Too much distance") -- A remplacer par la notif (2/2)
			net.Start("notificationSlasher")
				net.WriteString("Too much distance")
				net.WriteString("cross")
			net.Send(self.Owner)
			return
		end
	end

	local ent = ents.Create("alertropes")

	slashers_alertropes_place(self.Owner, ent)

	ent:Spawn()
 
	if !IsValid(self.firsthook) then
		self.firsthook = ent
	elseif IsValid(self.firsthook) then
		ent:LinkHook(self.firsthook)
		self.firsthook:LinkHook(ent)
		ent:StartTrace()
		constraint.Rope(ent, self.firsthook, 0, 0, Vector(0, 0, -3), Vector(0, 0, -3), 100, 100, 0, 1, "cable/cable.vmt", true ) 
		self.firsthook = nil
		self.Owner:SetAmmo(self:Ammo1() - 1, "ammo_alertropes")
	end

	cleanup.Add(self.Owner, "props", ent)
 
	undo.Create("alertropes")
		undo.AddEntity(ent)
		undo.SetPlayer(self.Owner)
	undo.Finish()
end

function SWEP:Reload()
	if IsValid(self.firsthook) then
		self.firsthook:Remove()
	end
end

function SWEP:SecondaryAttack()

end