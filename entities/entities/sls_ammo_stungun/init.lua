-- Utopia Games - Slashers
--
-- @Author: Guilhem PECH
-- @Date:   2017-07-26T13:54:42+02:00
-- @Last Modified by:   Garrus2142
-- @Last Modified time: 2017-07-26T22:25:37+02:00



local GM = GM or GAMEMODE

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')


function ENT:Initialize()
	self.Active = false
	self:SetModel("models/Items/BoxSRounds.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType( SIMPLE_USE )
	self:SetNWBool("ShouldRemove",false)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion(false)
	end

end

function ENT:SpawnFunction( ply, tr )
    if ( !tr.Hit ) then return end
    local ent = ents.Create("sls_jerrican")
    ent:SetPos( tr.HitPos + tr.HitNormal * 16 )
    ent:Spawn()

    return ent
end
ents.Create("prop_physics")



function ENT:Use(activator, caller)
		if IsValid(activator) and (activator:IsPlayer()) and activator:HasWeapon( "stun_gun" ) then
		
		--Maybe u can add a NWVar for get the type and count out of the shared.lua
			activator:GiveAmmo( 4 , "Stungun")
			
			
			net.Start( "notificationSlasher" )
			net.WriteTable({"ammo_notif_pickup"})
			net.WriteString("caution")
			net.Send(activator)
self:SetNWBool("ShouldRemove",true)
		end
		
end

function ENT:Think()
		if self:GetNWBool("ShouldRemove",false) then
			self:Remove()
			return false
end
end
