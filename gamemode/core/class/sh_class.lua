local GM = GM or GAMEMODE

GM.CLASS = {}
GM.CLASS.Survivors = {}
GM.CLASS.Killers = {}

GM.CLASS.Survivors[CLASS_SURV_SPORTS] = {}
GM.CLASS.Survivors[CLASS_SURV_SPORTS].name = "Sports"
GM.CLASS.Survivors[CLASS_SURV_SPORTS].dispname = "Trent"
GM.CLASS.Survivors[CLASS_SURV_SPORTS].description = "You have unlimited stamina and you're strong. Use weapons to stun the killer and helping the survivors running away."
GM.CLASS.Survivors[CLASS_SURV_SPORTS].walkspeed = 150
GM.CLASS.Survivors[CLASS_SURV_SPORTS].runspeed = 240
GM.CLASS.Survivors[CLASS_SURV_SPORTS].life = 120
GM.CLASS.Survivors[CLASS_SURV_SPORTS].stamina = 0
GM.CLASS.Survivors[CLASS_SURV_SPORTS].model = "models/steinman/slashers/sport_pm.mdl"
GM.CLASS.Survivors[CLASS_SURV_SPORTS].icon = Material("icons/icon_sportif.png")
GM.CLASS.Survivors[CLASS_SURV_SPORTS].die_sound = "slashers/effects/scream_man_1.wav"
GM.CLASS.Survivors[CLASS_SURV_SPORTS].weapons = {}

GM.CLASS.Survivors[CLASS_SURV_POPULAR] = {}
GM.CLASS.Survivors[CLASS_SURV_POPULAR].name = "Popular girl"
GM.CLASS.Survivors[CLASS_SURV_POPULAR].dispname = "Lynda"
GM.CLASS.Survivors[CLASS_SURV_POPULAR].description = "You're notified of the exact position of the Police at the end of each game. Use it to help the survivors escaping."
GM.CLASS.Survivors[CLASS_SURV_POPULAR].walkspeed = 160
GM.CLASS.Survivors[CLASS_SURV_POPULAR].runspeed = 240
GM.CLASS.Survivors[CLASS_SURV_POPULAR].life = 80
GM.CLASS.Survivors[CLASS_SURV_POPULAR].stamina = 120
GM.CLASS.Survivors[CLASS_SURV_POPULAR].model = "models/steinman/slashers/popular_pm.mdl"
GM.CLASS.Survivors[CLASS_SURV_POPULAR].icon = Material("icons/icon_popular.png")
GM.CLASS.Survivors[CLASS_SURV_POPULAR].die_sound = "slashers/effects/scream_girl_1.wav"
GM.CLASS.Survivors[CLASS_SURV_POPULAR].weapons = {}

GM.CLASS.Survivors[CLASS_SURV_NERD] = {}
GM.CLASS.Survivors[CLASS_SURV_NERD].name = "Nerd"
GM.CLASS.Survivors[CLASS_SURV_NERD].dispname = "Noah"
GM.CLASS.Survivors[CLASS_SURV_NERD].description = "Use your detector to see players nearby. Be careful, you can't make difference between survivors and the killer."
GM.CLASS.Survivors[CLASS_SURV_NERD].walkspeed = 130
GM.CLASS.Survivors[CLASS_SURV_NERD].runspeed = 240
GM.CLASS.Survivors[CLASS_SURV_NERD].life = 100
GM.CLASS.Survivors[CLASS_SURV_NERD].stamina = 110
GM.CLASS.Survivors[CLASS_SURV_NERD].model = "models/steinman/slashers/nerd_pm.mdl"
GM.CLASS.Survivors[CLASS_SURV_NERD].icon = Material("icons/icon_nerd.png")
GM.CLASS.Survivors[CLASS_SURV_NERD].die_sound = "slashers/effects/scream_man_1.wav"
GM.CLASS.Survivors[CLASS_SURV_NERD].weapons = {"tim_detector"}

