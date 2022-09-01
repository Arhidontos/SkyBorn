Acquisitive Soul Gems
Multi-Threaded
v. 4.7
Author: eyeonus

This mod causes Soul Gems to trap souls of the same size as the gem,
preventing smaller souls from being trapped, such as trapping a Petty
Soul in a Common Soul Gem or a Greater Soul in a Black Soul Gem, etc.

The book "[Settings]ASG Options" allows the easy changing of the following
options, which will also appear in the MCM menu if SkyUI is installed:

OnlyBlack (default:true):
	If set to (true), will force the Black Soul Gems and Black Star to be
	only able to trap Black Souls, otherwise will allow them to trap the same
	souls that Grand Soul Gems and Azura's Star can trap, respectively.

OnlyFull (default:false): 
	If set to (true), will not allow Azura's Star or the Black Star to trap souls
	smaller than Grand. Has no effect on the Black Star if OnlyBlack is true.

LossyCapture (false):
	If set to (true), will allow capturing souls in smaller gems at a loss, if 
	there are no Soul Gems of the right size. So, for example, when trying to 
	capture a Common Soul, the player only has Petty Soul Gems, a Petty Soul Gem 
	will be filled by the Common Soul as if it were a Petty Soul.

Allow Removal (false):
	If set to (true), the mod will stop making sure the player has the book in 
	inventory on game load. 
	(This is automagically set to (true) when opening the MCM menu if available.)

SilenceSucces (default:false),
SilenceFail (default:false):
	If set to (true), will turn off in-game notifications of successful or failed
	soul trap attempts, respectiverly.

--------

Installation:

Place the contents of the archive in your Skyrim/Data directory.
Works with Nexus Mod Manager and ModOrganizer.

EXTREMELY IMPORTANT:
Make certain that the version of "magicsoultrapfxscript.pex" is the one provided by this mod.

--------

Compatibility:

As long as no other mod overwrites magicSoulTrapFXScript.pex, there will be no compatibility issues.
This mod makes the same fixes to the script as the Unofficial Patch and can overwrite it without issue.

This means it will work with mods like "Perkus Maximus" and "Apocalypse - Magic of Skyrim" WITHOUT needing a patch.

Any mods that also modify the above script will be incompatible unless otherwise noted by that mod's author.

--------

Getting mod-added soul gem items to work with ASGM:

This feature requires PapyrusUtil (and therefore SKSE) in order to work, but is not required for ASGM in general.

Mod-added gems can be made to work with ASGM by including a json file in the "/data/interface/asgm/" folder, with a unique name to ensure it not be overwritten.
(It is recommended to use the name of the mod, unless the name is "Vanilla", in that case use something else, like "VanillaMod".)
How to treat the gem(s) is determined by which list it is in: mod-added gems that behave like a Black Star should be put into the "BlackStar" list, whereas gems that behave as a Common Soul Gem should be put into the "Common" list, etc.

SPECIAL NOTE: You MUST include a filled version as well as an unfilled version for any mod-added items that are not equivalent to Grand or Black Soul Gems or either of the Stars. (Not having a filled gem version would result in the item being destroyed by the LossyCapture feature, if enabled, and only recoverable with a console command.)

There is a default "vanilla.json" file that can be used as an example of the correct formatting for such a file. Do not make changes to this file. Create a new file with a unique name.

The json file can be created by hand, or by using PapyrusUtil's JsonUtil, refer to the makeVanilla() function in ASGMStartup.pec for an example of the latter.

If creating the file by hand, note that the format of an item entry is ' "<type>" : [ "<last 6 characters of FormID converted to decimal>:<Mod filename>" ] ', as for example:

"petty" : [ "189666:Skyrim.esm" ]

Also take note that CC content is handled specially: ALL CC content FormIDs begin with FE, the following three characters are determined by the alphabetical sort order of all the various CC mods, and only the last three characters actually matter for the purposes of adding the item to ASGM. (Not the last six as with normal mods.)

For example, if you have an item that says it's FormID is "FE05A800", only the "800" matters.

