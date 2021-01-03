
MUSICDATA:
                    DEFB 96   ; Loop start point * 2
                    DEFB 98   ; Song Length * 2
PATTERNDATA:        DEFW      PAT0
                    DEFW      PAT0
                    DEFW      PAT1
                    DEFW      PAT1
                    DEFW      PAT2
                    DEFW      PAT1
                    DEFW      PAT0
                    DEFW      PAT3
                    DEFW      PAT4
                    DEFW      PAT5
                    DEFW      PAT6
                    DEFW      PAT7
                    DEFW      PAT4
                    DEFW      PAT5
                    DEFW      PAT6
                    DEFW      PAT8
                    DEFW      PAT9
                    DEFW      PAT10
                    DEFW      PAT11
                    DEFW      PAT12
                    DEFW      PAT13
                    DEFW      PAT14
                    DEFW      PAT15
                    DEFW      PAT16
                    DEFW      PAT17
                    DEFW      PAT17
                    DEFW      PAT18
                    DEFW      PAT18
                    DEFW      PAT19
                    DEFW      PAT19
                    DEFW      PAT18
                    DEFW      PAT20
                    DEFW      PAT4
                    DEFW      PAT5
                    DEFW      PAT6
                    DEFW      PAT7
                    DEFW      PAT4
                    DEFW      PAT5
                    DEFW      PAT6
                    DEFW      PAT21
                    DEFW      PAT22
                    DEFW      PAT22
                    DEFW      PAT23
                    DEFW      PAT23
                    DEFW      PAT24
                    DEFW      PAT23
                    DEFW      PAT22
                    DEFW      PAT25
                    DEFW      PAT26

; *** Pattern data consists of pairs of frequency values CH1,CH2 with a single $0 to
; *** Mark the end of the pattern, and $01 for a rest
PAT0:
         DEFB 238  ; Pattern tempo
             DEFB 1,108
             DEFB 1,1
             DEFB 1,72
             DEFB 108,1
             DEFB 1,54
             DEFB 72,1
             DEFB 1,45
             DEFB 54,1
             DEFB 1,36
             DEFB 45,1
             DEFB 1,45
             DEFB 36,1
             DEFB 1,54
             DEFB 45,1
             DEFB 1,72
             DEFB 54,1
         DEFB $0
PAT1:
         DEFB 238  ; Pattern tempo
             DEFB 1,121
             DEFB 1,1
             DEFB 1,81
             DEFB 121,1
             DEFB 1,61
             DEFB 81,1
             DEFB 1,48
             DEFB 61,1
             DEFB 1,40
             DEFB 48,1
             DEFB 1,48
             DEFB 40,1
             DEFB 1,61
             DEFB 48,1
             DEFB 1,81
             DEFB 61,1
         DEFB $0
PAT2:
         DEFB 238  ; Pattern tempo
             DEFB 1,136
             DEFB 1,1
             DEFB 1,91
             DEFB 136,1
             DEFB 1,68
             DEFB 91,1
             DEFB 1,54
             DEFB 68,1
             DEFB 1,45
             DEFB 54,1
             DEFB 1,54
             DEFB 45,1
             DEFB 1,68
             DEFB 54,1
             DEFB 1,136
             DEFB 68,1
         DEFB $0
PAT3:
         DEFB 238  ; Pattern tempo
             DEFB 1,108
             DEFB 1,1
             DEFB 108,1
             DEFB 1,1
             DEFB 1,1
             DEFB 1,1
             DEFB 1,1
             DEFB 1,1
             DEFB 1,108
             DEFB 1,1
             DEFB 108,1
             DEFB 1,1
             DEFB 1,121
             DEFB 1,1
             DEFB 121,1
             DEFB 1,48
         DEFB $0
PAT4:
         DEFB 238  ; Pattern tempo
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
             DEFB 61,1
                          DEFB $02,$C0               ; Kick Drum
                          DEFB $02,$0F               ; Waveform Drum
             DEFB 1,1
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
             DEFB 61,1
                          DEFB $02,$C0               ; Kick Drum
                          DEFB $02,$0F               ; Waveform Drum
             DEFB 1,1
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
             DEFB 61,1
                          DEFB $02,$C0               ; Kick Drum
                          DEFB $02,$0F               ; Waveform Drum
             DEFB 1,1
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
             DEFB 61,1
                          DEFB $02,$C0               ; Kick Drum
                          DEFB $02,$0F               ; Waveform Drum
             DEFB 1,1
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
         DEFB $0
