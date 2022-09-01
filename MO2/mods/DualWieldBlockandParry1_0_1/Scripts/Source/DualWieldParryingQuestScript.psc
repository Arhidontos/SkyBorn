Scriptname DualWieldParryingQuestScript extends Quest conditional
int wantblock conditional
;idle property StopBlocking auto
;idle StartBlocking
int blockKeyCode = 47
Actor playerRef
;bool block_down = false

event oninit()
	;Debug.StartScriptProfiling("DualWieldParryingQuestScript")
	;Debug.notification("Initialization started")
	activateMod()
endevent

int function getBlockKeyCode()
	return blockKeyCode
EndFunction

Function setBlockKeyCode(int newKeyCode)
	UnregisterForKey(blockKeyCode)
	blockKeyCode = newKeyCode
	RegisterForKey(blockKeyCode)
EndFunction

Function activateMod()
	gotostate("")
	playerRef = game.getplayer()
	RegisterForKey(blockKeyCode)
	RegisterForAnimationEvent(playerref, "bashStop")
	RegisterForAnimationEvent(playerref, "blockStop")
	;RegisterForControl("Left Attack/Block")
EndFunction

Function deactivateMod()
	gotostate("")
	UnregisterForKey(blockKeyCode)
	UnRegisterForAnimationEvent(playerref, "bashStop")
	UnregisterForControl("Right Attack/Block")
	UnRegisterForAnimationEvent(playerref, "blockStop")
	UnregisterForControl("Left Attack/Block")
EndFunction

Event OnKeyDown(int keyCode)
	gotostate("b")
EndEvent

event onbeginstate()
	;Debug.Trace("iWantBlockState: " + playerref.getanimationvariablebool("iWantBlock"))
	if !playerref.getanimationvariablebool("iWantBlock")
		Debug.sendanimationevent(playerref, "blockStop")
	endif
	wantblock = 0
endevent

state b
Event OnKeyUp(int keyCode, float HoldTime)
;Debug.Trace(getstate() + " OnKeyUp started")
gotostate("")
EndEvent

event OnAnimationEvent(ObjectReference akSource, string asEventName)
	Debug.sendanimationevent(playerref, "blockStart")
endevent

event onbeginstate()
	;Debug.Trace("iWantBlockState: " + playerref.getanimationvariablebool("iWantBlock"))
	Debug.sendanimationevent(playerref, "blockStart")
	wantblock = 1
endevent
endstate
