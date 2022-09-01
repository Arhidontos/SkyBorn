;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname QF_FiE_Reload_010048A7 Extends Quest Hidden

;BEGIN ALIAS PROPERTY EventHandler
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_EventHandler Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY controller
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_controller Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PlayerAlias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PlayerAlias Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY StatsMenu
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_StatsMenu Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
;WARNING: Unable to load fragment source from function Fragment_2 in script QF_FiE_Reload_010048A7
;Source NOT loaded
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE FiE_Initializer
Quest __temp = self as Quest
FiE_Initializer kmyQuest = __temp as FiE_Initializer
;END AUTOCAST
;BEGIN CODE
kmyQuest.Init()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
