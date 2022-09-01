scriptname FiE_Effect_XPBoost extends ActiveMagicEffect

GlobalVariable Property FiE_ExpBonusGV Auto

event OnEffectStart(Actor akTarget, Actor akCaster)
    if(akTarget != Game.GetPlayer())
        return
    endif

    float magnitude = GetMagnitude()/100.0
    FiE_ExpBonusGV.Mod(magnitude)
endevent

event OnEffectFinish(Actor akTarget, Actor akCaster)
    if(akTarget != Game.GetPlayer())
        return
    endif

    float magnitude = GetMagnitude()/100.0
    FiE_ExpBonusGV.Mod(-magnitude)
endevent