#NoEnv ;For security
#SingleInstance force
;#NoTrayIcon
#InstallKeybdHook
#InstallMouseHook
#Hotstring EndChars -()[]{}:;'"/\,.?! `n   ;disable tab key to avoid conflicts with another software I am using--typing assistant
#UseHook		;directive prevents binds from triggering each other
Process, Priority, , High
DetectHiddenText, off
SetTitleMatchMode 2
SetWorkingDir %A_ScriptDir%
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;! Alt ^ Control + Shift # Windows
;for more check help->send
;http://www.autohotkey.com/docs/commands.htm
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;modify keys' behaviors

;suspend when necessary using pausebreak on the keyboard
pause::suspend ;suspend hotkeys

; remap ctrl alt while keep alt+tab
!a::Send ^a
!b::Send ^b
!c::Send ^c
!d::Send ^d
!f::Send ^f
!g::Send ^g
!i::Send ^i
!l::DllCall("LockWorkStation")
!m::WinMinimize,a
!n::Send ^n
!o::Send ^o
!p::Send ^p
!q::Send !{F4}
!s::Send ^s
!t::Send ^t
!v::Send ^v
!w::Send ^w
!x::Send ^x
!y::Send ^y
!z::Send ^z
!space::Send !{Shift}
; open link in new tab (alt+click)
#IfWinActive ahk_class Chrome_WidgetWin_1
!LButton::Send ^{Click}
!1::send ^+{tab}
!2::send ^{tab}
mbutton::Send {XButton1}
;!1::Send, {XButton1}  ;backward
;!2::Send, {XButton2}  ;forward
return
#IfWinActive

;disable shift+delete
+sc153::return
;open recycle bin
#sc153::Run ::{645ff040-5081-101b-9f08-00aa002f954e} 

#ifwinactive AutoHotkey.ahk
^r::
!r::
send ^s
sleep 100
reload
#ifwinnotactive
return

;replace tilde with backspace, so that I can easily press backspace with my left hand.
;not applicable to latex editors, including texwork, lyx, texmaker
#ifwinactive ahk_class QWidget
sc029::sc029
#ifwinnotactive
sc029::sc00E
return
!sc029::send {~}

;replace capslock with enter, so that I can easily press enter with my left hand.
Capslock::sc01C

;move carets to the up, down, left and right--ideas from emacs and joystick games.
!+i::send {up}
!+k::send {down}
!+j::send {left}
!+l::send {right} 
!+u::send {home}
!+o::send {end}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;global hotkeys

;paste plain texts
!+v::
Clip0 = %ClipBoardAll% 
Transform UC, Unicode         ; Save Unicode text 
Transform Clipboard, Unicode, %UC% 
Send ^v                       ; For best compatibility: SendPlay 
Sleep 500                     ; Don't change clipboard while it is pasted! (Sleep > 0) 
ClipBoard = %Clip0%           ; Restore original ClipBoard 
VarSetCapacity(Clip0, 0)      ; Free memory 
Return

^!a::
Winset, Alwaysontop, , A
return

;mouse button: press/hold left then right
~lbutton & rbutton:: run "AutoScriptWriter\AutoScriptWriter.exe"
~rbutton & lbutton:: run "AutoHotkey.chm",,max

AppsKey::
ifwinactive PDF-XChange
{
	clipboard =  ; Start off empty to allow ClipWait to detect when the text has arrived.
	Send ^c
	ClipWait  ; Wait for the clipboard to contain text.
	clip = %clipboard%  ; Get clipboard
	StringReplace, clip, clip, `r`n, %A_Space%, All
	;MsgBox Control-C copied the following contents to the clipboard:`n`n%clip%
	FoundPos := RegExMatch(clip, "(s|S)et (\d+)( |; )IC (\d+)", SubPat)
	clip = o %SubPat2% %SubPat4%
	clipboard = %clip%

	winactivate MATLAB R20
	send ^v{Enter}
}
ifwinactive ahk_class TFullScreenWindow
{
	MouseClick, right
	send {up 6}{enter}
	clipboard =  ; Start off empty to allow ClipWait to detect when the text has arrived.
	Send ^c{enter}
	ClipWait  ; Wait for the clipboard to contain text.
	winactivate MATLAB R20
	send d,size(EEG.icaweights,1),'^v'{Enter}
	winwait pop_loadset()
	send ^v.set{Enter}
	send s,t,tt(20,15,2){enter}
}
else
{
	winactivate PDF-XChange
	winactivate FastStone
}
return

f2::
ifwinexist ahk_class Chrome_WidgetWin_1
{
	ifwinactive
	{
		send !{tab}
		return
	}
	ifwinnotactive
	{
		winactivate
		return
	}
}
else
{
	run chrome.exe
	return
}

f3::
ifwinexist xplore ahk_class ATL:ExplorerFrame
{
	ifwinactive
	{
		send !{tab}
		return
	}
	ifwinnotactive
	{
		winactivate
		return
	}
}
else
{
	run "..\xplorer2_lite\xplorer2_lite.exe"
	return
}

f4::
ifwinexist FastStone
{
	ifwinactive
	{
		send !{tab}
		return
	}
	ifwinnotactive
	{
		winactivate
		return
	}
}
else
{
	run "..\FSViewer53\FSViewer.exe"
	return
}

f5::
ifwinexist ahk_class FastStoneScreenCapturePanel
{
	ifwinactive
	{
		send !{tab}
		return
	}
	ifwinnotactive
	{
		winactivate
		return
	}
}
else
{
	run "..\fscapture\FSCapture.exe"
	return
}

f6::
ifwinexist ahk_class ahk_class thinlinc-client
{
	ifwinactive
	{
		send !{tab}
		return
	}
	ifwinnotactive
	{
		winactivate
		return
	}
}
else
{
	run "tlclient.exe"
	return
}

f7::
ifwinexist PDF-XChange
{
	ifwinactive
	{
		send !{tab}
		return
	}
	ifwinnotactive
	{
		winactivate
		return
	}
}
else
{
	run "..\PDFXViewer2.5.312.1\PDFXCview.exe"
	return
}

; teamviewer
#c::^c
#a::^a
#s::^s
#z::^z
#x::^x
#v::^v
#y::^y
#f::^f
#n::^n
#b::^b
#o::^o
#i::^i
#p::^p
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
