-- Utopia Games - Slashers
--
-- @Author: Guilhem PECH <Daryl_Winters>
-- @Date:   2017-08-02T17:49:23+02:00
-- @Last modified by:   Guilhem PECH
-- @Last modified time: 05-Jan-2018

local LANG = {}

-- 	Core Gamemode
-- 		Survivors
LANG["class_desc_sports"] = "Vous avez une très bonne endurance est êtes l'un des plus rapides du groupe. Faites en bon escient pour tenir le tueur à distance !"
LANG["class_desc_popular"] = "Vous êtes notifié de la position exacte de la Police à la fin de la partie. Utilisez cette aide pour faire gagner votre équipe !"
LANG["class_desc_nerd"] = "Utilisez votre détecteur pour voir les formes de vies aux alentours. Mais attention, le détecteur ne fait pas la différence entre tueur et survivant ..."
LANG["class_desc_fat"] = "Vous êtes la personne la plus forte du groupe mais ... vous avez moins de stamina."
LANG["class_desc_shy"] = "Vous êtes immunisée contre l'aide primaire du tueur. Faites attention à vous, vous êtes sa cible privilégiée"
LANG["class_desc_junky"] = "Vous avez une meilleure vision. Utilisez votre capacité au lieu de la lampe pour rester discret."
LANG["class_desc_emo"] = "Vous êtes immunisée contre l'aide secondaire du tueur. Restez seule quand vous vous cachez pour une meilleure chance de survie ..."
LANG["class_desc_black"] = "Vous avez 3 clefs, utilisez les pour fermer des portes et garder les survivants à l'abris. Vous pouvez récuppérer vos clefs en réouvrant les portes."
LANG["class_desc_sherif"] = "Vous avez un révolver. Utilisez le pour paralyser le tueur et permettre aux autres de s'enfuir. Vous ne pouves pas tuer le tueur !"
--		Killers
LANG["class_desc_jason"] = "Vous êtes le tueur le plus rapide et vous avez la capacité de voir les empreintes de pas que les survivants laissent. Ecoutez bien, vous pouvez peut être entendre le coeur des survivants battre."
LANG["class_desc_ghostface"] = "Vous avez la capaciter de voir quand un survivant ouvre une porte, utilisez la pour les trouver rapidement. Pensez à refermer les portes derrière vous pour forcer les survivants à les réouvrirs. Ecoutez bien, vous pouvez peut être entendre le coeur des survivants battre."
LANG["class_desc_myers"] = "Vous êtes le tueur le plus lent et vous avez la capacité de voir un survivant en permanence. Utilisez la intelligemment pour surprendre vos victimes. Ecoutez bien, vous pouvez peut être entendre le coeur des survivants battre."
LANG["class_desc_proxy"] = "Vous avez la capacité de disparaitre ou de réaparaitre quand vous êtes hors du chap de vision d'un survivant. Utilisez la pour surprendre vos victimes ! Appuyez sur votre menu des objets ('A' par défaut) pour l'utiliser. Ecoutez bien, vous pouvez peut être entendre le coeur des survivants battre."
LANG["class_desc_intruder"] = "Vous avez la capacité de placer des pièges pour vous aider dans vos meurtre. Utilisez l'Alert Rope pour repérer vos victimes, les Bear Trap pour les ralentir ou la Door Trap pour les tuer. Ecoutez bien, vous pouvez peut être entendre le coeur des survivants battre."
LANG["class_desc_bates"] = "Utilisez le corps de votre défunte mère pour vous aidez à localiser les survivants. Plus un survivant est proche du corps, plus vous vous déplacerez rapidement mais attention, si quelqu'un le découvre, la police sera immédiatement appelée. Ecoutez bien, vous pouvez peut être entendre le coeur des survivants battre."

LANG["round_mission_police"] = "La Police arrive dans %s"
LANG["round_mission_police_killer"] = "Tuez les tous %s"
LANG["round_mission_escape"] = "Fuyez %s"
LANG["round_mission_escape_killer"] = "Ne les laissez pas s'enfuir %s"
LANG["round_mission_objectives"] = "Complétez les objectifs %s"
LANG["round_mission_objectives_killer"] = "Tuez les tous %s"
LANG["round_mission_jerrycan"] = "Trouvez %i jerrycan(s)"
LANG["round_mission_jerrycan_found"] = "Vous avez trouvé un jerrycan !"
LANG["round_mission_generator"] = "Trouvez et activez le générateur !"
LANG["round_mission_radio"] = "Trouvez et activez la radio!"
LANG["round_wait_players"] = "Attente de joueurs %i/%i"
LANG["round_team_name_survivor"] = "un Survivant"
LANG["round_team_name_killer"] = "le Tueur"
LANG["round_team_desc_survivor"] = "Tous les survivants ont une capacité propre. Votre but est de touver des jerrycans (le nombre varie en fonction du nombre de joueurs) pour remplir et allumer le générateur de manière à activer la radio et appeler la police. Chaque éléments que vous devez trouver a de nombreux points d'apparitions aléatoire.Le jeu d'équipe et l'utilisation modéré de la lampe-torche sont la clef de la survie !"
LANG["round_team_desc_killer"] = "Vous êtes le tueur d'un Slasher movie. Votre but est de tuer tous les survivants avant qu'ils s'enfuient. On vous donne une arme aléatoire parmis cette liste : une hache, une machete ou une tronconneuse (vous pouvez l'allumer en appuyant sur R) Pour un coup plus puissant enfoncer le clique gauche et relachez. Vous pouvez entendre le coeur battre des survivants qui ne bougent pas, suivez le son pour les trouver."
LANG["round_notif_police_call"] = "vous avez appelé la police !"
LANG["round_notif_police"] = "Survivez en attendant la police !"
LANG["round_notif_escape"] = "Echapez-vous !"
LANG["round_notif_escape_killer"] = "Ne les laissez pas s'enfuir !"
LANG["round_notif_error_radio"] = "Vous ne pouvez pas activer la radio !"
LANG["round_notif_error_generator"] = "Vous ne pouvez pas activer le générateur !"
LANG["round_notif_enabled_generator"] = "Vous avez activez le générateur!"
LANG["round_notif_player_die"] = "%s est mort"
LANG["round_end_escaped"] = "Les survivants se sont enfuis... pour l'instant"
LANG["round_end_dead"] = "Les survivants se sont fait massacrer"

-- Modules
LANG["antiafk_will_kicked"] = "Vous êtes sur le point d'être expulsé du serveur pour inactivité dans %s"
LANG["f1menu_you_are"] = "Vous êtes %s"
LANG["workshop_need_content"] = "Vous pouvez avoir besoin de contenu supplémentaire du Workshop Steam"
LANG["workshop_get_it"] = "Bien !"
LANG["workshop_no"] = "Je ne préfère pas"
LANG["traps_rope_hit_world"] = "La corde touche le sol"
LANG["traps_too_much_distance"] = "Trop loin"
LANG["killerhelp_cant_use_ability"] = "Vous ne pouvez pas utiliser votre capacité maintenant"
LANG["votemap_title"] = "Votez pour la map suivante !"
LANG["votemap_extend"] = "Prolonger"
LANG["votemap_random"] = "Aleatoire"

return LANG
