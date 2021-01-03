; -Minimal ayFX player v0.15 06/05/06
; Reproduce efectos en un AY
; No hay musica de fondo. La prioridad de la eleccion de canales: si los hay
; canales libres, uno de ellos esta seleccionado. Si esta libres
; sin canales, se selecciona el que suena mas largo. Procedimiento
; La reproduccion utiliza los registros AF, BC, DE, HL, IX.

; Inicializacion :
; ld hl, direccion del banco de efectos
; llame a AFXINIT

; Efecto de lanzamiento :
; ld a, numero de efecto (0..255)
; llame a AFXPLAY

; En el controlador de interrupciones :
; llame a AFXFRAME

; descriptores de canal, 4 bytes por canal:
; +0 (2) direccion actual (el canal esta libre si el byte alto = # 00)
; +2 (2) tiempo de efecto
; ...

	jp AFXINIT				; org +0 INICIAR player con el banco indicado en registro hl
	jp AFXPLAY				; org +3 SELECCIONA efectos indicado en registro a
	jp AFXFRAME				; org +6 PLAY un frame

afxChDesc	DS 3*4

; Inicializacion del reproductor de efectos.
; Apaga todos los canales, establece variables.
; Entrada: HL = direccion bancaria con efectos

AFXINIT
	inc hl
	ld (afxBnkAdr+1),hl		; guardar la direccion de la tabla de desplazamiento
MUTECHS
	ld hl,afxChDesc			; marcar todos los canales como vacios
	ld de,#00ff
	ld bc,#03fd
afxInit0
	ld (hl),d
	inc hl
	ld (hl),d
	inc hl
	ld (hl),e
	inc hl
	ld (hl),e
	inc hl
	djnz afxInit0

	ld hl,#ffbf				; inicializar AY
	ld e,#15
afxInit1
	dec e
	ld b,h
	out (c),e
	ld b,l
	out (c),d
	jr nz,afxInit1

	ld (afxNseMix+1),de		; restablecer variables de player

	ret

; play el frame actual.
; No tiene parametros.

AFXFRAME
	ld bc,#03fd
	ld ix,afxChDesc

afxFrame0
	push bc

	ld a,11
	ld h,(ix+1)
	cp h
	jr nc,afxFrame7
	ld l,(ix+0)

	ld e,(hl)
	inc hl

	sub b
	ld d,b

	ld b,#ff
	out (c),a
	ld b,#bf
	ld a,e
	and #0f
	out (c),a

	bit 5,e
	jr z,afxFrame1

	ld a,3
	sub d
	add a,a

	ld b,#ff
	out (c),a
	ld b,#bf
	ld d,(hl)
	inc hl
	out (c),d
	ld b,#ff
	inc a
	out (c),a
	ld b,#bf
	ld d,(hl)
	inc hl
	out (c),d

afxFrame1
	bit 6,e
	jr z,afxFrame3

	ld a,(hl)
	sub #20
	jr c,afxFrame2
	ld h,a
	ld b,#ff
	ld b,c
	jr afxFrame6

afxFrame2
	inc hl
	ld (afxNseMix+1),a

afxFrame3
	pop bc
	push bc
	inc b

	ld a,%01101111
afxFrame4
	rrc e
	rrca
	djnz afxFrame4
	ld d,a

	ld bc,afxNseMix+2
	ld a,(bc)
	xor e
	and d
	xor e
	ld (bc),a

afxFrame5
	ld c,(ix+2)
	ld b,(ix+3)
	inc bc

afxFrame6
	ld (ix+2),c
	ld (ix+3),b

	ld (ix+0),l
	ld (ix+1),h

afxFrame7
	ld bc,4
	add ix,bc
	pop bc
	djnz afxFrame0

	ld hl,#ffbf
afxNseMix
	ld de,0
	ld a,6
	ld b,h
	out (c),a
	ld b,l
	out (c),e
	inc a
	ld b,h
	out (c),a
	ld b,l
	out (c),d

	ret

; Iniciando un efecto en un canal libre. Con ausencia
; los canales libres seleccionaron el sonido mas largo.
; Entrada: A = numero de efecto 0..255

AFXPLAY
	ld de,0
	ld h,e
	ld l,a
	add hl,hl
afxBnkAdr
	ld bc,0
	add hl,bc
	ld c,(hl)
	inc hl
	ld b,(hl)
	add hl,bc
	push hl

	ld hl,afxChDesc
	ld b,3
afxPlay0
	inc hl
	inc hl
	ld a,(hl)
	inc hl
	cp e
	jr c,afxPlay1
	ld c,a
	ld a,(hl)
	cp d
	jr c,afxPlay1
	ld e,c
	ld d,a
	push hl
	pop ix
afxPlay1
	inc hl
	djnz afxPlay0

	pop de
	ld (ix-3),e
	ld (ix-2),d
	ld (ix-1),b
	ld (ix-0),b

	ret
	