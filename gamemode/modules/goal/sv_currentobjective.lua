-- Utopia Games - Slashers
--
-- @Author: Guilhem PECH
-- @Date:   2017-07-26T13:54:42+02:00
-- @Last Modified by:   Garrus2142
-- @Last Modified time: 2017-07-26T15:16:16+02:00



util.AddNetworkString( "objectiveSlasher" )
util.AddNetworkString( "modifyObjectiveSlasher" )

hook.Add( "sls_round_PostStart", "StartObjectives", function( ply, text, public )
		CurrentObjective = "find_jerrican"
		NbJerricanToFind = math.ceil(#player.GetAll() / 3)
		NbJerricanToFound = NbJerricanToFind

		net.Start( "objectiveSlasher" )
		net.WriteTable({"round_mission_jerrycan", NbJerricanToFind})
		net.WriteString("caution")
		net.SendOmit(GAMEMODE.ROUND.Killer)
	end
)

hook.Add( "sls_NextObjective", "Next Objective", function()
	if (CurrentObjective == "find_jerrican") then
		CurrentObjective = "activate_generator"
		GAMEMODE.ROUND:UpdateEndTime(GAMEMODE.ROUND.EndTime + GetConVar("slashers_duration_addobj"):GetFloat())
	elseif (CurrentObjective == "activate_generator") then
		CurrentObjective = "activate_radio"
		GAMEMODE.ROUND:UpdateEndTime(GAMEMODE.ROUND.EndTime + GetConVar("slashers_duration_addsurv"):GetFloat())
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
		net.WriteTable({})
		net.WriteString("safe")
		net.Broadcast()
end
