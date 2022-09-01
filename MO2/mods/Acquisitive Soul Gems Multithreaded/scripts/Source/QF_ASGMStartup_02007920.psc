;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 9
Scriptname QF_ASGMStartup_02007920 Extends Quest Hidden

;BEGIN ALIAS PROPERTY PlayerAlias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PlayerAlias Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN AUTOCAST TYPE ASGStartup
Quest __temp = self as Quest
ASGStartup kmyQuest = __temp as ASGStartup
;END AUTOCAST
;BEGIN CODE
ASGStartup Startup

Startup = game.getFormFromFile(0x007920, "AcquisitiveSoulGemMultithreaded.esp") as ASGStartup
debug.trace("ASGStartupQuest - starting first run process.")
Startup.makeVanilla()
Startup.getAllSoulGems()
Startup.giveBook(False)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
