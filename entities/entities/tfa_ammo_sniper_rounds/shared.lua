if SERVER then
	AddCSLuaFile()
end

ENT.Type 			= "anim"
ENT.Base 			= "tfa_ammo_base"
ENT.PrintName		= "Sniper Ammo"
ENT.Category		= "TFA Ammunition"

ENT.Spawnable		= true
ENT.AdminSpawnable	= true

ENT.Class=""
ENT.MyModel = "models/Items/sniper_round_box.mdl"
ENT.ImpactSound = "Default.ImpactSoft"
ENT.AmmoCount = 30
ENT.AmmoType = "SniperPenetratedRound"
ENT.DrawText = true
ENT.TextColor = Color(185, 25, 25, 255)
ENT.TextPosition = Vector( 1, -1.45, 2.1)
ENT.TextAngles = Vector(90, 0, 0)
ENT.ShouldDrawShadow = true
ENT.ImpactSound = "Default.ImpactSoft"
ENT.Damage = 80
ENT.Text = "Sniper Rounds"
ENT.TextScale = 0.5