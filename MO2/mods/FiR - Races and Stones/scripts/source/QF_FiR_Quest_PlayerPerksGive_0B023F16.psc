;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 4
Scriptname QF_FiR_Quest_PlayerPerksGive_0B023F16 Extends Quest Hidden

;BEGIN ALIAS PROPERTY StatsMenu
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_StatsMenu Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
PlayerRef.AddSpell(SpellWithPerks, false)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Spell Property SpellWithPerks  Auto  

Actor Property PlayerRef  Auto  
