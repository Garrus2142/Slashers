-- Utopia Games - Slashers
--
-- @Author: Guilhem PECH
-- @Date:   2017-07-26T13:54:42+02:00
-- @Last Modified by:   Guilhem PECH
-- @Last Modified time: 2017-07-26 23:47:01



sound.Add( {
	name = "Breathing",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 80,
	pitch = { 95, 110 },
	sound = "player/breathe.wav"
} )


-----
-----

if SERVER then
	util.AddNetworkString( "wantedSound" )
	util.AddNetworkString( "stopSound" )
	net.Receive( "wantedSound", function( len, ply )
		local soundName = net.ReadString()
		ply:EmitSound(soundName)
	end )

	net.Receive( "stopSound", function( len, ply )
		local soundName = net.ReadString()
		ply:StopSound(soundName)
	end )


end




------
------
------
if CLIENT then
	local AlreadyJump = false
	local AlreadyBreathing = false
	local GM = GM or GAMEMODE
	local scrW, scrH = ScrW(), ScrH()

	function GetClientMove(cmd)
		local NewButtons = cmd:GetButtons()
		local Change = FrameTime() * 5

		local ply = LocalPlayer()
		if !GAMEMODE.ROUND.Active || !IsValid(GAMEMODE.ROUND.Killer) || !GAMEMODE.ROUND.Survivors  then return end
		if table.HasValue(GAMEMODE.ROUND.Survivors, ply ) and GAMEMODE.CLASS.Survivors[ply.ClassID].name ~= "Sports" then

			if 	ply.Stamina >= 10 then
				net.Start("stopSound")
					net.WriteString("Breathing")
				net.SendToServer()

				-- ply:StopSound( "Breathing" )
				AlreadyBreathing = false
			end

			if 	!ply:Alive() then
				net.Start("stopSound")
				net.WriteString("Breathing")
				net.SendToServer()

				ply.Stamina = 100
				AlreadyBreathing = false
			end

			if cmd:KeyDown(IN_JUMP) and ply:OnGround() and !ply:InVehicle() then

				if not AlreadyBreathing and ply.Stamina<=30 then

					net.Start("wantedSound")
					net.WriteString("Breathing")
					net.SendToServer()
					-- ply:EmitSound("Breathing")
					AlreadyBreathing = true
				end

				if ply.Stamina <= 5 then
					NewButtons = NewButtons - IN_JUMP
				end

				if not AlreadyJump and ply.Stamina >= 5  then
					ply.Stamina = ply.Stamina - (ply.MaxStamina * 1/7)
					-- print(ply.Stamina)
				end
				AlreadyJump = true

			elseif not cmd:KeyDown(IN_JUMP) then

				AlreadyJump = false

			end

			if cmd:KeyDown(IN_SPEED) and ( cmd:KeyDown(IN_FORWARD) or cmd:KeyDown(IN_BACK) or cmd:KeyDown(IN_MOVELEFT) or cmd:KeyDown(IN_MOVERIGHT) ) and (ply:GetVelocity():Length() > 100) and ( ply:OnGround() or ply:WaterLevel() ~= 0 ) and !ply:InVehicle() then

				if ply.Stamina <= 0 then

					NewButtons = NewButtons - IN_SPEED

				else

					ply.Stamina = math.Clamp(ply.Stamina - 2 * Change * ply.DecayMul,0,ply.MaxStamina)
					ply.NextRegen = CurTime() + 2.25

				end

				if not AlreadyBreathing and ply.Stamina<=60 then

					net.Start("wantedSound")
					net.WriteString("Breathing")
					net.SendToServer()
					-- ply:EmitSound("Breathing")

					AlreadyBreathing = true

				end

			end


			if ply.NextRegen then
				if ply.NextRegen < CurTime() then
					if (cmd:KeyDown(IN_FORWARD) or cmd:KeyDown(IN_BACK) or cmd:KeyDown(IN_MOVELEFT) or cmd:KeyDown(IN_MOVERIGHT)) then
						ply.Stamina = math.Clamp(ply.Stamina + ( Change * 0.5 * ply.RegenMul ) ,0,ply.MaxStamina)
					else
						ply.Stamina = math.Clamp(ply.Stamina + ( Change * 1 * ply.RegenMul ) ,0,ply.MaxStamina)
					end
				end
			end
			cmd:SetButtons(NewButtons)
		end
	end

	hook.Add("CreateMove"," Sprint",GetClientMove)

	local function ResetStamina()
		local ply = LocalPlayer()
		if ply == GAMEMODE.ROUND.Killer then return end
		ply.Stamina = GAMEMODE.CLASS.Survivors[ply.ClassID].stamina
		ply.MaxStamina = GAMEMODE.CLASS.Survivors[ply.ClassID].stamina
		ply.DecayMul = 0.8
		ply.RegenMul = 1.8

		ply.NextRegen = 0
		ply.WaterTick = 0
	end 
	hook.Add("sls_round_PostStart", "sls_stamina_PostStart", ResetStamina)

	-- A function to draw a certain part of a texture
	local function DrawPartialTexturedRect( x, y, w, h, partx, party, partw, parth, texw, texh )
		-- Verify that we recieved all arguments
		if not( x && y && w && h && partx && party && partw && parth && texw && texh ) then
			ErrorNoHalt("surface.DrawPartialTexturedRect: Missing argument!");

			return;
		end;

		-- Get the positions and sizes as percentages / 100
		local percX, percY = partx / texw, party / texh;
		local percW, percH = partw / texw, parth / texh;

		-- Process the data
		local vertexData = {
			{
				x = x,
				y = y,
				u = percX,
				v = percY
			},
			{
				x = x + w,
				y = y,
				u = percX + percW,
				v = percY
			},
			{
				x = x + w,
				y = y + h,
				u = percX + percW,
				v = percY + percH
			},
			{
				x = x,
				y = y + h,
				u = percX,
				v = percY + percH
			}
		};

		surface.DrawPoly( vertexData );
	end;

	local MAT_STAMINA = Material("icons/stamina_bar.png")
	local alpha_stamina = 0
	local function HUDPaint()
		local ply = LocalPlayer()
		local bwide
		if ply:Team() != TEAM_SURVIVORS || !ply:Alive() then return end
		if ply.ClassID == nil || ply.ClassID == CLASS_SURV_SPORTS then return end
		if !ply.ClassID || !GAMEMODE.ROUND.Active || !GAMEMODE.CLASS.Survivors[ply.ClassID].stamina then return end
		bwide = 256 * ply.Stamina / GAMEMODE.CLASS.Survivors[ply.ClassID].stamina
		if ply.Stamina == GAMEMODE.CLASS.Survivors[ply.ClassID].stamina && alpha_stamina > 0 then
			alpha_stamina = math.max(0, alpha_stamina - 4)
		elseif ply.Stamina < GAMEMODE.CLASS.Survivors[ply.ClassID].stamina && alpha_stamina < 255 then
			alpha_stamina = math.min(alpha_stamina + 4, 255)
		end
		surface.SetDrawColor(Color(150, 150, 150, alpha_stamina))
		surface.SetMaterial(MAT_STAMINA)
		surface.DrawTexturedRect(scrW / 2 - 128, scrH - 48, 256, 32)
		surface.SetDrawColor(Color(255, 255, 255, alpha_stamina))
		surface.SetMaterial(MAT_STAMINA)
		DrawPartialTexturedRect(scrW / 2 - 128, scrH - 48, bwide, 32, 0, 0, bwide, 32, 256, 32)
	end
	hook.Add("HUDPaint", "sls_stamina_HUDPaint", HUDPaint)
end
