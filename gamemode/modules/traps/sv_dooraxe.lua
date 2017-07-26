-- Utopia Games - Slashers
--
-- @Author: Vyn
-- @Date:   2017-07-26 12:14:08
-- @Last Modified by:   Vyn
-- @Last Modified time: 2017-07-26 15:21:36

if SERVER then
	hook.Add( "PlayerUse", "slashers_dooraxe_playeruse", function(ply, ent)
		if !IsValid(ent) or !IsValid(ply) then return end
		if !ent.trapeddoor or ent.trapeddoor == 0 then return end
		if !ply:Alive() then return end
		if ply:Team() == TEAM_KILLER then return false end
		if ent.trapeddoor == 2 then return false end
		ent:Fire("Open")
		ent.axe:GetPhysicsObject():EnableMotion(true)
		ent.axe:GetPhysicsObject():ApplyForceCenter(Vector(0, 0, -1))
		ply:Freeze(true)
		timer.Simple(1, function()
			ply:Kill()
			ply:Freeze(false)
		end)
		ent.trapeddoor = 2
	end )
end