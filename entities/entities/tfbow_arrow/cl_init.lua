 
include('shared.lua')
 
--[[---------------------------------------------------------
   Name: Draw
   Purpose: Draw the model in-game.
   Remember, the things you render first will be underneath!
---------------------------------------------------------]]
function ENT:Draw()
	local ang,tmpang
	tmpang=self:GetAngles()
	ang=tmpang
	if !self.roll then
		self.roll = 0
	end
	local phobj=self:GetPhysicsObject()
	if IsValid(phobj) then
		self.roll=self.roll+phobj:GetVelocity():Length()/3600*GetConVarNumber("host_timescale")
	end
	
	ang:RotateAroundAxis(ang:Forward(),self.roll)
	self:SetAngles(ang)
    self:DrawModel()       -- Draw the model.
	self:SetAngles(tmpang)
	--self:SetModel("models/props_junk/watermelon01
end
 