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
	self:GodDisable()
	--self:SetNWInt("ClassID", class)
	self.ClassID = class
end



function playermeta:SetKillClass(class)
	if !GM.CLASS.Killers[class] then return false end

	self:StripWeapons()
	self:SetTeam(TEAM_KILLER)
	self:AllowFlashlight(false)
	self.InitialWeapon = table.Random(GM.CONFIG["killer_weapons"])
	self:Give(self.InitialWeapon)
	self:SetNoCollideWithTeammates(false)
	self:SetModel(GM.CLASS.Killers[class].model)
	self:SetupHands()

	if GM.CLASS.Killers[class].weapons then
		for _, v in ipairs(GM.CLASS.Killers[class].weapons) do
			self:Give(v)
		end
	end

	self:SetWalkSpeed(GM.CLASS.Killers[class].walkspeed)
	self:SetRunSpeed(GM.CLASS.Killers[class].runspeed)
	self:SetMaxHealth(GM.CLASS.Killers[class].life)
	self:GodEnable()
	-- self:SetNWInt("ClassID", class)
	self.ClassID = class
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