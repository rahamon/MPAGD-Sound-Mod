
; *****************************************************************************
; * The Music Studio Player Engine
; *
; * Based on code written by Saša Pušica for the utility, The Music Studio.
; * Modified by Chris Cowley
; *
; * Produced by Beepola v1.08.01
; ******************************************************************************
 
START:
                          LD    HL,MUSICDATA         ;  <- Pointer to Music Data. Change
                                                     ;     this to play a different song
                          LD   A,(HL)                         ; Get the loop start pointer
                          LD   (PATTERN_LOOP_BEGIN),A
                          INC  HL
                          LD   A,(HL)                         ; Get the song end pointer
                          LD   (PATTERN_LOOP_END),A
                          INC  HL
                          LD   (PATTERNDATA1),HL
                          LD   (PATTERNDATA2),HL
                          LD   A,254
                          LD   (PATTERN_PTR),A                ; Set the pattern pointer to zero
                          DI
                          EXX
                          PUSH  HL
                          CALL  NEXT_PATTERN
                          POP   HL
                          EXX                                 ; Restore HL' for return to BASIC
                          EI
                          RET
NEXTNOTE:
                          DI
                          EXX
                          PUSH  HL
                          CALL  PLAYNOTE

                          POP   HL
                          EXX                                 ; Restore HL' for return to BASIC
                          EI
                          RET                                 ; Return from playing tune

PATTERN_PTR:              DEFB 0
NOTE_PTR:                 DEFB 0

; ********************************************************************************************************
; * NEXT_PATTERN
; *
; * Select the next pattern in sequence (and handle looping if we've reached PATTERN_LOOP_END
; * Execution falls through to PLAYNOTE to play the first note from our next pattern
; ********************************************************************************************************
NEXT_PATTERN:
                          LD   A,(PATTERN_PTR)
                          INC  A
                          INC  A
                          DEFB $FE                           ; CP n
PATTERN_LOOP_END:         DEFB 0
                          JR   NZ,NO_PATTERN_LOOP
; Parche: End of the song flag. -------------------------------------------
PLY_Endofthesong 			defb 0
							ld a,1
							ld (PLY_Endofthesong),a
; fin del parche: fin de cancion. -----------------------------------------
                          DEFB $3E                           ; LD A,n
PATTERN_LOOP_BEGIN:       DEFB 0
                          POP  HL
                          POP  HL
                          EXX
                          EI
                          RET
NO_PATTERN_LOOP:          LD   (PATTERN_PTR),A

			                    DEFB $21                            ; LD HL,nn
PATTERNDATA1:             DEFW $0000
                          LD   E,A                            ; (this is the first byte of the pattern)
                          LD   D,0                            ; and store it at TEMPO
                          ADD  HL,DE
                          LD   E,(HL)
                          INC  HL
                          LD   D,(HL)
                          LD   A,(DE)                         ; Pattern Tempo -> A
	                	      LD   (TEMPO),A                      ; Store it at TEMPO

                          LD   A,1
                          LD   (NOTE_PTR),A

PLAYNOTE: 
                          DEFB $21                            ; LD HL,nn
PATTERNDATA2:             DEFW $0000
                          LD   A,(PATTERN_PTR)
                          LD   E,A
                          LD   D,0
                          ADD  HL,DE
                          LD   E,(HL)
                          INC  HL
                          LD   D,(HL)                         ; Now DE = Start of Pattern data
                          LD   A,(NOTE_PTR)
                          LD   L,A
                          LD   H,0
                          ADD  HL,DE                          ; Now HL = address of note data
                          LD   D,(HL)
                          LD   E,1

; IF D = $0 then were at the end of the pattern so increment PATTERN_PTR by 2 and set NOTE_PTR=0
                          LD   A,D
                          CP   $FE                           ; $FE indicates end of pattern
                          JR   Z,NEXT_PATTERN

CONTINUE0:                PUSH DE
                          INC  HL
                          LD   D,(HL)
                          LD   E,1

                          LD   A,(NOTE_PTR)
                          INC  A
                          INC  A
                          LD   (NOTE_PTR),A                   ; Increment the note pointer by 2 (one note per chan)

                          EXX
                          POP  DE                             ; Now CH1 freq is in DE, and CH2 freq is in DE'

                          LD   A,(TEMPO)
                          LD   C,A
                          LD   B,0
                          LD   A,BORDER_COL
                          EX   AF,AF'
                          LD   A,BORDER_COL                   ; So now BC = TEMPO, A and A' = BORDER_COL
                          EXX

OUTPUT_NOTE:
                          LD   IXH,D                          ; Put note frequency for chan 1 into IXH
                          LD   H,D
                          LD   L,H
                          DEC  L
                          LD   E,L
                          JR   Z,CONTINUE1
                          LD   E,$10
CONTINUE1:
                          EXX
                          LD   IXL,D                          ; Put note frequency for chan 2 into IXL
                          LD   H,D
                          LD   L,H
                          DEC  L
                          LD   E,L
                          JR   Z,CONTINUE2
                          LD   E,$10
CONTINUE2:
                          EXX
                          EX   AF,AF'
                          OUT  ($FE),A
                          DEC  H             ; Dec H, which also holds the frequency value
                          JR   NZ,L8055
                          XOR  E
                          LD   H,D
                          PUSH AF
                          LD   A,IXH
                          CP   $20
                          JR   NC,L8054      ; if A > $20 then this is not a drum effect, skip the INC D
                          INC  D             ; create the "fast falling pitch" percussion effect
L8054:                    POP  AF
L8055:                    DEC  L
                          JR   NZ,L805B
                          XOR  E
                          LD   L,D
                          DEC  L
L805B:                    EXX
                          EX   AF,AF'
                          OUT  ($FE),A
                          DEC  H
                          JR   NZ,L806D
                          XOR  E
                          LD   H,D
                          PUSH AF
                          LD   A,IXL
                          CP   $20
                          JR   NC,L806C     ; if A > $20 then this is not a drum effect, skip the INC D
                          INC  D            ; create the "fast falling pitch" percussion effect
L806C:                    POP  AF
L806D:                    DEC  L
                          JR   NZ,L8073
                          XOR  E
                          LD   L,D
                          DEC  L
L8073:                    DJNZ CONTINUE2
                          DEC  C
                          JR   NZ,CONTINUE2
                          RET

; *** DATA ***
BORDER_COL:               EQU $0
TEMPO:                    DEFB 238
