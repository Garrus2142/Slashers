-- Utopia Games - Slashers
--
-- @Author: Guilhem PECH
-- @Date:   2017-07-26T13:54:42+02:00
-- @Last Modified by:
-- @Last Modified time: 2017-07-26T22:25:56+02:00



local GM = GAMEMODE

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')


sound.Add( {
	name = "engine_sound",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 75,
	pitch = { 95, 110 },
	sound = "vehicles/Crane/crane_startengine1.wav"

} )
sound.Add( {
	name = "engine_fueling",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 80,
	pitch = { 95, 110 },
	sound = "ambient/water/leak_1.wav"
} )

local engine_fuelingSound = Sound("ambient/water/leak_1.wav")

function ENT:Initialize()

	self.Active = false
	self:SetModel("models/props_vehicles/generatortrailer01.mdl")
	self:PhysicsInit(SOLID_NONE)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetNWFloat( 'progressBar', 0 )
	self:SetNWBool( 'activated', false)

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion(false)
	end
end

function ENT:SpawnFunction( ply, tr )
	if ( !tr.Hit ) then return end
	local ent = ents.Create("sls_generator")
	ent:SetPos( tr.HitPos + tr.HitNormal )
	ent:Spawn()

	return ent
end


function ENT:OnTakeDamage(dmg)

end

function ENT:Use(activator, caller)
	if CurrentObjective == "activate_generator" && caller:Team() == TEAM_SURVIVORS then
		local tr = caller:GetEyeTrace()
		self:SetUseType( CONTINUOUS_USE )
		curentProgress = self:GetNWFloat('progressBar')
		generatorNowActivated = self:GetNWEntity( "activated")

		if (curentProgress < 1 ) then

			self:SetNWFloat( 'progressBar', curentProgress+ 0.003)
			net.Start( "activateProgressionSlasher" )
			net.WriteFloat(curentProgress)
			net.Send(caller)
		end

		if (curentProgress >= 1 && !generatorNowActivated) then

			self:SetNWBool( 'activated', true)
			self:SetNWFloat( 'progressBar', 2)
			self:EmitSound( "engine_sound", 75, 100, 1, CHAN_AUTO )

			net.Start( "activateProgressionSlasher" )
			net.WriteFloat(2)
			net.Send(caller)

			net.Start( "notificationSlasher" )
			net.WriteString("round_notif_enabled_generator")
			net.WriteString("safe")
			net.Send(caller)

			net.Start( "objectiveSlasher" )
			net.WriteTable({"round_mission_radio"})
			net.WriteString("caution")
			net.SendOmit(GM.ROUND.Killer)
			self.Active = true
			hook.Call("sls_NextObjective")
		end
	else
		self:SetUseType( SIMPLE_USE )
		if (!self:GetNWBool( 'activated')) then
			net.Start( "notificationSlasher" )
			net.WriteString("round_notif_error_generator")
			net.WriteString("cross")
			net.Send(caller)
		end
	end
end

function ENT:OnRemove()
	self:StopSound( "engine_sound" )
end
