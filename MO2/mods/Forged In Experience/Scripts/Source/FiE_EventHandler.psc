Scriptname FiE_EventHandler extends ReferenceAlias

FiE_Controller Property controller Auto
FiE_Alias_StatsMenu property statsMenu auto
Spell Property summonable Auto
Actor Property player auto

event OnInit()
    RegisterForTrackedStatsEvent()
    RegisterForControl("Jump")
    PO3_Events_Alias.RegisterForActorKilled(self)
    PO3_Events_Alias.RegisterForLevelIncrease(self)
endEvent

Event OnTrackedStatsEvent(string arStatName, int aiStatValue)
;    If (arStatName == "Skill Books Read")
;        controller.AddLPToPlayer(1)
;        return
;    EndIf

    if(arStatName != "Quests Completed")
        return
    endif

    controller.CalculateExpFromQuest()
EndEvent

Event OnActorKilled(Actor akVictim, Actor akKiller)
    if((akKiller == none && akVictim.GetActorValue("Health") <= 0.0) || akKiller.IsPlayerTeammate() || akKiller == player || (akKiller.IsCommandedActor() && !akKiller.IsHostileToActor(player)))
        
        ActorKilled(akVictim)
        return
    endif
EndEvent

Event OnLevelIncrease(int aiLevel)
    controller.levelIncreaseUIShowed = false
    controller.AddLPFromNewLevel()
EndEvent

Event OnPlayerLoadGame()
    statsMenu.RemapKeyUI(statsMenu.UIKeyCode)
endEvent

function ActorKilled(Actor akVictim)
    If (akVictim.HasSpell(summonable))
        return
    EndIf

    controller.CalculateExpFromActor(akVictim)
    akVictim.AddSpell(summonable, false)
endfunction