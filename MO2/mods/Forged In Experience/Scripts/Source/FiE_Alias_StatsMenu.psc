scriptname FiE_Alias_StatsMenu extends ReferenceAlias

Actor property PlayerRef auto
GlobalVariable Property FiE_LearningPointsGV Auto
GlobalVariable Property FiE_GV_LPperLevel Auto
GlobalVariable Property FiE_GV_ExpBonus Auto
GlobalVariable Property FiE_GV_TotalXPGained Auto

REQ_MassEffect_PC Property masseffect Auto

REQ_AttributeSystem Property data Auto

int Property UIKeyCode = 34 Auto
bool property ShowOnlyInStats = false auto

bool isMenuOpen = false

string ROOT_MENU = "CustomMenu"
string MENU_ROOT = "_root.ActorStatsPanelFader.actorStatsPanel."

Event OnKeyDown(int keyCode)
    If (isMenuOpen)
        return
    EndIf

    if(ShowOnlyInStats && !Ui.isMenuOpen("StatsMenu"))
        return
    endif

    if(Ui.isMenuOpen("Crafting Menu") || Ui.isMenuOpen("InventoryMenu") || Ui.isMenuOpen("MagicMenu") || Ui.isMenuOpen("MapMenu") || Ui.isMenuOpen("Journal Menu")|| Ui.isMenuOpen("Kinect Menu") || Ui.isMenuOpen("Console")|| Ui.isMenuOpen("Overlay Interaction Menu") || Ui.isMenuOpen("Debug Text Menu") || Ui.isMenuOpen("RaceSex Menu")|| Ui.isMenuOpen("Main Menu"))
        return
    endif
    
    if keycode == UIKeyCode
		isMenuOpen = true
        OpenMenu()
    endif
EndEvent

int function OpenMenu()
	RegisterForModEvent("UIStatsMenu_LoadMenu", "OnLoadMenu")
	RegisterForModEvent("UIStatsMenu_CloseMenu", "OnUnloadMenu")

	UI.OpenCustomMenu("fie_statsmenu")
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
    AddValue("$NewExp", Game.GetExperienceForLevel(PlayerRef.GetLevel()), 64, 2)
    AddValue("$TotalExp", FiE_GV_TotalXPGained.GetValueInt(), 64, 3)
    AddValue("$Lp", FiE_LearningPointsGV.GetValueInt(), 64, 4)
    AddValue("$ExpBoost", FiE_GV_ExpBonus.GetValue(), 64, 5, "phng")
    AddValue("$LpPerLevel", FiE_GV_LPperLevel.GetValueInt(), 64, 6)

	AddValue("$FiE_ModMass", masseffect.mod_mass, 1, 9, "ng")
	AddValue("$FiE_ModPenalty", masseffect.mod_penalty, 1, 10, "ng")

    UI.InvokeForm(ROOT_MENU, MENU_ROOT + "setActorStatsPanelForm", PlayerRef)
    UI.InvokeForm(ROOT_MENU, MENU_ROOT + "selectActor", PlayerRef)
    UI.InvokeInt(ROOT_MENU, MENU_ROOT + "setState", 0)
EndEvent

;CATEGOTY ID
;64 - character
;1 - general
;2 - resists
;4 - combat
;8 - sneak
;16 - magic
;32 - shouts

;TYPE
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

function RemapKeyUI(int newKey)
    UnRegisterForKey(UIKeyCode)
    UIKeyCode = newKey
    RegisterForKey(UIKeyCode)
    isMenuOpen = false
endfunction