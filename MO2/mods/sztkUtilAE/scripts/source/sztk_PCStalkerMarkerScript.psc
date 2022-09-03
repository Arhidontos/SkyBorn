ScriptName sztk_PCStalkerMarkerScript extends ObjectReference

Event OnCellDetach()
	Utility.Wait(0.1)
	MoveTo(Game.GetPlayer())

	int handle = ModEvent.Create("sztk_CellChange")
	if handle
		ModEvent.Send(handle)
	endif
EndEvent

