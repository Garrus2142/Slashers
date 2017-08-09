-- Utopia Games - Slashers
--
-- @Author: Guilhem PECH
-- @Date:   2017-07-26T13:54:42+02:00
-- @Last Modified by:   Garrus2142
-- @Last Modified time: 2017-07-26 22:32:02

local GM = GM or GAMEMODE

local function Spawn_SlashGen()
	if GM.MAP.Goal then --If we have data for this map
		for k, v in pairs( GM.MAP.Goal ) do

			if (v == GM.MAP.Goal.Jerrican) then
				nbEntToSpawn = 3 *  math.ceil( (#player.GetAll() / 3) )
			else
				nbEntToSpawn = 0
			end

			while (nbEntToSpawn >= 0) do
				w = table.Random(v)

				if !w.spw then
					--get the type of entity
					local entType = w.type
					--spawn it
					local newEnt = ents.Create(entType)
					if w.model then newEnt:SetModel(w.model) end --set model
					if w.ang then newEnt:SetAngles(w.ang) end --set angle
					if w.pos then newEnt:SetPos(w.pos) end --set position
					newEnt:Spawn()

					newEnt:Activate()

					w.spw = true
				end
				nbEntToSpawn = nbEntToSpawn -1
			end
		end
	end
end
hook.Add( "sls_round_PostStart", "Slasher Generator Spawn", Spawn_SlashGen )

hook.Add( "sls_round_PreStart", "sls_ReinitObjectives", function( ply, text, public )
	if GM.MAP.Goal then --If we have data for this map
		for k, v in pairs( GM.MAP.Goal ) do
			for m, w in pairs( v ) do
				w.spw = false
			end
		end
	end
end )
