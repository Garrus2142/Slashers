local GM = GM or GAMEMODE

local function CreateDebris(door, model, delay, aimvec)
	local debris = ents.Create("prop_physics_multiplayer")

	debris:SetModel(model)
	debris:SetAngles(door:GetAngles())
	debris:SetPos(door:GetPos())
	debris:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	debris:Spawn()
	debris:GetPhysicsObject():SetVelocity(aimvec * 200)
	constraint.NoCollide(debris, door, 0, 0)
	SafeRemoveEntityDelayed(debris, delay)
end

local function WoodenState1(ent, aimvec)
	CreateDebris(ent, "models/props_doors/doormain_rural04_small_01.mdl", 12, aimvec)
	CreateDebris(ent, "models/props_doors/doormain_rural04_small_02.mdl", 12, aimvec)
	CreateDebris(ent, "models/props_doors/doormain_rural04_small_03.mdl", 12, aimvec)
	CreateDebris(ent, "models/props_doors/doormain_rural04_small_04.mdl", 12, aimvec)

	ent:Remove()
end

local function WoodenState2(ent, aimvec)
	ent:SetModel("models/props_doors/doormain_rural03_small_01.mdl")

	CreateDebris(ent, "models/props_doors/doormain_rural03_small_02.mdl", 6, aimvec)
	CreateDebris(ent, "models/props_doors/doormain_rural03_small_03.mdl", 6, aimvec)
end

local function WoodenState3(ent, aimvec)
	ent:SetModel("models/props_doors/doormain_rural02_small_01.mdl")

	CreateDebris(ent, "models/props_doors/doormain_rural02_small_02.mdl", 6, aimvec)
	CreateDebris(ent, "models/props_doors/doormain_rural02_small_03.mdl", 6, aimvec)
end

local function WoodenState4(ent, aimvec)
	ent:SetModel("models/props_doors/doormain_rural01_small_01.mdl")
	ent:PhysicsInitConvex(wood1)
	ent:EnableCustomCollisions(true)

	CreateDebris(ent, "models/props_doors/doormain_rural01_small_02.mdl", 6, aimvec)
end

local function WoodenDamageCallback(ent, dmg)
	local aimvec

	ent.breakdoors_life = ent.breakdoors_life - dmg:GetDamage()
	if IsValid(dmg:GetAttacker()) && dmg:GetAttacker():IsPlayer() then
		aimvec = dmg:GetAttacker():GetAimVector()
	else
		aimvec = Vector(0, 0, 0)
	end
	if ent.breakdoors_cent > math.floor(ent.breakdoors_life / 100) then
		ent.breakdoors_cent = math.floor(ent.breakdoors_life / 100)
		if ent.breakdoors_cent == 3 then WoodenState4(ent, aimvec)
		elseif ent.breakdoors_cent == 2 then WoodenState3(ent, aimvec)
		elseif ent.breakdoors_cent == 1 then WoodenState2(ent, aimvec)
		elseif ent.breakdoors_life < 50 then WoodenState1(ent, aimvec) end
		if IsValid(ent) then
			ent:SetSolid(SOLID_VPHYSICS)
			ent:PhysicsInitShadow()
		end
	end
end

local function MetalState1(ent, aimvec)
	CreateDebris(ent, "models/props_doors/doormainmetal01_dm08_a.mdl", 12, aimvec)
	CreateDebris(ent, "models/props_doors/doormainmetal01_dm08_a.mdl", 12, aimvec)
	CreateDebris(ent, "models/props_doors/doormainmetal01_dm08_b.mdl", 12, aimvec)
	CreateDebris(ent, "models/props_doors/doormainmetal01_dm08_c.mdl", 12, aimvec)
	CreateDebris(ent, "models/props_doors/doormainmetal01_dm08_d.mdl", 12, aimvec)
	CreateDebris(ent, "models/props_doors/doormainmetal01_dm08_f.mdl", 12, aimvec)
	CreateDebris(ent, "models/props_doors/doormainmetal01_dm08_g.mdl", 12, aimvec)
	CreateDebris(ent, "models/props_doors/doormainmetal01_dm08_h.mdl", 12, aimvec)

	ent:Remove()
end

