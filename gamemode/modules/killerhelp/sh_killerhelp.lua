-- Utopia Games - Slashers
--
-- @Author: Garrus2142
-- @Date:   2017-07-25 16:15:50
-- @Last Modified by:   Daryl_Winters
-- @Last Modified time: 2017-08-09T17:20:41+02:00

hook.Add( "PlayerFootstep", "CDisableSoundFootStepsUnique", function( ply, pos, foot, sound, volume, filter )
	if ply:GetColor().a == 0  then
		return true
	else
		return
	end
end )

local function initCol()
	local allentities = ents.GetAll()
	for k, v in pairs(allentities) do
		if (v:IsPlayer()) or (v:GetClass() == "prop_door_rotating") then
			v:SetCustomCollisionCheck( true )
		end
	end
end
hook.Add( "InitPostEntity", "CustomInit", initCol )
hook.Add("sls_round_PostStart","TestInit",initCol)


local function ShouldCollide( ent1, ent2 )
	if ent1:IsPlayer() and ent1:GetColor().a == 0 and  ent2:GetClass() == "prop_door_rotating" or
		ent2:IsPlayer() and ent2:GetColor().a == 0 and  ent1:GetClass() == "prop_door_rotating" then
		return false
	end
	if ent1:IsPlayer() and ent1:GetColor().a == 0 or
		ent2:IsPlayer() and ent2:GetColor().a == 0 then
		return false
	end
	return true
end
hook.Add("ShouldCollide", "sls_killerhelp_ShouldCollide", ShouldCollide)
