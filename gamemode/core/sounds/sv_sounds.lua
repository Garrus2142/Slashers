local metaplayer = FindMetaTable("Player")
util.AddNetworkString("sls_sounds_PlaySound")

function metaplayer:PlaySound(sound)
	net.Start("sls_sounds_PlaySound")
		net.WriteString(sound)
	net.Send(self)
end