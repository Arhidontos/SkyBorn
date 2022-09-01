scriptname FiE_Initializer extends Quest

FiE_Controller Property modController Auto

Perk Property FiE_DisableSkillsLevelingPerk Auto

string Property MessageColor = "#FFFFFF" Auto

event OnFiEXPMessage(string pMessage)
    ((self as Form) as UILIB_1).ShowNotification(pMessage, MessageColor)
endEvent

;EXP TABLES INIT
function Init()
    Int result = modController.LoadConfigs()

    if result == 1
        Debug.MessageBox("$FiEinitFailed")
        Game.QuitToMainMenu()
    endif

    Actor playerRef = Game.GetPlayer()
	
	IF !playerRef.HasPerk(FiE_DisableSkillsLevelingPerk)
		playerRef.AddPerk(FiE_DisableSkillsLevelingPerk)
	ENDIF

    RegisterForModEvent("FiE_XPMessage", "OnFiEXPMessage")
    Debug.MessageBox("$FiEinit")
    SetStage(10)
endfunction
