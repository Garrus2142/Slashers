SWEP.PrintName			= "Nerd Detector"
SWEP.Base               = "weapon_base"
SWEP.Slot				= 3
SWEP.SlotPos			= 5
SWEP.Category = "Slashers"
SWEP.Author	= "Garrus2142"
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.Instructions = ""
SWEP.HoldType = "slam"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.UseHands = false
SWEP.ViewModel = "models/kali/miscstuff/stalker/detector_veles.mdl"
SWEP.WorldModel = "models/kali/miscstuff/stalker/detector_veles.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true
SWEP.Spawnable	= true
SWEP.AdminSpawnable	= true
//SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false

SWEP.Primary.Delay				= 0
SWEP.Primary.Recoil				= 0
SWEP.Primary.Damage				= 0
SWEP.Primary.NumShots			= 0
SWEP.Primary.Cone				= 0
SWEP.Primary.ClipSize			= 0
SWEP.Primary.DefaultClip		= 0
SWEP.Primary.Automatic   		= false
SWEP.Primary.Ammo         		= "pistol"
SWEP.Secondary.Delay			= 0
SWEP.Secondary.Recoil			= 0
SWEP.Secondary.Damage			= 0
SWEP.Secondary.NumShots			= 0
SWEP.Secondary.Cone		  		= 0
SWEP.Secondary.ClipSize			= -1
SWEP.Secondary.DefaultClip		= -1
SWEP.Secondary.Automatic   		= false
SWEP.Secondary.Ammo         	= "none"

SWEP.ViewModelBoneMods = {
	["Root"] = { scale = Vector(1, 1, 1), pos = Vector(8, 0, -4), angle = Angle(40, 0, 0) }
}

SWEP.Offset = {
    Pos = {
        Up = 1.5,
        Right = -1.5,
        Forward = 2,
    },
    Ang = {
        Up = 0,
        Right = 30,
        Forward = 0,
    }
}

function SWEP:Initialize()
    self.nextPing = 0
    self.startPing = false
    self.drawPingY = 0
    self.startEcho = -1
    self.echos = {}
    self:SetHoldType(self.HoldType)
    if CLIENT then
        self.ViewModelBoneMods = table.FullCopy( self.ViewModelBoneMods )
        // init view model bone build function
		if IsValid(self.Owner) then
			local vm = self.Owner:GetViewModel()
			if IsValid(vm) then
				self:ResetBonePositions(vm)

				// Init viewmodel visibility
				if (self.ShowViewModel == nil or self.ShowViewModel) then
					vm:SetColor(Color(255,255,255,255))
				else
					// we set the alpha to 1 instead of 0 because else ViewModelDrawn stops being called
					vm:SetColor(Color(255,255,255,1))
					// ^ stopped working in GMod 13 because you have to do Entity:SetRenderMode(1) for translucency to kick in
					// however for some reason the view model resets to render mode 0 every frame so we just apply a debug material to prevent it from drawing
					vm:SetMaterial("Debug/hsv")
				end
			end
		end
    end
end

function SWEP:Equip()
    if SERVER then
        self.Owner:GetViewModel():SetSkin(1)
    end
end

function SWEP:PrimaryAttack()
end
function SWEP:SecondaryAttack()
end

if CLIENT then
    function SWEP:Ping()
        surface.PlaySound("slashers/effects/detector_ping.wav")
        self.startPing = true
        self.startEcho = CurTime() + 0.2
        self.drawPingY = 0
    end

    function SWEP:Echo()
        local found = false
        self.echos = {}
        for _, v in ipairs(player.GetAll()) do
        	if !v:Alive() then continue end
            local ang = LocalPlayer():GetAngles();
            local pos = LocalPlayer():GetPos() - v:GetPos();
            pos:Rotate(Angle(0, -1*ang.Yaw, 0));
            local x1 = 159 + pos.y/6.9;
            local y1 = 219 + 0.15*pos.x;
            local dist = v:GetPos():Distance(LocalPlayer():GetPos())

            if dist < 1000 && math.abs(pos.z) < 125 && x1 >= 16 && x1 <= 304 && y1 >= 71 && y1 <= 216 then
                found = true
                table.insert(self.echos, {x1, y1, 255})
            end
        end
        if found then
            surface.PlaySound("slashers/effects/detector_echo.wav")
        end
    end

    function SWEP:Think()
        local curTime = CurTime()

        if self.nextPing < curTime then
            self:Ping()
            self.nextPing = curTime + 1.5
        end
        if self.startEcho > -1 && self.startEcho < curTime then
            self:Echo()
            self.startEcho = -1
        end
    end

    local mat = Material("icons/detector_echo.png")
    function SWEP:ViewModelDrawn(vm)
        self:UpdateBonePositions(vm)

        local pos, ang = vm:GetBonePosition(vm:LookupBone("Root"))
        pos = pos + ang:Up() * -3.1 + ang:Forward() * -1.02 + ang:Right() * 1.6
        ang:RotateAroundAxis(ang:Up(), 180)
        ang:RotateAroundAxis(ang:Forward(), 270)
        ang:RotateAroundAxis(ang:Right(), 270)
        cam.Start3D2D(pos, ang, 0.01)
            // Canvas: width(325) height(246)

            // Draw Ping
            if self.startPing then
                for i = 0, 10 do
                    surface.SetDrawColor(Color(0, 200, 0, 10 + (5 * i)))
                    surface.DrawLine(0, 246 - (i + self.drawPingY), 325, 246 - (i + self.drawPingY))
                end
                self.drawPingY = self.drawPingY + (FrameTime() * 700)
                if self.drawPingY > 256 then
                    self.startPing = false
                end
            end

            // Draw echo
            surface.SetMaterial(mat)
            for k, v in ipairs(self.echos) do
                surface.SetDrawColor(0, 255, 0, v[3])
                surface.DrawTexturedRect(v[1] - 8, v[2] - 8, 16, 16)
                self.echos[k][3] = math.max(0, v[3] - (FrameTime() * 170))
            end
        cam.End3D2D()
    end

    function SWEP:DrawWorldModel()
        local hand, offset

        if !IsValid(self.Owner) then
            self:DrawModel()
            return
        end

        if !self.hand then
            self.hand = self.Owner:LookupAttachment("anim_attachment_rh")
        end

        hand = self.Owner:GetAttachment( self.hand )

        if !hand then
            self:DrawModel()
            return
        end

        offset = hand.Ang:Right( ) * self.Offset.Pos.Right + hand.Ang:Forward( ) * self.Offset.Pos.Forward + hand.Ang:Up( ) * self.Offset.Pos.Up

        hand.Ang:RotateAroundAxis( hand.Ang:Right( ), self.Offset.Ang.Right )
        hand.Ang:RotateAroundAxis( hand.Ang:Forward( ), self.Offset.Ang.Forward )
        hand.Ang:RotateAroundAxis( hand.Ang:Up( ), self.Offset.Ang.Up )

        self:SetRenderOrigin( hand.Pos + offset )
        self:SetRenderAngles( hand.Ang )

        self:DrawModel()
    end
