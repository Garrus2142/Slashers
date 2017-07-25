local function PlaySound()
	local sound = net.ReadString()
	surface.PlaySound(sound)
end
net.Receive("sls_sounds_PlaySound", PlaySound)