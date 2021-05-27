-- @Author: Guilhem PECH <Daryl_Winters>
-- @Date:   2018-01-09 10:40:07
-- @Email:  guilhempech@gmail.com
-- @Project: Slashers
-- @Last modified by:   Guilhem PECH
-- @Last modified time: 2018-01-11 17:03:44

AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")
SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

local GM = GAMEMODE
function SWEP:Equip(NewOwner)
  NewOwner:GiveAmmo(1, "ammo_batesmum", true)
end

function SWEP:PrimaryAttack()
  if self:Ammo1() <= 0 then
    self:SecondaryAttack()
    return
  end

  local ent = ents.Create("sls_motherbates")
  local batesmum_pos, batesmum_angle = slashers_batesmum_place(self.Owner, ent)
  local tracedata = {}
  tracedata.start = Vector(self.Owner:GetEyeTrace().HitPos)
  tracedata.endpos = Vector(self.Owner:GetEyeTrace().HitPos)
  tracedata.endpos.z = tracedata.endpos.z - 5
  if self.Owner:GetPos():Distance(self.Owner:GetEyeTrace().HitPos) > self.MaxDistance or not util.TraceLine(tracedata).HitWorld or (batesmum_angle.pitch % 360) > 45 then
    ent:Remove()
    return
  end

  ent:Spawn()
  cleanup.Add(self.Owner, "props", ent)
  undo.Create("sls_motherbates")
  undo.AddEntity(ent)
  undo.SetPlayer(self.Owner)
  undo.Finish()
  self.Owner:SetAmmo(self:Ammo1() - 1, "ammo_batesmum")
end

function SWEP:Reload()
end

function SWEP:SecondaryAttack()  
  local trace = self.Owner:GetEyeTrace()
  if self.Owner:GetPos():Distance(trace.HitPos) < self.MaxDistance  and trace.Entity:GetClass() == "sls_motherbates" then
    trace.Entity:Remove()
    if (GM.MAP) then
      self.Owner:SetWalkSpeed(GM.MAP.Killer.WalkSpeed)
      self.Owner:SetRunSpeed(GM.MAP.Killer.WalkSpeed)
    end
    self.Owner:GiveAmmo(1, "ammo_batesmum", true)
  end
end
