format = {}

function format.Seconde(sec)
	local fsec = ""

	if sec < 10 then
		fsec = "0"
	end

	return fsec .. sec
end