GM.CLASS.Survivors[CLASS_SURV_FAT] = {}
GM.CLASS.Survivors[CLASS_SURV_FAT].name = "Fat boy"
GM.CLASS.Survivors[CLASS_SURV_FAT].dispname = "Franklin"
GM.CLASS.Survivors[CLASS_SURV_FAT].description = "You're the strongest and hardest survivor to kill but you have the lowest stamina."
GM.CLASS.Survivors[CLASS_SURV_FAT].walkspeed = 130
GM.CLASS.Survivors[CLASS_SURV_FAT].runspeed = 240
GM.CLASS.Survivors[CLASS_SURV_FAT].life = 180
GM.CLASS.Survivors[CLASS_SURV_FAT].stamina = 80
GM.CLASS.Survivors[CLASS_SURV_FAT].model = "models/steinman/slashers/fat_pm.mdl"
GM.CLASS.Survivors[CLASS_SURV_FAT].icon = Material("icons/icon_fat.png")
GM.CLASS.Survivors[CLASS_SURV_FAT].die_sound = "slashers/effects/scream_man_1.wav"
GM.CLASS.Survivors[CLASS_SURV_FAT].weapons = {}

GM.CLASS.Survivors[CLASS_SURV_SHY] = {}
GM.CLASS.Survivors[CLASS_SURV_SHY].name = "Shy girl"
GM.CLASS.Survivors[CLASS_SURV_SHY].dispname = "Sydney"
GM.CLASS.Survivors[CLASS_SURV_SHY].description = "You're immunized to the killer main ability, but you're very weak. Be careful, the killer may want to kill you in priority."
GM.CLASS.Survivors[CLASS_SURV_SHY].walkspeed = 140
GM.CLASS.Survivors[CLASS_SURV_SHY].runspeed = 240
GM.CLASS.Survivors[CLASS_SURV_SHY].life = 60
GM.CLASS.Survivors[CLASS_SURV_SHY].stamina = 140
GM.CLASS.Survivors[CLASS_SURV_SHY].model = "models/player/korka007/maxc.mdl"
GM.CLASS.Survivors[CLASS_SURV_SHY].icon = Material("icons/icon_shy.png")
GM.CLASS.Survivors[CLASS_SURV_SHY].die_sound = "slashers/effects/scream_girl_1.wav"
GM.CLASS.Survivors[CLASS_SURV_SHY].weapons = {}

GM.CLASS.Survivors[CLASS_SURV_JUNKY] = {}
GM.CLASS.Survivors[CLASS_SURV_JUNKY].name = "Junky"
GM.CLASS.Survivors[CLASS_SURV_JUNKY].dispname = "Marty"
GM.CLASS.Survivors[CLASS_SURV_JUNKY].description = "You have an improved vision. Use it instead of your flashlight for a better stealth."
GM.CLASS.Survivors[CLASS_SURV_JUNKY].walkspeed = 130
GM.CLASS.Survivors[CLASS_SURV_JUNKY].runspeed = 240
GM.CLASS.Survivors[CLASS_SURV_JUNKY].life = 110
GM.CLASS.Survivors[CLASS_SURV_JUNKY].stamina = 120
GM.CLASS.Survivors[CLASS_SURV_JUNKY].model = "models/steinman/slashers/junky_pm.mdl"
GM.CLASS.Survivors[CLASS_SURV_JUNKY].icon = Material("icons/icon_junky.png")
GM.CLASS.Survivors[CLASS_SURV_JUNKY].die_sound = "slashers/effects/scream_man_1.wav"
GM.CLASS.Survivors[CLASS_SURV_JUNKY].weapons = {}

