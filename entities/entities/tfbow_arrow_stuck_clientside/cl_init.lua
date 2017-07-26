 
include('shared.lua')
 
--[[---------------------------------------------------------
   Name: Draw
   Purpose: Draw the model in-game.
   Remember, the things you render first will be underneath!
---------------------------------------------------------]]
function ENT:Draw()
     --self.BaseClass.Draw(self)  -- We want to override rendering, so don't call baseclass.
                                  -- Use this when you need to add to the rendering.
    --self:DrawEntityOutline( 1.0 ) -- Draw an outline of 1 world unit.
    self:DrawModel()       -- Draw the model.
	--self:SetModel("models/props_junk/watermelon01.mdl")
 
    --AddWorldTip( self:EntIndex(), "BATHTUB TIME!", 0.5, self:GetPos(), self  ) -- Add an example tip.
end
 
hook.Add("PostRender","ClientArrowsUpdate", function()
	for k,v in pairs(TFArrowEnts) do
		v:UpdatePosition()
	end
end)