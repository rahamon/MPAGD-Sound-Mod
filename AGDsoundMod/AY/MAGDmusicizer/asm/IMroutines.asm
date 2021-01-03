; ---------------------------------------------------------------------
;	IMsubroutines
;	Set LoopOff with USER 0
;	Set SOUND to the music you want to play eg USER 1 - 29.
;	When the music starts control will then be set to 30!! This means music is playing
;	To stop and mute the music set USER 31
;	To halt (SKIP) playback USER 32 (note this does not mute the AY chip)
;   Monitor con USER 36
;   Fx con USER > 100
; ---------------------------------------------------------------------
	
; interrupt routine itself 
ISR:	
		di              	    ; disable interrupts
		push af     	        ; save all std regs
		push bc
		push de
		push hl
		push ix             
		push iy
		ex af, af'				;'
		push af					;' save all std regs'
		
		IF BASICMODE = 0
			ld a,(23672)		; store frames in a 
			inc a				; inc a 
			ld (23672),a		; write back to frames 	
		ENDIF 
; ---------------------------------------------------------------------
; Seccion de musica
; ---------------------------------------------------------------------	
		ld a,(ctrN)				; load a with ctrN 
		cp 30					; clave 30
		jp z,contplay			; yes go to contplay	
		cp 32					; clave 32
		jp z,skipplay			; go to skip play 
		include "irinclude.asm"	
		; check LOOP
		and a
		jp z,loopOFF 			; check: ctrN = 0 -> command LoopOff: play una sola vez.
		cp 31					; clave 31
		jp z, muteplay 			; this stops plackback and mutes AY (no music on launch. EmptySong).
		ld a,30					; clave 30 command PLAY
		ld (ctrN),a
		jp skipplay
		
loopOFF
		ld a,10					; command new check ciclo+
		ld (ctrN),a
		call bank4	
        ld a,1
        ld (49152+10),a			; VTPlayerLoopFlag = 1, loopOFF.
		jp skipplay

muteplay:
		ld a,32					; command skipplay
		ld (ctrN),a
		call bank4
		call 49152				; mute audio 
		jp skipplay
		
contplay:
		call bank4	
		call 49157       		; play the current tune
		; check end of song
		ld a,(49152+10)
		rla
        jr nc,skipCheckLoopFlag	; no End -> continua.
		; check loopFlag
		and a				
		jr z,skipStop			; loopFlag = 0 -> loopON, continua.
		; Reset VTPlayerLoopFlag and Stop (end of song).
		ld a,0
		ld (49152+10),a			; reset LoopFlag
		call bank0
		jp muteplay				; Stop 
		
skipStop		
skipCheckLoopFlag		
skipplay:
		call bank0
; ---------------------------------------------------------------------
; fx section		
; ---------------------------------------------------------------------
		ld a,(ctrF)			; sound to play.
		and a          	    	; any new sound?
		jr z,plfx				; no.
		ld c,a
		dec c
		call Selectfx			; iniciamos banco
		ld a,1
		ld (isOkfx),a
		xor a
		ld (ctrF),a			; new ready.
plfx		
		DEFB $3E        	    ; LD A,n
isOkfx	defb 0
		cp 1
		call z,AFXFRAME			; efectos de juego

		pop af 
		ex af, af' ;'
		pop iy
		pop ix              
		pop hl
		pop de
		pop bc
		pop af              
		ei      
		IF BASICMODE = 1
		 jp 56					; set for use in basic 
		ELSE 
		 reti	 				; set for use in AGD
		ENDIF 

IMStart:
		;ld hl,ISR 
		;ld (IJUMP),hl			; poke ISR address to the ijunp
		di
		;call bank4	
		ld a, IJUMP/256
		ld i, a
		im 2
		call bank0
		ei
		ret       
IMOff:
		di
		im 1
		call bank4
		call 49152				; mute
		call bank0
		ld a,20					; command new check ciclo+
		ld (ctrN),a	
		ei
		ret
