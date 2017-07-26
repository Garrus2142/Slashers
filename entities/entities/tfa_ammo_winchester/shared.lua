if SERVER then
	AddCSLuaFile()
end

ENT.Type 			= "anim"
ENT.Base 			= "tfa_ammo_base"
ENT.PrintName		= "Winchester Ammo"
ENT.Category		= "TFA Ammunition"

ENT.Spawnable		= true
ENT.AdminSpawnable	= true

ENT.Class=""
ENT.MyModel = "models/Items/sniper_round_box.mdl"
ENT.ImpactSound = "Default.ImpactSoft"
ENT.AmmoCount = 50
ENT.AmmoType = "AirboatGun"
ENT.DrawText = true
ENT.TextColor = Color(185, 25, 25, 255)
ENT.TextPosition = Vector( 1, -1.45, 1.5)
ENT.TextAngles = Vector(90, 0, 0)
ENT.ShouldDrawShadow = true
ENT.ImpactSound = "Default.ImpactSoft"
ENT.Damage = 30
ENT.Text = ".308"