end

function SWEP:Holster()

	if CLIENT and IsValid(self.Owner) then
		local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
			self:ResetBonePositions(vm)
		end
	end

	return true
end

function SWEP:OnRemove()
	self:Holster()
end

if CLIENT then
	local allbones
	local hasGarryFixedBoneScalingYet = false

	function SWEP:UpdateBonePositions(vm)

		if self.ViewModelBoneMods then

			if (!vm:GetBoneCount()) then return end

			// !! WORKAROUND !! //
			// We need to check all model names :/
			local loopthrough = self.ViewModelBoneMods
			if (!hasGarryFixedBoneScalingYet) then
				allbones = {}
				for i=0, vm:GetBoneCount() do
					local bonename = vm:GetBoneName(i)
					if (self.ViewModelBoneMods[bonename]) then
						allbones[bonename] = self.ViewModelBoneMods[bonename]
					else
						allbones[bonename] = {
							scale = Vector(1,1,1),
							pos = Vector(0,0,0),
							angle = Angle(0,0,0)
						}
					end
				end

				loopthrough = allbones
			end
			// !! ----------- !! //

			for k, v in pairs( loopthrough ) do
				local bone = vm:LookupBone(k)
				if (!bone) then continue end

				// !! WORKAROUND !! //
				local s = Vector(v.scale.x,v.scale.y,v.scale.z)
				local p = Vector(v.pos.x,v.pos.y,v.pos.z)
				local ms = Vector(1,1,1)
				if (!hasGarryFixedBoneScalingYet) then
					local cur = vm:GetBoneParent(bone)
					while(cur >= 0) do
						local pscale = loopthrough[vm:GetBoneName(cur)].scale
						ms = ms * pscale
						cur = vm:GetBoneParent(cur)
					end
				end

				s = s * ms
				// !! ----------- !! //

				if vm:GetManipulateBoneScale(bone) != s then
					vm:ManipulateBoneScale( bone, s )
				end
				if vm:GetManipulateBoneAngles(bone) != v.angle then
					vm:ManipulateBoneAngles( bone, v.angle )
				end
				if vm:GetManipulateBonePosition(bone) != p then
					vm:ManipulateBonePosition( bone, p )
				end
			end
		else
			self:ResetBonePositions(vm)
		end

	end

	function SWEP:ResetBonePositions(vm)

		if (!vm:GetBoneCount()) then return end
		for i=0, vm:GetBoneCount() do
			vm:ManipulateBoneScale( i, Vector(1, 1, 1) )
			vm:ManipulateBoneAngles( i, Angle(0, 0, 0) )
			vm:ManipulateBonePosition( i, Vector(0, 0, 0) )
		end

	end

	/**************************
		Global utility code
	**************************/

	// Fully copies the table, meaning all tables inside this table are copied too and so on (normal table.Copy copies only their reference).
	// Does not copy entities of course, only copies their reference.
	// WARNING: do not use on tables that contain themselves somewhere down the line or you'll get an infinite loop
	function table.FullCopy( tab )

		if (!tab) then return nil end

		local res = {}
		for k, v in pairs( tab ) do
			if (type(v) == "table") then
				res[k] = table.FullCopy(v) // recursion ho!
			elseif (type(v) == "Vector") then
				res[k] = Vector(v.x, v.y, v.z)
			elseif (type(v) == "Angle") then
				res[k] = Angle(v.p, v.y, v.r)
			else
				res[k] = v
			end
		end

		return res

	end

end
