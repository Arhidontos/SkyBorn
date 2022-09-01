scriptname FiR_Alias_StatsMenu extends ReferenceAlias

Actor property PlayerRef auto
GlobalVariable Property FiE_LearningPointsGV Auto
GlobalVariable Property FiE_GV_LPperLevel Auto
GlobalVariable Property FiE_GV_ExpBonus Auto

REQ_AttributeSystem Property data Auto

bool isResetting = false
bool _waitLock = false
bool isMenuOpen = false

string ROOT_MENU = "CustomMenu"
string MENU_ROOT = "_root.ActorStatsPanelFader.actorStatsPanel."

event OnInit()
    RegisterForKey(34)
endEvent

Event OnKeyDown(int keyCode)
    If (isMenuOpen)
        return
    EndIf

    if(Ui.isMenuOpen("InventoryMenu") || Ui.isMenuOpen("MagicMenu") || Ui.isMenuOpen("MapMenu") || Ui.isMenuOpen("Console")|| Ui.isMenuOpen("Overlay Interaction Menu")|| Ui.isMenuOpen("Debug Text Menu"))
        return
    endif
    
    if keycode == 34
        OpenMenu()
        isMenuOpen = true
        RegisterForModEvent("UIStatsMenu_LoadMenu", "OnLoadMenu")
        RegisterForModEvent("UIStatsMenu_CloseMenu", "OnUnloadMenu")
    endif
EndEvent

int function OpenMenu()
    If !BlockUntilClosed() || !WaitForReset()
		return 0
	Endif

	RegisterForModEvent("UIStatsMenu_LoadMenu", "OnLoadMenu")
	RegisterForModEvent("UIStatsMenu_CloseMenu", "OnUnloadMenu")

	UI.OpenCustomMenu("statssheetmenu")
endfunction

Event OnUnloadMenu(string eventName, string strArg, float numArg, Form formArg)
	isMenuOpen = false
    UnregisterForModEvent("UIStatsMenu_LoadMenu")
	UnregisterForModEvent("UIStatsMenu_CloseMenu")
EndEvent

Event OnLoadMenu(string eventName, string strArg, float numArg, Form formArg)
	UnregisterForModEvent("UIStatsMenu_LoadMenu")

    AddValue("$Level", PlayerRef.GetLevel(), 64, 0)
    AddValue("$Exp", Game.GetPlayerExperience(), 64, 1)
    AddValue("$NewExp", Game.GetExperienceForLevel(PlayerRef.GetLevel()+1), 64, 2)
    AddValue("$Lp", FiE_LearningPointsGV.GetValueInt(), 64, 3)
    AddValue("$ExpBoost", FiE_GV_ExpBonus.GetValue(), 64, 4, "phng")
    AddValue("$LpPerLevel", FiE_GV_LPperLevel.GetValueInt(), 64, 5)

    UI.InvokeForm(ROOT_MENU, MENU_ROOT + "setActorStatsPanelForm", PlayerRef)
    UI.InvokeForm(ROOT_MENU, MENU_ROOT + "selectActor", PlayerRef)
    UI.InvokeInt(ROOT_MENU, MENU_ROOT + "setState", 0)
EndEvent

;c - just number
;p - percent
;ng - no green
;png - percent no green
;phng - percent mult by 100 and no green
function AddValue(string name, float value, int category, int customId, string type = "ng")
    int[] customValueIdCat = new int[2]
    customValueIdCat[0] = customId
    customValueIdCat[1] = category

    UI.InvokeIntA(ROOT_MENU, MENU_ROOT + "addCustomValue", customValueIdCat)
    UI.InvokeInt(ROOT_MENU, MENU_ROOT + "setTargetIndex", customId)
    UI.InvokeString(ROOT_MENU, MENU_ROOT + "setCustomName", name)
    UI.InvokeString(ROOT_MENU, MENU_ROOT + "setValueType", type)
    UI.InvokeFloat(ROOT_MENU, MENU_ROOT + "setCustomValue", value)
endfunction

Function Lock()
	_waitLock = true
EndFunction

bool Function WaitLock()
	int lockOut = 0
	While _waitLock
		lockOut += 1
		If lockOut > 50 ; Took more than 5 sec
			_waitLock = false
			return false
		Endif
		Utility.Wait(0.1)
	EndWhile
	return true
EndFunction

Function Unlock()
	_waitLock = false
EndFunction

bool Function BlockUntilClosed()
	int counter = 0
	While UI.IsMenuOpen("CustomMenu")
		counter += 1
		If counter > 50
			return false
		Endif
		Utility.Wait(0.1)
	EndWhile

	return true
EndFunction

bool Function WaitForReset()
	int counter = 0
	While isResetting
		counter += 1
		If counter > 50
			isResetting = false
			return false
		Endif
		Utility.Wait(0.1)
	EndWhile

	return true
EndFunction