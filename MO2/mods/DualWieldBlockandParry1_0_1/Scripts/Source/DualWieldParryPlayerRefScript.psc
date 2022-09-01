Scriptname DualWieldParryPlayerRefScript extends ReferenceAlias
Event OnPlayerLoadGame()
	DualWieldParryingQuestScript controller = getowningquest() as DualWieldParryingQuestScript
	controller.deactivateMod()
	controller.activateMod()
EndEvent