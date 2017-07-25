util.AddNetworkString( "objectiveSlasher" )
util.AddNetworkString( "modifyObjectiveSlasher" )

hook.Add( "sls_round_PostStart", "StartObjectives", function( ply, text, public )
		CurrentObjective = "find_jerrican"
		NbJerricanToFind = math.ceil(#player.GetAll() / 3)
		NbJerricanToFound = NbJerricanToFind

		net.Start( "objectiveSlasher" )
		net.WriteString("Find "..NbJerricanToFind.. " jerrycan(s)" )
		net.WriteString("caution")
		net.SendOmit(GAMEMODE.ROUND.Killer)
	end
)

hook.Add( "sls_NextObjective", "Next Objective", function()
	if (CurrentObjective == "find_jerrican") then
		CurrentObjective = "activate_generator"
		GAMEMODE.ROUND:UpdateEndTime(GAMEMODE.ROUND.EndTime + GAMEMODE.CONFIG["round_duration_add_obj"])
	elseif (CurrentObjective == "activate_generator") then
		CurrentObjective = "activate_radio"
		GAMEMODE.ROUND:UpdateEndTime(GAMEMODE.ROUND.EndTime + GAMEMODE.CONFIG["round_duration_add_obj"])
	elseif (CurrentObjective == "activate_radio") then
		CurrentObjective ="wainting_police"
			GAMEMODE.ROUND:StartWaitingPolice()

	elseif (CurrentObjective == "wainting_police") then
			objectifComplete()
	end
end )

hook.Add( "sls_round_End", "Next Objective", function()
	objectifComplete()
end)

function objectifComplete()
		net.Start( "objectiveSlasher" )
		net.WriteString('')
		net.WriteString("safe")
		net.Broadcast()
end
