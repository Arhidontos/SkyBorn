scriptname FiE_MustRestart extends Quest

event OnInit()
    If(Game.GetGameSettingInt("iMineDisarmExperience") == 1)
            Game.QuitToMainMenu()
    Debug.MessageBox("$RERUN_GAME")
    EndIf
endevent