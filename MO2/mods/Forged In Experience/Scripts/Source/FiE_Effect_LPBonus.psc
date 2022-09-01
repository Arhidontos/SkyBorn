scriptname FiE_Effect_LPBonus extends ActiveMagicEffect

GlobalVariable Property FiE_LPBonusGV Auto

event OnEffectStart(Actor akTarget, Actor akCaster)
    if(akTarget != Game.GetPlayer())
        return
    endif

    float magnitude = GetMagnitude()
    FiE_LPBonusGV.Mod(magnitude as int)
endevent

event OnEffectFinish(Actor akTarget, Actor akCaster)
    if(akTarget != Game.GetPlayer())
        return
    endif

    float magnitude = GetMagnitude()
    FiE_LPBonusGV.Mod(-magnitude as int)
endevent