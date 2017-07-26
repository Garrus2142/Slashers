if SERVER then AddCSLuaFile() end

game.AddAmmoType({name = "nmrih_flare"})
if CLIENT then
	language.Add("nmrih_flare_ammo","Flares")
end

game.AddAmmoType({name = "gasoline"})
if CLIENT then
	language.Add("gasoline_ammo","Gasoline")
end

game.AddAmmoType({name = "tnt"})
if CLIENT then
	language.Add("tnt_ammo","TNT")
end

game.AddAmmoType({name = "frag"})
if CLIENT then
	language.Add("frag_ammo","Fragmentation Grenades")
end

game.AddAmmoType({name = "molly"})
if CLIENT then
	language.Add("molly_ammo","Molotov Cocktails")
end

game.AddAmmoType({name = "co2"})
if CLIENT then
	language.Add("co2_ammo","Carbon Dioxide")
end

game.AddAmmoType({name = "propane"})
if CLIENT then
	language.Add("propane_ammo","Propane")
end

game.AddAmmoType({name = "lighter"})
if CLIENT then
	language.Add("lighter_ammo","Lighters")
end