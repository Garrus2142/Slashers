if SERVER then
	AddCSLuaFile()
end

ENT.Type 			= "anim"
ENT.Base 			= "tfa_ammo_base"
ENT.PrintName		= "Buckshot"
ENT.Category		= "TFA Ammunition"

ENT.Spawnable		= true
ENT.AdminSpawnable	= true

ENT.Class=""
ENT.MyModel = "models/Items/BoxBuckshot.mdl"
ENT.ImpactSound = "Default.ImpactSoft"
ENT.AmmoCount = 20
ENT.AmmoType = "buckshot"
ENT.DrawText = true
ENT.TextColor = Color(225, 225, 225, 255)
ENT.TextPosition = Vector( 2, 3.54, 3)
ENT.TextAngles = Vector(0, 90 , 90)
ENT.ShouldDrawShadow = true
ENT.ImpactSound = "Default.ImpactSoft"
ENT.Damage = 40
ENT.Text = "Buckshot"