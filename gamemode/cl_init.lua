include("shared.lua")
include("config.lua")
include("core/_includes.lua")

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

LoadModules()