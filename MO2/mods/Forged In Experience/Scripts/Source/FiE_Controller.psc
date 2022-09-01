Scriptname FiE_Controller extends ReferenceAlias
{The FiE controller script that contain all useful fucntions for mod working.}

GlobalVariable Property FiE_GV_LearningPoint Auto
GlobalVariable Property FiE_GV_LPperLevel Auto
GlobalVariable Property FiE_GV_XPBonus Auto
GlobalVariable Property FiE_GV_TotalXPGained Auto

Actor Property player Auto

Int Function LoadConfigs()
    LoadExpTable("Data/Fexperience/Actors/Races", "racesExpMap")
    LoadExpTable("Data/Fexperience/Actors/Factions", "factionsExpMap")
    LoadExpTable("Data/Fexperience/Actors/Unique", "actorsExpMap")
    LoadExpTable("Data/Fexperience/Actors/UniqueLP", "uniqueLPMap")
    LoadSimpleJSON("Data/Fexperience/Actors/actor_av.json", "actorValuesExpMap")
    LoadSimpleJSON("Data/Fexperience/quests.json", "questsMap")

    return 0
endFunction

function CreateXPMessage(Actor pActor, int xp, int currentXP, int nextXP)
    If (xp <= 0)
        return
    EndIf

    int handle = ModEvent.Create("FiE_XPMessage")
    ModEvent.PushString(handle, "${" + pActor.GetLevel() + "}{" + pActor.GetDisplayName() + "}:_{" + xp + "}_XP_({" + currentXP + "}/{" + nextXP + "})")
    ModEvent.Send(handle)
    
endfunction

function CreateXPMessageFromQuest(int xp, int currentXP, int nextXP)
    If (xp <= 0)
        return
    EndIf

    int handle = ModEvent.Create("FiE_XPMessage")
    ModEvent.PushString(handle, "$ObjectiveCompleted{" + xp + "}_XP_({" + currentXP + "}/{" + nextXP + "})")
    ModEvent.Send(handle)
endfunction

function CreateLPMessage(int count, int currentValue)
    int handle = ModEvent.Create("FiE_XPMessage")
    ModEvent.PushString(handle, "$Gained{" + count + "}_LP{"+ currentValue +"}")
    ModEvent.Send(handle)
endfunction

Int function LoadExpTable(string path, string dbKey)
    JDB.setObj(dbKey, 0)
    int racesMap = JValue.addToPool(JIntMap.object(), "tempMap")

    string[] files = JContainers.contentsOfDirectoryAtPath(path, ".json")
    int index = 0
    int size = files.Length

    While (index < size)
        int expTableFile = JValue.addToPool(JValue.readFromFile(files[index]), "expTableFile")
        float modifier = JValue.solveFlt(expTableFile, ".valueModifier")
        int valueIndex = 0
        while (JValue.hasPath(expTableFile, ".values[" + valueIndex + "][0]"))
            int formID = JValue.solveForm(expTableFile, ".values[" + valueIndex + "][0]").GetFormID()
            float exp = JValue.solveInt(expTableFile, ".values[" + valueIndex + "][1]", 0) * modifier
            JIntMap.setFlt(racesMap, formID, exp)
            valueIndex += 1
        EndWhile
        index += 1
        JValue.cleanPool("expTableFile")
    EndWhile
    
    JDB.setObj(dbKey, racesMap)
    JValue.cleanPool("tempMap")
    return 0
endFunction

function LoadSimpleJSON(string path, string dbKey)
    int jObject = JValue.readFromFile(path)
    JDB.setObj(dbKey, jObject)
endfunction

function CalculateExpFromActor(Actor pActor)
    int uniqExp = GetExpFromUniqueActor(pActor)
    int uniqLP = GetLPFromUniqueActor(pActor)

    AddLPToPlayer(uniqLP)
    If (uniqExp > -1)
        AddExpToPlayerFromActor(uniqExp, pActor)
        return
    EndIf

    int raceExp = GetExpFromRace(pActor)
    int factionExp = GetExpFromFraction(pActor)
    float avExp = GetExpFromAV(pActor)
    float multByLevel = GetMultByLevel(pActor)

    int exp = (((raceExp + factionExp) + avExp) * (1 + multByLevel)) as int
    
    If (exp <= 0)
        return
    EndIf

    AddExpToPlayerFromActor(exp, pActor)
endfunction

int[] property CachedCompletedQuests auto
string[] property QuestsName auto

