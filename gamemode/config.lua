-- Utopia Games - Slashers
--
-- @Author: Garrus2142
-- @Date:   2017-07-25 16:15:45
-- @Last Modified by:   Daryl_Winters
-- @Last Modified time: 2017-08-06T15:27:08+02:00

local GM = GM or GAMEMODE
GM.CONFIG = {}

GM.CONFIG["lang_default"] = "en"

GM.CONFIG["disabled_modules"] = {
	-- ["goal"] = true, -- set true to disable module
}

-- Classe du tueur
GM.CONFIG["killer_class_map"] = {
	["slash_highschool"] = CLASS_KILL_GHOSTFACE,
	["slash_summercamp"] = CLASS_KILL_JASON,
	["slash_selvage"] = CLASS_KILL_MYERS,
	["slash_subway"] = CLASS_KILL_PROXY,
	["slash_lodge"] = CLASS_KILL_INTRUDER
}
-- Musique course poursuite
GM.CONFIG["chase_musics"] = {
	["slash_highschool"] = "slashers/ambient/chase_ghostface.wav",
	["slash_summercamp"] = "slashers/ambient/chase_jason.wav",
	["slash_selvage"] = "slashers/ambient/chase_myers.wav",
	["slash_subway"] = "slashers/ambient/chase_proxy.wav",
	["slash_lodge"] = "slashers/ambient/chase_intruder.wav"
}
-- Armes pour le tueur
GM.CONFIG["killer_weapons"] = {
	"tfa_nmrih_chainsaw",
	-- "tfa_nmrih_kknife",
	"tfa_nmrih_fireaxe",
	"tfa_nmrih_machete"
}
-- Armes pour les survivants
GM.CONFIG["survivors_weapons"] = {
	"weapon_flashlight"
}
-- Points ajoutés de choosekiller ajoutés à chaque manche terminée
GM.CONFIG["round_choosekiller_add"] = 10
-- Joueurs néscessaire pour démarrer une manche
GM.CONFIG["round_min_player"] = 3
-- Temps avant de démarrer une manche (secondes)
GM.CONFIG["round_timer_start"] = 10
-- Temps de démarrage de la manche (secondes)
GM.CONFIG["round_freeze_start"] = 10
-- Durée initiale de la manche (secondes)
GM.CONFIG["round_duration_base"] = 67.5
-- Durée ajouté par survivant (secondes)
GM.CONFIG["round_duration_add"] = 52.5
-- Durée ajouté par objectifs atteints
GM.CONFIG["round_duration_add_obj"] = 120
-- Durée d'attente lors d'une fin de manche
GM.CONFIG["round_duration_end"] = 30
-- Nombre de manche avant de changer de carte
GM.CONFIG["round_count_nextmap"] = 5
-- Musique de start
GM.CONFIG["round_start_music"] = {
	["slash_highschool"] = "slashers_start_game_ghostface.wav",
	["slash_summercamp"] = "slashers_start_game_jason.wav",
	["slash_selvage"] = "slashers_start_game_myers.wav",
	["slash_subway"] = "slashers_start_game_proxy.wav",
	["slash_lodge"] = "slasher_start_game_intruder.wav"
}

-- Durée d'attente avant l'arrivée de la police base
GM.CONFIG["round_duration_waitingpolice_base"] = 32.5
-- Durée ajouté par survivant pour l'arrivée de la police (secondes)
GM.CONFIG["round_duration_waitingpolice_add"] = 22.5

-- Durée de la manche évacuation (secondes)
GM.CONFIG["round_duration_escape"] = {
	["slash_highschool"] = 60,
	["slash_summercamp"] = 90,
	["slash_subway"] = 90,
	["slash_selvage"] = 60,
	["slash_lodge"] = 60
}
-- Entités Killerhelp porte
GM.CONFIG["killerhelp_door_entities"] = {
	"prop_door_rotating",
	"func_door_rotating"
}
-- Entités sorties
GM.CONFIG["killerhelp_exit_entities"] = {
	"brush_car_1",
	"brush_car_2",
	"door_exit_1",
	"door_exit_2",
	"door_exit_3",
	"door_exit_4"
}
-- Durée icones porte
GM.CONFIG["killerhelp_door_duration"] = 3
-- Durée trace de pas
GM.CONFIG["killerhelp_step_duration"] = 30

-- Custom added maps
GM.CONFIG["custom_maps"] = {
	-- "gm_construct.bsp",
	-- "gm_flatgrass.bsp"
}
