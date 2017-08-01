-- Utopia Games - Slashers
--
-- @Author: Garrus2142
-- @Date:   2017-08-01 17:14:19
-- @Last Modified by:   Garrus2142
-- @Last Modified time: 2017-08-01 17:14:19

-- Send all language files to client
local languagesPath = "slashers/gamemode/languages"
local files, _ = file.Find(languagesPath .. "/*.lua", "LUA")

for _, f in ipairs(files) do
	AddCSLuaFile(languagesPath .. "/" .. f)
end
