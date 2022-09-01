scriptname ASGThreadLock extends Quest
{Makes sure only one Soul Trap gets called at a time.
Needed because ASGM removes soul gems from trapper's
inventory while running, so we need to be certain those
gems are put back before we allow another Soul Trap
to occur.}

import debug

Actor[] trappers
int activeTrappers = 0

;Create the array used to track active trappers.
event OnInit()
	trappers = new Actor[128]
	debug.trace("ASGThreadLock - Trapper Array created")
endEvent

string function intToHex (int num)
	int remainder
	string result = ""
	;string[] hex = {"0","1","2","3,"4","5","6","7","8","9","A","B","C","D","E","F"}
	string[] hex = new string[16]
	;assign the individual parts of hex[] since we can't do it all at once.
	int i = 0
	while (i < 10)
		hex[i] = ""+i
		i+=1
	endWhile
	hex[10] = "A"
	hex[11] = "B"
	hex[12] = "C"
	hex[13] = "D"
	hex[14] = "E"
	hex[15] = "F"
	
	;The actual conversion from int to hex string	
	while (num > 0)
		remainder = num % 16
		result = hex[remainder] + result
		num = num/16
	endWhile
	return result
endFunction

;Determine if trapper has a Soul Trap happening already,
;and grant lock if not, adding trapper to the array.
bool function acquireLock(Actor trapper)
	if trappers.find(trapper) >= 0
		return trapper == None
	else
		trappers[activeTrappers] = trapper
		activeTrappers += 1
		debug.trace("ASGThreadLock - Lock granted to "+intToHex(Trapper.GetFormID()))
		return true
	endif
endFunction

;Remove Trapper from the array.
function releaseLock(Actor trapper)
	int lockIndex = trappers.find(trapper)
	if lockIndex >= 0
		activeTrappers -= 1
		trappers[lockIndex] = trappers[activeTrappers]
		trappers[activeTrappers] = None
	endif
	debug.trace("ASGThreadLock - "+intToHex(Trapper.GetFormID())+" Lock released.")
endFunction 