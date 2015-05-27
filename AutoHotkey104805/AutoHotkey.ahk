#NoEnv ; For security
#SingleInstance force
;#NoTrayIcon
#InstallKeybdHook
#InstallMouseHook
#Hotstring EndChars -()[]{}:;'"/\,.?! `n   ;disable tab key to avoid conflicts with another software I am using--typing assistant
Process, Priority, , High
DetectHiddenText, off
SetTitleMatchMode 2

;for reference ! Alt ^ Control + Shift # Windows
;for more check help->send

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;take a rest every hour
;sleep after 11pm


;put all the timers on top, so they can run at the same time.
SetTimer, HaveARest, % 60*60*1000 ;the beginning % is used to force an experession: min*second*millisecond
SetTimer, CheckBedTime, % 5*60*1000 ;%
return

HaveARest:
;;;;;;;;;;;
ifgreater, A_TimeIdlePhysical, 900000, return ;if 15 min of idle then skip this cycle of remind.
SetTimer, HaveARest, Off  ; i.e. the timer turns itself off here.
Gosub Check_FullScreenActive
;;;;;;;
;check pps
Process, exist, PPStream.exe
if ErrorLevel { ;if it is running
FullScreenActive := true
}
;;;;;;
If !(FullScreenActive){
SplashTextOn, , , Love myslelf and take a rest...
Sleep, % 5*60*1000 ;the beginning % is used to force an experession: min*second*millisecond
SplashTextOff
}
SetTimer, HaveARest, On
return

Check_FullScreenActive:
wingetpos,,,w,h,A
wwwh=%w%%h%
swsh=%a_screenwidth%%a_screenheight%
WinGet, Style, Style, A
FullScreenActive := false
if !(Style & 0xC00000) {
  if(wwwh = swsh) {
    FullScreenActive := true
  }
}
return
;;;;;;;;;;;;
;bed time
CheckBedTime:
SetTimer, CheckBedTime, off
if A_hour = 23
{
SplashTextOn, 300, 300, Bed Time
Sleep, % 1*60*1000 ;the beginning % is used to force an experession: min*second*millisecond
SplashTextOff
}
SetTimer, CheckBedTime, on
Return
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;modify keys' behaviors
;suspend when necessary using pausebreak on the keyboard
pause::suspend ;suspend hotkeys

