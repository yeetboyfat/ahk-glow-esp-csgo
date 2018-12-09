SendMode Input
DllName = client_panorama.dll
Process, Exist, csgo.exe
If (ErrorLevel = 0)
{
msgbox, Run "Counter-Strike: Global Offensive" then start the cheat
ExitApp
}
Process, Exist, csgo.exe
PID = %ErrorLevel%
Client := GetDllBase(DllName, PID)
while (!Client){
Process, Exist, csgo.exe
PID = %ErrorLevel%
Client := GetDllBase(DllName, PID)
msgbox Error could not find CLIENT.DLL %Client%
}
z := 1
xc := 0
r := 1
b := 1
g := 1
a := 1
zToggle := 0
bToggle := 1
IniRead, bToggle, Settings.INI, Settings, bToggle, 0
IniRead, zToggle, Settings.INI, Settings, zToggle, 0
IniRead, a, Settings.INI, Settings, a, 0.8
IniRead, r, Settings.INI, Settings, r, 1
IniRead, b, Settings.INI, Settings, b, 0
IniRead, g, Settings.INI, Settings, g, 1
IniRead, LocalPlayer, Settings.INI, Offsets, LocalPlayer, 0xC5B80C
IniRead, glowobjectmanger, Settings.INI, Offsets, glowobjectmanger, 0x5177CC0
IniRead, entitylist, Settings.INI, Offsets, entitylist, 0x4C37FEC
IniRead, glowindexz, Settings.INI, Offsets, glowindexz, 0xA320
IniWrite, %LocalPlayer%, Settings.INI, Offsets, LocalPlayer
IniWrite, %glowobjectmanger%, Settings.INI, Offsets, glowobjectmanger
IniWrite, %entitylist%, Settings.INI, Offsets, entitylist
IniWrite, %glowindexz%, Settings.INI, Offsets, glowindexz
while true
{
if (z = 40){
z:= 1
}
if (xc = 40000){
Reload
}
localadress :=ReadMemory(Client+LocalPlayer,PID)
Ent :=ReadMemory(Client+entitylist + (z * 0x10 ),PID)
Dormant :=ReadMemory(Ent + 0xE9 ,PID)
health:=ReadMemory(Ent + 0xFC ,PID)
entTeam :=ReadMemory(Ent+0xF0,PID)
Myteam :=ReadMemory(localadress+0xf0,PID)
glowindex :=ReadMemory(Ent+glowindexz,PID)
glowobj :=ReadMemory(client+glowobjectmanger,PID)
if (health <> 0 and entTeam<>Myteam and Dormant <= 0 and zToggle = 0 ){
WriteMemoryfloat(r,glowobj + ((glowindex*0x38)+0x4),PID)
WriteMemoryfloat(g,glowobj + ((glowindex*0x38)+0x8),PID)
WriteMemoryfloat(b,glowobj + ((glowindex*0x38)+0xC) ,PID)
WriteMemoryfloat(a,glowobj + ((glowindex*0x38)+0x10) ,PID)
WriteMemoryUChar(PID, glowobj + ((glowindex*0x38)+0x24), 1)
WriteMemoryUChar(PID, glowobj + ((glowindex*0x38)+0x25), 0)
WriteMemoryUChar(PID, glowobj + ((glowindex*0x38)+0x2C), bToggle)
}else if (health <> 0 and entTeam<>Myteam and Dormant <= 0 and zToggle = 1 ){
if (health >= 70){
WriteMemoryfloat(0,glowobj + ((glowindex*0x38)+0x4),PID)
WriteMemoryfloat(1,glowobj + ((glowindex*0x38)+0x8),PID)
WriteMemoryfloat(0,glowobj + ((glowindex*0x38)+0xC) ,PID)
WriteMemoryfloat(a,glowobj + ((glowindex*0x38)+0x10) ,PID)
WriteMemoryUChar(PID, glowobj + ((glowindex*0x38)+0x24), 1)
WriteMemoryUChar(PID, glowobj + ((glowindex*0x38)+0x25), 0)
WriteMemoryUChar(PID, glowobj + ((glowindex*0x38)+0x2C), bToggle)
}
if (health <= 69 and health >= 35){
WriteMemoryfloat(1,glowobj + ((glowindex*0x38)+0x4),PID)
WriteMemoryfloat(0.5,glowobj + ((glowindex*0x38)+0x8),PID)
WriteMemoryfloat(0,glowobj + ((glowindex*0x38)+0xC) ,PID)
WriteMemoryfloat(a,glowobj + ((glowindex*0x38)+0x10) ,PID)
WriteMemoryUChar(PID, glowobj + ((glowindex*0x38)+0x24), 1)
WriteMemoryUChar(PID, glowobj + ((glowindex*0x38)+0x25), 0)
WriteMemoryUChar(PID, glowobj + ((glowindex*0x38)+0x2C), bToggle)
}
if (health < 35){
WriteMemoryfloat(1,glowobj + ((glowindex*0x38)+0x4),PID)
WriteMemoryfloat(0,glowobj + ((glowindex*0x38)+0x8),PID)
WriteMemoryfloat(0,glowobj + ((glowindex*0x38)+0xC) ,PID)
WriteMemoryfloat(a,glowobj + ((glowindex*0x38)+0x10) ,PID)
WriteMemoryUChar(PID, glowobj + ((glowindex*0x38)+0x24), 1)
WriteMemoryUChar(PID, glowobj + ((glowindex*0x38)+0x25), 0)
WriteMemoryUChar(PID, glowobj + ((glowindex*0x38)+0x2C), bToggle)
}
}
xc := xc + 1
z := z + 1
}
NumpadDel::
if (bToggle = 1){
bToggle := 0
}else{
bToggle := 1
}
IniWrite, %bToggle%, Settings.INI, Settings, bToggle
return
NumpadHome::
r := r + 0.05
if (r > 1){
r := 1
}
IniWrite, %r%, Settings.INI, Settings, r
return
NumpadLeft::
r := r - 0.05
if (r < 0){
r := 0
}
IniWrite, %r%, Settings.INI, Settings, r
return
NumpadDown::
if (zToggle = 1){
zToggle := 0
}else{
zToggle := 1
}
IniWrite, %zToggle%, Settings.INI, Settings, zToggle
return
NumpadEnd::
a := a + 0.05
if (a > 1){
a := 1
}
IniWrite, %a%, Settings.INI, Settings, a
return
NumpadPgDn::
a := a - 0.05
if (a < 0){
a := 0
}
IniWrite, %a%, Settings.INI, Settings, a
return
NumpadUp::
b := b + 0.05
if (b > 1){
b := 1
}
IniWrite, %b%, Settings.INI, Settings, b
return
NumpadClear::
b := b - 0.05
if (b < 0){
b := 0
}
IniWrite, %b%, Settings.INI, Settings, b
return
NumpadPgUp::
g := g + 0.05
if (g > 1){
g := 1
}
IniWrite, %g%, Settings.INI, Settings, g
return
NumpadRight::
g := g - 0.05
if (g < 0){
g := 0
}
IniWrite, %g%, Settings.INI, Settings, g
return
GetDllBase(DllName, PID = 0)
{
SetFormat, Integer, Hex
TH32CS_SNAPMODULE := 0x00000008
INVALID_HANDLE_VALUE = -1
VarSetCapacity(me32, 548, 0)
NumPut(548, me32)
snapMod := DllCall("CreateToolhelp32Snapshot", "Uint", TH32CS_SNAPMODULE
, "Uint", PID)
If (snapMod = INVALID_HANDLE_VALUE) {
SetFormat, Integer, D
Return 0
}
If (DllCall("Module32First", "Uint", snapMod, "Uint", &me32)){
while(DllCall("Module32Next", "Uint", snapMod, "UInt", &me32)) {
If !DllCall("lstrcmpi", "Str", DllName, "UInt", &me32 + 32) {
DllCall("CloseHandle", "UInt", snapMod)
SetFormat, Integer, D
Return NumGet(&me32 + 20)
}
}
}
DllCall("CloseHandle", "Uint", snapMod)
SetFormat, Integer, D
Return 0
}
WriteMemoryUChar(PID, adress, value){
ProcessHandle := DllCall("OpenProcess", "UInt", 2035711, "char", 0, "UInt", PID, "Ptr")
DllCall("WriteProcessMemory", "Ptr", ProcessHandle, "Ptr", adress, "UChar*", value, "Ptr", 1, "Ptr", 0)
DllCall("CloseHandle", "Ptr", ProcessHandle)
return
}
ReadMemory(MADDRESS,PID = 0)
{
SetFormat, Integer, Hex
VarSetCapacity(MVALUE,4,0)
ProcessHandle := DllCall("OpenProcess", "Int", 24, "Char", 0, "UInt", pid, "UInt")
DllCall("ReadProcessMemory","UInt",ProcessHandle,"UInt",MADDRESS,"Str",MVALUE,"UInt",4,"UInt *",0)
Loop 4
result += *(&MVALUE + A_Index-1) << 8*(A_Index-1)
SetFormat, Integer, D
return, result
}
WriteMemoryfloat(value, adress, PID = 0){
ProcessHandle := DllCall("OpenProcess", "int", 2035711, "char", 0, "UInt", PID, "UInt")
DllCall("WriteProcessMemory", "UInt", ProcessHandle, "UInt", adress, "float*", value, "Uint", 8, "Uint *", 0)
DllCall("CloseHandle", "int", ProcessHandle)
return
}
~*End::ExitApp
return
~*Home::Reload
return
~*Del::ExitApp
return
