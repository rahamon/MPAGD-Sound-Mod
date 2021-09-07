; -----------------------------------------------------------------------------
; Initialise a sound.
; -----------------------------------------------------------------------------

isnd
		include "isnd.asm"
		
; mute/pause/stop a ISRsound.
silenc
		ld a,31				; no music on launch EmptySong
		ld (ctrN),a
		ret
		
; restaura player			
msetup:
		di ;
		ld a,10					; clave new check ciclo+
		ld (ctrN),a
		call bank4
		push hl 
		call 49152+8			; MUTE	
		pop hl 
		call 49155			; POINTING TO Module
		ret 	

; -----------------------------------------------------------------------------
; AY FX Routines
; -----------------------------------------------------------------------------
			
fxsnd	ret

FXsetup						; inicializacion de drivers
		call bank4
		ld hl,(FX4BANK)
		call FX4BANK + 2	; AFXINIT setup FX
		call bank0
		ret
Selectfx					; SELECT efecto
		call bank4
		
		ld a,(ctrF)			; efect to play.
		ld c,a
		dec c
		; Chequera FX (c)
		ld hl,(FX4BANK)
		ld a,(hl)
		dec a
		cp c			; verifique el efecto (c) existe en el banco
		jr c,playSfx2		; transicion si el banco no tiene tantos efectos
		ld a,c				; lanzar el efecto (c)
		call FX4BANK + 5	; AFXPLAY
playSfx2
		call bank0
		ret
	
