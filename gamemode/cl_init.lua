-- Utopia Games - Slashers
--
-- @Author: Garrus2142
-- @Date:   2017-07-25 16:15:45
-- @Last modified by:   Guilhem PECH
-- @Last modified time: 21-Oct-2018

include("shared.lua")
include("config.lua")
include("core/_includes.lua")
include("modulesloader.lua")

local hide = {
	CHudHealth = true,
	CHudBattery = true,
	CHudAmmo = true,
	//CHudWeaponSelection = true,
}

hook.Add( "HUDShouldDraw", "HideHUD", function( name )
	if ( hide[ name ] ) then return false end

	-- Don't return anything here, it may break other addons that rely on this hook.
end )

-- Enleve le nom des joueurs
function GM:HUDDrawTargetID()

end

function GM:HUDWeaponPickedUp()

end

function GM:HUDAmmoPickedUp()

end

function GM:DrawDeathNotice(x, y)

end
