if SERVER then AddCSLuaFile() end

sound.Add({
	name = 			"Weapon_Bow.1",
	channel = 		CHAN_STATIC,
	volume = 		1.0,
	sound = 			{ "weapons/tfbow/fire1.wav", "weapons/tfbow/fire2.wav", "weapons/tfbow/fire3.wav" }
})


sound.Add({
	name = 			"Weapon_Bow.boltpull",
	channel = 		CHAN_USER_BASE+11,
	volume = 		1.0,
	sound = 			{ "weapons/tfbow/pull1.wav", "weapons/tfbow/pull2.wav", "weapons/tfbow/pull3.wav" }
})
