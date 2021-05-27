-- @author: Garrus2142
-- @Date: 2017-08-01 16:53:54
-- @last Modified by: Daryl_Winters
-- @last Modified time: 2017-08-06T16:17:17+02:00

local LANG = {}

-- Core Gamemode
-- Survivors
LANG["class_desc_sports"] = "Você possui muito vigor e também é forte. Use armas para atordoar o assassino e ajudar os sobreviventes à fugirem."
LANG["class_desc_popular"] = "Você é notificada com a posição exata da Polícia no fim de cada rodada. Use-o para ajudar os sobreviventes à fugirem"
LANG["class_desc_nerd"] = "Use o seu detector para ver jogadores próximos. Cuidado, não há diferença entre os sobreviventes e o assassino"
LANG["class_desc_fat"] = "Você é o mais forte e o mais difícil de morrer, mas possui vigor baixo."
LANG["class_desc_shy"] = "Você é imune á habilidade primária do assassino, porém é fraca. Cuidado, o assassino poderá querer te matar primeiro."
LANG["class_desc_junky"] = "Você possui uma visão melhor. Use em vez da lanterna para ter mais furtividade."
LANG["class_desc_emo"] = "Você é imune à habilidade secundária do assassino. Fique sozinha quanto se esconde para uma chance maior de sobreviver."
LANG["class_desc_black"] = "Você possui 3 chaves, use-as para trancar portas e manter os sobreviventes seguros. Você pode destrancar portas para recuperar as chaves."
LANG["class_desc_sherif"] = "Você possui um revólver. Use-o para atordoar o assassino e permitir que os sobreviventes fujam. Você não pode matar o assassino"
-- Killers
LANG["class_desc_jason"] = "Você é o assassino mais rápido e possui a habilidade de ver pegadas deixadas pelos sobreviventes. Escute bem, pois você pode ouvir a batida do coração dos sobreviventes."
LANG["class_desc_ghostface"] = "Você possui a habilidade de ver quando um sobrevivente fecha ou abre uma porta, use-a para achar-los rapidamente. Escute bem, pois você pode ouvir a batida do coração dos sobreviventes."
LANG["class_desc_myers"] = "Você é o assassino mais lento e possui a habilidade de focar um sobrevivente por vez. Use-a para assustar sobreviventes e matá-los rapidamente. Escute bem, pois você pode ouvir a batida do coração dos sobreviventes."
LANG["class_desc_proxy"] = "Você possui a habilidade de aparecer e desaparecer quando não estiver visível a um sobrevivente. Use-a para assusstar suas vítimas. Pressione o botão menu ('A' como principal) para usar-lá. Escute bem, pois você pode ouvir a batida do coração dos sobreviventes."
LANG["class_desc_intruder"] = "Você tem a habilidade de colocar armadilhas para matar sobreviventes. Use suas cordas de alerta para localizar sobreviventes, suas armadilhas de urso para neutralizar-los e o machado de porta para uma morte surpresa. Escute bem, pois você pode ouvir a batida do coração dos sobreviventes."

LANG["round_mission_police"] = "A polícia chegará em %s"
LANG["round_mission_police_killer"] = "Mate todos eles %s"
LANG["round_mission_escape"] = "Escape %s"
LANG["round_mission_escape_killer"] = "Não os deixe ir %s"
LANG["round_mission_objectives"] = "Complete os objetivos %s"
LANG["round_mission_objectives_killer"] = "Mate todos eles %s"
LANG["round_mission_jerrycan"] = "Ache %i galão(ões)de gasolina"
LANG["round_mission_jerrycan_found"] = "Você achou um galão de gasolina !"
LANG["round_mission_generator"] = "Ache e ative o gerador !"
LANG["round_mission_radio"] = "Ache e ative o rádio !"
LANG["round_wait_players"] = "Procurando por jogadores %i/%i"
LANG["round_team_name_survivor"] = "um Sobrevivente"
LANG["round_team_name_killer"] = "o Assassino"
LANG["round_team_desc_survivor"] = "Cada sobrevivente tem uma habilidade especial. Seu objetivo é achar galões de gasolina (número varia do número de jogadores) para encher o gerador, depois ativar o rádio e chamar a polícia por ajuda. Cada elemento que você tiver que achar posssui vários pontos de spawn e surgem aleatóriamente no mapa. O trabalho em equipe e um uso moderado de sua lanterna são a chave para a sobrevivência."
LANG["round_team_desc_killer"] = "Você é um assassino de um filme slasher e é imortal. Seu objetivo é matar cada sobrevivente antes que escapem. Você é recebido com uma das seguintes armas ; o machado ; o facão ou a motoserra (que liga ao pressionar R) Para dar um ataque forte, segure o botão esquerdo do mouse e soltar. Você pode ouvir a batida do coração dos sobreviventes quando eles não estão se movendo, apenas siga o som e você irá os encontrar."
LANG["round_notif_police_call"] = "Você chamou a polícia !"
LANG["round_notif_police"] = "Sobreviva até a chegada da polícia !"
LANG["round_notif_escape"] = "Escape"
LANG["round_notif_escape_killer"] = "Não os deixe ir"
LANG["round_notif_error_radio"] = "Você não pode ativar o rádio !"
LANG["round_notif_error_generator"] = "Você não pode ativar o gerador !"
LANG["round_notif_enabled_generator"] = "Você ativou o gerador !"
LANG["round_notif_player_die"] = "%s está morto"
LANG["round_end_escaped"] = "Os sobreviventes escaparam... por enquanto"
LANG["round_end_dead"] = "Os sobreviventes foram erradicados"

-- Modules
LANG["antiafk_will_kicked"] = "Você será kickado do servidor por inatividade em %s"
LANG["f1menu_you_are"] = "Você é o/a %s"
LANG["workshop_need_content"] = "Você precisará de conteúdo extra do Steam Workshop"
LANG["workshop_get_it"] = "Me leve até ele!"
LANG["workshop_no"] = "Não quero."
LANG["traps_rope_hit_world"] = "A corda está longe"
LANG["traps_too_much_distance"] = "Muita distância"
LANG["killerhelp_cant_use_ability"] = "Você não pode usar a habilidade agora"
LANG["votemap_title"] = "Vote para o próximo mapa !"
LANG["votemap_extend"] = "De novo"
LANG["votemap_random"] = "Aleatório"
return LANG
