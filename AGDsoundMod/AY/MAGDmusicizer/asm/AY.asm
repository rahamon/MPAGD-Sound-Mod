; -----------------------------------------------------------------------------
; Initialise a sound.
; -----------------------------------------------------------------------------

isnd
		;call chksn
		;ld a,c				; recogemos SOUND n en registro a
	
		;ld (ctrN),a			; guardamos n en ctrN
		; dame un respiro
		;push ix
		;ld b,1
		;call delay
		;pop ix
		;ret
		
		include "isnd.asm"
		
; mute/pause/stop a ISRsound.
silenc
		ld a,31				; no music on launch EmptySong
		ld (ctrN),a
		ret

; -----------------------------------------------------------------------------
; AY FX Routines
; -----------------------------------------------------------------------------
			
fxsnd	ret

FXsetup						; inicializacion de drivers
		;ld hl,sfxBankAd		
		call bank4			;*
		ld hl,(FX4BANK)		;*
		call FX4BANK + 2	; AFXINIT setup FX
		call bank0			;*
		ret
Selectfx					; Inicia efecto
		;ld a,(sfxBankAd)	; verifique el efecto (c) existe en el banco
		call bank4
		
		ld a,(ctrF)			; sound to play.
		ld c,a
		dec c
		
		ld hl,(FX4BANK)		;*
		ld a,(hl)			; verifique el efecto (c) existe en el banco
		dec a
		cp c
		jr c,playSfx2		; transicion si el banco no tiene tantos efectos
		ld a,c				; lanzar el efecto (c)
		call FX4BANK + 5	; AFXPLAY
playSfx2
		call bank0			;*
		ret

;AYFxPlayer
;		include "ayfxplay.a80.asm"	; enciende la fuente del reproductor de efectos
;sfxBankAd
;		incbin "sfxBank.afb"
	