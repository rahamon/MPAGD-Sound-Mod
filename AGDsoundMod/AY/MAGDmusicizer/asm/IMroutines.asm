; ---------------------------------------------------------------------
;	IMsubroutines
; ---------------------------------------------------------------------
	
; interrupt routine itself 
ISR:	
		di              	    		; disable interrupts
		push af     	       			; save all std regs
		push bc
		push de
		push hl
		push ix             
		push iy
		ex af, af'				;'
		push af					;' save all std regs'
		
		IF BASICMODE = 0
			ld a,(23672)			; store frames in a 
			inc a				; inc a 
			ld (23672),a			; write back to frames 	
		ENDIF 
; ---------------------------------------------------------------------
; Seccion de musica
; ---------------------------------------------------------------------	
		ld a,(ctrN)				; load a with ctrN
		; Checking
		cp 30
		jp z,contplay				; clave 30 go to contplay	
		cp 32
		jp z,skipplay				; clave 32 go to skip play
		; check songs
		include "irinclude.asm"	
		; check LOOP
		ld a,(ctrN)
		and a
		jp z,loopOFF				; clave 0 LoopOff: play una sola vez.
		; check MUTE
		cp 31
		jp z, muteplay				; clave 31 this stops plackback and mutes AY (no music on launch. EmptySong).
		; todo sigue igual
		ld a,30
		ld (ctrN),a				; set clave 30 PLAYING
		jp skipplay
		
loopOFF
		ld a,10
		ld (ctrN),a				; set clave new check ciclo+
		call bank4	
        	ld a,1
        	ld (49152+10),a				; set VTPlayerLoopFlag = 1, loopOFF.
		jp skipplay

muteplay:
		ld a,32
		ld (ctrN),a				; set clave skipplay
		call bank4
		call 49152				; MUTE audio 
		jp skipplay
		
contplay:
		call bank4	
		call 49157       			; PLAY the current tune
		; check end of song
		ld a,(49152+10)
		rla
        	jr nc,skipCheckLoopFlag			; not ended -> nada más que checkear.
		; check loopFlag
		and a				
		jr z,skipStop				; loopFlag = 0 -> loopON, REPETIR música.
		; Stop (end of song).
		jp muteplay				; STOP música 
		
skipStop		
skipCheckLoopFlag		
skipplay:
		call bank0
; ---------------------------------------------------------------------
; fx section		
; ---------------------------------------------------------------------
		ld a,(ctrF)				; sound to play.
		and a          	    			; any new sound?
		jr z,plfx				; no.
		
		call Selectfx				; SELECT FX from banck

		xor a
		ld (ctrF),a				; new ready.
plfx		
		DEFB $3E        	    		; LD A,n
isOkfx		defb 0
		cp 0
		jp z,endfx
		
		call bank4
		call FX4BANK + 8			; PLAY efectos de juego
endfx		call bank0

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
		di
		ld a, IJUMP/256
		ld i, a
		im 2
		ei
		ret       
IMOff:
		di
		im 1	
		ei
		ret
