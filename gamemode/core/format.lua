-- Utopia Games - Slashers
--
-- @Author: Garrus2142
-- @Date:   2017-07-25 16:15:46
-- @Last Modified by:   Garrus2142
-- @Last Modified time: 2017-07-26 14:47:32

format = {}

function format.Seconde(sec)
	local fsec = ""

	if sec < 10 then
		fsec = "0"
	end

	return fsec .. sec
end