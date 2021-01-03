; -----------------------------------------------------
; Fx routines con beeper		
; -----------------------------------------------------

fxsnd
		ld a,(ctrF)       ; sound to play.
		and a               ; any sound?
		jp z,exitbeep		; no.
		
		dec a
		ld (Beepfxplayer+1),a
		call Beepfxplayer
fxsnded
		xor a
		ld (ctrF),a
exitbeep
		ret

Beepfxplayer
		include "FX.asm"
		ret
		defs 4,0
		
; -------------------------------------------------------------
; Beeper Music Routines
; n = 36 -> monitor
; n = 64 -> commando: no regresa al game sin terminar la musica
; n = 96 -> playnote
; n = 0 -> commando: deshabilita loop (loop activado por defecto)
; n > 100 -> efectos
; -------------------------------------------------------------

isnd
		include "isnd48.asm"

beeper
		ld a,(ctrN)
		cp 0
		jp z,SetLoopOFF
		; check monitor
		cp 36
		jp z,monitor
		cp 64
		jp z,Noexitloop
		cp 96
		jp z,plsnd48
; Seleccion Musica:
		include "SelectTunes.asm"
initplayer
		ld (START+1),hl
		ld a,1
		ld (playfla),a					; PLAY flag = 1
		ld (LoopTun),a					; 1 (por defecto)
		xor a
		ld (termina),a					; 0 (por defecto)
startplayer
		xor a
		ld (PLY_Endofthesong),a		; 0 (por defecto)
		call START
		ret
		
plsnd48	
		; check end of song
		ld a,(PLY_Endofthesong)
		cp 1
		jp z,checkloop					; end or song -> check loop
		; check play
		DEFB $3E						; LD A,n
playfla	defb 0
		cp 0
		jr z,skipBeep
		; play
		call NEXTNOTE					; PLAY
		; check loop sin salida
		DEFB $3E						; LD A,n
termina	defb 0
		cp 1
        jp z,plsnd48						; termina la musica antes que otra cosa.
skipBeep
		ret
		
checkloop
		DEFB $3E        			    ; LD A,n
LoopTun	defb 0
		cp 1
		jp z,startplayer				; re-start player (loop)
		jp mute

SetLoopOFF
		xor a
		ld (LoopTun),a					; LoopTun = 0 -> desactiva loop
		ret

Noexitloop	
		ld a,1
		ld (termina),a					; termina = 1 -> activa loop sin salida
		ret

monitor
		ld a,(PLY_Endofthesong)
		cp 1
		jr nz,sonando
		xor a
		ld (vara),a
		ret
sonando
		ld a,1
		ld (vara),a
		ret
		
silenc						; mute/pause/stop a sound.
mute
		xor a
		ld (playfla),a		; MUTE/STOP		
		ret

plsnd	ret

; rutinas de sonido
BeepMusicPlayer
		include "BOXPlayer.asm"
; Puedes escoger otro player, si lo haces tendrás que
; compilar de nuevo la música con el motor beepola correspondiente. 
		;include "StudioPlayer.asm"
		;include "BeepPlayer.asm"
		
; por defecto el player necesita apuntar a MUSICDATA = defaut tune.		
MUSICDATA
		include "music.asm"
		defs 4,0
		
		
