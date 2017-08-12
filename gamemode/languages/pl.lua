-- Utopia Games - Slashers
--
-- @Author: Garrus2142
-- @Date:   2017-08-01 16:53:54
-- @Last Modified by:   danx91
-- @Last Modified time: 2017-08-12 12:27 ( CET )

local LANG = {}

-- 	Core Gamemode
-- 		Survivors
LANG["class_desc_sports"] = "Jesteś silny i masz dobrą kondycję, przez co możesz biegać dłużej. Używaj broni aby ogłuszyć mordercę i pomóc innym w ucieczce."
LANG["class_desc_popular"] = "Jesteś informowana o pozycji policji na końcu każdej rozgrywki. Używaj tej umiejętności aby pomóc innym w ucieczce."
LANG["class_desc_nerd"] = "Używaj wykrywacza, aby zobaczyć graczy w pobliżu, ale uważaj, bo nie dostrzegasz różnicy między mordercą a normalnymi ludźmi."
LANG["class_desc_fat"] = "Jesteś najsilniejszym i najtrudniejszym do zabicia ze wszystkich, ale za to masz słabą kondycję."
LANG["class_desc_shy"] = "Jesteś odporna na główną umiejętność mordercy, a także najsłabsza ze wszystkich. Uważaj, zabójca może próbować zabić ciebie w pierwszej kolejności."
LANG["class_desc_junky"] = "Masz lepszy wzrok od innych. Używaj go zamiast latarki, aby być mniej wykrywalnym."
LANG["class_desc_emo"] = "Jesteś odporna na specjalną umiejętność zbójcy. Trzymaj się z dala od innych aby zwiększyć swoje szanse na przeżycie."
LANG["class_desc_black"] = "Masz 3 klucze, którymi możesz zamknąć drzwi aby ochronić siebie i innych przed mordercą. Możesz odblokować drzwi by odzyskać klucz."
LANG["class_desc_sherif"] = "Masz rewolwer, który spowolni mordercę dając tobie i innym szansę na ucieczkę, ale pamiętaj nie możesz go zabić."
--		Killers
LANG["class_desc_jason"] = "Jesteś najszybszym zabójcą oraz możesz zobaczyć odciski butów pozostawione przez graczy. Słuchaj uważnie - możesz usłyszeć bicie serc ludzi w pobliżu."
LANG["class_desc_ghostface"] = "Masz zdolność, dzięki której możesz zobaczyć jak ktoś otwiera lub zamyka drzwi. Wykorzystaj ją aby szybko wytropić swoje ofiary. Pomyśl o zamykaniu otwartych drzwi, aby zmusić ocalałych do ich ponownego otwarcia. Słuchaj uważnie - możesz usłyszeć bicie serc ludzi w pobliżu."
LANG["class_desc_myers"] = "Jesteś najwolniejszym zabójcą, a także masz zdolność skupienia się na jednym graczu. Używaj jej, aby ich zaskoczyć. Słuchaj uważnie - możesz usłyszeć bicie serc ludzi w pobliżu."
LANG["class_desc_proxy"] = "Masz umiejętność do pojawiania się i znikania, gdy nikt nie widzi. Używaj jej aby zakraść się i zaskoczyć swoje ofiary. Naciśnij przycisk menu ( domyślnie 'Q' ) aby jej użyć. Słuchaj uważnie - możesz usłyszeć bicie serc ludzi w pobliżu."
LANG["class_desc_intruder"] = "Masz możliwość umieszczania pułapek aby zaskoczyć swoje ofiary. Używaj lin aby wykrywać ludzi, pułapek na misie aby ich zneutralizować oraz siekiery, którą możesz zamontować do drzwi, aby zabić ich z zaskoczenia. Słuchaj uważnie - możesz usłyszeć bicie serc ludzi w pobliżu."

LANG["round_mission_police"] = "Policja przybędzie za %s"
LANG["round_mission_police_killer"] = "Zabij ich wszystkich %s"
LANG["round_mission_escape"] = "Ucieknij %s"
LANG["round_mission_escape_killer"] = "Nie pozwól im uciec %s"
LANG["round_mission_objectives"] = "Ukończ zadania %s"
LANG["round_mission_objectives_killer"] = "Zabij ich wszystkich %s"
LANG["round_mission_jerrycan"] = "Kanistry do znalezienia: %i"
LANG["round_mission_jerrycan_found"] = "Znalazłeś kanister!"
LANG["round_mission_generator"] = "Znajdź i uruchom generator!"
LANG["round_mission_radio"] = "Znajź i uruchom radio!"
LANG["round_wait_players"] = "Oczekiwanie na graczy %i/%i"
LANG["round_team_name_survivor"] = "Jesteś uciekającym" --You are a Survivor
LANG["round_team_name_killer"] = "Jesteś zabójcą" --You are the killer
LANG["round_team_desc_survivor"] = "Każdy z uciekających ma specjalną umiejętność. Twoim celem jest znalezienie kanistrów z benzyną (ich liczba zależy od ilości graczy) aby uruchomić generator, dzięki czemu przy użyciu radia, które da możliwość zadzwonienia na policje, zapewnicie sobie drogę ucieczki. Każdy element, który musisz znaleźć ma kilka losowych miejsc w których się pojawi. Gra zespołowa i rzadkie używanie latarki jest kluczem do zwycięstwa."
LANG["round_team_desc_killer"] = "Jesteś zabójcą z filmu Slasher i jesteś nieśmiertelny. Twoim celem jest zabicie wszystkich zanim uciekną. Dostaniesz jedną z losowych broni: siekiera, maczeta lub piła motorowa (którą możesz włączyć klikając R). Aby zadać zwiększone obrażenia, możesz przytrzymać lewy klawisz i go puścić. Możesz usłyszeć bicie serc ludzi kiedy się nie ruszają. Podążaj za dźwiękiem, a napewno ich znajdziesz."
LANG["round_notif_police_call"] = "Skontaktowałeś się z policją!"
LANG["round_notif_police"] = "Przetrwaj do przyjazdu policji!"
LANG["round_notif_escape"] = "Ucieknij"
LANG["round_notif_escape_killer"] = "Nie pozwól im uciec"
LANG["round_notif_error_radio"] = "Nie możesz uruchomić radia!"
LANG["round_notif_error_generator"] = "Nie możesz uruchomić generatora!"
LANG["round_notif_enabled_generator"] = "Uruchomiłeś generator!"
LANG["round_notif_player_die"] = "%s jest martwy"
LANG["round_end_escaped"] = "Ludzie uciekli... narazie"
LANG["round_end_dead"] = "Wszyscy zostali zamordowani"

-- Modules
LANG["antiafk_will_kicked"] = "Zostaniesz wyrzucony z serwera z powodu nieaktywność za %s"
LANG["f1menu_you_are"] = "%s" --I left it empty, because i added 'You are' to killer and survivor. I done that mainly to change 'You are [class]' to just '[class]' because after 'You are' in polish you have to change form of noun( here class name )
LANG["workshop_need_content"] = "Możesz potrzebować dodatkowej zawartości z warsztatu."
LANG["workshop_get_it"] = "Zabierz mnie tam!"
LANG["workshop_no"] = "Nie, dziękuje."
LANG["traps_rope_hit_world"] = "Lina udeżyła w świat"
LANG["traps_too_much_distance"] = "Za duża odległość"
LANG["killerhelp_cant_use_ability"] = "Nie możesz użyć teraz specjalnej umiejętności"
LANG["votemap_title"] = "Zagłosuj na następną mapę"
LANG["votemap_extend"] = "Przedłuż"
LANG["votemap_random"] = "Losowa"
return LANG
