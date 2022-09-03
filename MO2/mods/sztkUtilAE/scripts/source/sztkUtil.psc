Scriptname sztkUtil

int Function GetVersion() global native
int Function GetScriptVersion() global
	return 20220312
EndFunction

int Function CalculateCRC(string filepath) global native

float Function GetDistance(ObjectReference obj1, ObjectReference obj2, float zScale, float zCutOff) global native

int Function IssueToken(string keyStr) global native
bool Function VerifyToken(string keyStr, int tokenValue) global native

Form[] Function GetAllMerchantContainers() global native

int Function RandomInt(int minValue = 0, int maxValue = 100) global native
float Function RandomFloat(float minValue = 0.0, float maxValue = 1.0) global native
int[] Function RandomIntArray(int n, int minValue = 0, int maxValue = 100) global native
float[] Function RandomFloatArray(int n, float minValue = 0.0, float maxValue = 1.0) global native
Form[] Function ShuffleFormArray(Form[] forms) global native

bool Function GetPreventSpellSpam(Actor victim, Actor aggressor, Form source, float threshold) global native
Function ClearPreventSpellSpam() global native

Function AddDegradationPriority(Form inner, Form outer) global native
Function RemoveDegradationPriority(Form inner, Form outer) global native
Form[] Function GetDegradationPriority(Form inner) global native
Function ClearDegradationPriority() global native
Function AddDegradationPriorityList(Form[] items) global native
Form[] Function GetDegradationPriorityList() global native
Form Function RandomSelectArmorToDegrade(Form[] wornForms) global native
Form Function SelectArmorToDegrade(Form[] wornForms, Form armorToBeDegrade) global native

Form[] Function SortFormsByName(Form[] items) global native
string[] Function GetFormNames(Form[] items) global native
Form[] Function GetContainerArmorForms(ObjectReference obj) global native

Form[] Function GetActorWornForms(Actor aActor, int slotMaskIgnore = 0, bool allowNonPlayable = false, FormList excludeKeywordList = none) global native
Form[] Function FilterFormsByHasKeyword(Form[] forms, Keyword[] keywords, bool any) global native
Form[] Function FilterFormsByNotHaveKeyword(Form[] forms, FormList keywordList) global native
Form[] Function FilterFormsByIsPlayable(Form[] forms, bool isPlayable = true) global native
bool Function GetFormHasAnyKeyword(Form aForm, FormList keywordList) global native
Keyword[] Function CreateKeywordArray(int n) global native
Form[] Function GetIntersectionForms(Form[] forms1, Form[] forms2) global native
Form[] Function GetDifferenceForms(Form[] forms1, Form[] forms2) global native
int Function GetActorEquipmentNamesHealths(Actor aActor, string[] names, float[] healths, FormList excludeKeywordList = none) global native
float Function TemperEquipment(Actor tmpActor, Form equipment, float minHealth, float maxHealth) global native
int[] Function TemperWornEquipment(Actor aActor, float minHealth, float maxHealth, FormList excludeKeywordList = none) global native
bool Function IsActorInAnyFactions(Actor aActor, Faction[] factions, int minRank = 0, int maxRank = 127) global native
Actor[] Function GetActorsInAnyFactions(Actor[] actors, FormList factionList, int minRank = 0, int maxRank = 127) global native
Function SetEffectMagnitudes(Spell theSpell, float[] magnitudes) global native

string Function FormatS1(string formatString, string arg0) global native
string Function FormatS2(string formatString, string arg0, string arg1) global native
string Function FormatS3(string formatString, string arg0, string arg1, string arg2) global native
string Function FormatF1(string formatString, float arg0) global native
string Function FormatF2(string formatString, float arg0, float arg1) global native
string Function FormatF3(string formatString, float arg0, float arg1, float arg2) global native
string Function FormatI1(string formatString, int arg0) global native
string Function FormatI2(string formatString, int arg0, int arg1) global native
string Function FormatI3(string formatString, int arg0, int arg1, int arg2) global native

