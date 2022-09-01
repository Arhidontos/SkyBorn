scriptname FiE_TrainingWindow extends Quest

Message property FiE_TrainingMessageLightArmor auto
Message property FiE_TrainingMessageSneak auto
Message property FiE_TrainingMessageLockPicking auto
Message property FiE_TrainingMessagePickpocket auto
Message property FiE_TrainingMessageSpeech auto
Message property FiE_TrainingMessageAlchemy auto

Message property FiE_TrainingMessageSmithing auto
Message property FiE_TrainingMessageHeavyArmor auto
Message property FiE_TrainingMessageBlock auto
Message property FiE_TrainingMessageTwoHanded auto
Message property FiE_TrainingMessageOneHanded auto
Message property FiE_TrainingMessageArchery auto

Message property FiE_TrainingMessageIllusion auto
Message property FiE_TrainingMessageConjuration auto
Message property FiE_TrainingMessageDestruction auto
Message property FiE_TrainingMessageRestoration auto
Message property FiE_TrainingMessageAlteration auto
Message property FiE_TrainingMessageEnchanting auto

GlobalVariable property FiE_GV_MaxLevel auto
GlobalVariable property FiE_GV_PlayerSkillLevel auto

GlobalVariable property FiE_LearningPointsGV auto
GlobalVariable property FiE_GV_PlayerGold auto

GlobalVariable property FiE_GV_1CostG auto
GlobalVariable property FiE_GV_5CostG auto
GlobalVariable property FiE_GV_10CostG auto
GlobalVariable property FiE_GV_20CostG auto

GlobalVariable property FiE_GV_1CostLP auto
GlobalVariable property FiE_GV_5CostLP auto
GlobalVariable property FiE_GV_10CostLP auto
GlobalVariable property FiE_GV_20CostLP auto

GlobalVariable property FiE_GV_Show1 auto
GlobalVariable property FiE_GV_Show5 auto
GlobalVariable property FiE_GV_Show10 auto
GlobalVariable property FiE_GV_Show20 auto

GlobalVariable Property FiE_GV_IncreaseCostEvery Auto
GlobalVariable property FiE_GV_CostGoldMult auto
GlobalVariable property FiE_GV_CostLPMult auto

MiscObject Property Gold  Auto
Actor Property player Auto

function Show(string skillName, int trainerLevel)
    int skillLevel = player.GetBaseActorValue(skillName) as int

    FiE_GV_Show1.SetValueInt(1)
    FiE_GV_Show5.SetValueInt(1)
    FiE_GV_Show10.SetValueInt(1)
    FiE_GV_Show20.SetValueInt(1)

    FiE_GV_PlayerSkillLevel.SetValueInt(skillLevel)
    FiE_GV_MaxLevel.SetValueInt(trainerLevel)
    FiE_GV_PlayerGold.SetValueInt(player.GetItemCount(Gold))

    int gCost1 = CalculateGCost(skillLevel, 1)
    int gCost5 = CalculateGCost(skillLevel, 5)
    int gCost10 = CalculateGCost(skillLevel, 10)
    int gCost20 = CalculateGCost(skillLevel, 20)

    FiE_GV_1CostG.SetValueInt(gCost1)
    FiE_GV_5CostG.SetValueInt(gCost5)
    FiE_GV_10CostG.SetValueInt(gCost10)
    FiE_GV_20CostG.SetValueInt(gCost20)
            
    int lpCost1 = CalculateLPCost(skillLevel, 1)
    int lpCost5 = CalculateLPCost(skillLevel, 5)
    int lpCost10 = CalculateLPCost(skillLevel, 10)
    int lpCost20 = CalculateLPCost(skillLevel, 20)

    FiE_GV_1CostLP.SetValueInt(lpCost1)
    FiE_GV_5CostLP.SetValueInt(lpCost5)
    FiE_GV_10CostLP.SetValueInt(lpCost10)
    FiE_GV_20CostLP.SetValueInt(lpCost20)

    if(skillLevel+1 > trainerLevel)
        FiE_GV_Show1.SetValueInt(0)
        FiE_GV_1CostG.SetValueInt(0)
        FiE_GV_1CostLP.SetValueInt(0)
    endif

    if(skillLevel+5 > trainerLevel)
        FiE_GV_Show5.SetValueInt(0)
        FiE_GV_5CostG.SetValueInt(0)
        FiE_GV_5CostLP.SetValueInt(0)
    endif
        
    if(skillLevel+10 > trainerLevel)
        FiE_GV_Show10.SetValueInt(0)
        FiE_GV_10CostG.SetValueInt(0)
        FiE_GV_10CostLP.SetValueInt(0)
    endif

    if(skillLevel+20 > trainerLevel)
        FiE_GV_Show20.SetValueInt(0)
        FiE_GV_20CostG.SetValueInt(0)
        FiE_GV_20CostLP.SetValueInt(0)
    endif
    
    UpdateGlobals()
    Message pMessage = GetMessageByAV(skillName)
    
    if(!pMessage)
        return
    endif

    int inputIndex = pMessage.Show()
    if(inputIndex == 0)
        If (IncreaseSkill(skillName, 1, gCost1, lpCost1))
            Show(skillName, trainerLevel)
        EndIf
    elseif(inputIndex == 1)
        If (IncreaseSkill(skillName, 5, gCost5, lpCost5))
            Show(skillName, trainerLevel)
        EndIf
    elseif(inputIndex == 2)
        If (IncreaseSkill(skillName, 10, gCost10, lpCost10))
            Show(skillName, trainerLevel)
        EndIf
    elseif(inputIndex == 3)
        If (IncreaseSkill(skillName, 20, gCost20, lpCost20))
            Show(skillName, trainerLevel)
        EndIf
    elseif(inputIndex == 4)
        return
    endif
