-- Utopia Games - Slashers
--
-- @Author: Guilhem PECH
-- @Date:   2017-07-26T13:54:42+02:00
-- @Last Modified by:   Guilhem PECH
-- @Last Modified time: 2017-07-26 23:38:33



if SERVER then
    AddCSLuaFile("shared.lua")
    util.AddNetworkString("Close_time")
	util.AddNetworkString("keyLeft")
end

if CLIENT then
    SWEP.PrintName = "Keys"
    SWEP.Slot = 1
    SWEP.SlotPos = 2
    SWEP.DrawAmmo = false
    SWEP.DrawCrosshair = false
end

SWEP.Author = "DarylWinters"
SWEP.Instructions = "Left click to lock / Right click to unlock"
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.WorldModel				=  ""

SWEP.UseHands = true
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.AdminOnly = true
SWEP.Category = "Slashers"
SWEP.Sound = Sound("physics/wood/wood_box_impact_hard3.wav")
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""
SWEP.CloseTime = 1


function SWEP:Initialize()
    self:SetWeaponHoldType("normal")
	self.KeysLeft = 3

end

if CLIENT then
    net.Receive("Close_time", function()
        local wep = net.ReadEntity()
        local time = net.ReadUInt(5)
        wep.IsCloseing = true
        wep.StartPick = CurTime()
        wep.CloseTime = time
        wep.EndPick = CurTime() + time
    end)

end



