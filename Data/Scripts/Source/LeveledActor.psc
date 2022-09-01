Scriptname LeveledActor extends Form Hidden

; Adds the given count of the given form to the under the given level in this leveled list
Function AddForm(Form apForm, int aiLevel) native

; Removes all script added forms from this leveled list
Function Revert() native

; SKSE64 additions built 2021-11-10 05:57:47.902000 UTC
int Function GetNumForms() native
Form Function GetNthForm(int n) native

int Function GetNthLevel(int n) native
Function SetNthLevel(int n, int level) native

int Function GetNthCount(int n) native
Function SetNthCount(int n, int count) native