PAT5:
         DEFB 238  ; Pattern tempo
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
             DEFB 68,1
                          DEFB $02,$C0               ; Kick Drum
                          DEFB $02,$0F               ; Waveform Drum
             DEFB 1,1
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
             DEFB 68,1
                          DEFB $02,$C0               ; Kick Drum
                          DEFB $02,$0F               ; Waveform Drum
             DEFB 1,1
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,48
             DEFB 68,1
                          DEFB $02,$C0               ; Kick Drum
                          DEFB $02,$0F               ; Waveform Drum
             DEFB 1,1
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,61
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
             DEFB 68,1
                          DEFB $02,$C0               ; Kick Drum
                          DEFB $02,$0F               ; Waveform Drum
             DEFB 1,1
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
         DEFB $0
PAT6:
         DEFB 238  ; Pattern tempo
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
             DEFB 72,1
                          DEFB $02,$C0               ; Kick Drum
                          DEFB $02,$0F               ; Waveform Drum
             DEFB 1,1
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
             DEFB 72,1
                          DEFB $02,$C0               ; Kick Drum
                          DEFB $02,$0F               ; Waveform Drum
             DEFB 1,1
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
             DEFB 72,1
                          DEFB $02,$C0               ; Kick Drum
                          DEFB $02,$0F               ; Waveform Drum
             DEFB 1,1
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,48
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
             DEFB 72,1
                          DEFB $02,$C0               ; Kick Drum
                          DEFB $02,$0F               ; Waveform Drum
             DEFB 1,1
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
         DEFB $0
PAT7:
         DEFB 238  ; Pattern tempo
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
             DEFB 68,1
                          DEFB $02,$C0               ; Kick Drum
                          DEFB $02,$0F               ; Waveform Drum
             DEFB 1,1
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
             DEFB 68,1
                          DEFB $02,$C0               ; Kick Drum
                          DEFB $02,$0F               ; Waveform Drum
             DEFB 1,1
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
                          DEFB $02,$0F               ; Waveform Drum
                          DEFB $02,$C0               ; Kick Drum
                          DEFB $02,$0F               ; Waveform Drum
                          DEFB $02,$0F               ; Waveform Drum
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
                          DEFB $02,$0F               ; Waveform Drum
                          DEFB $02,$0F               ; Waveform Drum
                          DEFB $02,$C0               ; Kick Drum
             DEFB 61,1
                          DEFB $02,$0F               ; Waveform Drum
                          DEFB $02,$0F               ; Waveform Drum
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,48
         DEFB $0
PAT8:
         DEFB 238  ; Pattern tempo
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
             DEFB 68,1
                          DEFB $02,$C0               ; Kick Drum
                          DEFB $02,$0F               ; Waveform Drum
             DEFB 1,1
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
             DEFB 68,1
                          DEFB $02,$C0               ; Kick Drum
                          DEFB $02,$0F               ; Waveform Drum
             DEFB 1,1
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
                          DEFB $02,$0F               ; Waveform Drum
                          DEFB $02,$C0               ; Kick Drum
                          DEFB $02,$0F               ; Waveform Drum
                          DEFB $02,$0F               ; Waveform Drum
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
                          DEFB $02,$0F               ; Waveform Drum
                          DEFB $02,$0F               ; Waveform Drum
                          DEFB $02,$C0               ; Kick Drum
             DEFB 61,1
                          DEFB $02,$0F               ; Waveform Drum
                          DEFB $02,$0F               ; Waveform Drum
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
         DEFB $0
PAT9:
         DEFB 238  ; Pattern tempo
                          DEFB $02,$C0               ; Kick Drum
                          DEFB $02,$C0               ; Kick Drum
             DEFB 91,1
             DEFB 1,1
             DEFB 91,1
             DEFB 1,1
             DEFB 91,108
             DEFB 91,108
             DEFB 91,1
             DEFB 1,1
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
                          DEFB $02,$0F               ; Waveform Drum
             DEFB 1,1
             DEFB 91,1
             DEFB 1,1
         DEFB $0
PAT10:
         DEFB 238  ; Pattern tempo
                          DEFB $02,$C0               ; Kick Drum
                          DEFB $02,$C0               ; Kick Drum
             DEFB 91,1
             DEFB 1,1
             DEFB 91,1
             DEFB 1,1
             DEFB 91,108
             DEFB 91,108
             DEFB 91,1
             DEFB 1,54
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
                          DEFB $02,$0F               ; Waveform Drum
             DEFB 1,1
             DEFB 91,48
             DEFB 1,1
         DEFB $0
