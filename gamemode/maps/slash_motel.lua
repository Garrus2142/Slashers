-- @Author: Guilhem PECH <Daryl_Winters>
-- @Date:   05-Jan-2018
-- @Email:  guilhempech@gmail.com
-- @Project: Slashers
-- @Last modified by:   Guilhem PECH
-- @Last modified time: 05-Jan-2018



local GM = GM or GAMEMODE
if CLIENT then
	local ply = LocalPlayer()
end

GM.MAP.Name = "Motel"
GM.MAP.EscapeDuration = 90
GM.MAP.StartMusic = "slashers_start_game_jason.wav"
GM.MAP.ChaseMusic = "slashers/ambient/chase_jason.wav"
GM.MAP.Goal = {
	Generator = {

	},

	Jerrican = {

	},

	Radio = {

	}
}

-- Killer
GM.MAP.Killer.Name = "Norman Bates"
GM.MAP.Killer.Model = "models/player/mkx_jason.mdl"
GM.MAP.Killer.WalkSpeed = 190
GM.MAP.Killer.RunSpeed = 240
GM.MAP.Killer.ExtraWeapons = {}

if CLIENT then
	GM.MAP.Killer.Desc = GM.LANG:GetString("class_desc_bates")
	GM.MAP.Killer.Icon = Material("icons/icon_jason.png")
end

-- Convars
CreateConVar("slashers_bates_far_radius", 400, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Set the first radius (far).")
CreateConVar("slashers_bates_medium_radius", 200, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Set the second radius (medium).")
CreateConVar("slashers_bates_close_radius", 100, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Set the third radius (close).")


-- Ability
-------------------The other part of the ability code is in the 'Mother' entity code
-------------------The corpse entity send a net.Message ("slash_mother_bates") to the killer, processed here :
if CLIENT then
	local curSound
	local function playSound(sound)
		sound.PlayFile( sound, "", function( station )
			if ( IsValid( station ) then
				if IsValid(curSound) then
					curSound:Stop()
				end
				curSound = station
				curSound:Play()
				curSound:EnableLooping(true)
			end
		end )
	end


	local function receiveMotherInfo()
		local radius  = net.ReadUInt(2) // 0 if there is nobody inside the radius / 1 if far  / 2 if medium / 3 if close
		if radius == 1 then
			// far
			playSound("sound/music/vlvx_song22.mp3")
		elseif radius == 2 then
			//medium
			playSound("sound/music/vlvx_song22.mp3")
		elseif radius == 3 then
			// close
			playSound("sound/music/vlvx_song22.mp3")
		else
			if IsValid(curSound) then
				curSound:Stop()
			end
		end
	end
	net.Receive("slash_mother_bates",receiveMotherInfo)
