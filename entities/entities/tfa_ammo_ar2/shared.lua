if SERVER then
	AddCSLuaFile()
end

ENT.Type 			= "anim"
ENT.Base 			= "tfa_ammo_base"
ENT.PrintName		= "Assault Ammo"
ENT.Category		= "TFA Ammunition"

ENT.Spawnable		= true
ENT.AdminSpawnable	= true

ENT.Class=""
ENT.MyModel = "models/Items/BoxMRounds.mdl"
ENT.ImpactSound = "Default.ImpactSoft"
ENT.AmmoCount = 100
ENT.AmmoType = "ar2"
ENT.DrawText = true
ENT.TextColor = Color(5, 5, 5, 255)
ENT.TextPosition = Vector( 2, 1.5, 13.4)
ENT.TextAngles = Vector(90, 90, 90)
ENT.ShouldDrawShadow = true
ENT.ImpactSound = "Default.ImpactSoft"
ENT.Damage = 35
ENT.Text = "Assault Ammo"