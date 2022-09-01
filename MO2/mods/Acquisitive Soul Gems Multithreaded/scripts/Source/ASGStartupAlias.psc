scriptname ASGStartupAlias extends ReferenceAlias

ASGStartup Startup
GlobalVariable ASGMSettings

; EVENTS -----------------------------------------------------------------------------------------

event OnPlayerLoadGame()
    ASGMSettings = game.getFormFromFile(0x000d65, "AcquisitiveSoulGemMultithreaded.esp") as GlobalVariable
	Startup = game.getFormFromFile(0x007920, "AcquisitiveSoulGemMultithreaded.esp") as ASGStartup
	debug.trace("ASGStartupAlias - starting onload process.")
	Startup.makeVanilla()
	Startup.getAllSoulGems()
	Startup.giveBook(True)
	
endEvent