mbutton::
run rundll32.exe shell32.dll`,Control_RunDLL main.cpl @0
winwait Mouse Properties ahk_class #32770
winactivate Mouse Properties ahk_class #32770
send {shift down}{tab}{shift up} {right 3}
sleep 100
send {tab}{up}
sleep 500
send {enter}
return

;disable shift+delete
+sc153::return
;open recycle bin
+f1::Run ::{645ff040-5081-101b-9f08-00aa002f954e} 

;f5
#ifwinactive TeXworks ahk_class QWidget
f5::^t
#ifwinactive ahk_class Rgui Workspace
f5::^r
#ifwinactive AutoMate.ahk - Notepad++ ahk_class Notepad++
f5::
send ^s
sleep 100
reload
#ifwinnotactive
return

;delete
f1::
sendplay {sc153}
ifwinexist Confirm deletion ahk_class #32770
{
winactivate Confirm deletion ahk_class #32770
winwaitactive Confirm deletion ahk_class #32770
sendplay {tab 5}
}
return

del::
sendplay {sc153}
ifwinexist Confirm deletion ahk_class #32770
{
winactivate Confirm deletion ahk_class #32770
winwaitactive Confirm deletion ahk_class #32770
sendplay {tab 5}
}
return

;suspend
AppsKey::DllCall("PowrProf\SetSuspendState", "int", 0, "int", 0, "int", 0)

;maximize in SPM8
#IfWinActive ahk_class SunAwtFrame
F11::
winget, maximized, MinMax, ahk_class SunAwtFrame
if (maximized = 1)
{
winrestore ahk_class SunAwtFrame
}
else
{
winmaximize ahk_class SunAwtFrame
}
#IfWinNotActive
return

;nyfedit
#IfWinActive ahk_class wjjsoft::nyfedit::mainform
!a::^!left
!d::^!right
sc16A::^!left
sc169::^!right
F8::
send ^{F9}
StatusBarGetText, Attached, 2
IfInString, Attached, Attach
;the above two lines check whether this note has attachments
send ^{F7} ;if there is no attached file, it is unnecessary to show the attchment view.
return
#IfWinNotActive
return

;powerpoint
#IfWinActive ahk_class PPTFrameClass
f5::+f5
return
#IfWinNotActive
return

;not effective in excel
#IfWinNotActive ahk_class XLMAIN
[::sendplay []{left}

+[::sendplay {{}{}}{left} ;use {} to escape { and }

+9::sendplay (){left} ;Chinese parentheses are also OK. 

+sc028::sendplay {"}{"}{left} ;quotation makrs

;sc028::sendplay {'}{'}{left} ;single quotation

;+<::sendplay {space}<{space}

;+>::sendplay {space}>{space}

;+=::sendplay {space}{+}{space}

;=::sendplay {space}={space}

;-::sendplay {space}-{space}

return
#IfWinActive
return

;swap mouse
~lbutton & rbutton:: run "D:\2Computer\SwapMouse.exe"
~rbutton & lbutton:: run "D:\2Computer\SwapMouse.exe"

;switch applications
;f6::send !{tab}

;flashget
#IfWinActive ahk_class FlashGet3_Main_Frame
f4::PostMessage, 0x112, 0xF060,,,A
#IfWinActive 360Chrome
f4::^w
#IfWinActive ahk_class Chrome_WidgetWin_0
f4::^w
#IfWinActive TheWorld Browser
f4::^w
#IfWinNotActive
f4::!f4
return

;chrome
#ifWinActive ahk_class Chrome_WidgetWin_0
f2::sendplay ^+{Tab}
f3::sendplay ^{Tab}
!z::sendplay ^+t
return
#IfWinNotActive
return

;ACDSee
#IfWinActive ahk_class ACDViewer
sc14B::sc149
sc148::sc149
sc150::sc151
sc14D::sc151
return
#IfWinNotActive
return

;kmplayer
#IfWinActive ahk_class Winamp v1.x
!c::sendplay ^!s
#ifwinnotactive
return

;Live messenger
#IfWinActive ahk_class IMWindowClass
!s::sendplay {enter}
#ifwinnotactive
return

;Acrobat
#IfWinActive ahk_class AcrobatSDIWindow
sc16A::!sc14B
sc169::!sc14D
return
#IfWinNotActive
return

;replace tilde with backspace, so that I can easily press backspace with my left hand.
;not applicable to latex editors, including texwork, lyx, texmaker
#ifwinactive ahk_class QWidget
sc029::sc029
#ifwinnotactive
sc029::sc00E
return
+sc029::sendplay {~}

;replace capslock with enter, so that I can easily press enter with my left hand.
Capslock::sc01C

;move carets to the up, down, left and right--ideas from emacs and joystick games.
!i::sendplay {up}
!k::sendplay {down}
!j::sendplay {left}
!l::
ifwinexist ahk_class #32770, List1 ;get rid of typing assistant window
{
sendplay {esc}
}
sendplay {right} 
return
!u::sendplay {home}
!o::sendplay {end}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 仿KDE下窗口控制的AHK脚本
; win+右键最小化窗口
;win+左键拖拽窗口
; win+中键move between multimonitors
; win+左键双击切换最大化和普通状态
;Alt changed to win because the conflict of xplorer
Lwin & MButton::
CoordMode, Mouse  ; Switch to screen/absolute coordinates.
MouseGetPos, EWD_MouseStartX, EWD_MouseStartY, EWD_MouseWin
WinClose,ahk_id %EWD_MouseWin%
return

Lwin & RButton::
CoordMode, Mouse  ; Switch to screen/absolute coordinates.
MouseGetPos, EWD_MouseStartX, EWD_MouseStartY, EWD_MouseWin
WinMinimize,ahk_id %EWD_MouseWin%
return

Lwin & LButton::
CoordMode, Mouse  ; Switch to screen/absolute coordinates.
MouseGetPos, EWD_MouseStartX, EWD_MouseStartY, EWD_MouseWin
WinGet,winstat,MinMax,ahk_id %EWD_MouseWin%
if(winstat <> 1)
{
	WinGetPos, EWD_OriginalPosX, EWD_OriginalPosY,,, ahk_id %EWD_MouseWin%
	SetTimer, EWD_WatchMouse, 10 ; Track the mouse as the user drags it.
}
Keywait, LButton, , t0.2 ; 双击判断，等待第二次按键
if errorlevel <> 1 ; 
{
	Keywait, LButton, d, t0.1 ; 判断第二次按键是否是鼠标左键
	if errorlevel = 0
	{
		if(winstat = 1) ; 切换窗口状态
			WinRestore,ahk_id %EWD_MouseWin%
		else
			WinMaximize,ahk_id %EWD_MouseWin%
	}
}

return

EWD_WatchMouse:
GetKeyState, EWD_LButtonState, LButton, P
if EWD_LButtonState = U  ; Button has been released, so drag is complete.
{
	SetTimer, EWD_WatchMouse, off
	return
}
GetKeyState, EWD_EscapeState, Escape, P
if EWD_EscapeState = D  ; Escape has been pressed, so drag is cancelled.
{
	SetTimer, EWD_WatchMouse, off
	WinMove, ahk_id %EWD_MouseWin%,, %EWD_OriginalPosX%, %EWD_OriginalPosY%
	return
}
; Otherwise, reposition the window to match the change in mouse coordinates
; caused by the user having dragged the mouse:
CoordMode, Mouse
MouseGetPos, EWD_MouseX, EWD_MouseY
WinGetPos, EWD_WinX, EWD_WinY,,, ahk_id %EWD_MouseWin%
SetWinDelay, -1   ; Makes the below move faster/smoother.
WinMove, ahk_id %EWD_MouseWin%,, EWD_WinX + EWD_MouseX - EWD_MouseStartX, EWD_WinY + EWD_MouseY - EWD_MouseStartY
EWD_MouseStartX := EWD_MouseX  ; Update for the next timer-call to this subroutine.
EWD_MouseStartY := EWD_MouseY
return
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;global hotkeys
#t::
run "D:\2Personal\Diary\ZTD.xls",,max
return

#f::
Run "C:\Program Files\Everything\Everything.exe"
WinWait ahk_class EVERYTHING
winactivate ahk_class EVERYTHING
winwaitnotactive ahk_class EVERYTHING
winclose ahk_class EVERYTHING
return

;paste plain texts
#v::
Clip0 = %ClipBoardAll% 
Transform UC, Unicode         ; Save Unicode text 
Transform Clipboard, Unicode, %UC% 
Send ^v                       ; For best compatibility: SendPlay 
Sleep 500                     ; Don't change clipboard while it is pasted! (Sleep > 0) 
ClipBoard = %Clip0%           ; Restore original ClipBoard 
VarSetCapacity(Clip0, 0)      ; Free memory 
Return

#l::
sleep 500 ;wait possible hotkeys to be released
DllCall("LockWorkStation")
SendMessage 0x112, 0xF170, 2,,Program Manager ; send the monitor into standby (off) mode
return

#e::run "C:\Program Files\zabkat\xplorer2\xplorer2_UC.exe"
#g::
winclose ahk_class Sandbox:DefaultBox:Chrome_WidgetWin_0
run "http://gmail.com/"
return
#q::run "C:\Program Files\Tencent\TM2009\Bin\TM.exe"
#z::run "C:\Program Files\Lingoes\Lingoes.exe"
#x::run "D:\2Personal\Xpense.xlsx"
#s::run "D:\2Personal\2011.docx"
#j::
run "http://www.renren.com/home"
sleep 3000
run "https://www.facebook.com/"
run "http://weibo.com/"
return

#h::
;run "http://www.google.com/calendar"
run "C:\Program Files\Palm\Palm.exe"
return

#u::run "C:\Program Files\iTunes\iTunes.exe"
;#u::run "D:\2Computer\PalmWebOS\Media_Remote_V5_1\MediaControllerApplication.exe"
#p::run "D:\2Computer\TTPlayer\TTPlayer.exe"
#m::run "C:\Program Files\AutoHotkey\AutoScriptWriter\AutoScriptWriter.exe"
f9::run D:\2Personal\XXX\MakeMoney.ahk
#w::
ifwinexist ahk_class Chrome_WidgetWin_0
{
winactivate ahk_class Chrome_WidgetWin_0
winwaitactive ahk_class Chrome_WidgetWin_0
Send, {ALTDOWN}d{ALTUP}{CTRLDOWN}c{CTRLUP}
Sleep, 100
winclose ahk_class Chrome_WidgetWin_0
winwaitclose ahk_class Chrome_WidgetWin_0
ifwinnotexist ahk_class Sandbox:DefaultBox:Chrome_WidgetWin_0
{
runwait "C:\Program Files\Sandboxie\Start.exe" default_browser
}
winwait ahk_class Sandbox:DefaultBox:Chrome_WidgetWin_0
winactivate ahk_class Sandbox:DefaultBox:Chrome_WidgetWin_0
winwaitactive ahk_class Sandbox:DefaultBox:Chrome_WidgetWin_0
Sleep, 2000
sendplay !d
sleep 100
sendplay ^v
sleep 100
send {enter}
return
}
ifwinexist ahk_class Sandbox:DefaultBox:Chrome_WidgetWin_0
{
winclose ahk_class Chrome_WidgetWin_0
winactivate ahk_class Sandbox:DefaultBox:Chrome_WidgetWin_0
return
}
run "C:\Program Files\Sandboxie\Start.exe" default_browser
return


;prevent sleep
#f3::
Tooltip Preventing sleeping... Press Q to quit...
SetTimer, PreventIdle, % 1*60*1000 ;%min*second*milisecond
PreventIdle:
    Send, {LShift Down}{LShift Up}
	ifwinexist Rescue and Recovery ahk_class #32770, has successfully created
	{
	tooltip backup finished! will sleep in 2 min. Press Q to quit...
	sleep 120000
	DllCall("PowrProf\SetSuspendState", "int", 0, "int", 0, "int", 0)
	return
	}
	;beyond compare
	ifwinexist ahk_class TViewForm.UnicodeClass
	{
	wingettitle synprogress, ahk_class TViewForm.UnicodeClass
	if synprogress not contains `%
	{
	tooltip backup finished! will sleep in 2 min. Press Q to quit...
	sleep 120000
	DllCall("PowrProf\SetSuspendState", "int", 0, "int", 0, "int", 0)
	return
	}
	}