function CalculateExpFromQuest()
    int exp = 0
    int lp = 0
    int index = 0
    While (index < QuestsName.Length)
        string name = QuestsName[index]
        int completedQuestCount = Game.QueryStat(name)
        int cachedCompletedQuestsCount = CachedCompletedQuests[index]

        if(completedQuestCount > cachedCompletedQuestsCount)
            int xpvalue = (JDB.solveInt(".questsMap." + name + "[0]", 0) * FiE_GV_XPBonus.GetValue()) as int
            int lpvalue = JDB.solveInt(".questsMap." + name + "[1]", 0)
            int increment = JDB.solveInt(".questsMap." + name + "[2]", 0)
            
            int total = ((xpvalue+(xpvalue*completedQuestCount*increment))/(2*increment)) * completedQuestCount
            int prev = ((xpvalue+(xpvalue*cachedCompletedQuestsCount*increment))/(2*increment)) * cachedCompletedQuestsCount
            exp += Math.abs(total-prev) as int
            lp += lpvalue

            CachedCompletedQuests[index] = completedQuestCount
        endif

        index += 1
    EndWhile

    AddLPToPlayer(lp)
    float expValue = AddXPToPlayer(exp)
    float valueToNext = Game.getExperienceForLevel(player.GetLevel())
    CreateXPMessageFromQuest(exp, expValue as int, valueToNext as int)
endfunction

function AddExpToPlayerFromActor(float pExp, Actor pActor)
    pExp = pExp * FiE_GV_XPBonus.GetValue()
    float expValue = AddXPToPlayer(pExp)
    float valueToNext = Game.getExperienceForLevel(player.GetLevel())
    CreateXPMessage(pActor, pExp as int, expValue as int, valueToNext as int)
endfunction

bool property levelIncreaseUIShowed auto
float Function AddXPToPlayer(float value)
    int level = player.GetLevel()
    float levelExp = Game.getExperienceForLevel(level)
    float playerExp = Game.GetPlayerExperience()
    float bonusExperience = playerExp + value
    Game.SetPlayerExperience(bonusExperience)
    FiE_GV_TotalXPGained.Mod(value)

    float endPercent = bonusExperience / levelExp * 100
    if (endPercent < 100 || levelIncreaseUIShowed)
        return bonusExperience
    endif

    levelIncreaseUIShowed = true
    UI.InvokeString("HUD Menu", "_global.QuestNotification.AnimLetter.ShowQuestUpdate", "NEW LEVEL")
    UI.InvokeString("HUD Menu", "_global.QuestNotification.Instance.LevelMeterBaseInstance.gotoAndPlay", "FadeIn")
    UI.InvokeFloat("HUD Menu", "_global.QuestNotification.Instance.LevelUpMeter.SetPercent", 95)
    UI.InvokeFloat("HUD Menu", "_global.QuestNotification.Instance.LevelUpMeter.SetTargetPercent", 100)
    UI.InvokeString("HUD Menu", "_global.QuestNotification.Instance.LevelMeterBaseInstance.LevelTextBaseInstance.levelValue.SetText", (level + 1))

    Utility.Wait(3.0)
    UI.InvokeString("HUD Menu", "_global.QuestNotification.Instance.LevelMeterBaseInstance.gotoAndPlay", "FadeOut")

    return bonusExperience
EndFunction

function AddLPFromNewLevel()
    AddLPToPlayer(FiE_GV_LPperLevel.GetValueInt())
endfunction

function AddLPToPlayer(int value)
    if(value == 0)
        return
    endif

    float lp = FiE_GV_LearningPoint.Mod(value)
    CreateLPMessage(value, lp as int)
endfunction

Int function GetExpFromUniqueActor(Actor pActor)
    int exp = JDB.solveInt(".actorsExpMap[" + pActor.GetActorBase().GetFormID() + "]", -1)
    return exp
endfunction

Int function GetLPFromUniqueActor(Actor pActor)
    int lp = JDB.solveInt(".uniqueLPMap[" + pActor.GetActorBase().GetFormID() + "]", 0)
    return lp
endfunction

Int function GetExpFromRace(Actor pActor)
    int id = pActor.GetRace().GetFormID()
    int exp = JDB.solveInt(".racesExpMap[" + id + "]", 0)
    return exp
endfunction

Int function GetExpFromFraction(Actor pActor)
    int expValue = 0
    Faction[] factions = pActor.GetFactions(0, 127)

    If (factions.Length <= 0)
        return expValue
    EndIf

    int index = 0
    While (index < factions.Length)
        int id = factions[index].GetFormID()
        int exp = JDB.solveInt(".factionsExpMap[" + id + "]", 0)
        if(exp > expValue)
            expValue = exp
        endif
        index += 1
    EndWhile
    return expValue
endfunction

float function GetExpFromAV(Actor pActor)
    float exp = 0
    float multiply = JDB.solveFlt(".actorValuesExpMap.valueModifier", 0.1)
    int index = 0
    
    While (JDB.hasPath(".actorValuesExpMap.actorValues[" + index + "][0]"))
        string name = JDB.solveStr(".actorValuesExpMap.actorValues[" + index + "][0]")
        float modifier = JDB.solveFlt(".actorValuesExpMap.actorValues[" + index + "][1]", 1.0)
        float value = pActor.GetBaseActorValue(name) * multiply
        exp += value * modifier

        index += 1
    EndWhile

    return exp
endfunction

float function GetMultByLevel(Actor pActor)
    return pActor.GetLevel() * JDB.solveFlt(".actorValuesExpMap.coefByActorLevel", 1)
endfunction