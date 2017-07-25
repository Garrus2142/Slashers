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
		ply:Kill()
		ent.trapeddoor = 2
	end )
end