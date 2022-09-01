scriptname ASGStartup extends Quest

import debug

GlobalVariable ASGMSettings
Book ASGOptionsBook
Quest ASGMStartup
Actor property PlayerREF Auto

function giveBook(bool isLoad)
    debug.trace("ASGM Startup loaded, waiting 1 second before giving book. (Notification = " + isLoad as string + ")")
    utility.wait(1.0)
    ASGMSettings = game.getFormFromFile(0x000d65, "AcquisitiveSoulGemMultithreaded.esp") as GlobalVariable
    ASGOptionsBook = game.getFormFromFile(0x004e0f, "AcquisitiveSoulGemMultithreaded.esp") as Book
    ASGMStartup = game.getFormFromFile(0x007920, "AcquisitiveSoulGemMultithreaded.esp") as Quest

    ;AllowRemoval (bit 5) enabled? % 64 to remove higher bits, <32; not enabled, >=32; enabled
    debug.trace("ASGM Startup - Settings:" + ASGMSettings.getValueInt() + ", enabled: " + ((ASGMSettings.getValueInt() % 64) < 32))
    if ((((ASGMSettings.getValueInt() % 64) < 32) || !isLoad) && (PlayerREF.getItemCount(ASGOptionsBook) != 1))
        PlayerREF.removeItem(ASGOptionsBook, PlayerREF.getItemCount(ASGOptionsBook), true )
        PlayerREF.addItem(ASGOptionsBook, 1, isLoad )
        debug.trace("ASGM Startup - book given. (Total books in inventory = " + PlayerREF.getItemCount(ASGOptionsBook) + ")")
    endIf
endFunction

function makeVanilla()
	debug.trace("ASGM Startup - Making Vanilla.")
	string ASGMPath = "../../../interface/asgm/"
	string VanillaGems = ASGMPath + "vanilla.json"
	
	string Petty = 0x02e4e2 as string + ":Skyrim.esm"
	if JsonUtil.StringListFind(VanillaGems, "Petty", Petty) < 0
	    JsonUtil.StringListAdd(VanillaGems, "Petty", Petty)
	endif
	
	string FilledPetty = 0x02e4e3 as string + ":Skyrim.esm"
	if JsonUtil.StringListFind(VanillaGems, "FilledPetty", FilledPetty)  < 0
	    JsonUtil.StringListAdd(VanillaGems, "FilledPetty", FilledPetty)
	endif
	
	string Lesser = 0x02e4e4 as string + ":Skyrim.esm"
	if JsonUtil.StringListFind(VanillaGems, "Lesser", Lesser) < 0
	    JsonUtil.StringListAdd(VanillaGems, "Lesser", Lesser)
	endif
	
	string FilledLesser = 0x02e4e5 as string + ":Skyrim.esm"
	if JsonUtil.StringListFind(VanillaGems, "FilledLesser", FilledLesser) < 0
	    JsonUtil.StringListAdd(VanillaGems, "FilledLesser", FilledLesser)
	endif
	
	string Common = 0x02e4e6 as string + ":Skyrim.esm"
	if JsonUtil.StringListFind(VanillaGems, "Common", Common) < 0
	    JsonUtil.StringListAdd(VanillaGems, "Common", Common)
	endif
	
	string FilledCommon = 0x02e4f3 as string + ":Skyrim.esm"
	if JsonUtil.StringListFind(VanillaGems, "FilledCommon", FilledCommon) < 0
	    JsonUtil.StringListAdd(VanillaGems, "FilledCommon", FilledCommon)
	endif
	
	string Greater = 0x02e4f4 as string + ":Skyrim.esm"
	if JsonUtil.StringListFind(VanillaGems, "Greater", Greater) < 0
	    JsonUtil.StringListAdd(VanillaGems, "Greater", Greater)
	endif
	
	string FilledGreater = 0x02e4fb as string + ":Skyrim.esm"
	if JsonUtil.StringListFind(VanillaGems, "FilledGreater", FilledGreater) < 0
	    JsonUtil.StringListAdd(VanillaGems, "FilledGreater", FilledGreater)
	endif
	
	string Grand = 0x02e4fc as string + ":Skyrim.esm"
	if JsonUtil.StringListFind(VanillaGems, "Grand", Grand) < 0
	    JsonUtil.StringListAdd(VanillaGems, "Grand", Grand)
	endif
	
	string Black = 0x02e500 as string + ":Skyrim.esm"
	if JsonUtil.StringListFind(VanillaGems, "Black", Black) < 0
	    JsonUtil.StringListAdd(VanillaGems, "Black", Black)
	endif
	
	string AzurasStar = 0x063b27 as string + ":Skyrim.esm"
	if JsonUtil.StringListFind(VanillaGems, "AzurasStar", AzurasStar) < 0
	    JsonUtil.StringListAdd(VanillaGems, "AzurasStar", AzurasStar)
	endif
	
	string BlackStar = 0x063b29 as string + ":Skyrim.esm"
	if JsonUtil.StringListFind(VanillaGems, "BlackStar", BlackStar) < 0
	    JsonUtil.StringListAdd(VanillaGems, "BlackStar", BlackStar)
	endif
	
	JsonUtil.Save(VanillaGems)
endFunction

