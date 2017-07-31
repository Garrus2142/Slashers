-- Utopia Games - Slashers
--
-- @Author: Garrus2142
-- @Date:   2017-07-27 00:03:40
-- @Last Modified by:   
-- @Last Modified time: 2017-07-27 00:03:40

CreateConVar("slashers_antiafk_enable", 1, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE}, "Enable / Disable antiafk")
CreateConVar("slashers_antiafk_afktime", 60, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE}, "Set afktime duration in seconds")
CreateConVar("slashers_antiafk_afkmsgtime", 15, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE}, "Set afk message duration before being kick")
