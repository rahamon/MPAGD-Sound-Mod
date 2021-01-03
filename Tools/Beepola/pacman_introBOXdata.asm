
Intro_MUSICDATA:
                    DEFB 0		; Loop start point * 2
                    DEFB 2		; Song Length * 2
Intro_PATTERNDATA:
					DEFW Intro_PAT0

; *** Pattern data consists of pairs of frequency values CH1,CH2 with a single $0 to
; *** Mark the end of the pattern, and $01 for a rest
Intro_PAT0:
			 DEFB 242			; Pattern tempo
             DEFB 24,96
             DEFB 1,1
             DEFB 1,1
             DEFB 1,1
             DEFB 16,96
             DEFB 1,1
             DEFB 19,48
             DEFB 1,1
             DEFB 1,1
             DEFB 16,1
             DEFB 1,96
             DEFB 1,1
             DEFB 19,96
             DEFB 1,1
             DEFB 1,1
             DEFB 1,1
             DEFB 23,91
             DEFB 1,1
             DEFB 1,1
             DEFB 1,1
             DEFB 15,96
             DEFB 1,1
             DEFB 18,45
             DEFB 1,1
             DEFB 1,1
             DEFB 15,1
             DEFB 1,91
             DEFB 1,1
             DEFB 18,91
             DEFB 1,1
             DEFB 1,1
             DEFB 1,1
             DEFB 24,96
             DEFB 1,1
             DEFB 1,1
             DEFB 1,1
             DEFB 16,91
             DEFB 1,1
             DEFB 19,48
             DEFB 1,1
             DEFB 1,1
             DEFB 16,1
             DEFB 1,96
             DEFB 1,1
             DEFB 19,96
             DEFB 1,1
             DEFB 1,1
             DEFB 1,1
             DEFB 19,128
             DEFB 18,1
             DEFB 17,1
             DEFB 1,1
             DEFB 17,114
             DEFB 16,1
             DEFB 15,128
             DEFB 1,1
             DEFB 15,102
             DEFB 14,1
             DEFB 13,1
             DEFB 1,1
             DEFB 1,96
             DEFB 1,1
             DEFB 1,102
             DEFB 1,1
			 DEFB $0
