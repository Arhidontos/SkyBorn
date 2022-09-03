ScriptName sztk_DetectCellChangeEffectScript extends ActiveMagicEffect

ObjectReference Property PCStalkerMarker Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	Utility.Wait(0.1)
	PCStalkerMarker.MoveTo(akTarget)

	int handle = ModEvent.Create("sztk_CellChange")
	if handle
		ModEvent.Send(handle)
	endif
EndEvent

