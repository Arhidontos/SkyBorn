scriptname magicSoulTrapFXScript extends ActiveMagicEffect
{Scripted effect for the Soul Trap Visual FX}

import debug
import StringUtil

;======================================================================================;
;	PROPERTIES	/
;=============/
ImageSpaceModifier property TrapImod auto
{IsMod applied when we trap a soul}
Sound property TrapSoundFX auto ; create a sound property we'll point to in the editor
{Sound played when we trap a soul}
VisualEffect property targetVFX auto
{Visual Effect on target aiming at caster}
VisualEffect property casterVFX auto
{Visual Effect on caster aiming at target}
EffectShader property casterFXS auto
{Effect Shader on caster during Soul trap}
EffectShader property targetFXS auto
{Effect Shader on target during Soul trap}
bool property bIsEnchantmentEffect = false auto
{Set this to true if this soul trap is on a weapon enchantment or a spell that can do damage to deal with a fringe case}

;======================================================================================;
;	VARIABLES	/
;=============/
actor victim
bool deadAlready = false
bool bUseWait = true

;======================================================================================;
; ASG VARIABLES		/
;=================/
string ASGversion = "4.6.6"

;Handles thread locking so only one Soul Trap occurs at a time.
ASGThreadLock ThreadLockHandler
;Chest to hold the Soul Gems when performing the soul size checks
ObjectReference ASGGemHolderRef

GlobalVariable ASGMSettings
Keyword ActorTypeNPC

SoulGem[] SoulGemPetty
SoulGem[] SoulGemPettyFilled
SoulGem[] SoulGemLesser
SoulGem[] SoulGemLesserFilled
SoulGem[] SoulGemCommon
SoulGem[] SoulGemCommonFilled
SoulGem[] SoulGemGreater
SoulGem[] SoulGemGreaterFilled
SoulGem[] SoulGemGrand
SoulGem[] SoulGemBlack
SoulGem[] AzurasStar
SoulGem[] BlackStar

int[] numBlackStar
int[] numAzurasStar
int[] numBlack
int[] numGrand
int[] numGreater
int[] numCommon
int[] numLesser

string AllGems = "../../../interface/asgm/all/list.json"

;Position of each setting in the "settings" array once we've transffered ASGMSettings
int LossyCapture = 6
int AllowRemove = 5
int International = 4
int OnlyBlack = 3
int OnlyFull = 2
int SilenceSuccess = 1
int SilenceFail = 0

;======================================================================================;
;	eventS		/
;=============/
event OnEffectStart(Actor target, Actor caster)
	debug.trace("ASGSoulTrap v"+ASGversion+" - Beginning Effect")
	victim = target
	
	if bIsEnchantmentEffect == false
		deadAlready = victim.isDead()
	endIf
	bUseWait = false
	if (!victim.isDead() && victim.getActorValue("BrainCondition") == 8675309)
		victim.setActorValue("BrainCondition", 100)
	endIf
	;debug.trace("Is Soultrap target dead? ("+deadAlready+")("+victim+")")
endEvent

