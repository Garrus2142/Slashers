-- Utopia Games - Slashers
--
-- @Author: Vyn
-- @Date:   2017-07-26 00:54:09
-- @Last Modified by:   Vyn
-- @Last Modified time: 2017-07-26 15:19:21

AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.
 
include('shared.lua')

local function IsKiller(ent) 
	if ent:Team() == TEAM_KILLER then return true end -- MODIFY
	return false
end

function ENT:LinkHook(ent)
	self.hookedrope = ent
end

function ENT:StartTrace()
	self.tracedata = {};

	self.tracedata.start = Vector(self:GetPos())
	self.tracedata.endpos = Vector(self.hookedrope:GetPos())
	self.tracedata.filter = {self}

	for k, v in pairs(ents.GetAll()) do
		if v:GetClass() == "prop_door_rotating" then
			table.insert(self.tracedata.filter, v)
		end
	end
end

function ENT:Think()
	if self.tracedata then
		local traceresult = util.TraceLine(self.tracedata)
		if IsValid(traceresult.Entity) and traceresult.Entity:GetClass() == "player" then
			if IsKiller(traceresult.Entity) then return end
			if CurTime() - self.lasttime > 1 then
				self.lasttime = CurTime()
				self:EmitSound("slashers/effects/alert_bell.wav")
				if self.hookedrope && team.GetPlayers(TEAM_KILLER)[1] then
					net.Start("noticonSlashers")
						net.WriteVector(self.hookedrope:GetPos())
						net.WriteString("info")
						net.WriteInt(4, 32)
					net.Send(team.GetPlayers(TEAM_KILLER)[1])
				end
			end
		end
		self:NextThink(CurTime())
		return true
	end
end

function ENT:Initialize()

	self:SetModel("models/props_junk/meathook001a.mdl")
	self:SetModelScale(0.2)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS) 
	self:SetUseType(SIMPLE_USE)
	self.hookedrope = nil
	self.tracedata = nil

	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)

	self.lasttime = CurTime()

	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end

	self:GetPhysicsObject():EnableMotion(false) -- Freeze trap entity
end

function ENT:Use(activator, caller, useType, value)
	if !IsKiller(caller) then return end
	if IsValid(self.hookedrope) then
		self.hookedrope:Remove()
		caller:GiveAmmo(1, "ammo_alertropes", true)
	end
	self:Remove()
end

function ENT:Touch(ent)
	
end
