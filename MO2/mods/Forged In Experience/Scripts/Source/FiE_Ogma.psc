Scriptname FiE_Ogma extends ObjectReference  

Perk property blessgods_perk auto
FiE_Controller property controller auto

Auto State DoOnceState
	Event OnRead()
        If (!Game.GetPlayer().HasPerk(blessgods_perk))
            controller.AddLPToPlayer(25)
        EndIf
		GoToState ("DoNothingState")
	EndEvent
EndState

State DoNothingState
	Event OnRead()
	EndEvent
EndState