local function MetalState2(ent, aimvec)
	ent:SetModel("models/props_doors/doormainmetal01_dm07.mdl")

	CreateDebris(ent, "models/props_doors/doormainmetal01_dm07_a.mdl", 6, aimvec)
	CreateDebris(ent, "models/props_doors/doormainmetal01_dm07_b.mdl", 6, aimvec)
end

local function MetalState3(ent, aimvec)
	ent:SetModel("models/props_doors/doormainmetal01_dm06.mdl")

	CreateDebris(ent, "models/props_doors/doormainmetal01_dm06_a.mdl", 6, aimvec)
	CreateDebris(ent, "models/props_doors/doormainmetal01_dm06_b.mdl", 6, aimvec)
end

local function MetalState4(ent, aimvec)
	ent:SetModel("models/props_doors/doormainmetal01_dm06.mdl")

	CreateDebris(ent, "models/props_doors/doormainmetal01_dm05_a.mdl", 6, aimvec)
	CreateDebris(ent, "models/props_doors/doormainmetal01_dm05_b.mdl", 6, aimvec)
end

local function MetalState5(ent, aimvec)
	ent:SetModel("models/props_doors/doormainmetal01_dm04.mdl")
end

local function MetalState6(ent, aimvec)
	ent:SetModel("models/props_doors/doormainmetal01_dm04.mdl")

	CreateDebris(ent, "models/props_doors/doormainmetal01_dm03_a.mdl", 6, aimvec)
	CreateDebris(ent, "models/props_doors/doormainmetal01_dm03_b.mdl", 6, aimvec)
end

local function MetalState7(ent, aimvec)
	ent:SetModel("models/props_doors/doormainmetal01_dm02.mdl")
end

local function MetalState8(ent, aimvec)
	ent:SetModel("models/props_doors/doormainmetal01_dm01.mdl")
end

local function MetalDamageCallback(ent, dmg)
	local aimvec

	ent.breakdoors_life = ent.breakdoors_life - dmg:GetDamage()
	if IsValid(dmg:GetAttacker()) && dmg:GetAttacker():IsPlayer() then
		aimvec = dmg:GetAttacker():GetAimVector()
	else
		aimvec = Vector(0, 0, 0)
	end
	if ent.breakdoors_cent > math.floor(ent.breakdoors_life / 100) then
		ent.breakdoors_cent = math.floor(ent.breakdoors_life / 100)
		if ent.breakdoors_cent == 7 then MetalState8(ent, aimvec)
		elseif ent.breakdoors_cent == 6 then MetalState7(ent, aimvec)
		elseif ent.breakdoors_cent == 5 then MetalState6(ent, aimvec)
		elseif ent.breakdoors_cent == 4 then MetalState5(ent, aimvec)
		elseif ent.breakdoors_cent == 3 then MetalState4(ent, aimvec)
		elseif ent.breakdoors_cent == 2 then MetalState3(ent, aimvec)
		elseif ent.breakdoors_cent == 1 then MetalState2(ent, aimvec)
		elseif ent.breakdoors_life < 50 then MetalState1(ent, aimvec) end
		if IsValid(ent) then
			ent:SetSolid(SOLID_VPHYSICS)
			ent:PhysicsInitShadow()
		end
	end
end

local function InitializeWooden(ent)
	ent.breakdoors_life = 500
	ent.breakdoors_cent = math.floor(ent.breakdoors_life / 100)
	ent.breakdoors_callback = WoodenDamageCallback
end

local function InitializeMetal(ent)
	ent.breakdoors_life = 800
	ent.breakdoors_cent = math.floor(ent.breakdoors_life / 100)
	ent.breakdoors_callback = MetalDamageCallback
end

local function BreakDoorsInitialize()
	for _, v in ipairs(ents.FindByClass("prop_door_rotating")) do
		if v:GetModel() == "models/props_doors/doormain_rural01_small.mdl" then
			InitializeWooden(v)
		elseif v:GetModel() == "models/props_doors/doormainmetal01.mdl" then
			InitializeMetal(v)
		end
	end
end
hook.Add("sls_round_PostStart", "breakdoors_PostStart", BreakDoorsInitialize)

hook.Add("EntityTakeDamage", "breakdoors_EntityTakeDamage", 
	function(ent, dmg) 
		if IsValid(ent) && ent.breakdoors_callback then
			ent.breakdoors_callback(ent, dmg)
		end 
	end
)