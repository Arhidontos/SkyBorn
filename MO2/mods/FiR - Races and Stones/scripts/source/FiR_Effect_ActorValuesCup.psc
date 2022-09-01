scriptname FiR_Effect_ActorValuesCup extends ActiveMagicEffect


String[] property StatNames auto
Float[] property MinCapValues auto
Float property UpdateTime auto
Float[] property MaxCapValues auto

Int bRun = 1
Float StatOffset
Float[] StatOffsets
Actor TargetRef

function OnEffectFinish(Actor Target, Actor Caster)

	bRun = 0
	Int i = 0
	while i < StatNames.length
		TargetRef.modav(StatNames[i], StatOffsets[i])
		i += 1
	endWhile
endFunction

function OnUpdate()

	self.UpdateStats(TargetRef)
	if bRun == 1
		self.RegisterForSingleUpdate(UpdateTime)
	endIf
endFunction

Float function UpdateStat(Actor actorRef, String _StatName, Float max_cap_value, Float min_cap_value, Float stat_offset)

	Float stat_value = actorRef.getav(_StatName)
	Float mod = self.CalcNewValue(stat_value + stat_offset, max_cap_value, min_cap_value) - stat_value
	actorRef.modav(_StatName, mod)
	stat_offset -= mod
	return stat_offset
endFunction

function OnEffectStart(Actor akTarget, Actor akCaster)

	self.UpdateStats(akTarget)
	TargetRef = akTarget
	bRun = 1
	self.RegisterForSingleUpdate(UpdateTime)
endFunction

function UpdateStats(Actor actorRef)

	if !StatOffsets
		StatOffsets = new Float[127]
		StatOffsets[0] = StatOffset
	endIf
	Int i = 0
	while i < StatNames.length
		StatOffsets[i] = self.UpdateStat(actorRef, StatNames[i], MaxCapValues[i], MinCapValues[i], StatOffsets[i])
		i += 1
	endWhile
endFunction

Float function CalcNewValue(Float val, Float max_cap_value, Float min_cap_value)

	if val > max_cap_value
		return max_cap_value
	endIf
	if val < min_cap_value
		return min_cap_value
	endIf
	return val
endFunction