PAT11:
         DEFB 238  ; Pattern tempo
                          DEFB $02,$C0               ; Kick Drum
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
             DEFB 1,1
             DEFB 48,1
             DEFB 1,1
             DEFB 48,121
             DEFB 48,121
             DEFB 48,1
             DEFB 1,1
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
                          DEFB $02,$0F               ; Waveform Drum
             DEFB 1,1
             DEFB 48,1
             DEFB 1,1
         DEFB $0
PAT12:
         DEFB 238  ; Pattern tempo
                          DEFB $02,$C0               ; Kick Drum
                          DEFB $02,$C0               ; Kick Drum
             DEFB 48,1
             DEFB 1,1
             DEFB 48,1
             DEFB 1,1
             DEFB 48,121
             DEFB 48,121
             DEFB 48,1
                          DEFB $02,$0F               ; Waveform Drum
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
                          DEFB $02,$0F               ; Waveform Drum
             DEFB 1,1
             DEFB 48,61
             DEFB 1,1
         DEFB $0
PAT13:
         DEFB 238  ; Pattern tempo
                          DEFB $02,$C0               ; Kick Drum
                          DEFB $02,$C0               ; Kick Drum
             DEFB 91,1
             DEFB 1,1
             DEFB 91,1
             DEFB 1,1
             DEFB 91,136
             DEFB 91,136
             DEFB 91,1
             DEFB 1,1
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
                          DEFB $02,$0F               ; Waveform Drum
             DEFB 1,1
             DEFB 91,1
             DEFB 1,1
         DEFB $0
PAT14:
         DEFB 238  ; Pattern tempo
                          DEFB $02,$C0               ; Kick Drum
                          DEFB $02,$C0               ; Kick Drum
             DEFB 91,1
             DEFB 1,1
             DEFB 91,1
             DEFB 1,1
             DEFB 91,136
             DEFB 91,136
             DEFB 91,1
                          DEFB $02,$0F               ; Waveform Drum
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
                          DEFB $02,$0F               ; Waveform Drum
             DEFB 1,1
             DEFB 91,54
             DEFB 1,1
         DEFB $0
PAT15:
         DEFB 238  ; Pattern tempo
                          DEFB $02,$C0               ; Kick Drum
                          DEFB $02,$C0               ; Kick Drum
             DEFB 61,61
             DEFB 1,1
             DEFB 61,1
             DEFB 1,1
             DEFB 61,121
             DEFB 1,121
             DEFB 61,61
             DEFB 1,1
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
                          DEFB $02,$0F               ; Waveform Drum
             DEFB 1,1
             DEFB 61,1
             DEFB 1,1
         DEFB $0
PAT16:
         DEFB 238  ; Pattern tempo
                          DEFB $02,$C0               ; Kick Drum
                          DEFB $02,$C0               ; Kick Drum
             DEFB 61,1
             DEFB 1,1
             DEFB 61,1
             DEFB 1,1
             DEFB 121,1
             DEFB 121,1
             DEFB 61,1
                          DEFB $02,$0F               ; Waveform Drum
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
                          DEFB $02,$1F               ; Waveform Drum
             DEFB 1,1
                          DEFB $02,$1F               ; Waveform Drum
             DEFB 1,1
         DEFB $0
PAT17:
         DEFB 238  ; Pattern tempo
                          DEFB $02,$C0               ; Kick Drum
                          DEFB $02,$C0               ; Kick Drum
                          DEFB $02,$0F               ; Waveform Drum
             DEFB 91,54
                          DEFB $02,$2F               ; Waveform Drum
             DEFB 1,1
                          DEFB $02,$C0               ; Kick Drum
                          DEFB $02,$C0               ; Kick Drum
                          DEFB $02,$0F               ; Waveform Drum
                          DEFB $02,$2F               ; Waveform Drum
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,54
                          DEFB $02,$1F               ; Waveform Drum
             DEFB 1,1
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
         DEFB $0
PAT18:
         DEFB 238  ; Pattern tempo
                          DEFB $02,$C0               ; Kick Drum
                          DEFB $02,$C0               ; Kick Drum
                          DEFB $02,$0F               ; Waveform Drum
             DEFB 48,61
                          DEFB $02,$2F               ; Waveform Drum
             DEFB 1,1
                          DEFB $02,$C0               ; Kick Drum
                          DEFB $02,$C0               ; Kick Drum
                          DEFB $02,$0F               ; Waveform Drum
                          DEFB $02,$2F               ; Waveform Drum
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,61
                          DEFB $02,$1F               ; Waveform Drum
             DEFB 1,1
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
         DEFB $0
