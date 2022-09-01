Scriptname FiR_Ability_Serpent extends ActiveMagicEffect

Spell Property DoomWarriorSpell Auto
Spell Property DoomLadySpell Auto
Spell Property DoomLordSpell Auto
Spell Property DoomSteedSpell Auto

Spell Property DoomThiefSpell Auto
Spell Property DoomLoverSpell Auto
Spell Property DoomTowerSpell Auto
Spell Property DoomShadowSpell Auto

Spell Property DoomMageSpell Auto
Spell Property DoomAtronachSpell Auto
Spell Property DoomApperianceSpell Auto
Spell Property DoomRitualSpell Auto

Message Property FiR_Ability_Serpent_Start Auto
Message Property FiR_Ability_Serpent_Warrior Auto
Message Property FiR_Ability_Serpent_Thief Auto
Message Property FiR_Ability_Serpent_Mage Auto

event OnEffectStart(Actor target, Actor caster)
    ShowDialog(target)
endevent

function ClearSpells(Actor target)
target.RemoveSpell(DoomApperianceSpell)
target.RemoveSpell(DoomAtronachSpell)
target.RemoveSpell(DoomLadySpell)
target.RemoveSpell(DoomLordSpell)
target.RemoveSpell(DoomLoverSpell)
target.RemoveSpell(DoomMageSpell)
target.RemoveSpell(DoomRitualSpell)
target.RemoveSpell(DoomShadowSpell)
target.RemoveSpell(DoomSteedSpell)
target.RemoveSpell(DoomThiefSpell)
target.RemoveSpell(DoomTowerSpell)
target.RemoveSpell(DoomWarriorSpell)
endfunction

function ShowDialog(Actor target)
    int selection = FiR_Ability_Serpent_Start.Show()
    If (selection == 3)
        return
    Elseif(selection == 0)
        int doomSelection = FiR_Ability_Serpent_Warrior.Show()
        If (doomSelection == 0)
            ClearSpells(target)
            target.AddSpell(DoomWarriorSpell)
        elseif(doomSelection == 1)
            ClearSpells(target)
            target.AddSpell(DoomLadySpell)
        elseif(doomSelection == 2)
            ClearSpells(target)
            target.AddSpell(DoomLordSpell)
        elseif(doomSelection == 3)
            ClearSpells(target)
            target.AddSpell(DoomSteedSpell)
        elseif(doomSelection == 4)
            ShowDialog(target)
        EndIf
    Elseif(selection == 1)
        int doomSelection = FiR_Ability_Serpent_Thief.Show()
        If (doomSelection == 0)
            ClearSpells(target)
            target.AddSpell(DoomThiefSpell)
        elseif(doomSelection == 1)
            ClearSpells(target)
            target.AddSpell(DoomLoverSpell)
        elseif(doomSelection == 2)
            ClearSpells(target)
            target.AddSpell(DoomTowerSpell)
        elseif(doomSelection == 3)
            ClearSpells(target)
            target.AddSpell(DoomShadowSpell)
        elseif(doomSelection == 4)
            ShowDialog(target)
        EndIf
    Elseif(selection == 2)
        int doomSelection = FiR_Ability_Serpent_Mage.Show()

        If (doomSelection == 0)
            ClearSpells(target)
            target.AddSpell(DoomMageSpell)
        elseif(doomSelection == 1)
            ClearSpells(target)
            target.AddSpell(DoomAtronachSpell)
        elseif(doomSelection == 2)
            ClearSpells(target)
            target.AddSpell(DoomApperianceSpell)
        elseif(doomSelection == 3)
            ClearSpells(target)
            target.AddSpell(DoomRitualSpell)
        elseif(doomSelection == 4)
            ShowDialog(target)
        EndIf
    endif
endfunction