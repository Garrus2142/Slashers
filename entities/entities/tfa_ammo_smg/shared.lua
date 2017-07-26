if SERVER then
	AddCSLuaFile()
end

ENT.Type 			= "anim"
ENT.Base 			= "tfa_ammo_base"
ENT.PrintName		= "SMG Rounds"
ENT.Category		= "TFA Ammunition"

ENT.Spawnable		= true
ENT.AdminSpawnable	= true

ENT.Class=""
ENT.MyModel = "models/Items/BoxSRounds.mdl"
ENT.ImpactSound = "Default.ImpactSoft"
ENT.AmmoCount = 100
ENT.AmmoType = "smg1"
ENT.DrawText = true
ENT.TextColor = Color(255, 255, 255, 255)
ENT.TextPosition = Vector( 2, 1.5, 11.6)
ENT.TextAngles = Vector(90, 90 , 90)
ENT.ShouldDrawShadow = true
ENT.ImpactSound = "Default.ImpactSoft"
ENT.Damage = 20
ENT.Text = "SMG Rounds"