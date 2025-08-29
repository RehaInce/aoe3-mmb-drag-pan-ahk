; AOE3:DE – MMB Drag-to-Pan (ScanCode, Hold/Release) – AHK v2 (Compat)
#Requires AutoHotkey v2.0
#SingleInstance Force
SendMode "Input"
SetKeyDelay 0, 10
SetMouseDelay 0
SetControlDelay 0

; ===== Kullanıcı Ayarları =====
global UseArrows := true   ; true: Ok tuşları, false: WASD
global PollMs    := 12
global Deadzone  := 3
global InvertX   := false
global InvertY   := false
global ThreshX   := 2
global ThreshY   := 2
global RequireTitle := ""  ; örn: "Age of Empires III: Definitive Edition"

; ===== Dahili Durum =====
global enabled := true
global dragging := false
global lastX := 0
global lastY := 0
global holdLeft := false
global holdRight := false
global holdUp := false
global holdDown := false

; Scan code eşlemesi
global KeySC := Map()
KeySC["Left"]  := "sc04B"
KeySC["Right"] := "sc04D"
KeySC["Up"]    := "sc048"
KeySC["Down"]  := "sc050"
KeySC["A"]     := "sc01E"
KeySC["D"]     := "sc020"
KeySC["W"]     := "sc011"
KeySC["S"]     := "sc01F"

; ===== Toggle: F8 =====
F8::
{
    global enabled
    enabled := !enabled
    ToolTip(enabled ? "MMB Drag-to-Pan: AÇIK" : "MMB Drag-to-Pan: KAPALI")
    SetTimer HideTip, -800
}

HideTip() {
    ToolTip()
}

; ===== MMB basılı: başlat =====
*MButton::
{
    global enabled, dragging, lastX, lastY, RequireTitle
    if !enabled
        return
    if (RequireTitle != "" && !WinActive(RequireTitle))
        return
    dragging := true
    MouseGetPos &lastX, &lastY
    SetTimer PanLoop, PollMs
}

; ===== MMB bırak: durdur =====
*MButton Up::
{
    global dragging
    dragging := false
    SetTimer PanLoop, 0
    ReleaseAll()
}

PanLoop() {
    global dragging, lastX, lastY, Deadzone, InvertX, InvertY, ThreshX, ThreshY
    if !dragging
        return

    x := 0, y := 0
    MouseGetPos &x, &y
    dx := x - lastX
    dy := y - lastY
    lastX := x
    lastY := y

    if (Abs(dx) < Deadzone)
        dx := 0
    if (Abs(dy) < Deadzone)
        dy := 0

    if InvertX
        dx := -dx
    if InvertY
        dy := -dy

    wantLeft  := (dx < -ThreshX)
    wantRight := (dx >  ThreshX)
    wantUp    := (dy < -ThreshY)
    wantDown  := (dy >  ThreshY)

    if (wantLeft && wantRight) {
        wantLeft := false
        wantRight := false
    }
    if (wantUp && wantDown) {
        wantUp := false
        wantDown := false
    }

    UpdateHold("X", wantLeft, wantRight)
    UpdateHold("Y", wantUp, wantDown)
}

UpdateHold(axis, wantNeg, wantPos) {
    global holdLeft, holdRight, holdUp, holdDown, UseArrows
    if (axis = "X") {
        if wantNeg && !holdLeft {
            ReleaseKey(UseArrows ? "Right" : "D")
            PressKey(  UseArrows ? "Left"  : "A")
            holdLeft := true
            holdRight := false
        } else if wantPos && !holdRight {
            ReleaseKey(UseArrows ? "Left"  : "A")
            PressKey(  UseArrows ? "Right" : "D")
            holdRight := true
            holdLeft := false
        } else if !wantNeg && !wantPos {
            if holdLeft  {
                ReleaseKey(UseArrows ? "Left"  : "A")
                holdLeft := false
            }
            if holdRight {
                ReleaseKey(UseArrows ? "Right" : "D")
                holdRight := false
            }
        }
    } else {
        if wantNeg && !holdUp {
            ReleaseKey(UseArrows ? "Down" : "S")
            PressKey(  UseArrows ? "Up"   : "W")
            holdUp := true
            holdDown := false
        } else if wantPos && !holdDown {
            ReleaseKey(UseArrows ? "Up"   : "W")
            PressKey(  UseArrows ? "Down" : "S")
            holdDown := true
            holdUp := false
        } else if !wantNeg && !wantPos {
            if holdUp {
                ReleaseKey(UseArrows ? "Up"   : "W")
                holdUp := false
            }
            if holdDown {
                ReleaseKey(UseArrows ? "Down" : "S")
                holdDown := false
            }
        }
    }
}

PressKey(name) {
    global KeySC
    sc := KeySC.Has(name) ? KeySC[name] : name
    Send "{" sc " down}"
}

ReleaseKey(name) {
    global KeySC
    sc := KeySC.Has(name) ? KeySC[name] : name
    Send "{" sc " up}"
}

ReleaseAll() {
    global holdLeft, holdRight, holdUp, holdDown, UseArrows
    if holdLeft  {
        ReleaseKey(UseArrows ? "Left"  : "A")
        holdLeft := false
    }
    if holdRight {
        ReleaseKey(UseArrows ? "Right" : "D")
        holdRight := false
    }
    if holdUp    {
        ReleaseKey(UseArrows ? "Up"    : "W")
        holdUp := false
    }
    if holdDown  {
        ReleaseKey(UseArrows ? "Down"  : "S")
        holdDown := false
    }
}