Return

#ifwinexist Preventing sleeping... Press Q to quit...
q::
SetTimer, PreventIdle, off
tooltip
reload
return
#ifwinnotexist
return

#ifwinexist backup finished! will sleep in 2 min. Press Q to quit...
q::
SetTimer, PreventIdle, off
tooltip
reload
return
#ifwinnotexist
return

#k::run "C:\Program Files\Internet Explorer\iexplore.exe" "http://calendar.google.com/"
;add a new item into inbox
#a::
run "D:\2Personal\Diary\ZTD.xls",,max
winwait, ZTD.xls
winactivate ZTD.xls
send ^7
sleep 10
send ^{home}
sleep 10
send {insert}
return

F6::
;wired, l is used before assigned a value by user
FileReadLine, address, D:\2Personal\XXX\allip.txt, %l%
InputBox, l, Title, Prompt, , , , , , , 2, 1
if ErrorLevel = 1
    setproxy(address,"OFF")
else
    setproxy(address,"",l)  ;to access l within the function
return 

setproxy(address = "",state = "",l=""){ 
if (state = "") 
    state = TOGGLE 

if address
    regwrite,REG_SZ,HKCU,Software\Microsoft\Windows\CurrentVersion\Internet Settings,ProxyServer,%address%
  if (state ="ON")
    regwrite,REG_DWORD,HKCU,Software\Microsoft\Windows\CurrentVersion\Internet Settings,Proxyenable,1
  else if (state="OFF")
    {
	regwrite,REG_DWORD,HKCU,Software\Microsoft\Windows\CurrentVersion\Internet Settings,Proxyenable,0
	tooltip
	}
  else if (state = "TOGGLE")
    {
      if regread("HKCU","Software\Microsoft\Windows\CurrentVersion\Internet Settings","Proxyenable") = 1
        { 
		regwrite,REG_DWORD,HKCU,Software\Microsoft\Windows\CurrentVersion\Internet Settings,Proxyenable,0
		tooltip F6 proxy %l% off, 1199, 772
		}
      else if regread("HKCU","Software\Microsoft\Windows\CurrentVersion\Internet Settings","Proxyenable") = 0
        {
		regwrite,REG_DWORD,HKCU,Software\Microsoft\Windows\CurrentVersion\Internet Settings,Proxyenable,1 
		tooltip F6 proxy %l% on, 1199, 772
		}
    }
  dllcall("wininet\InternetSetOptionW","int","0","int","39","int","0","int","0")
  dllcall("wininet\InternetSetOptionW","int","0","int","37","int","0","int","0")
  Return
}

RegRead(RootKey, SubKey, ValueName = "") {
   RegRead, v, %RootKey%, %SubKey%, %ValueName%
   Return, v
}

return

#c::
ifwinexist Cover part of subtitles
{
splashtextoff
return
}
SysGet, Mon1, Monitor, 1
SplashTextOn %Mon1Right%, 50, Cover part of subtitles
WinMove, Cover part of subtitles, , -1024, 582
return
