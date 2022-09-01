scriptname ASGQuest extends SKI_ConfigBase

import debug

; SCRIPT VERSION ----------------------------------------------------------------------------------
int function getVersion()
	return 5 ; Default version
endFunction

; VARIABLES ---------------------------------------------------------------------------------------
GlobalVariable property ASGMSettings auto

bool[] setting
int LossyCapture = 6
int AllowRemove = 5
int International = 4
int OnlyBlack = 3
int OnlyFull = 2
int SilenceSuccess = 1
int SilenceFail = 0
int blackOID
int fullOID
int silenceSuccessOID
int silenceFailOID
int lossyCaptureOID

function getSettings()
	int set_temp = ASGMSettings.getValueInt()
	int bit_pos = 0
	while (bit_pos < 32)
		if (set_temp - 2 * (set_temp / 2) > 0)
			setting[bit_pos] = true
		else
			setting[bit_pos] = false
		endIf
		bit_pos += 1
		set_temp /= 2
	endWhile
endFunction

function recordChange()
	int set_temp = 0
	int bit_pos = 0
	while (bit_pos < 32)
		if (setting[bit_pos])
			set_temp += math.pow(2,bit_pos) as int
		endIf
		bit_pos += 1
	endWhile
	ASGMSettings.setValueInt(set_temp)
endFunction

; INITIALIZATION ----------------------------------------------------------------------------------
; @implements SKI_ConfigBase
event OnConfigInit()
	{Called when this config menu is initialized}
	setting = new bool[32]
	getSettings()
	setting[International] = true
	setting[AllowRemove] = true
	recordChange()
	debug.trace("ASGM MCM Menu initialized - ASGMSettings:"+ASGMSettings.GetValueInt()+" International:"+setting[International]+" AllowRemove:"+setting[AllowRemove]+" OnlyBlack:"+setting[OnlyBlack]+" OnlyFull:"+setting[OnlyFull]+" SilenceSuccess:"+setting[SilenceSuccess]+" SilenceFail:"+setting[SilenceFail]+" LossyCapture:"+setting[LossyCapture])
	; ...
endEvent

; EVENTS ------------------------------------------------------------------------------------------
; @implements SKI_ConfigBase
event OnPageReset(string a_page)
	{Called when a new page is selected, including the initial empty page}
	setCursorFillMode(TOP_TO_BOTTOM) 
	setting = new bool[32]
	getSettings()
	setting[International] = true
	setting[AllowRemove] = true
	recordChange()
	debug.trace("ASGM MCM Menu page reset - ASGMSettings:"+ASGMSettings.GetValueInt()+" International:"+setting[International]+" AllowRemove:"+setting[AllowRemove]+" OnlyBlack:"+setting[OnlyBlack]+" OnlyFull:"+setting[OnlyFull]+" SilenceSuccess:"+setting[SilenceSuccess]+" SilenceFail:"+setting[SilenceFail]+" LossyCapture:"+setting[LossyCapture])
	blackOID = addToggleOption("$ASGBlackOption", setting[OnlyBlack])
	fullOID = addToggleOption("$ASGFilledOption", setting[OnlyFull])
	lossyCaptureOID = addToggleOption("$ASGLossyCaptureOption", setting[LossyCapture])
	silenceSuccessOID = addToggleOption("$ASGSilenceSuccessOption", setting[SilenceSuccess])
	silenceFailOID = addToggleOption("$ASGSilenceFailOption", setting[SilenceFail])
	; ...
endEvent

event OnOptionSelect(int option)
	if(option == blackOID)
		setting[OnlyBlack] = !setting[OnlyBlack]
		recordChange()
		setToggleOptionValue(option, setting[OnlyBlack])
		debug.trace("ASGM MCM Menu set OnlyBlack - ASGMSettings:"+ASGMSettings.GetValueInt()+" OnlyBlack:"+setting[OnlyBlack])
	elseIf(option == fullOID)
		setting[OnlyFull] = !setting[OnlyFull]
		recordChange()
		setToggleOptionValue(option, setting[OnlyFull])
		debug.trace("ASGM MCM Menu set OnlyFull - ASGMSettings:"+ASGMSettings.GetValueInt()+" OnlyFull:"+setting[OnlyFull])
	elseIf(option == lossyCaptureOID)
		setting[LossyCapture] = !setting[LossyCapture]
		recordChange()
		setToggleOptionValue(option, setting[LossyCapture])
		debug.trace("ASGM MCM Menu set LossyCapture - ASGMSettings:"+ASGMSettings.GetValueInt()+" LossyCapture:"+setting[LossyCapture])
	elseIf(option == silenceSuccessOID)
		setting[SilenceSuccess] = !setting[SilenceSuccess]
		recordChange()
		setToggleOptionValue(option, setting[SilenceSuccess])
		debug.trace("ASGM MCM Menu set SilenceSuccess - ASGMSettings:"+ASGMSettings.GetValueInt()+" SilenceSuccess:"+setting[SilenceSuccess])
	elseIf(option == silenceFailOID)
		setting[SilenceFail] = !setting[SilenceFail]
		recordChange()
		setToggleOptionValue(option, setting[SilenceFail])
		debug.trace("ASGM MCM Menu set SilenceFail - ASGMSettings:"+ASGMSettings.GetValueInt()+" SilenceFail:"+setting[SilenceFail])
	endIf
endEvent

event OnOptionHighlight(int option)
	if(option == blackOID)
		setInfoText("$ASGBlackInfo")
	elseIf(option == fullOID)
		setInfoText("$ASGFilledInfo")
	elseIf(option == lossyCaptureOID)
		setInfoText("$ASGLossyCaptureInfo")
	elseIf(option == silenceSuccessOID)
		setInfoText("$ASGSilenceSuccessInfo")
	elseIf(option == silenceFailOID)
		setInfoText("$ASGSilenceFailInfo")
	endIf
endEvent
