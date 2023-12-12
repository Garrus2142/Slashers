-- Utopia Games - Slashers
--
-- @Author: Guilhem PECH
-- @Date:   2017-07-26T13:54:42+02:00
-- @Last Modified by:   Daryl_Winters
-- @Last Modified time: 2017-08-09T15:07:23+02:00



include("shared.lua")
ENT.RenderGroup = RENDERGROUP_BOTH
function ENT:Initialize()
end

function ENT:Draw()
	self.Entity:DrawModel()
end

function ENT:DrawTranslucent()
	if LocalPlayer():IsLineOfSightClear( self.Entity ) and self.Entity:GetPos():Distance( LocalPlayer():GetPos()) < 150 and  LocalPlayer():Team() != TEAM_KILLER   then
		DrawIndicator(self.Entity)
	end
end

function ENT:Think()

end
