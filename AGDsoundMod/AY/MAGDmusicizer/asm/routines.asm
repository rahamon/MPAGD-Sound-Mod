; subroutines 

bank0:	; swap to bank 0 - original @ 49152 - 16k
		;di
		ld a,(23388)   
		and 248
		or 0 
		ld bc,32765
		ld (23388),a
		out (c),a
		;ei
		ret

bank4:	; swap to bank 4 @ 49152 - 16k
		;di
		ld a,(23388)   
		and 248
		or tBank 
		ld bc,32765
		ld (23388),a
		out (c),a
		;ei
		ret 

bankScreen:	; swap to bank asigned in b @ 49152 - 16k
		;di
		ld a,(23388)   
		and 248
		or b 
		ld bc,32765
		ld (23388),a
		out (c),a
		;ei
		ret 
		
showSplash
		; Volcado de pantalla
		di				; esperad todos un momento!
		ld b,6			; quiero ver este banco de memoria
		call bankScreen	; cambia a ese banco
		ld hl,$c000		; desde origen
		ld de,$4000		; hasta pantalla
		ld bc,6912		; todos estos bites
		ldir			; cópialos
		call bank0		; mira ahora al banco 0 (el de siempre)
		ei				; ya podeis seguir con vuestras cosas
		ret				; gracias