"common" : ["2049:ccbgssse037-curios.esl" ]
(This example is the "Flawed Varla Stone" from the "Rare Curios" CC content. FormID is "FExxx801", only the 801 matters, 0x801 = 0d2049.)
--------

Note on "filled" Soul Gems:
A "Grand Soul Gem" with a Grand Soul trapped in it (ID# 0002E4FC)
is not the same thing as a "Grand Soul Gem (Grand)" (ID# 0002E4FF)
even though they look exactly alike in game. There are mods that will
automagically replace the former with the latter, in part to fix
the Soul Gem dropping bug. I strongly suggest you get one of them.
The Unofficial Patch is a really good one, as it fixes other things as well.

--------

Changelog:
Version 4.7:
	Made soul gem list be rebuilt on every game load, allowing the gem list to update dynamically.

Version 4.6.6:
	Added ability to enable mod-added soul gem items to work with ASGM. (Feature requires PapyrusUtil.)
	Update Italian and Polish translations.

Version 4.6.5:
	Removed unneeded book recipe.

Version 4.6.4:
	Removed buggy freeze-inducing script ASGMScriptMaintenance.

Version 4.6.3:
	Updated Lossy Capture to not include Black Souls, as was originally intended. Oops.

Version 4.6.2:
	Updated .esp to fix bug with capturing souls from already dead creatures.
	Updated Settings book text.

Version 4.6.1:
	Fixed issues with book not loading at game start (Skyrim and SkyrimSE)
		and on saved game loading (SkryrimSE).

Version 4.6:
	Added option to capture souls in a too-small container at a loss.

Version 4.5.2:
	Added option to allow removal of book.

Version 4.5.1:
	Added this text to the book.
	Renamed book to sort to top.
	Prevented book from showing in trade menus.
	Prevented crafting book when book exists in inventory.
	Make it more likely book will be given to player on game load.

Version 4.5:
	Added recipe for Options Book so it is craftable if needed. Uses 1 leather strip.
	Changed message silence option to be two settings, one for silencing success messages, and one for silencing fail messages.
	Revamped how settings are stored, now uses one global for all settings rather than one for each.

Version 4.2
	Added Options Menu Book for those without access to the console.
	Minor fixes and optimizations.

Version 4.1.1
	Removed edits to soul gems for mod compatibility.
		No longer fixes soul gem dropping bug. (Unofficial Patch recommended.)
		No longer breaks names from sorting mods.
		Initial release - Skyrim SE (PC/XBone)
Version 4.1
	Fixed Soul Stealer perk not working with mod.
	
Version 4.0.m
	Merged non-SKSE and International forks, SKSE only required for International mode, off by default.
	Fixed Black Soul Gem duplication bug.

Version 3.2.r, 3.2.i.r
	Reupload to fix incorrect linking of Petty Soul Gems.

Version 3.2, 3.2.i
	Fixed soul gem bug regression.

Version 3.1.i
	Language localization support added.
	SKSE required for international version to work correctly! Still not required for standard, English-only version.

Version 3.1
	Fixed bug w/ Black Soul Gems introduced in 3.0, no longer interferes with autolooting mods at all. 

Version 3.0
	Removed mod dependency, no other mods required to be installed for this mod to work correctly.

Version 2.9.1
	Fixed soul gem duplication bug introduced in v.2.9.

Version 2.9
	Updated gem checking to interfere with looting mods less. Glitches will now only occur, if ever, once the player has either Star.

Version 2.8
	Bugfixing: Stop trying to steal souls from the ones that aren't dead yet.

	Initial release - USLEP dependancy update.

Version 2.7

	Bugfixing: (Failed to) Capture spamming, most noticable with soul trap enchanted weapons, fixed.
		Uses unused ActorVariable BrainCondition to make sure soul traps are not performed on soulless victims.

Version 2.6

	Initial release

	No patches required for Apocalypse, PerkusMaximus, etc.

	Uses MCM for configuration. (Not required.)

	Able to capture multiple souls at the same time, unlike ASG v2.5.6

	Upgrade Ordinator if experiencing problems with this and it.