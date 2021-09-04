
		org 61440

	FX4BANK_FXBANK		defw ayfxBankAd		; org + 0 Dirección de Banco de effectos

AYFxPlayer
		; AYFxPlayer +0 (org + 2) AFXINIT inicia player con el banco indicado en registro hl
		; AYFxPlayer +3 (org + 5) AFXPLAY selecciona efectos indicado en registro a
		; AYFxPlayer +6 (org + 8) AFXFRAME play un frame
		include "ayfxplay.a80.asm"	; enciende la fuente del reproductor de efectos
		defs 4,0
ayfxBankAd
		incbin "sfxBank.afb"