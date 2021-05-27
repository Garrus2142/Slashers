-- @Author: Guilhem PECH <Daryl_Winters>
-- @Date:   2018-01-09 11:09:22
-- @Email:  guilhempech@gmail.com
-- @Project: Slashers
-- @Last modified by:   Guilhem PECH
-- @Last modified time: 2018-01-11 16:59:23
local GM = GM or GAMEMODE
AddCSLuaFile("cl_init.lua") -- Make sure clientside
AddCSLuaFile("shared.lua") -- and shared scripts are sent.
include("shared.lua")
util.AddNetworkString("slash_mother_bates")
local timer = 0

local radiusFar = 500
local radiusMedium = 400
local radiusClose = 200

local function getDistanceNearestPlayer(table, origin)
	local result = false

	for k, v in ipairs(table) do
		if v:IsValid() and v:IsPlayer() and v:Team() ~= TEAM_KILLER and (not result or v:GetPos():Distance(origin) < result) then
			result = v:GetPos():Distance(origin)
		end
	end

	return result
end

function ENT:Think()
	local status = 0
	if not GM.ROUND.Active then return end
	if (timer + 0.5) < CurTime() then
		timer = CurTime()

		proximityPlayers = getDistanceNearestPlayer(ents.FindInSphere(self:GetPos(), radiusFar or 500), self:GetPos())

		if not proximityPlayers then
			print("Not")
			GM.ROUND.Killer:SetWalkSpeed( GM.MAP.Killer.WalkSpeed  )
			GM.ROUND.Killer:SetRunSpeed(GM.MAP.Killer.RunSpeed )
			status = 0
		elseif proximityPlayers <= radiusClose then
			print("Supplosed =", GM.MAP.Killer.WalkSpeed * 1.8)
			GM.ROUND.Killer:SetWalkSpeed( GM.MAP.Killer.WalkSpeed * 1.8 )
			GM.ROUND.Killer:SetRunSpeed(GM.MAP.Killer.RunSpeed * 1.8)
			status = 3
		elseif proximityPlayers <= radiusMedium then
			print("Supplosed =", GM.MAP.Killer.WalkSpeed * 1.3)
			GM.ROUND.Killer:SetWalkSpeed( GM.MAP.Killer.WalkSpeed * 1.3 )
			GM.ROUND.Killer:SetRunSpeed(GM.MAP.Killer.RunSpeed * 1.3)
			status = 2
		else
			print("Supplosed =", GM.MAP.Killer.WalkSpeed * 1.1)
			GM.ROUND.Killer:SetWalkSpeed( GM.MAP.Killer.WalkSpeed * 1.1 )
			GM.ROUND.Killer:SetRunSpeed(GM.MAP.Killer.RunSpeed * 1.1)
			status = 1
		end

		net.Start("slash_mother_bates")
		net.WriteUInt(status, 3)
		net.Broadcast()
	end
end

local ragdoll = ents.Create("prop_ragdoll")

function ENT:Initialize()
	if ConVarExists("slashers_bates_far_radius") and  ConVarExists("slashers_bates_medium_radius") and  ConVarExists("slashers_bates_close_radius") then
		radiusFar = GetConVar("slashers_bates_far_radius"):GetInt()
		radiusMedium = GetConVar("slashers_bates_medium_radius"):GetInt()
		radiusClose = GetConVar("slashers_bates_close_radius"):GetInt()
	end
	for k,v in pairs(ents.GetAll()) do
		if v:GetName() == "slash_bates_points" then
			v:Remove()
		end
	end
	if (not IsValid(ragdoll)) then
		ragdoll = ents.Create("prop_ragdoll")
	end
	ragdoll:SetModel("models/skeleton/skeleton_whole_noskins.mdl")
	ragdoll:PhysicsInit(SOLID_VPHYSICS)
	ragdoll:GetPhysicsObject():EnableDrag(true)
	ragdoll:SetPos(self:GetPos())
	self:SetParent(ragdoll)
	ragdoll:Spawn()
	ragdoll:SetName("slash_bates_mother")
	self:SetName("slash_bates_points")
end

function ENT:Touch(ent)
end
