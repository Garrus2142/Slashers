-- Utopia Games - Slashers
--
-- @Author: Garrus2142
-- @Date:   2017-07-25 16:15:45
-- @Last modified by:   Guilhem PECH
-- @Last modified time: 21-Oct-2018

if SERVER then
	-- Convars
	include("convars.lua")
	AddCSLuaFile("convars.lua")
	-- Language
	include("lang/sv_lang.lua")
	AddCSLuaFile("lang/cl_lang.lua")
	-- Maps loader
	include("mapsloader.lua")
	AddCSLuaFile("mapsloader.lua")
	-- Fonts
	AddCSLuaFile("fonts.lua")
	-- Format
	AddCSLuaFile("format.lua")
	-- Messages
	AddCSLuaFile("messages.lua")
	-- Sounds
	include("sounds/sv_sounds.lua")
	AddCSLuaFile("sounds/cl_sounds.lua")
	-- Notification
	include("notification/sv_notification.lua")
	AddCSLuaFile("notification/cl_notification.lua")
	-- Class
	include("downloads.lua")
	include("class/sh_class.lua")
	include("class/sv_class.lua")
	AddCSLuaFile("class/sh_class.lua")
	AddCSLuaFile("class/cl_class.lua")
	-- Rounds
	include("rounds/sh_rounds.lua")
	include("rounds/sv_rounds.lua")
	include("rounds/sv_choosekiller.lua")


	AddCSLuaFile("rounds/sh_rounds.lua")
	AddCSLuaFile("rounds/cl_network.lua")
	AddCSLuaFile("rounds/cl_rounds.lua")

	-- Slot CheckPassword
	include ("slot/sv_slotcheck.lua")
else
	-- Convars
	include("convars.lua")
	-- Language
	include("lang/cl_lang.lua")
	-- Maps loader
	include("mapsloader.lua")
	-- Fonts
	include("fonts.lua")
	-- Format
	include("format.lua")
	-- Messages
	include("messages.lua")
	-- Sounds
	include("sounds/cl_sounds.lua")
	-- Notification
	include("notification/cl_notification.lua")
	-- Class
	include("class/sh_class.lua")
	include("class/cl_class.lua")
	-- Rounds
	include("rounds/sh_rounds.lua")
	include("rounds/cl_network.lua")
	include("rounds/cl_rounds.lua")
end
