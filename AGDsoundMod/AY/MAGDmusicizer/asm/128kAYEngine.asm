; Modulo para lanzar musica y efectos
; MUSIC AND SOUNDS

MUSICSTART 	equ 51310
tBank		equ	4
AGame		equ start
IJUMP		equ IJUMPA+$FF
;IJUMP 		equ $f8FF 				; location in memory where out jump address will be. ($nnFF<f9b6)
BASICMODE 	equ 0					; funciona desde basic

			include "musicsizes.asm"
		
			jp initPlayer 			; main call org+0 INICIADRIVERS
			
;str:		defb	"Based in AGD Musicizer by David Saphier."
gameloop:
			call IMStart
			call AGame
salirABasicScore:
			call IMOff
			ld bc,score				; return pointing to score.
			ret						; salir

initPlayer:
			di
			; write ISR address to the ijunp
			call bank0
			
			ld hl,ISR 
			ld (IJUMP),hl
			;ld (IJUMP+1),hl

			; bank 4
			call bank4
			
			ld hl,ISR 
			ld (IJUMP),hl 
			;ld (IJUMP+1),hl
			
			ld a,31					; no music on launch. EmptySong
			ld (ctrN),a
			; setup
			call bank4
			call 49152				; init VT player
			call bank0
			call FXsetups
			jp gameloop
			
msetup:								; mover a AY.asm
			di ;
			ld a,10					; command new check ciclo+
			ld (ctrN),a
			call bank4
			push hl 
			;call 49152
			call 49152+8			; mute	
			pop hl 
			;ld (49153),hl	
			;call 49152				; init
			call 49155
			ret 		
			
			include "musicplayback.asm"
			include	"routines.asm"
			include "IMroutines.asm"
			
; FX and MUSIC routines
			include "AY.asm"

