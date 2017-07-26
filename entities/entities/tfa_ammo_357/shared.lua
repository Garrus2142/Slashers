if SERVER then
	AddCSLuaFile()
end

ENT.Type 			= "anim"
ENT.Base 			= "tfa_ammo_base"
ENT.PrintName		= "357"
ENT.Category		= "TFA Ammunition"

ENT.Spawnable		= true
ENT.AdminSpawnable	= true

ENT.Class=""
ENT.MyModel = "models/Items/357ammo.mdl"
ENT.ImpactSound = "Default.ImpactSoft"
ENT.AmmoCount = 25
ENT.AmmoType = "357"
ENT.DrawText = true
ENT.TextColor = Color(225, 225, 225, 255)
ENT.TextPosition = Vector(5, 0, 7.5)
ENT.TextAngles = Vector(42, 90 , 0)
ENT.ShouldDrawShadow = true
ENT.ImpactSound = "Default.ImpactSoft"
ENT.Damage = 50