local LockAction
function SWEP:PrimaryAttack()
	LockAction = true
	self:SetNextPrimaryFire(CurTime() + 2)
    if self.IsCloseing then return end
    local trace = self.Owner:GetEyeTrace()
    local e = trace.Entity
    if self.KeysLeft == 0 then return end
	if not IsValid(e) or trace.HitPos:Distance(self.Owner:GetShootPos()) > 100 or trace.Entity:GetClass() ~= "prop_door_rotating"  then return end

	if e:GetModel() ~= "models/props_doors/doormain_rural01_small.mdl" and e:GetModel() ~= "models/props_doors/doormainmetal01.mdl" then return end

	if trace.Entity:GetNWBool("LockedByUser" , false ) then return end

    if SERVER then
        self.IsCloseing = true
        self.StartPick = CurTime()
        self.CloseTime = 1
        net.Start("Close_time")
        net.WriteEntity(self)
        net.WriteUInt(self.CloseTime, 5)
        net.Send(self.Owner)
        self.EndPick = CurTime() + self.CloseTime
    end

    self:SetWeaponHoldType("pistol")

    if SERVER then
        timer.Create("CloseSounds", 0.1, self.CloseTime, function()
            if not IsValid(self) then return end
            local snd = {1, 3, 4}
            self:EmitSound("weapons/357/357_reload" .. tostring(snd[math.random(1, #snd)]) .. ".wav", 50, 100)
        end)
	end
end

function SWEP:Holster()
    self.IsCloseing = false

    if SERVER then
        timer.Remove("CloseSounds")
    end

    if CLIENT then
        timer.Remove("CloseDots")
    end

    return true
end


function SWEP:AddKeys()
	PlayerEnt = LocalPlayer()
  if GAMEMODE.CLASS.Survivors[PlayerEnt.ClassID].keysNumber >= 3 then return end
  GAMEMODE.CLASS.Survivors[PlayerEnt.ClassID].keysNumber = GAMEMODE.CLASS.Survivors[PlayerEnt.ClassID].keysNumber + 1
end

function SWEP:RemoveKeys()
	PlayerEnt = LocalPlayer()
  if GAMEMODE.CLASS.Survivors[PlayerEnt.ClassID].keysNumber <= 0 then return end
	GAMEMODE.CLASS.Survivors[PlayerEnt.ClassID].keysNumber = GAMEMODE.CLASS.Survivors[PlayerEnt.ClassID].keysNumber - 1



end

function SWEP:Succeed()
    self.IsCloseing = false
    self:SetWeaponHoldType("normal")
    local trace = self.Owner:GetEyeTrace()


    if IsValid(trace.Entity) and trace.Entity.Fire then
        if  LockAction == true then
			trace.Entity:Fire("Lock", "", .1)
			trace.Entity:Fire("setanimation", "Lock", .1)
			trace.Entity:Fire("Close", "", .0)
			trace.Entity:SetNWBool( "LockedByUser", true )

      if self.KeysLeft > 0 then
			     self.KeysLeft = self.KeysLeft - 1
      end
			-- GAMEMODE.CLASS.Survivors[self.Owner:GetNWInt("ClassID")].keysNumber = self.KeysLeft
			self:CallOnClient( "RemoveKeys")
		else
			trace.Entity:Fire("Unlock", "", .0)
			trace.Entity:Fire("setanimation", "Unlock", .0)
			trace.Entity:SetNWBool( "LockedByUser", false )
      if self.KeysLeft < 3 then   
			     self.KeysLeft = self.KeysLeft + 1
      end
			-- GAMEMODE.CLASS.Survivors[self.Owner:GetNWInt("ClassID")].keysNumber = self.KeysLeft
			self:CallOnClient( "AddKeys")

		end
    end

    if SERVER then
        timer.Remove("CloseSounds")
    end

    if CLIENT then
        timer.Remove("CloseDots")
    end
end

function SWEP:Fail()
    self.IsCloseing = false
    self:SetWeaponHoldType("normal")

    if SERVER then
        timer.Remove("CloseSounds")
    end

    if CLIENT then
        timer.Remove("CloseDots")
    end
end

function SWEP:Think()

	if self.IsCloseing and self.EndPick then
        local trace = self.Owner:GetEyeTrace()

        if not IsValid(trace.Entity) then
            self:Fail()
        end

        if trace.HitPos:Distance(self.Owner:GetShootPos()) > 100 or trace.Entity:GetClass() ~= "prop_door_rotating"  then
            self:Fail()
        end

        if self.EndPick <= CurTime() then

			self:Succeed()
        end
    end
end

function SWEP:DrawHUD()
    if self.IsCloseing and self.EndPick then
        local w = ScrW()
        local h = ScrH()
        local x, y, width, height = w / 2 - w / 10, h / 1.15, w / 5, h / 35
        draw.RoundedBox(8, x, y, width, height, Color(10, 10, 10, 120))
        local time = self.EndPick - self.StartPick
        local curtime = CurTime() - self.StartPick
        local status = math.Clamp(curtime / time, 0, 1)
        local BarWidth = status * (width - 16)
        local cornerRadius = math.Min(8, BarWidth / 3 * 2 - BarWidth / 3 * 2 % 2)
        draw.RoundedBox(cornerRadius, x + 8, y + 8, BarWidth, height - 16, Color(255 - (status * 255), 0 + (status * 255), 0, 255))

    end
end

function SWEP:PreDrawViewModel()
    return true
end

function SWEP:SecondaryAttack()
    LockAction = false
	self:SetNextPrimaryFire(CurTime() + 2)
    if self.IsCloseing then return end
    local trace = self.Owner:GetEyeTrace()
    local e = trace.Entity
	if e:GetModel() ~= "models/props_doors/doormain_rural01_small.mdl" and e:GetModel() ~= "models/props_doors/doormainmetal01.mdl" then return end
    if not IsValid(e) or trace.HitPos:Distance(self.Owner:GetShootPos()) > 100 or trace.Entity:GetClass() ~= "prop_door_rotating"  then return end
    if not trace.Entity:GetNWBool("LockedByUser" , false )then
		if self.KeysLeft >= 3 then
			self:PrimaryAttack()
		else
			return
		end
	end

    if SERVER then
        self.IsCloseing = true
        self.StartPick = CurTime()
        self.CloseTime = 1
        net.Start("Close_time")
        net.WriteEntity(self)
        net.WriteUInt(self.CloseTime, 5)
        net.Send(self.Owner)
        self.EndPick = CurTime() + self.CloseTime

	end

    self:SetWeaponHoldType("pistol")

    if SERVER then
        timer.Create("CloseSounds", 0.1, self.CloseTime, function()
            if not IsValid(self) then return end
            local snd = {1, 3, 4}
            self:EmitSound("weapons/357/357_reload" .. tostring(snd[math.random(1, #snd)]) .. ".wav", 50, 100)
        end)
	end
end
