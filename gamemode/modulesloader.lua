-- Utopia Games - Slashers
--
-- @Author: Garrus2142
-- @Date:   2017-07-27 17:07:04
-- @Last Modified by:   Garrus2142
-- @Last Modified time: 2017-07-27 17:07:59

local modulesPath = "slashers/gamemode/modules"
local _, directories = file.Find(modulesPath .. "/*", "LUA")

if SERVER then print("--- MODULES ---") end
for _, mod in ipairs(directories) do
	if GM.CONFIG["disabled_modules"][mod] then continue end
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