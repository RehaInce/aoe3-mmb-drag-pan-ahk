; AOE3:DE – MMB Drag-to-Pan (ScanCode, Hold/Release) – AHK v1
#SingleInstance Force
SendMode, Input
SetKeyDelay, 0, 10
SetMouseDelay, 0
SetControlDelay, 0

; ====== Kullanıcı Ayarları ======
UseArrows  := 1       ; 1: Ok tuşları, 0: WASD
PollMs     := 12      ; tarama periyodu (ms)
Deadzone   := 3       ; piksel eşiği
InvertX    := 0
InvertY    := 0
ThreshX    := 2       ; yön kararı eşiği (piksel)
ThreshY    := 2

; ====== Dahili Durum ======
enabled    := 1
dragging   := 0
lastX      := 0
lastY      := 0
holdLeft   := 0
holdRight  := 0
holdUp     := 0
holdDown   := 0

; Ok tuşları sc: Left 04B, Right 04D, Up 048, Down 050
; WASD sc: A 01E, D 020, W 011, S 01F
sc_Left  := "sc04B"
sc_Right := "sc04D"
sc_Up    := "sc048"
sc_Down  := "sc050"
sc_A     := "sc01E"
sc_D     := "sc020"
sc_W     := "sc011"
sc_S     := "sc01F"

; ====== Kısayol: Aç/Kapat ======
F8::
enabled := !enabled
ToolTip, % "MMB Drag-to-Pan: " (enabled ? "AÇIK" : "KAPALI")
SetTimer, __HideTip, -800
return
__HideTip:
ToolTip
return

; ====== MMB basılı: başlat ======
*MButton::
if (!enabled)
    return
dragging := 1
MouseGetPos, lastX, lastY
SetTimer, __PanLoop, %PollMs%
return

; ====== MMB bırak: durdur ======
*MButton Up::
dragging := 0
SetTimer, __PanLoop, Off
Gosub, __ReleaseAll
return

; ====== Ana döngü ======
__PanLoop:
if (!dragging)
    return

MouseGetPos, x, y
dx := x - lastX
dy := y - lastY
lastX := x
lastY := y

if (Abs(dx) < Deadzone)
    dx := 0
if (Abs(dy) < Deadzone)
    dy := 0

if (InvertX)
    dx := -dx
if (InvertY)
    dy := -dy

wantLeft  := (dx < -ThreshX)
wantRight := (dx >  ThreshX)
wantUp    := (dy < -ThreshY)
wantDown  := (dy >  ThreshY)

; Aynı eksende çift yön isteme durumunu temizle
if (wantLeft and wantRight)
{
    wantLeft  := 0
    wantRight := 0
}
if (wantUp and wantDown)
{
    wantUp   := 0
    wantDown := 0
}

; X ekseni
if (wantLeft and !holdLeft)
{
    Gosub, __ReleaseRight
    Gosub, __PressLeft
}
else if (wantRight and !holdRight)
{
    Gosub, __ReleaseLeft
    Gosub, __PressRight
}
else if (!wantLeft and !wantRight)
{
    Gosub, __ReleaseLeft
    Gosub, __ReleaseRight
}

; Y ekseni
if (wantUp and !holdUp)
{
    Gosub, __ReleaseDown
    Gosub, __PressUp
}
else if (wantDown and !holdDown)
{
    Gosub, __ReleaseUp
    Gosub, __PressDown
}
else if (!wantUp and !wantDown)
{
    Gosub, __ReleaseUp
    Gosub, __ReleaseDown
}
return

; ====== Bas/Bırak yardımcıları ======
__PressLeft:
if (UseArrows)
    Send, {%sc_Left% down}
else
    Send, {%sc_A% down}
holdLeft := 1
return

__ReleaseLeft:
if (holdLeft)
{
    if (UseArrows)
        Send, {%sc_Left% up}
    else
        Send, {%sc_A% up}
    holdLeft := 0
}
return

__PressRight:
if (UseArrows)
    Send, {%sc_Right% down}
else
    Send, {%sc_D% down}
holdRight := 1
return

__ReleaseRight:
if (holdRight)
{
    if (UseArrows)
        Send, {%sc_Right% up}
    else
        Send, {%sc_D% up}
    holdRight := 0
}
return

__PressUp:
if (UseArrows)
    Send, {%sc_Up% down}
else
    Send, {%sc_W% down}
holdUp := 1
return

__ReleaseUp:
if (holdUp)
{
    if (UseArrows)
        Send, {%sc_Up% up}
    else
        Send, {%sc_W% up}
    holdUp := 0
}
return

__PressDown:
if (UseArrows)
    Send, {%sc_Down% down}
else
    Send, {%sc_S% down}
holdDown := 1
return

__ReleaseDown:
if (holdDown)
{
    if (UseArrows)
        Send, {%sc_Down% up}
    else
        Send, {%sc_S% up}
    holdDown := 0
}
return

__ReleaseAll:
if (holdLeft)
{
    if (UseArrows)
        Send, {%sc_Left% up}
    else
        Send, {%sc_A% up}
    holdLeft := 0
}
if (holdRight)
{
    if (UseArrows)
        Send, {%sc_Right% up}
    else
        Send, {%sc_D% up}
    holdRight := 0
}
if (holdUp)
{
    if (UseArrows)
        Send, {%sc_Up% up}
    else
        Send, {%sc_W% up}
    holdUp := 0
}
if (holdDown)
{
    if (UseArrows)
        Send, {%sc_Down% up}
    else
        Send, {%sc_S% up}
    holdDown := 0
}
return