event OnEffectFinish(Actor target, Actor caster)
	debug.trace("ASGSoulTrap v"+ASGversion+" - Ending Effect")
	;debug.trace(self + " is finishing")
	
	;setup lock
	ThreadLockHandler = game.getFormFromFile(0x0022EE, "AcquisitiveSoulGemMultithreaded.esp") as ASGThreadLock
	if ThreadLockHandler != None
		debug.trace("ASGSoulTrap v"+ASGversion+" - Acquiring Lock")
		while !ThreadLockHandler.AcquireLock(caster)
			utility.wait(0.1)
		endWhile
		debug.trace("ASGSoulTrap v"+ASGversion+" - Lock Acquired")
	endIf
	
	if victim
		if bUseWait
			utility.wait(0.25)
		endIf
		
		debug.trace("ASGSoulTrap v"+ASGversion+" - BrainCondition: "+victim.getActorValue("BrainCondition"))
		if (!deadAlready && victim.isDead() && victim.getActorValue("BrainCondition") != 8675309)
			debug.trace("ASGSoulTrap v"+ASGversion+" - BrainCondition is good, proceeding")
			
			;Create the arrays
			SoulGemPetty = new SoulGem[128]
			SoulGemPettyFilled = new SoulGem[128]
			SoulGemLesser = new SoulGem[128]
			SoulGemLesserFilled = new SoulGem[128]
			SoulGemCommon = new SoulGem[128]
			SoulGemCommonFilled = new SoulGem[128]
			SoulGemGreater = new SoulGem[128]
			SoulGemGreaterFilled = new SoulGem[128]
			SoulGemGrand = new SoulGem[128]
			SoulGemBlack = new SoulGem[128]
			AzurasStar = new SoulGem[128]
			BlackStar = new SoulGem[128]
			
			numBlackStar = new int[128]
			numAzurasStar = new int[128]
			numBlack = new int[128]
			numGrand = new int[128]
			numGreater = new int[128]
			numCommon = new int[128]
			numLesser = new int[128]
			
			;Set references
			ASGGemHolderRef = game.getFormFromFile(0x002857, "AcquisitiveSoulGemMultithreaded.esp") as ObjectReference
			ActorTypeNPC = game.getFormFromFile(0x013794, "Skyrim.esm") as Keyword
			ASGMSettings = game.getFormFromFile(0x000d65, "AcquisitiveSoulGemMultithreaded.esp") as GlobalVariable
			
			string[] PettySoulGems = JsonUtil.StringListToArray(AllGems, "Petty")
			SoulGemPetty[0] = game.getFormFromFile(0x02e4e2, "Skyrim.esm") as SoulGem
			int i = 0
			while i < PettySoulGems.Length
				int FormID = StringUtil.Substring(PettySoulGems[i], 0, StringUtil.Find(PettySoulGems[i], ":", 0)) as int
				string ModName = StringUtil.Substring(PettySoulGems[i], StringUtil.Find(PettySoulGems[i], ":", 0) + 1)
				SoulGemPetty[i] = game.getFormFromFile(FormID, ModName) as SoulGem
				i += 1
			endWhile
			
			string[] FilledPettySoulGems = JsonUtil.StringListToArray(AllGems, "FilledPetty")
			SoulGemPettyFilled[0] = game.getFormFromFile(0x02e4e3, "Skyrim.esm") as SoulGem
			i = 0
			while i < FilledPettySoulGems.Length
				int FormID = StringUtil.Substring(FilledPettySoulGems[i], 0, StringUtil.Find(FilledPettySoulGems[i], ":", 0)) as int
				string ModName = StringUtil.Substring(FilledPettySoulGems[i], StringUtil.Find(FilledPettySoulGems[i], ":", 0) + 1)
				SoulGemPettyFilled[i] = game.getFormFromFile(FormID, ModName) as SoulGem
				i += 1
			endWhile
			
			string[] LesserSoulGems = JsonUtil.StringListToArray(AllGems, "Lesser")
			SoulGemLesser[0] = game.getFormFromFile(0x02e4e4, "Skyrim.esm") as SoulGem
			i = 0
			while i < LesserSoulGems.Length
				int FormID = StringUtil.Substring(LesserSoulGems[i], 0, StringUtil.Find(LesserSoulGems[i], ":", 0)) as int
				string ModName = StringUtil.Substring(LesserSoulGems[i], StringUtil.Find(LesserSoulGems[i], ":", 0) + 1)
				SoulGemLesser[i] = game.getFormFromFile(FormID, ModName) as SoulGem
				i += 1
			endWhile
			
			string[] FilledLesserSoulGems = JsonUtil.StringListToArray(AllGems, "FilledLesser")
			SoulGemLesserFilled[0] = game.getFormFromFile(0x02e4e5, "Skyrim.esm") as SoulGem
			i = 0
			while i < FilledLesserSoulGems.Length
				int FormID = StringUtil.Substring(FilledLesserSoulGems[i], 0, StringUtil.Find(FilledLesserSoulGems[i], ":", 0)) as int
				string ModName = StringUtil.Substring(FilledLesserSoulGems[i], StringUtil.Find(FilledLesserSoulGems[i], ":", 0) + 1)
				SoulGemLesserFilled[i] = game.getFormFromFile(FormID, ModName) as SoulGem
				i += 1
			endWhile
			
			string[] CommonSoulGems = JsonUtil.StringListToArray(AllGems, "Common")
			SoulGemCommon[0] = game.getFormFromFile(0x02e4e6, "Skyrim.esm") as SoulGem
			i = 0
			while i < CommonSoulGems.Length
				int FormID = StringUtil.Substring(CommonSoulGems[i], 0, StringUtil.Find(CommonSoulGems[i], ":", 0)) as int
				string ModName = StringUtil.Substring(CommonSoulGems[i], StringUtil.Find(CommonSoulGems[i], ":", 0) + 1)
				SoulGemCommon[i] = game.getFormFromFile(FormID, ModName) as SoulGem
				i += 1
			endWhile
			
			string[] FilledCommonSoulGems = JsonUtil.StringListToArray(AllGems, "FilledCommon")
			SoulGemCommonFilled[0] = game.getFormFromFile(0x02e4f3, "Skyrim.esm") as SoulGem
			i = 0
			while i < FilledCommonSoulGems.Length
				int FormID = StringUtil.Substring(FilledCommonSoulGems[i], 0, StringUtil.Find(FilledCommonSoulGems[i], ":", 0)) as int
				string ModName = StringUtil.Substring(FilledCommonSoulGems[i], StringUtil.Find(FilledCommonSoulGems[i], ":", 0) + 1)
				SoulGemCommonFilled[i] = game.getFormFromFile(FormID, ModName) as SoulGem
				i += 1
			endWhile
			
			string[] GreaterSoulGems = JsonUtil.StringListToArray(AllGems, "Greater")
			SoulGemGreater[0] = game.getFormFromFile(0x02e4f4, "Skyrim.esm") as SoulGem
			i = 0
			while i < GreaterSoulGems.Length
				int FormID = StringUtil.Substring(GreaterSoulGems[i], 0, StringUtil.Find(GreaterSoulGems[i], ":", 0)) as int
				string ModName = StringUtil.Substring(GreaterSoulGems[i], StringUtil.Find(GreaterSoulGems[i], ":", 0) + 1)
				SoulGemGreater[i] = game.getFormFromFile(FormID, ModName) as SoulGem
				i += 1
			endWhile
			
			string[] FilledGreaterSoulGems = JsonUtil.StringListToArray(AllGems, "FilledGreater")
			SoulGemGreaterFilled[0] = game.getFormFromFile(0x02e4fb, "Skyrim.esm") as SoulGem
			i = 0
			while i < FilledGreaterSoulGems.Length
				int FormID = StringUtil.Substring(FilledGreaterSoulGems[i], 0, StringUtil.Find(FilledGreaterSoulGems[i], ":", 0)) as int
				string ModName = StringUtil.Substring(FilledGreaterSoulGems[i], StringUtil.Find(FilledGreaterSoulGems[i], ":", 0) + 1)
				SoulGemGreaterFilled[i] = game.getFormFromFile(FormID, ModName) as SoulGem
				i += 1
			endWhile
			
			string[] GrandSoulGems = JsonUtil.StringListToArray(AllGems, "Grand")
			SoulGemGrand[0] = game.getFormFromFile(0x02e4fc, "Skyrim.esm") as SoulGem
			i = 0
			while i < GrandSoulGems.Length
				int FormID = StringUtil.Substring(GrandSoulGems[i], 0, StringUtil.Find(GrandSoulGems[i], ":", 0)) as int
				string ModName = StringUtil.Substring(GrandSoulGems[i], StringUtil.Find(GrandSoulGems[i], ":", 0) + 1)
				SoulGemGrand[i] = game.getFormFromFile(FormID, ModName) as SoulGem
				i += 1
			endWhile
			
			string[] BlackSoulGems = JsonUtil.StringListToArray(AllGems, "Black")
			SoulGemBlack[0] = game.getFormFromFile(0x02e500, "Skyrim.esm") as SoulGem
			i = 0
			while i < BlackSoulGems.Length
				int FormID = StringUtil.Substring(BlackSoulGems[i], 0, StringUtil.Find(BlackSoulGems[i], ":", 0)) as int
				string ModName = StringUtil.Substring(BlackSoulGems[i], StringUtil.Find(BlackSoulGems[i], ":", 0) + 1)
				SoulGemBlack[i] = game.getFormFromFile(FormID, ModName) as SoulGem
				i += 1
			endWhile
			
			string[] AzurasStars = JsonUtil.StringListToArray(AllGems, "AzurasStar")
			AzurasStar[0] = game.getFormFromFile(0x063b27, "Skyrim.esm") as SoulGem
			i = 0
			while i < AzurasStars.Length
				int FormID = StringUtil.Substring(AzurasStars[i], 0, StringUtil.Find(AzurasStars[i], ":", 0)) as int
				string ModName = StringUtil.Substring(AzurasStars[i], StringUtil.Find(AzurasStars[i], ":", 0) + 1)
				AzurasStar[i] = game.getFormFromFile(FormID, ModName) as SoulGem
				i += 1
			endWhile
			
			string[] BlackStars = JsonUtil.StringListToArray(AllGems, "BlackStar")
			i = 0
			BlackStar[0] = game.getFormFromFile(0x063b29, "Skyrim.esm") as SoulGem
			while i < BlackStars.Length
				int FormID = StringUtil.Substring(BlackStars[i], 0, StringUtil.Find(BlackStars[i], ":", 0)) as int
				string ModName = StringUtil.Substring(BlackStars[i], StringUtil.Find(BlackStars[i], ":", 0) + 1)
				BlackStar[i] = game.getFormFromFile(FormID, ModName) as SoulGem
				i += 1
			endWhile
			
			;Get the current settings
			int set_temp = ASGMSettings.getValueInt()
			int bit_pos = 0
			bool[] setting = new bool[32]
			while (bit_pos < 32)
				if (set_temp - 2 * (set_temp / 2) > 0)
					setting[bit_pos] = true
				else
					setting[bit_pos] = false
				endIf
				bit_pos += 1
				set_temp /= 2
			endWhile
			
			;Perform soul size checks
			int targetLevel = victim.getLevel()
			debug.trace("ASGSoulTrap v"+ASGversion+" - Performing Gem checks")
			string soulType = "Black"
			if(!victim.hasKeyword(ActorTypeNPC))
				if(setting[OnlyBlack])
					i = 0
					while BlackStar[i] != None
						numBlackStar[i] = caster.getItemCount(BlackStar[i])
						caster.removeItem(BlackStar[i], numBlackStar[i], true, ASGGemHolderRef)
						i += 1
					endWhile
					i = 0
					while SoulGemBlack[i] != None
						numBlack[i] = caster.getItemCount(SoulGemBlack[i])
						caster.removeItem(SoulGemBlack[i], numBlack[i], true)
						i += 1
					endWhile
				endIf
				soulType = "Grand"
				if(targetLevel < game.getGameSettingInt("iGrandSoulActorLevel"))
					i = 0
					while SoulGemBlack[i] != None
						numBlack[i] = numBlack[i] + caster.getItemCount(SoulGemBlack[i])
						caster.removeItem(SoulGemBlack[i], numBlack[i], true )
						i += 1
					endWhile
					i = 0
					while SoulGemGrand[i] != None
						numGrand[i] = caster.getItemCount(SoulGemGrand[i])
						caster.removeItem(SoulGemGrand[i], numGrand[i], true )
						i += 1
					endWhile
					if(setting[OnlyFull])
						i = 0
						while BlackStar[i] != None
							numBlackStar[i] = numBlackStar[i] + caster.getItemCount(BlackStar[i])
							caster.removeItem(BlackStar[i], numBlackStar[i], true, ASGGemHolderRef)
							i += 1
						endWhile
						i = 0
						while AzurasStar[i] != None
							numAzurasStar[i] = caster.getItemCount(AzurasStar[i])
							caster.removeItem(AzurasStar[i], numAzurasStar[i], true, ASGGemHolderRef)
							i += 1
						endWhile
					endIf
					soulType = "Greater"
				endIf
				if(targetLevel < game.getGameSettingInt("iGreaterSoulActorLevel"))
					i = 0
					while SoulGemGreater[i] != None
						numGreater[i] = caster.getItemCount(SoulGemGreater[i])
						caster.removeItem(SoulGemGreater[i], numGreater[i], true )
						i += 1
					endWhile
					soulType = "Common"
				endIf
				if(targetLevel < game.getGameSettingInt("iCommonSoulActorLevel"))
					i = 0
					while SoulGemCommon[i] != None
						numCommon[i] = caster.getItemCount(SoulGemCommon[i])
						caster.removeItem(SoulGemCommon[i], numCommon[i], true )
						i += 1
					endWhile
					soulType = "Lesser"
				endIf
				if(targetLevel < game.getGameSettingInt("iLesserSoulActorLevel"))
					i = 0
					while SoulGemLesser[i] != None
						numLesser[i] = caster.getItemCount(SoulGemLesser[i])
						caster.removeItem(SoulGemLesser[i], numLesser[i], true )
						i += 1
					endWhile
					soulType = "Petty"
				endIf
			endIf

			;capture soul
			debug.trace("ASGSoulTrap v"+ASGversion+" - Trapping soul")
			bool result = caster.trapSoul(victim)
			victim.setActorValue("BrainCondition", 8675309)

			;Perform lossy capture if enabled and normal trapping didn't work.
			if (setting[LossyCapture] && !result && !victim.hasKeyword(ActorTypeNPC))
				debug.trace("ASGSoulTrap v"+ASGversion+" - Running Lossy Capture checks: targetLevel: "+targetLevel+" Grand Soul Level: "+game.getGameSettingInt("iGrandSoulActorLevel")+" Greater Soul Level: "+game.getGameSettingInt("iGreaterSoulActorLevel")+" Common Soul Level: "+game.getGameSettingInt("iCommonSoulActorLevel")+" Lesser Soul Level: "+game.getGameSettingInt("iLesserSoulActorLevel"))
				if (targetLevel > game.getGameSettingInt("iGreaterSoulActorLevel"))
					i = 0
					while SoulGemGreater[i] != None && i < 128 && !result
						if (caster.getItemCount(SoulGemGreater[i]) > 0)
							debug.trace("ASGSoulTrap v"+ASGversion+" - Soul at least Greater, have Greater Soul Gem")
							result = true
							soulType = "Greater"
							caster.removeItem(SoulGemGreater[i], 1, true)
							caster.addItem(SoulGemGreaterFilled[i], 1, true)
						endIf
						i += 1
					endWhile
				endIf
				if (targetLevel > game.getGameSettingInt("iCommonSoulActorLevel"))
					i = 0
					while SoulGemCommon[i] != None && i < 128 && !result
						if (caster.getItemCount(SoulGemCommon[i]) > 0)
							debug.trace("ASGSoulTrap v"+ASGversion+" - Soul at least Common, have Common Soul Gem")
							result = true
							soulType = "Common"
							caster.removeItem(SoulGemCommon[i], 1, true)
							caster.addItem(SoulGemCommonFilled[i], 1, true)
						endIf
						i += 1
					endWhile
				endIf
				if (targetLevel > game.getGameSettingInt("iLesserSoulActorLevel"))
					i = 0
					while SoulGemLesser[i] != None && i < 128 && !result
						if (caster.getItemCount(SoulGemLesser[i]) > 0)
							debug.trace("ASGSoulTrap v"+ASGversion+" - Soul at least Lesser, have Lesser Soul Gem")
							result = true
							soulType = "Lesser"
							caster.removeItem(SoulGemLesser[i], 1, true)
							caster.addItem(SoulGemLesserFilled[i], 1, true)
						endIf
						i += 1
					endWhile
				endIf
				i = 0
				while SoulGemPetty[i] != None && i < 128 && !result
					if (caster.getItemCount(SoulGemPetty[i]) > 0)
						debug.trace("ASGSoulTrap v"+ASGversion+" - Have Petty Soul Gem")
						result = true
						soulType = "Petty"
						caster.removeItem(SoulGemPetty[i], 1, true)
						caster.addItem(SoulGemPettyFilled[i], 1, true)
					endIf
					i += 1
				endWhile

				;Inform player of lossy capture success if success notifications are turned on.
				if (result && !setting[SilenceSuccess])
					if (setting[International])
						debug.notification("$ASGLossyCapture")		;International SKSE version
					else
						debug.notification("Lossy Capture!")	;English-only non-SKSE version
					endIf
				endIf
			endIf

			;return all gems
			debug.trace("ASGSoulTrap v"+ASGversion+" - Returning Gems")
			i = 0
			while BlackStar[i] != None
				ASGGemHolderRef.removeItem(BlackStar[i], numBlackStar[i], true, caster)
				i += 1
			endWhile
			i = 0
			while AzurasStar[i] != None
				ASGGemHolderRef.removeItem(AzurasStar[i], numAzurasStar[i], true, caster)
				i += 1
			endWhile
			i = 0
			while SoulGemBlack[i] != None
				caster.addItem(SoulGemBlack[i], numBlack[i], true )
				i += 1
			endWhile
			i = 0
			while SoulGemGrand[i] != None
				caster.addItem(SoulGemGrand[i], numGrand[i], true )
				i += 1
			endWhile
			i = 0
			while SoulGemGreater[i] != None
				caster.addItem(SoulGemGreater[i], numGreater[i], true )
				i += 1
			endWhile
			i = 0
			while SoulGemCommon[i] != None
				caster.addItem(SoulGemCommon[i], numCommon[i], true )
				i += 1
			endWhile
			i = 0
			while SoulGemLesser[i] != None
				caster.addItem(SoulGemLesser[i], numLesser[i], true )
				i += 1
			endWhile

			;custom message
			debug.trace("ASGSoulTrap v"+ASGversion+" - Vanilla handling started")
			if(result)

				; Vanilla: "You have captured a soul!"

				;Inform player of successful capture, including what size was captured, if success notifications are on.
				if (!setting[SilenceSuccess])
					if (setting[International])
						debug.notification("$ASGCaptured"+soulType)		;International SKSE version
					else
						debug.notification(soulType+" soul captured!")	;English-only non-SKSE version
					endIf
				endIf

				;debug.trace(victim + " is, in fact, dead.	Play soul trap visFX")
				TrapSoundFX.play(caster)			; play TrapSoundFX sound from player
				TrapImod.apply()					; apply isMod at full strength
				targetVFX.play(victim,4.7,caster)	; Play targetVFX and aim them at the player
				casterVFX.play(caster,5.9,victim)
				targetFXS.play(victim,2)			; Play Effect Shaders
				casterFXS.play(caster,3)
			else
				;debug.trace(victim + " is, in fact, dead, But the TrapSoul check failed or came back false")
				; Vanilla: "There is no Soul Gem large enough to capture the soul."

				;Inform player of failed capture, including what size soul was not captured, if failure notifications are on.
				if (!setting[SilenceFail])
					if (setting[International])
						debug.notification("$ASGFailed"+soulType)					;International SKSE version
					else
						debug.notification("Failed to capture "+soulType+" soul.")	;English-only non-SKSE version
					endIf
				endIf
			endIf
		;else
			;debug.trace(self + "tried to soulTrap, but " + victim + " is already Dead.")
		endIf
	endIf

	;release lock
	if ThreadLockHandler != None
		debug.trace("ASGSoulTrap v"+ASGversion+" - Releasing Lock")
		ThreadLockHandler.ReleaseLock(caster)
		debug.trace("ASGSoulTrap v"+ASGversion+" - Lock Released")
	endIf
	debug.trace("ASGSoulTrap v"+ASGversion+" - Effect Ended")
endEvent
