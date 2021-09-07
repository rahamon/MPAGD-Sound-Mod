; 	Chequear sonido, comando o efecto
;	Set LoopOff with SOUND 0
;	Set SOUND to the music you want to play eg SOUND 1 - 29.
;	When the music starts control will then be set to 30!! This means music is playing
;	To stop and mute the music set SOUND 31
;	To halt (SKIP) playback SOUND 32 (note this does not mute the AY chip)
;	Monitor con SOUND 36
;	Fx con SOUND > 100


		call div41
		ld a,c				; recogemos SOUND n en registro a
		ld (chkcom),a		; guardamos comando
		
		ld a,100
		ld hl,chkcom
		cp (hl)
		jp c,noesmusica		; if comando > 100
		jp z,noesmusica		; if comando = 100
esmusica
		ld a,(chkcom)
		; check monitor
		cp 36
		jp z,monitor
		ld (ctrN),a			; guardamos control en ctrN
		push ix
		ld b,2
		call delay
		pop ix
		ret
noesmusica
esefecto
		ld c,100
		ld a,(chkcom)
		sub c			 	; subtract 100 to comando
		ld (ctrF),a
		ret
monitor
		push ix
		ld b,2
		call delay
		pop ix
		ld a,(ctrN)
		cp 30
		jr z,sonando
		xor a
		ld (vara),a
		ret
sonando
		ld a,1
		ld (vara),a
		ret
		
chkcom	defb 0
ctrN	defb 0				; SOUND CONTROL
ctrF	defb 0				; FX CONTROL
		
; CALCULO: c = (HL-fx1)/41	
div41
		ld de,fx1
		sbc hl,de
		push hl
		pop bc				; bc Dividendo
		ld de,41 			; de Divisor
		ld hl,0
		ld a,b 				; Dividendo es AC en lugar de BC para optimizar código y liberar B como contador
		ld b,16
		sll c 				; Esta instrucción es indocumentada, algunos ensambladores no la reconocen, se puede sustituir por defb #CB,#31
		rla
		adc hl,hl
		sbc hl,de
		jr nc,$+4
		add hl,de
		dec c
		djnz $-11
							; Cociente queda en AC, se puede hacer ld b,a para que quede en BC
							; Resto queda en HL (realmente en L, ya que H siempre será cero)
		;dec c				 recoger n en registro C
		ret
		