function getAllSoulGems()
{Finds all the .json files located in "<Skyrim install>/data/interface/asgm",
 and loads all the SoulGem entries in all of those files into an in-game form 
 that the main script will use to check mod-added SoulGems as well.
 See the example "vanilla.json" to see how the file should look, and see
 makeVanilla(), above, for an example of how to add SoulGems to a custom named
 file for mod-added items.}
	debug.trace("ASGM Startup - Getting all Soul Gems.")
	string ASGMPath = "../../../interface/asgm/"
	string AllGems = ASGMPath + "all/list.json"
	string[] GemFiles = JsonUtil.JsonInFolder(ASGMPath)
	
	JsonUtil.ClearAll(AllGems)
	
	int i = 0
	int j = 0
	while i < GemFiles.Length
		debug.trace("Currently importing gems in file: " + GemFiles[i])
		string[] Petty = JsonUtil.StringListToArray(ASGMPath + GemFiles[i], "Petty")
		j = 0
		while j < Petty.Length
			if JsonUtil.StringListFind(AllGems, "Petty", Petty[j]) < 0
				JsonUtil.StringListAdd(AllGems, "Petty", Petty[j])
			endif
			j += 1
		endWhile
		string[] FilledPetty = JsonUtil.StringListToArray(ASGMPath + GemFiles[i], "FilledPetty")
		j = 0
		while j < FilledPetty.Length
			if JsonUtil.StringListFind(AllGems, "FilledPetty", FilledPetty[j]) < 0
				JsonUtil.StringListAdd(AllGems, "FilledPetty", FilledPetty[j])
			endif
			j += 1
		endWhile
		string[] Lesser = JsonUtil.StringListToArray(ASGMPath + GemFiles[i], "Lesser")
		j = 0
		while j < Lesser.Length
			if JsonUtil.StringListFind(AllGems, "Lesser", Lesser[j]) < 0
				JsonUtil.StringListAdd(AllGems, "Lesser", Lesser[j])
			endif
			j += 1
		endWhile
		string[] FilledLesser = JsonUtil.StringListToArray(ASGMPath + GemFiles[i], "FilledLesser")
		j = 0
		while j < FilledLesser.Length
			if JsonUtil.StringListFind(AllGems, "FilledLesser", FilledLesser[j]) < 0
				JsonUtil.StringListAdd(AllGems, "FilledLesser", FilledLesser[j])
			endif
			j += 1
		endWhile
		string[] Common = JsonUtil.StringListToArray(ASGMPath + GemFiles[i], "Common")
		j = 0
		while j < Common.Length
			if JsonUtil.StringListFind(AllGems, "Common", Common[j]) < 0
				JsonUtil.StringListAdd(AllGems, "Common", Common[j])
			endif
			j += 1
		endWhile
		string[] FilledCommon = JsonUtil.StringListToArray(ASGMPath + GemFiles[i], "FilledCommon")
		j = 0
		while j < FilledCommon.Length
			if JsonUtil.StringListFind(AllGems, "FilledCommon", FilledCommon[j]) < 0
				JsonUtil.StringListAdd(AllGems, "FilledCommon", FilledCommon[j])
			endif
			j += 1
		endWhile
		string[] Greater = JsonUtil.StringListToArray(ASGMPath + GemFiles[i], "Greater")
		j = 0
		while j < Greater.Length
			if JsonUtil.StringListFind(AllGems, "Greater", Greater[j]) < 0
				JsonUtil.StringListAdd(AllGems, "Greater", Greater[j])
			endif
			j += 1
		endWhile
		string[] FilledGreater = JsonUtil.StringListToArray(ASGMPath + GemFiles[i], "FilledGreater")
		j = 0
		while j < FilledGreater.Length
			if JsonUtil.StringListFind(AllGems, "FilledGreater", FilledGreater[j]) < 0
				JsonUtil.StringListAdd(AllGems, "FilledGreater", FilledGreater[j])
			endif
			j += 1
		endWhile
		string[] Grand = JsonUtil.StringListToArray(ASGMPath + GemFiles[i], "Grand")
		j = 0
		while j < Grand.Length
			if JsonUtil.StringListFind(AllGems, "Grand", Grand[j]) < 0
				JsonUtil.StringListAdd(AllGems, "Grand", Grand[j])
			endif
			j += 1
		endWhile
		string[] Black = JsonUtil.StringListToArray(ASGMPath + GemFiles[i], "Black")
		j = 0
		while j < Black.Length
			if JsonUtil.StringListFind(AllGems, "Black", Black[j]) < 0
				JsonUtil.StringListAdd(AllGems, "Black", Black[j])
			endif
			j += 1
		endWhile
		string[] AzurasStar = JsonUtil.StringListToArray(ASGMPath + GemFiles[i], "AzurasStar")
		j = 0
		while j < AzurasStar.Length
			if JsonUtil.StringListFind(AllGems, "AzurasStar", AzurasStar[j]) < 0
				JsonUtil.StringListAdd(AllGems, "AzurasStar", AzurasStar[j])
			endif
			j += 1
		endWhile
		string[] BlackStar = JsonUtil.StringListToArray(ASGMPath + GemFiles[i], "BlackStar")
		j = 0
		while j < BlackStar.Length
			if JsonUtil.StringListFind(AllGems, "BlackStar", BlackStar[j]) < 0
				JsonUtil.StringListAdd(AllGems, "BlackStar", BlackStar[j])
			endif
			j += 1
		endWhile
		i += 1
	endWhile
	JsonUtil.Save(AllGems)
endFunction