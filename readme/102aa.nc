G21         ; Set units to mm
G90         ; Absolute positioning
G1 Z2.54 F2540      ; Move to clearance level

;
; Operation:    0
; Name:         
; Type:         Engrave
; Paths:        1
; Direction:    Conventional
; Cut Depth:    3.175
; Pass Depth:   3.175
; Plunge rate:  127
; Cut rate:     1016
;

; Path 0
; Rapid to initial position
G1 X46.8925 Y46.8925 F2540
G1 Z0.0000
; plunge
G1 Z-3.1750 F127
; cut
G1 X0.0000 Y46.8925 F1016
G1 X0.0000 Y-0.0000
G1 X46.8925 Y-0.0000
G1 X46.8925 Y46.8925
G1 X46.8925 Y46.8925
; Retract
G1 Z2.5400 F2540
M2
