scriptname ASGMOptions extends ObjectReference

;======================================================================================;
; ASG VARIABLES		/
;=================/
GlobalVariable ASGMSettings	; 000d65
Message property ASGOptionsMESG Auto	; 004e0b
Message property ASGOnlyBlackMESG Auto	; 004e0c
Message property ASGOnlyFullMESG Auto	; 004e0d
Message property ASGSilenceSuccessMESG Auto		; 004e0e
Message property ASGSilenceFailMESG Auto		; 008ea8
Message property ASGAllowRemoveMESG Auto		; 008ea8
Message property ASGLossyCaptureMESG Auto		; 00cf44

int LossyCapture = 6
int AllowRemove = 5
int International = 4
int OnlyBlack = 3
int OnlyFull = 2
int SilenceSuccess = 1
int SilenceFail = 0

;======================================================================================;
;	EVENTS		/
;=============/
event OnRead()
	menu()
	game.enablePlayerControls(false, false, false, false, false, true) ; Undo disablePlayerControls
endEvent 

function menu(bool abMenu = true, int aiButton = 0)
	ASGMSettings = game.getFormFromFile(0x000d65, "AcquisitiveSoulGemMultithreaded.esp") as GlobalVariable

	int set_temp
	int bit_pos
	int iButton
	bool[] setting = new bool[32]

	while abMenu
		set_temp = ASGMSettings.getValueInt()
		bit_pos = 0
		iButton = 0
		while (bit_pos < 32)
			if (set_temp - 2 * (set_temp / 2) > 0)
				setting[bit_pos] = true
			else
				setting[bit_pos] = false
			endIf
			bit_pos += 1
			set_temp /= 2
		endWhile

		if aiButton != -1 ; Wait for input (this can prevent problems if recycling the aiButton argument in submenus)
			aiButton = ASGOptionsMESG.show(setting[OnlyBlack] as float, setting[OnlyFull] as float, setting[LossyCapture] as float, setting[SilenceSuccess] as float, setting[SilenceFail] as float) ; Main Menu
			if aiButton == 0
				iButton = ASGOnlyBlackMESG.show()
				if iButton != 2
					setting[OnlyBlack] = (iButton == 1)
				endIf
			elseIf aiButton == 1
				iButton = ASGOnlyFullMESG.show()
				if iButton != 2
					setting[OnlyFull] = (iButton == 1)
				endIf
			elseIf aiButton == 2
				iButton = ASGLossyCaptureMESG.show()
				if iButton != 2
					setting[LossyCapture] = (iButton == 1)
				endIf
			elseIf aiButton == 3
				iButton = ASGSilenceSuccessMESG.show()
				if iButton != 2
					setting[SilenceSuccess] = (iButton == 1)
				endIf
			elseIf aiButton == 4
				iButton = ASGSilenceFailMESG.show()
				if iButton != 2
					setting[SilenceFail] = (iButton == 1)
				endIf
			elseIf aiButton == 5
				iButton = ASGAllowRemoveMESG.show()
				if iButton != 2
					setting[AllowRemove] = (iButton == 1)
				endIf
			elseIf aiButton == 6 ;Read Book option
				abMenu = false ; End the function
			elseIf aiButton == 7 ;Close option
				game.disablePlayerControls(false, false, false, false, false, true) ; Ensure MessageBox is not on top of other menus & prevent book from opening normally.
				abMenu = false ; End the function
			endIf
		endIf

		set_temp = 0
		bit_pos = 0
		while (bit_pos < 32)
			if (setting[bit_pos])
				set_temp += math.pow(2,bit_pos) as int
			endIf
			bit_pos += 1
		endWhile
		ASGMSettings.setValueInt(set_temp)
	endWhile
endFunction