GM.CLASS.Survivors[CLASS_SURV_EMO] = {}
GM.CLASS.Survivors[CLASS_SURV_EMO].name = "Emo"
GM.CLASS.Survivors[CLASS_SURV_EMO].dispname = "Audrey"
GM.CLASS.Survivors[CLASS_SURV_EMO].description = "You're immunized to the killer second ability. Stay alone when hiding for a better chance of survival."
GM.CLASS.Survivors[CLASS_SURV_EMO].walkspeed = 130
GM.CLASS.Survivors[CLASS_SURV_EMO].runspeed = 240
GM.CLASS.Survivors[CLASS_SURV_EMO].life = 110
GM.CLASS.Survivors[CLASS_SURV_EMO].stamina = 130
GM.CLASS.Survivors[CLASS_SURV_EMO].model = "models/steinman/slashers/emo_pm.mdl"
GM.CLASS.Survivors[CLASS_SURV_EMO].icon = Material("icons/icon_emo.png")
GM.CLASS.Survivors[CLASS_SURV_EMO].die_sound = "slashers/effects/scream_girl_1.wav"
GM.CLASS.Survivors[CLASS_SURV_EMO].weapons = {}

GM.CLASS.Survivors[CLASS_SURV_BLACK] = {}
GM.CLASS.Survivors[CLASS_SURV_BLACK].name = "Black"
GM.CLASS.Survivors[CLASS_SURV_BLACK].dispname = "Roland"
GM.CLASS.Survivors[CLASS_SURV_BLACK].description = "You have 3 keys, use them to lock doors and keep the survivors safe. You can unlock locked doors to get back your keys."
GM.CLASS.Survivors[CLASS_SURV_BLACK].walkspeed = 140
GM.CLASS.Survivors[CLASS_SURV_BLACK].runspeed = 240
GM.CLASS.Survivors[CLASS_SURV_BLACK].life = 120
GM.CLASS.Survivors[CLASS_SURV_BLACK].stamina = 130
GM.CLASS.Survivors[CLASS_SURV_BLACK].model = "models/player/spike/lamar.mdl"
GM.CLASS.Survivors[CLASS_SURV_BLACK].icon = Material("icons/icon_black.png")
GM.CLASS.Survivors[CLASS_SURV_BLACK].die_sound = "slashers/effects/scream_man_1.wav"
GM.CLASS.Survivors[CLASS_SURV_BLACK].weapons = {"weapon_keys"}
GM.CLASS.Survivors[CLASS_SURV_BLACK].keysNumber = 3

GM.CLASS.Survivors[CLASS_SURV_SHERIF] = {}
GM.CLASS.Survivors[CLASS_SURV_SHERIF].name = "Sherif"
GM.CLASS.Survivors[CLASS_SURV_SHERIF].dispname = "Gale"
GM.CLASS.Survivors[CLASS_SURV_SHERIF].description = "You have a revolver. Use it to stun the killer and allow the survivors to run away. You can't kill the killer."
GM.CLASS.Survivors[CLASS_SURV_SHERIF].walkspeed = 150
GM.CLASS.Survivors[CLASS_SURV_SHERIF].runspeed = 240
GM.CLASS.Survivors[CLASS_SURV_SHERIF].life = 130
GM.CLASS.Survivors[CLASS_SURV_SHERIF].stamina = 140
GM.CLASS.Survivors[CLASS_SURV_SHERIF].model = "models/steinman/slashers/sheriff_pm.mdl"
GM.CLASS.Survivors[CLASS_SURV_SHERIF].icon = Material("icons/icon_sherif.png")
GM.CLASS.Survivors[CLASS_SURV_SHERIF].die_sound = "slashers/effects/scream_girl_1.wav"
GM.CLASS.Survivors[CLASS_SURV_SHERIF].weapons = {"stun_gun"}

GM.CLASS.Killers[CLASS_KILL_JASON] = {}
GM.CLASS.Killers[CLASS_KILL_JASON].name = "Jason"
GM.CLASS.Killers[CLASS_KILL_JASON].description = "You're the fastest killer and have the ability to see footprints left by the survivors to follow them. Listen carefully, you may hear survivors' hearbeat."
GM.CLASS.Killers[CLASS_KILL_JASON].walkspeed = 190
GM.CLASS.Killers[CLASS_KILL_JASON].runspeed = 240
GM.CLASS.Killers[CLASS_KILL_JASON].model = "models/player/mkx_jason.mdl"
GM.CLASS.Killers[CLASS_KILL_JASON].icon = Material("icons/icon_jason.png")

