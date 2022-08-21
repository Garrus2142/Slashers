-- Utopia Games - Slashers
--
-- @Author: Garrus2142
-- @Date:   2017-07-25 16:15:46
-- @Last Modified by:   Garrus2142
-- @Last Modified time: 2017-07-26 14:45:24

local GM = GM or GAMEMODE
local playermeta = FindMetaTable("Player")

function playermeta:SetSurvClass(class)
	if !GM.CLASS.Survivors[class] then return false end

	print(Format("Player %s is set to class %s", self:Nick(), GM.CLASS.Survivors[class].name))

	self:StripWeapons()
	self:SetTeam(TEAM_SURVIVORS)
	self:AllowFlashlight(false)
	self:SetNoCollideWithTeammates(true)
	if GM.CLASS.Survivors[class].model then
		self:SetModel(GM.CLASS.Survivors[class].model)
	else
		self:SetModel("models/player/eli.mdl")
	end
	self:SetupHands()
	for _, v in ipairs(GM.CONFIG["survivors_weapons"]) do
		self:Give(v)
	end
	for _, v in ipairs(GM.CLASS.Survivors[class].weapons) do
		self:Give(v)
	end
	self:SetWalkSpeed(GM.CLASS.Survivors[class].walkspeed)
	self:SetRunSpeed(GM.CLASS.Survivors[class].runspeed)
	self:SetMaxHealth(GM.CLASS.Survivors[class].life)
	self:SetHealth(GM.CLASS.Survivors[class].life)
	self:GodDisable()
	--self:SetNWInt("ClassID", class)
	self.ClassID = class
end



function playermeta:SetupKiller()
	self:StripWeapons()
	self:SetTeam(TEAM_KILLER)
	self:AllowFlashlight(false)
	self.InitialWeapon = table.Random(GM.CONFIG["killer_weapons"])
	self:Give(self.InitialWeapon)
	self:SetNoCollideWithTeammates(false)
	self:SetModel(GM.MAP.Killer.Model)
	self:SetupHands()

	if GM.MAP.Killer.ExtraWeapons then
		for _, v in ipairs(GM.MAP.Killer.ExtraWeapons) do
			self:Give(v)
		end
	end

	self:SetWalkSpeed(GM.MAP.Killer.WalkSpeed)
	self:SetRunSpeed(GM.MAP.Killer.RunSpeed)
	self:SetMaxHealth(100)
	self:GodEnable()
	self.ClassID = CLASS_KILLER
end

function GM.CLASS:SetupSurvivors()
	local classes = table.GetKeys(GM.CLASS.Survivors)

	for _, v in ipairs(GM.ROUND.Survivors) do
		local class, key = table.Random(classes)
		v:SetSurvClass(class)
		table.remove(classes, key)
	end
end

function GM.CLASS.GetClassIDTable()
	local tbl = {}

	for _, v in ipairs(player.GetAll()) do
		if v.ClassID != nil then
			table.insert(tbl, {ply = v, ClassID = v.ClassID})
		end
	end
	return tbl
end

-- Disable TeamKill
local function PlayerShouldTakeDamage(ply, attacker)
	if !IsValid(ply) || !IsValid(attacker) || !attacker:IsPlayer() then return end
	if ply:Team() == attacker:Team() then
		return false
	end
end
hook.Add("PlayerShouldTakeDamage", "sls_class_PlayerShouldTakeDamage", PlayerShouldTakeDamage)
