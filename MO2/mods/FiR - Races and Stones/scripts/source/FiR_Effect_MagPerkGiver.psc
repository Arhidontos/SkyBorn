scriptname FiR_Effect_MagPerkGiver extends ActiveMagicEffect

Perk property PerkToGive auto
float property AddValue Auto
float property MultValue auto

event OnEffectStart(Actor akTarget, Actor akCaster)
    akTarget.RemovePerk(PerkToGive)
    PerkToGive.SetNthEntryValue(0, 0, (AddValue) + (GetMagnitude() * MultValue))
    akTarget.AddPerk(PerkToGive)
endevent

event OnEffectFinish(Actor akTarget, Actor akCaster)
    akTarget.RemovePerk(PerkToGive)
endevent