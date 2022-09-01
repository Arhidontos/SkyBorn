scriptname FiR_Alias_ChangeRaceHandler extends ReferenceAlias

Race Property PlayerRace Auto
Actor Property PlayerRef Auto

Event OnRaceSwitchComplete()
    int i = PlayerRace.GetSpellCount()
    while i != 0
        i = i - 1

    endwhile
endEvent