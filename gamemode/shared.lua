-- Utopia Games - Slashers
--
-- @Author: Garrus2142
-- @Date:   2017-07-25 16:15:52
-- @Last Modified by:   Garrus2142
-- @Last Modified time: 2017-07-26 14:49:51

GM.Name = "Slashers";
GM.Author = "Garrus2142";
SLASHERS = {}
SLASHERS.ROUND = {}

TEAM_KILLER = 1;
TEAM_SURVIVORS = 2;

-- Classes
CLASS_SURV_SPORTS = 1
CLASS_SURV_POPULAR = 2
CLASS_SURV_NERD = 3
CLASS_SURV_FAT = 4
CLASS_SURV_SHY = 5
CLASS_SURV_JUNKY = 6
CLASS_SURV_EMO = 7
CLASS_SURV_BLACK = 8
CLASS_SURV_SHERIF = 9
CLASS_KILL_JASON = 101
CLASS_KILL_GHOSTFACE = 102
CLASS_KILL_MYERS = 103
CLASS_KILL_PROXY = 104
CLASS_KILL_INTRUDER = 105

team.SetUp(TEAM_KILLER, "Murderer", Color(255, 0, 0), false);
team.SetUp(TEAM_SURVIVORS, "Survivors", Color(0, 0, 255), false);

-- Module Loader
local disabledModules = {
	["observer"] = false,
	["breakdoors"] = false,
}
function LoadModules()
	local modulesPath = "slashers/gamemode/modules"
	local _, directories = file.Find(modulesPath .. "/*", "LUA")

	if SERVER then print("--- MODULES ---") end
	for _, mod in ipairs(directories) do
		if disabledModules[mod] then continue end
		files = file.Find(modulesPath .. "/" .. mod .. "/*.lua", "LUA")
		if #files > 0 then
			if SERVER then print("LOADING " .. mod) end
		end
		for _, v in ipairs(files) do
			local ext = string.sub(v, 1, 3)
			if ext == "cl_" || ext == "sh_" then
				if SERVER then
					AddCSLuaFile(modulesPath .. "/" .. mod .. "/" .. v)
				else
					include(modulesPath .. "/" .. mod .. "/" .. v)
				end
			end
			if ext == "sv_" || ext == "sh_" then
				if SERVER then
					include(modulesPath .. "/" .. mod .. "/" .. v)
				end
			end
		end
	end
end