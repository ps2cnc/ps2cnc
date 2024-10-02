G21         ; Set units to mm
G90         ; Absolute positioning
G1 Z2.54 F500      ; Move to clearance level

;
; Operation:    0
; Name:         
; Type:         Engrave
; Paths:        1
; Direction:    Conventional
; Cut Depth:    3
; Pass Depth:   1.001
; Plunge rate:  100
; Cut rate:     300
;

; Path 0
; Rapid to initial position
G1 X12.7000 Y12.7000 F500
G1 Z0.0000
; plunge
G1 Z-1.0010 F100
; cut
G1 X-12.7000 Y12.7000 F300
G1 X-12.7000 Y-12.7000
G1 X12.7000 Y-12.7000
G1 X12.7000 Y12.7000
G1 X12.7000 Y12.7000
; Rapid to initial position
G1 X12.7000 Y12.7000 F500
G1 Z-1.0010
; plunge
G1 Z-2.0020 F100
; cut
G1 X-12.7000 Y12.7000 F300
G1 X-12.7000 Y-12.7000
G1 X12.7000 Y-12.7000
G1 X12.7000 Y12.7000
G1 X12.7000 Y12.7000
; Rapid to initial position
G1 X12.7000 Y12.7000 F500
G1 Z-2.0020
; plunge
G1 Z-3.0000 F100
; cut
G1 X-12.7000 Y12.7000 F300
G1 X-12.7000 Y-12.7000
G1 X12.7000 Y-12.7000
G1 X12.7000 Y12.7000
G1 X12.7000 Y12.7000
; Retract
G1 Z2.5400 F500
M2
