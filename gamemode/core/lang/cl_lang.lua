-- Utopia Games - Slashers
--
-- @Author: Garrus2142
-- @Date:   2017-08-01 17:14:14
-- @Last Modified by:   Garrus2142
-- @Last Modified time: 2017-08-01 17:14:14

local GM = GM or GAMEMODE
local LANG

GM.LANG = {}

function GM.LANG:GetString(key, ...)
	return string.format(LANG[key], ...)
end

local function LoadLanguage(lang)
	local languagesPath = "slashers/gamemode/languages"
	local files, _ = file.Find(languagesPath .. "/*.lua", "LUA")

	LANG = include(languagesPath .. "/" .. GM.CONFIG["lang_default"] .. ".lua")

	for _, v in ipairs(files) do
		if v == lang .. ".lua" then
			table.Merge(LANG, include(languagesPath .. "/" .. v))
			return
		end
	end
end

local function OnLangChange(convar_name, value_old, value_new)
	if value_new != value_old then
		LoadLanguage(value_new)
	end
end
cvars.AddChangeCallback("gmod_language", OnLangChange)

-- Load user language
do
	local cvLang = GetConVar("gmod_language")
	LoadLanguage(cvLang:GetString())
end
