local Timer1 = 0 
local Ply

local function HaveASurvivorInSight()		
	local killer = team.GetPlayers(TEAM_KILLER)[1]	
	if !IsValid(killer) then return end
	if LocalPlayer():Team() != TEAM_KILLER then return end
	local curtime = CurTime()
	if Timer1 > curtime then return end

	local SurvivorsPly = player.GetAll()
	for k,v in pairs(SurvivorsPly) do
		--print (v)  
		if killer:GetPos():Distance(v:GetPos()) < 1000 && LocalPlayer():IsLineOfSightClear( v )  and v:IsValid() and v ~= LocalPlayer() then
					
			local TargetPosMax= v:GetPos()+ v:OBBMaxs() - Vector(10,0,0)			
			local TargetPosMin = v:GetPos()+ v:OBBMins() + Vector(10,0,0)
			
			local ScreenPosMax = TargetPosMax:ToScreen()
			local ScreenPosMin = TargetPosMin:ToScreen()	
	
			//draw.DrawText( "I see "..v:GetName(), "TargetID", ScrW() * 0.5, ScrH() * 0.25, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
			if (ScreenPosMax.x < ScrW() and ScreenPosMax.y < ScrH() and ScreenPosMin.x > 0 and ScreenPosMin.y > 0) then
				net.Start( "sls_killerseesurvivor" )
					net.WriteEntity( v ) 
					net.WriteUInt(LocalPlayer():GetColor().a, 8)
				net.SendToServer()
			end

		end 
	end
	Timer1 = curtime + 1
end
hook.Add("Think", "sls_SurvivorInView", HaveASurvivorInSight)
local ChaseSound
local function InitValue()
	if !IsValid(Ply) then return end
	ChaseSound = CreateSound( LocalPlayer(), GAMEMODE.CONFIG["chase_musics"][game.GetMap()])
	LocalPlayer().LastViewByKillerTime = 0
	Ply.ChaseSoundPlaying = false 
end 
hook.Add("PlayerSpawn","InitPlayValue",InitValue)
hook.Add("sls_round_PostStart", "sls_chasemo_PostStart", InitValue)

local function LastViewByKiller()
	local ply = LocalPlayer()
	ply.LastViewByKillerTime = net.ReadFloat()
end
net.Receive( "sls_chaseactivated", LastViewByKiller)


	

local function chaseMusique()
	
	Ply = LocalPlayer()
	curtime= CurTime()
	if !IsValid(ChaseSound) then return end
	if (!LocalPlayer():Alive() and Ply.ChaseSoundPlaying)then ChaseSound:FadeOut(1.2)end
	if (!LocalPlayer():Alive())then return end
	if !(LocalPlayer().LastViewByKillerTime) then return end	
	if (Ply.LastViewByKillerTime > curtime - 3 and !Ply.ChaseSoundPlaying) then
		timer.Simple(3, function() 
			if Ply.LastViewByKillerTime > curtime - 3 then
				ChaseSound:Play()
			end
		end)
		Ply.ChaseSoundPlaying = true
	elseif Ply.ChaseSoundPlaying and Ply.LastViewByKillerTime < curtime - 5  then
		ChaseSound:FadeOut(1.2)
		Ply.ChaseSoundPlaying = false
	end 
	

end
hook.Add("Think","sls_ChasemodeMusic",chaseMusique)