endfunction

int function CalculateGCost(int currentSkillValue, int countValue)
    int cost = 0
    int index = currentSkillValue
    While (index < currentSkillValue+countValue)
        index += 1
        cost += GetGCostFor(index)
    EndWhile
    return cost
endfunction

int function CalculateLPCost(int currentSkillValue, int countValue)
    int cost = 0
    int index = currentSkillValue
    While (index < currentSkillValue+countValue)
        index += 1
        cost += GetLPCostFor(index)
    EndWhile
    return cost
endfunction

int function GetGCostFor(int skillValue)
    return (Math.Ceiling(skillvalue/FiE_GV_IncreaseCostEvery.GetValue()))*FiE_GV_CostGoldMult.GetValueInt()
endfunction

int function GetLPCostFor(int skillValue)
    return (Math.Ceiling(skillvalue/FiE_GV_IncreaseCostEvery.GetValue()))*FiE_GV_CostLPMult.GetValueInt()
endfunction

bool function IncreaseSkill(String skillName, int value, int gCost, int lpCost)
    If (gCost > player.GetItemCount(Gold) || lpCost > FiE_LearningPointsGV.GetValueInt())
        Debug.MessageBox("$YOU_DONT_HAVE_GOLD_OR_LEARNING_POINTS")
        return false
    EndIf

    player.RemoveItem(Gold, gCost)
    FiE_LearningPointsGV.Mod(-lpCost)

    player.SetActorValue(skillName, player.GetBaseActorValue(skillName)+value)
    return true
endfunction

function UpdateGlobals()
    UpdateCurrentInstanceGlobal(FiE_GV_PlayerSkillLevel)
    UpdateCurrentInstanceGlobal(FiE_GV_MaxLevel)
    UpdateCurrentInstanceGlobal(FiE_LearningPointsGV)
    UpdateCurrentInstanceGlobal(FiE_GV_PlayerGold)

    UpdateCurrentInstanceGlobal(FiE_GV_1CostG)
    UpdateCurrentInstanceGlobal(FiE_GV_5CostG)
    UpdateCurrentInstanceGlobal(FiE_GV_10CostG)
    UpdateCurrentInstanceGlobal(FiE_GV_20CostG)
    UpdateCurrentInstanceGlobal(FiE_GV_1CostLP)
    UpdateCurrentInstanceGlobal(FiE_GV_5CostLP)
    UpdateCurrentInstanceGlobal(FiE_GV_10CostLP)
    UpdateCurrentInstanceGlobal(FiE_GV_20CostLP)

    UpdateCurrentInstanceGlobal(FiE_GV_Show1)
    UpdateCurrentInstanceGlobal(FiE_GV_Show5)
    UpdateCurrentInstanceGlobal(FiE_GV_Show10)
    UpdateCurrentInstanceGlobal(FiE_GV_Show20)
endfunction

Message function GetMessageByAV(string skillName)
    if(skillName == "LightArmor")
        return FiE_TrainingMessageLightArmor
    ElseIf (skillName == "Sneak")
        return FiE_TrainingMessageSneak
    ElseIf (skillName == "LockPicking")
        return FiE_TrainingMessageLockPicking
    ElseIf (skillName == "Pickpocket")
        return FiE_TrainingMessagePickpocket
    ElseIf (skillName == "Speechcraft")
        return FiE_TrainingMessageSpeech
    ElseIf (skillName == "Alchemy")
        return FiE_TrainingMessageAlchemy
    ElseIf (skillName == "Smithing")
        return FiE_TrainingMessageSmithing
    ElseIf (skillName == "HeavyArmor")
        return FiE_TrainingMessageHeavyArmor
    ElseIf (skillName == "Block")
        return FiE_TrainingMessageBlock
    ElseIf (skillName == "TwoHanded")
        return FiE_TrainingMessageTwoHanded
    ElseIf (skillName == "OneHanded")
        return FiE_TrainingMessageOneHanded
    ElseIf (skillName == "Marksman")
        return FiE_TrainingMessageArchery
    ElseIf (skillName == "Illusion")
        return FiE_TrainingMessageIllusion
    ElseIf (skillName == "Conjuration")
        return FiE_TrainingMessageConjuration
    ElseIf (skillName == "Destruction")
        return FiE_TrainingMessageDestruction
    ElseIf (skillName == "Restoration")
        return FiE_TrainingMessageRestoration
    ElseIf (skillName == "Alteration")
        return FiE_TrainingMessageAlteration
    ElseIf (skillName == "Enchanting")
        return FiE_TrainingMessageEnchanting
    endif
endfunction