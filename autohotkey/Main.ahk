#Requires AutoHotkey v2.0
#SingleInstance Force

+4:: Send '{$}'

#b::
{
    static launching := false

    if WinExist("ahk_exe wezterm-gui.exe")
        WinActivate
    else if !launching {
        launching := true
        Run "C:/ProgramData/Microsoft/Windows/Start Menu/Programs/Wezterm"
        WinWait "ahk_exe wezterm-gui.exe",, 10
        launching := false
    }
}

#a::
{
    if ProcessExist("Discord.exe")
        WinActivate "ahk_exe Discord.exe"
}

#s::
{
    if WinExist("ahk_class MozillaWindowClass")
        WinActivate()
}

#c::
{
    if ProcessExist("Zed.exe")
        WinActivate "ahk_exe Zed.exe"
    else
        Run "C:\Users\SirCi\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Zed\Zed"
}

#f::
{
    if WinExist("ahk_class Chrome_WidgetWin_1")
        WinActivate "ahk_exe Spotify.exe"
}

; Caps lock, macro system

SetCapsLockState("AlwaysOff")

mouseHeld := false
capsUsed := false

*CapsLock::
{
    global capsUsed
    capsUsed := false

    ; Wait until released or held for one second
    if !KeyWait("CapsLock", "T1") {
        ; Only toggle Caps Lock if no macro was used
        if !capsUsed {
            SetCapsLockState(
                GetKeyState("CapsLock", "T") ? "Off" : "On"
            )
        }
        KeyWait("CapsLock")
    }
}

; Caps Lock + Numpad 1
#HotIf GetKeyState("CapsLock", "P")

Numpad1::
NumpadEnd::
{
    global mouseHeld, capsUsed

    capsUsed := true
    mouseHeld := !mouseHeld

    Send(mouseHeld ? "{LButton Down}" : "{LButton Up}")
}

#HotIf
