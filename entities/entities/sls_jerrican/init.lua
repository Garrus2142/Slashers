-- Utopia Games - Slashers
--
-- @Author: Guilhem PECH
-- @Date:   2017-07-26T13:54:42+02:00
-- @Last Modified by:   Guilhem PECH
-- @Last Modified time: 2017-07-26T22:25:37+02:00



local GM = GAMEMODE

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
	
	self.Active = false
	self:SetModel("models/props_junk/gascan001a.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType( SIMPLE_USE )
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

function ENT:OnTakeDamage(dmg)

end

function ENT:Use(ply)
	if (CurrentObjective == "find_jerrican" && ply:Team() == TEAM_SURVIVORS) then
		if (NbJerricanToFound != 0) then
			self:Remove()
			NbJerricanToFound = NbJerricanToFound - 1
			net.Start( "notificationSlasher" )
							net.WriteString("You found a jerrycan !")
							net.WriteString("safe")
							net.Send(ply)


			net.Start( "modifyObjectiveSlasher" )
						net.WriteString("Find " .. NbJerricanToFound .." jerrycan(s)")
						net.SendOmit(GM.ROUND.Killer)

		end
		if (NbJerricanToFound == 0) then
			net.Start( "objectiveSlasher" )
							 net.WriteString("Find and activate the Generator !")
							 net.WriteString("caution")
							 net.SendOmit(GM.ROUND.Killer)

			hook.Call("sls_NextObjective")

		end
		self:EmitSound("player/shove_01.wav",100,100,1,CHAN_AUTO)
		self:Remove()
	end
end
