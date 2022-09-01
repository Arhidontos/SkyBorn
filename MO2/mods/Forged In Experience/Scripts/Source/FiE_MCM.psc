Scriptname FiE_MCM Extends SKI_ConfigBase Conditional

FiE_Alias_StatsMenu Property StatsMenu Auto
FiE_Controller Property Controller Auto
FiE_Initializer Property Initializer Auto

int property MessageColorInt = 0xFFFFFF auto

int[] OptionOID
string[] Difficulty

int difficultyIndex = 1

event OnInit()
	parent.OnInit()
endEvent

Event OnConfigInit()
    StatsMenu.RemapKeyUI(StatsMenu.UIKeyCode)
endevent

event OnPageReset(string page)
	OptionOID = new int[7]

	Difficulty = new string[3]
	Difficulty[0] = "$EasyLP"
	Difficulty[1] = "$NormalLP"
	Difficulty[2] = "$HardLP"

	if(page == "$General")
		OptionOID[0] = AddColorOption("$MessagesColor", MessageColorInt, 0)
    	OptionOID[1] = AddKeyMapOption("$KeymapStatsUIOption", StatsMenu.UIKeyCode, 0)
    	OptionOID[2] = AddToggleOption("$ShowStatsUIOnlyInStats", StatsMenu.ShowOnlyInStats, 0)
		OptionOID[6] = AddMenuOption("$LPMode", Difficulty[difficultyIndex], 0)
	ElseIf (page == "$Debug")
		OptionOID[3] = AddInputOption("$XPInput", 0, 0)
		OptionOID[4] = AddInputOption("$LPInput", 0, 0)

		OptionOID[5] = AddToggleOption("$Reload", false, 0)
	endif
endEvent

event OnOptionKeyMapChange(int option, int keyCode, string conflictControl, string conflictName)
	if KeyBindConflict(option, keyCode, conflictControl, conflictName) == True
			StatsMenu.RemapKeyUI(keyCode)
	endif
endEvent

Event OnOptionColorOpen(int option)
   if (option == OptionOID[0])
		SetColorDialogStartColor(MessageColorInt)
		SetColorDialogDefaultColor(MessageColorInt)
    endIf
EndEvent

Event OnOptionColorAccept(int option, int color)
	if (option == OptionOID[0])
		MessageColorInt = color
		Initializer.MessageColor = DecToHex(color)
		SetColorOptionValue(option, color, 0)
    endIf
EndEvent

event OnOptionSelect(int option)
    if(option == OptionOID[2])
        StatsMenu.ShowOnlyInStats = !StatsMenu.ShowOnlyInStats
        SetToggleOptionValue(option, StatsMenu.ShowOnlyInStats, 0)
	ElseIf (option == OptionOID[5])
		SetToggleOptionValue(option, true, 0)
		Initializer.Init()
	endif
endevent

event OnOptionInputAccept(int option, string pInput)
	if(option == OptionOID[3])
		int count = pInput as int
		if(count == 0)
			Debug.MessageBox("$XPInputError")
			return
		endif
		Controller.AddXPToPlayer(count)
	ElseIf (option == OptionOID[4])
		int count = pInput as int
		if(count == 0)
			Debug.MessageBox("$XPInputError")
			return
		endif
		Controller.FiE_GV_LearningPoint.SetValueInt(Controller.FiE_GV_LearningPoint.GetValueInt()+count)
	endif
endevent

bool Function KeyBindConflict(int option, int keyCode, string conflictControl, string conflictName)
	bool continue = true
	if (conflictControl != "")
		string msg
		if (conflictName != "")
			msg = "$Message_0{\n\"" + conflictControl + "\"\n}{(" + conflictName + ")\n\n}"
		else
			msg = "$Message_1{\n\"" + conflictControl + "\"\n\n}"
		endIf
		continue = ShowMessage(msg, true, "$Yes", "$No")
	endIf

	if (continue)
		SetKeymapOptionValue(option, keyCode, 0)
	endIf
	
	return continue
EndFunction

event OnOptionMenuOpen(int option)
	if (option == OptionOID[6])
		SetMenuDialogOptions(Difficulty)
		SetMenuDialogStartIndex(difficultyIndex)
		SetMenuDialogDefaultIndex(1)
	endIf
endEvent

event OnOptionMenuAccept(int option, int index)
	if (option == OptionOID[6])
		if(difficultyIndex == 0)
			Controller.FiE_GV_LPperLevel.Mod(-20.0)
		elseif(difficultyIndex == 1)
			Controller.FiE_GV_LPperLevel.Mod(-15.0)
		elseif(difficultyIndex == 2)
			Controller.FiE_GV_LPperLevel.Mod(-10.0)
		endif

		if(index == 0)
			Controller.FiE_GV_LPperLevel.Mod(20.0)
		elseif(index == 1)
			Controller.FiE_GV_LPperLevel.Mod(15.0)
		elseif(index == 2)
			Controller.FiE_GV_LPperLevel.Mod(10.0)
		endif

		difficultyIndex = index
		SetMenuOptionValue(OptionOID[7], Difficulty[difficultyIndex], 0)
	endIf
endEvent

string Function DecToHex(int ColorInt)
	string HexLine = "0123456789ABCDEF"
	string ColorinHex = ""
	int Counter = 0
	int Result
	While Counter < 6
		Result = (ColorInt % 16)
		ColorinHex = StringUtil.GetNthChar(HexLine, Result) + ColorinHex		
		ColorInt = (ColorInt / 16)
		Counter += 1
	EndWhile
	
	return "#" + ColorinHex
EndFunction