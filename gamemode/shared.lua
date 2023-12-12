-- Utopia Games - Slashers
--
-- @Author: Garrus2142
-- @Date:   2017-07-25 16:15:52
-- @Last Modified by:   Garrus2142
-- @Last Modified time: 2017-07-27 17:08:04

GM.Name = "Slashers";
GM.Author = "Garrus2142";
GM.Version = "1.1.0"
GM.Github = "https://github.com/Garrus2142/Slashers/"
GM.Workshop = "http://steamcommunity.com/sharedfiles/filedetails/?id=1092007703"

TEAM_KILLER = 1;
TEAM_SURVIVORS = 2;

-- Classes
CLASS_KILLER = 1001
CLASS_SURV_SPORTS = 1
CLASS_SURV_POPULAR = 2
CLASS_SURV_NERD = 3
CLASS_SURV_FAT = 4
CLASS_SURV_SHY = 5
CLASS_SURV_JUNKY = 6
CLASS_SURV_EMO = 7
CLASS_SURV_BLACK = 8
CLASS_SURV_SHERIF = 9

team.SetUp(TEAM_KILLER, "Murderer", Color(255, 0, 0), false);
team.SetUp(TEAM_SURVIVORS, "Survivors", Color(0, 0, 255), false);

-- Header message
print("\n### This server run Slashers Gamemode by Utopia-Games ###\n")
print("Version: " .. GM.Version)
print("Workshop: " .. GM.Workshop)
print("Github: " .. GM.Github)
print("\n###                 Thanks for playing                ###\n")
