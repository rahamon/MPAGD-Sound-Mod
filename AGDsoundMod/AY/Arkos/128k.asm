;IJUMP		equ	$f8FF
IJUMP		equ IJUMPA+$FF
PLAY4BANK	equ 49152
AGame		equ start

gameloop:
			call InitPLayer			; con EmtySong
			call IMStart
			call AGame				; Arcade Game
salirABasicScore:
			call IMOff
			ld bc,score				; return pointing to score.
			ret						; salir
			
; -----------------------------------------------------
; Fx routines 	
; -----------------------------------------------------

comando_InitSoundEffects	equ PLAY4BANK+15
comando_PlaySoundEffect		equ PLAY4BANK+18
dir_SoundEffects			equ PLAY4BANK+21

fxsnd
		; Inicia fx
		DEFB $3E        	    ; LD A,n
isOkfx	defb 0
		cp 1
		call nz,Initfx

		ld a,(ctrF)			; sound to play.
		and a					; any sound?
		jp z,exitbeep			; no.
		
		; selecciona efecto
		call bank4
        ld c,1
        ld b,0					; Full volume.
		ld a,(ctrF)			; sound to play.
        call comando_PlaySoundEffect
		call bank0
fxsnded
		xor a
		ld (ctrF),a			; ready again
exitbeep
		ret
	
Initfx
        ;Initializes the sound effects.
		call bank4
        ld hl,(dir_SoundEffects)
        call comando_InitSoundEffects
		call bank0
		ld a,1
		ld (isOkfx),a
		ret		

; -----------------------------------------------------
; Music Routines
; -----------------------------------------------------

comando_Init			equ PLAY4BANK+0
comando_Play			equ PLAY4BANK+3
comando_STOP			equ PLAY4BANK+6
dir_MUSICDATA			equ PLAY4BANK+9
dir_EMPTYSONG			equ PLAY4BANK+11
dir_EndofthesongAddr	equ PLAY4BANK+13

; Inicia Sonido de = n*41
isnd
		include "isnd.asm"
		; check loop command
AY
		and a					; n = 0? -> commando: deshabilita loop (loop activado por defecto)
		jp z,SetLoopOFF
		; Seleccion Musica:
		call bank4
		ld a,(ctrN)				; Subsong a. GUARDAR EN ROM
        ld hl,(dir_MUSICDATA)
		dec a
        call comando_Init		; INIT
		call ResetEndofthesongflag
		call bank0
		; reset LoopTunflag
		ld a,1
		ld (LoopTun),a			; LoopTun = 1 (por defecto)
		ret

ISR 	; ISR pre:
		di
		push af                 ; store registers.
		push hl
		push bc
		push de
		push ix
		push iy
		exx
		ex af,af'				;'
		push af
		push hl
		push bc
		push de
								; set for use in basic 
		ld a,(23672)			; store frames in a 
		inc a					; inc a 
		ld (23672),a			; write back to frames 

;plsnd
		; play
		call bank4
		call comando_Play		; PLAY
		call bank0
		; checkloop
		DEFB $3E            	; LD A,n
LoopTun	defb 0
		cp 1
		jr z,skipchekend
		; check final de musica
		call bank4
		ld hl,(dir_EndofthesongAddr)
		ld a,(hl)
		ld (ctrN),a
		cp 1
		call z,silenceSound
		call bank0
skipchekend
skipplay

; ISR post: restore registers.
		pop de                  ; restore registers.
		pop bc
		pop hl
		pop af
		ex af,af'				;'
		exx
		pop iy
		pop ix
		pop de
		pop bc
		pop hl
		pop af
		ei
		reti
		;jp 56					; set for use in basic 


silenc
silenceSound
		call bank4
		call comando_STOP		; STOP
		; musica silencio
		call InitEmptySong
		call ResetEndofthesongflag
		call bank0
		ret

SetLoopOFF
		xor a
		ld (LoopTun),a			; LoopTun = 0 -> desactiva loop
		ret
		
InitEmptySong
        ld hl,(dir_EMPTYSONG)
        xor a                   ; Subsong 0.
        call comando_Init		; INIT
		ld a,1
		ld (LoopTun),a			; LoopTun = 1 (por defecto)
		ret

ResetEndofthesongflag
		; reset Endofthesongflag
		xor a
		ld hl,(dir_EndofthesongAddr)
		ld (hl),a
		ret

InitPLayer
		call bank4
		call InitEmptySong
		call ResetEndofthesongflag
		call bank0
		ret
				
; subroutines 

IMStart:             			; initializes interrupts
		ld hl,ISR				; poke IJUMP con ISR address
		ld (IJUMP),hl
		di
		ld hl,IJUMP   			; i table (256 bytes buffer) at this address, must 	not exceed 64768 (AGD sprite buffer)
		ld a,h
		ld i,a
		im 2
		ei
		ret

IMOff:							; disables music - CALL point here in the Lost Game and Completed Game events
		di
		im 1	
		ei
		ret	
	
;routines
		include "routines.asm"

