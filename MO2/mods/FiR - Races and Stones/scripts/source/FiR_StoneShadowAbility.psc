scriptname FiR_StoneShadowAbility extends ActiveMagicEffect

Spell Property Invisibility Auto
MagicEffect property InvisEffect Auto

Actor Target

function OnEffectStart(Actor akTarget, Actor akCaster)
	PO3_Events_AME.RegisterForActorKilled(self as activemagiceffect)
	Target = akTarget
    Invisibility.Cast(akTarget)
	OnUpdate()
endFunction

Event OnActorKilled(Actor akVictim, Actor akKiller)
	
	if akKiller == Game.GetPlayer()
	Invisibility.Cast(Game.GetPlayer())
	endif
EndEvent

function OnEffectFinish(Actor akTarget, Actor akCaster)
	akTarget.DispelSpell(Invisibility)
endFunction

Event OnUpdate()
	If !Target.HasMagicEffect(InvisEffect)
		Dispel()
	Else
		RegisterForSingleUpdate(0.25)
	EndIf
EndEvent