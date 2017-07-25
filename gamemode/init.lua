DEFINE_BASECLASS( "gamemode_base" )
include("shared.lua")
include("config.lua")
include("libs/zones.lua")
include("core/_includes.lua")
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("config.lua")
AddCSLuaFile("core/_includes.lua")

GAME_LUM = "g"

//pjs = pjs or {};

function GM:CanPlayerSuicide()
	return false
end

function GM:Initialize()
	timer.Simple(0,function()engine.LightStyle(0,GAME_LUM)end)
end


-- Prevent self respawn
function GM:PlayerDeathThink()
	return false
end

function GM:PlayerNoClip( ply )
	return false
end

-- Fall damage
function GM:GetFallDamage( ply, speed )
	-- return math.max( 0, math.ceil( 0.2418*speed - 141.75 ) )
	return ( speed / 8 )
end

LoadModules()