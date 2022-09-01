scriptname FiR_Effect_MagByStat extends ActiveMagicEffect

Actor property PlayerRef auto
Spell property PlayerSpell auto
string[] property ScalableStatName auto
float[] property BonusMag auto
float property StatBonusCap = 500.0 auto 
Spell property ConstNPCSpell auto

Keyword property FiR_KW_PlayerRaceUpdate auto

event OnEffectStart(Actor akTarget, Actor akCaster)
    if(akTarget == PlayerRef)
        UpdateEffectsForPlayer(akTarget)
        RegisterForModEvent("REQ_UpdatePlayerStats", "OnUpdateStats")
        return
    endif
    akTarget.AddSpell(ConstNPCSpell, false)
endevent

event OnEffectFinish(Actor akTarget, Actor akCaster)
    if(akTarget == PlayerRef)
        UnregisterForAllModEvents()
        akTarget.RemoveSpell(PlayerSpell)
        return
    endif
    akTarget.RemoveSpell(ConstNPCSpell)
endevent

event OnUpdateStats()
    UpdateEffectsForPlayer(PlayerRef)
endevent

function UpdateEffectsForPlayer(Actor akTarget)
    int i = BonusMag.Length
    while i != 0
        i -= 1
        float value = Calculate(akTarget, i)
        PlayerSpell.SetNthEffectMagnitude(i, value)
    endwhile
    
    akTarget.RemoveSpell(PlayerSpell)
    akTarget.AddSpell(PlayerSpell, false)
endfunction

float function Calculate(Actor target, int statIndex)
    float value = target.GetBaseActorValue(ScalableStatName[statIndex])
    If (value > StatBonusCap)
        value = StatBonusCap
    EndIf
    return (value / 5.0) * BonusMag[statIndex]
endfunction

Event OnPlayerLoadGame()
    if(GetTargetActor() == PlayerRef)
        UpdateEffectsForPlayer(PlayerRef)
        return
    endif
EndEvent