GM.CLASS.Killers[CLASS_KILL_GHOSTFACE] = {}
GM.CLASS.Killers[CLASS_KILL_GHOSTFACE].name = "Ghostface"
GM.CLASS.Killers[CLASS_KILL_GHOSTFACE].description = "You have the ability to see when a survivor open or close a door, use it to find them quickly. Think about closing opened doors to force the survivors to open door again. Listen carefully, you may hear survivors' hearbeat."
GM.CLASS.Killers[CLASS_KILL_GHOSTFACE].walkspeed = 190
GM.CLASS.Killers[CLASS_KILL_GHOSTFACE].runspeed = 240
GM.CLASS.Killers[CLASS_KILL_GHOSTFACE].model = "models/player/screamplayermodel/scream/scream.mdl"
GM.CLASS.Killers[CLASS_KILL_GHOSTFACE].icon = Material("icons/icon_ghostface.png")

GM.CLASS.Killers[CLASS_KILL_MYERS] = {}
GM.CLASS.Killers[CLASS_KILL_MYERS].name = "Michael Myers"
GM.CLASS.Killers[CLASS_KILL_MYERS].description = "You're the slowest killer and have the ability to focus one survivor at the time. Use it carefully to surprise the survivors and kill them quickly. Listen carefully, you may heard survivors' hearbeat."
GM.CLASS.Killers[CLASS_KILL_MYERS].walkspeed = 200
GM.CLASS.Killers[CLASS_KILL_MYERS].runspeed = 200
GM.CLASS.Killers[CLASS_KILL_MYERS].model = "models/player/dewobedil/mike_myers/default_p.mdl"
GM.CLASS.Killers[CLASS_KILL_MYERS].icon = Material("icons/icon_myers.png")

GM.CLASS.Killers[CLASS_KILL_PROXY] = {}
GM.CLASS.Killers[CLASS_KILL_PROXY].name = "the Proxy"
GM.CLASS.Killers[CLASS_KILL_PROXY].description = "You have the ability to appear and disappear when not visible by a survivor. Use it to sneak and surprise your victims. Press your menu key ('A' by default) to use it. Listen carefully, you may hear survivors' heartbeat."
GM.CLASS.Killers[CLASS_KILL_PROXY].walkspeed = 200
GM.CLASS.Killers[CLASS_KILL_PROXY].runspeed = 200
GM.CLASS.Killers[CLASS_KILL_PROXY].model = "models/slender_arrival/chaser.mdl"
GM.CLASS.Killers[CLASS_KILL_PROXY].icon = Material("icons/icon_proxy.png")

GM.CLASS.Killers[CLASS_KILL_INTRUDER] = {}
GM.CLASS.Killers[CLASS_KILL_INTRUDER].name = "the Intruder"
GM.CLASS.Killers[CLASS_KILL_INTRUDER].description = "You have the ability to place traps to help you killing the survivors. Use your alert ropes to spot the survivors, your bear traps to neutralize them and the door axe to kill them by surprise.Listen carefully, you may hear survivors' heartbeat."
GM.CLASS.Killers[CLASS_KILL_INTRUDER].walkspeed = 200
GM.CLASS.Killers[CLASS_KILL_INTRUDER].runspeed = 200
GM.CLASS.Killers[CLASS_KILL_INTRUDER].model = "models/steinman/slashers/intruder_pm.mdl"
GM.CLASS.Killers[CLASS_KILL_INTRUDER].icon = Material("icons/icon_intruder.png")
GM.CLASS.Killers[CLASS_KILL_INTRUDER].weapons = {"weapon_beartrap", "weapon_alertropes", "weapon_dooraxe"}

local function StartRound()
	for _, v in ipairs(player.GetAll()) do
		v.ClassID = nil
	end
end
hook.Add("sls_round_PreStart", "sls_class_PreStart", StartRound)