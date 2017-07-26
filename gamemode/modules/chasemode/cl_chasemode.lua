local Timer1 = 0
local localplayer = LocalPlayer()


local function HaveASurvivorInSight()
	local killer = team.GetPlayers(TEAM_KILLER)[1]
	if !IsValid(killer) then return end
	if localplayer:Team() != TEAM_KILLER then return end
	local curtime = CurTime()
	if Timer1 > curtime then return end

	local SurvivorsPly = player.GetAll()
	for k,v in pairs(SurvivorsPly) do

		if killer:GetPos():Distance(v:GetPos()) < 1000 && localplayer:IsLineOfSightClear( v )  and v:IsValid() and v ~= localplayer  then

			local TargetPosMax= v:GetPos()+ v:OBBMaxs() - Vector(10,0,0)
			local TargetPosMin = v:GetPos()+ v:OBBMins() + Vector(10,0,0)

			local ScreenPosMax = TargetPosMax:ToScreen()
			local ScreenPosMin = TargetPosMin:ToScreen()


			if (ScreenPosMax.x < ScrW() and ScreenPosMax.y < ScrH() and ScreenPosMin.x > 0 and ScreenPosMin.y > 0) then
				net.Start( "sls_killerseesurvivor" )
					net.WriteEntity( v )
					net.WriteUInt(localplayer:GetColor().a, 8)
				net.SendToServer()
			end

		end
	end
	Timer1 = curtime + 1
end
hook.Add("Think", "sls_SurvivorInView", HaveASurvivorInSight)

local ChaseSound
local function InitValue()
	if !IsValid(localplayer) then return end
	localplayer = LocalPlayer()
	ChaseSound = CreateSound( localplayer, GAMEMODE.CONFIG["chase_musics"][game.GetMap()])
	localplayer.LastViewByKillerTime = 0
	localplayer.ChaseSoundPlaying = false
end
hook.Add("PlayerSpawn","InitPlayValue",InitValue)
hook.Add("sls_round_PostStart", "sls_chasemo_PostStart", InitValue)

local function LastViewByKiller()
	localplayer.LastViewByKillerTime = net.ReadFloat()
end
net.Receive( "sls_chaseactivated", LastViewByKiller)




local function chaseMusic()
	curtime= CurTime()
	if !IsValid(ChaseSound) then return end
	if (!localplayer:Alive() and localplayer.ChaseSoundPlaying) then ChaseSound:FadeOut(1.2) end
	if (!localplayer:Alive()) then return end
	if !(localplayer.LastViewByKillerTime) then return end
	if (localplayer.LastViewByKillerTime > curtime - 3 and !localplayer.ChaseSoundPlaying) then
		timer.Simple(3, function()
			if localplayer.LastViewByKillerTime > curtime - 3 then
				ChaseSound:Play()
			end
		end)
		localplayer.ChaseSoundPlaying = true
	elseif localplayer.ChaseSoundPlaying and localplayer.LastViewByKillerTime < curtime - 5  then
		ChaseSound:FadeOut(1.2)
		localplayer.ChaseSoundPlaying = false
	end


end
hook.Add("Think","sls_ChasemodeMusic",chaseMusic)
