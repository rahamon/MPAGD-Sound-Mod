
; *****************************************************************************
; * ROM BEEP Engine
; *
; * By Chris Cowley
; *
; * Produced by Beepola v1.08.01
; ******************************************************************************
 
START:
                          LD   HL,MUSICDATA         ;  <- Pointer to Music Data. Change
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
                          CALL  NEXT_PATTERN
                          EI
                          RET
NEXTNOTE:
                          EI
                          CALL  PLAYNOTE

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
PLY_Endofthesong 		defb 0
							ld a,1
							ld (PLY_Endofthesong),a
; fin del parche: fin de cancion. -----------------------------------------
                          DEFB $3E                           ; LD A,n
PATTERN_LOOP_BEGIN:       DEFB 0
                          POP  HL
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

                          ; IF D = $0 then we are at the end of the pattern so set next pattern
                          LD   A,D
                          AND  A                              ; Optimised CP 0
                          JR   Z,NEXT_PATTERN

                          INC  HL
                          LD   E,(HL)

                          LD   A,(NOTE_PTR)
                          INC  A
                          INC  A
                          LD   (NOTE_PTR),A                   ; Increment the note pointer by 2 (one note per chan)

                          ; D = Note1 Value 0-255 (1=rest)
                          ; E = Note2 Value 0-255 (1=rest)

OUTPUT_NOTE:              LD   A,(TEMPO)
                          LD   B,A
OUTPUT_NOTE_LOOP:         PUSH BC
                          PUSH DE
                          LD   A,D
                          CALL BEEP_REST_A
OUTPUT_CH2:               POP  DE
                          PUSH DE
                          LD   A,E
                          CALL BEEP_REST_A
                          POP  DE
                          POP  BC
                          DJNZ OUTPUT_NOTE_LOOP
                          RET

BEEP_REST_A:              DEC  A
                          JR   Z,REST
                          ; Push duration onto calc stack
                          PUSH AF 
                          RST  $28 
                          DEFB $34
                          DEFB $EB,$23,$D7,$0A,$3D
                          DEFB $38
                          POP  AF
                          ; Push note value onto calc stacl
                          INC  A
                          CALL $2D28
                          LD   A,60
                          CALL $2D28
                          RST  $28 
                          DEFB $03,$38   ; SUBTRACT, END
                          CALL $03F8
                          RET
REST:                     HALT
                          HALT
                          LD   B,$FF
REST_LOOP:                LD   A,(BC)    ; Waste 7 Ts each iteration
                          DJNZ REST_LOOP
                          RET


; *** DATA ***
TEMPO:                    DEFB 3