PAT19:
         DEFB 238  ; Pattern tempo
                          DEFB $02,$C0               ; Kick Drum
                          DEFB $02,$C0               ; Kick Drum
                          DEFB $02,$0F               ; Waveform Drum
             DEFB 54,68
                          DEFB $02,$2F               ; Waveform Drum
             DEFB 1,1
                          DEFB $02,$C0               ; Kick Drum
                          DEFB $02,$C0               ; Kick Drum
                          DEFB $02,$0F               ; Waveform Drum
                          DEFB $02,$2F               ; Waveform Drum
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,68
                          DEFB $02,$1F               ; Waveform Drum
             DEFB 1,1
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
         DEFB $0
PAT20:
         DEFB 238  ; Pattern tempo
                          DEFB $02,$C0               ; Kick Drum
                          DEFB $02,$C0               ; Kick Drum
                          DEFB $02,$0F               ; Waveform Drum
             DEFB 68,61
                          DEFB $02,$2F               ; Waveform Drum
             DEFB 1,1
                          DEFB $02,$C0               ; Kick Drum
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
             DEFB 1,1
                          DEFB $02,$1F               ; Waveform Drum
             DEFB 1,1
                          DEFB $02,$1F               ; Waveform Drum
                          DEFB $02,$0F               ; Waveform Drum
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,48
         DEFB $0
PAT21:
         DEFB 238  ; Pattern tempo
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
             DEFB 68,1
                          DEFB $02,$C0               ; Kick Drum
                          DEFB $02,$0F               ; Waveform Drum
             DEFB 1,1
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
             DEFB 68,1
                          DEFB $02,$C0               ; Kick Drum
                          DEFB $02,$0F               ; Waveform Drum
             DEFB 1,1
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
                          DEFB $02,$0F               ; Waveform Drum
                          DEFB $02,$C0               ; Kick Drum
                          DEFB $02,$0F               ; Waveform Drum
                          DEFB $02,$0F               ; Waveform Drum
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
                          DEFB $02,$0F               ; Waveform Drum
                          DEFB $02,$0F               ; Waveform Drum
                          DEFB $02,$C0               ; Kick Drum
             DEFB 61,1
                          DEFB $02,$0F               ; Waveform Drum
                          DEFB $02,$0F               ; Waveform Drum
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
         DEFB $0
PAT22:
         DEFB 238  ; Pattern tempo
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
             DEFB 1,72
             DEFB 108,1
             DEFB 1,54
             DEFB 72,1
                          DEFB $02,$C0               ; Kick Drum
             DEFB 54,1
                          DEFB $02,$0F               ; Waveform Drum
             DEFB 45,1
             DEFB 1,45
             DEFB 36,1
             DEFB 1,54
             DEFB 45,1
                          DEFB $02,$C0               ; Kick Drum
             DEFB 54,1
         DEFB $0
PAT23:
         DEFB 238  ; Pattern tempo
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
             DEFB 1,81
             DEFB 121,1
             DEFB 1,61
             DEFB 81,1
                          DEFB $02,$C0               ; Kick Drum
             DEFB 61,1
                          DEFB $02,$0F               ; Waveform Drum
             DEFB 48,1
             DEFB 1,48
             DEFB 40,1
             DEFB 1,61
             DEFB 48,1
                          DEFB $02,$C0               ; Kick Drum
             DEFB 61,1
         DEFB $0
PAT24:
         DEFB 238  ; Pattern tempo
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
             DEFB 1,91
             DEFB 136,1
             DEFB 1,68
             DEFB 91,1
                          DEFB $02,$C0               ; Kick Drum
             DEFB 68,1
                          DEFB $02,$0F               ; Waveform Drum
             DEFB 54,1
             DEFB 1,54
             DEFB 45,1
             DEFB 1,68
             DEFB 54,1
                          DEFB $02,$C0               ; Kick Drum
             DEFB 68,1
         DEFB $0
PAT25:
         DEFB 238  ; Pattern tempo
                          DEFB $02,$C0               ; Kick Drum
             DEFB 1,1
             DEFB 108,1
             DEFB 1,1
             DEFB 1,1
             DEFB 1,1
             DEFB 1,1
             DEFB 1,1
             DEFB 1,1
             DEFB 1,1
         DEFB $0
PAT26:
         DEFB 238  ; Pattern tempo
             DEFB 1,1
             DEFB 1,1
             DEFB 1,1
             DEFB 1,1
         DEFB $0
