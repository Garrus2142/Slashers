local Zones_meta = {}
local Zones = {}

Zones_meta.__index = Zones_meta

function CreateZone(vec1, vec2)
    local zone = {}

    OrderVectors(vec1, vec2)
    zone.coords = {vec1, vec2}
    zone.id = table.insert(Zones, zone)
    setmetatable(zone, Zones_meta)
    return zone
end

function Zones_meta:__tostring()
    return "Zone [" .. self.id .. "]"
end

function Zones_meta:GetID()
    return self.id
end

function Zones_meta:OnPlayerEnter(ply)
end

function Zones_meta:OnPlayerLeave(ply)
end

function Zones_meta:GetPlayers()
    local players = {}
    for _, v in ipairs(player.GetAll()) do
        if IsValid(v) && v:Alive() && self:HasPlayer(v) then
            table.insert(players, v)
        end
    end
    return players
end

function Zones_meta:HasPlayer(ply)
    return ply:GetPos():WithinAABox(self.coords[1], self.coords[2])
end

function Zones_meta:Remove()
    table.remove(Zones, self.id)
end

local function PlayerDK(ply)
	if !ply.inzones then return end
	
	for _, v in ipairs(ply.inzones) do
		if Zones[v] then Zones[v]:OnPlayerLeave(ply) end
	end
	ply.inzones = nil
end
hook.Add("PlayerDeath", "zones_PlayerDeath", PlayerDK)
hook.Add("PlayerDisconnected", "zones_PlayerDisconnected", PlayerDK)

local function Think()
    for _, ply in ipairs(player.GetAll()) do
    	if !ply:Alive() then continue end

        for _, zone in ipairs(Zones) do
            if ply.inzones && table.HasValue(ply.inzones, zone:GetID()) then
                -- Leave
                if !zone:HasPlayer(ply) then
                    zone:OnPlayerLeave(ply)
                    table.RemoveByValue(ply.inzones, zone:GetID())
                end
            else
                -- Enter
                if zone:HasPlayer(ply) then
                    ply.inzones = ply.inzones or {}
                    zone:OnPlayerEnter(ply)
                    table.insert(ply.inzones, zone:GetID())
                end
            end
        end
    end
end
hook.Add("Think", "zones_Think", Think)