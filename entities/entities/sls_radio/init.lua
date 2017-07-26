-- Utopia Games - Slashers
--
-- @Author: Guilhem PECH
-- @Date:   2017-07-26T13:54:42+02:00
-- @Last Modified by:   Guilhem PECH
-- @Last Modified time: 2017-07-26T15:16:14+02:00



local GM = GAMEMODE

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

sound.Add( {
	name = "slashers_radio",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 80,
	pitch = { 95, 110 },
	sound = "slashers/effects/radio_incoming.wav"
} )

function ENT:Initialize()
	-- self.Entity:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self.Active = false
	self:SetModel("models/props_lab/citizenradio.mdl")
	self:PhysicsInit(SOLID_NONE)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetNWBool('activated',false)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType( SIMPLE_USE )

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion(false)
	end
end

function ENT:SpawnFunction( ply, tr )
    if ( !tr.Hit ) then return end
    local ent = ents.Create("sls_radio")
    ent:SetPos( tr.HitPos + tr.HitNormal * 16 )
    ent:Spawn()

    return ent
end
ents.Create("prop_physics")

function ENT:OnTakeDamage(dmg)

end

function ENT:Use(ply)
	if CurrentObjective == "activate_radio" && ply:Team() == TEAM_SURVIVORS then
		net.Start( "notificationSlasher" )
						net.WriteString("You contacted the police !")
						net.WriteString("safe")
						net.Send(ply)

		net.Start( "objectiveSlasher" )
						 net.WriteString("Survive until the police arrival !")
						 net.WriteString("caution")
						 net.SendOmit(GM.ROUND.Killer)

		hook.Call("sls_NextObjective")
		self.Active = true
		self:EmitSound("slashers_radio")
	else
		if (!self:GetNWBool( 'activated')) then
				net.Start( "notificationSlasher" )
								net.WriteString("You can't activate the radio !")
								net.WriteString("cross")
								net.Send(ply)
		end

	end
end

function ENT:OnRemove()
    self:StopSound("slashers_radio")
end
