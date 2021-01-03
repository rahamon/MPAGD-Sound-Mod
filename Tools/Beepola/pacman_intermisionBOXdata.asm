intermision_MUSICDATA:
                    DEFB 0   ; Loop start point * 2
                    DEFB 2   ; Song Length * 2
intermision_PATTERNDATA:        DEFW      intermision_PAT0

; *** Pattern data consists of pairs of frequency values CH1,CH2 with a single $0 to
; *** Mark the end of the pattern, and $01 for a rest
intermision_PAT0:
         DEFB 246  ; Pattern tempo
             DEFB 68,34
             DEFB 1,1
             DEFB 1,34
             DEFB 68,1
             DEFB 68,34
             DEFB 1,1
             DEFB 1,40
             DEFB 68,45
             DEFB 68,34
             DEFB 1,34
             DEFB 1,1
             DEFB 68,27
             DEFB 54,1
             DEFB 51,1
             DEFB 48,1
             DEFB 45,1
             DEFB 68,34
             DEFB 1,1
             DEFB 1,34
             DEFB 68,1
             DEFB 68,34
             DEFB 1,1
             DEFB 1,40
             DEFB 68,45
             DEFB 68,34
             DEFB 1,34
             DEFB 1,1
             DEFB 68,40
             DEFB 54,1
             DEFB 51,1
             DEFB 48,1
             DEFB 45,1
             DEFB 68,34
             DEFB 1,1
             DEFB 1,34
             DEFB 68,1
             DEFB 68,34
             DEFB 1,1
             DEFB 1,40
             DEFB 68,45
             DEFB 68,34
             DEFB 1,34
             DEFB 1,1
             DEFB 68,28
             DEFB 54,1
             DEFB 51,25
             DEFB 48,1
             DEFB 45,24
             DEFB 1,1
             DEFB 1,1
             DEFB 1,25
             DEFB 45,1
             DEFB 48,28
             DEFB 51,1
             DEFB 57,34
             DEFB 68,1
             DEFB 76,28
             DEFB 1,1
             DEFB 72,1
             DEFB 1,34
             DEFB 68,1
             DEFB 1,1
             DEFB 1,1
             DEFB 1,1
         DEFB $0
