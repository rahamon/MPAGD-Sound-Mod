; "Basado en AGD Musicizer V2.1.8 by David Saphier (c)2018"

			org 32000
			
			jp InstallBank4 

InstallBank4: 	
			ld a,16							; for Divmmc
			ld (23388),a 
			push iy
			;di
			
			; carga presentación pantalla.
			ld b,6
			call bankScreen
			ld hl,screeninc
			ld de,$c000
			call zx7bin
			call showSplash
			
			; extract Arkplayer pack to 49152 en bank 4
			call bank4
			ld hl,ayplaybin
			ld de,49152
			call zx7bin
			call bank0			
			
exit:
			pop iy							; for Divmmc
			;ei
			ret 
			
			include "routines.asm"
			include	"zx7.asm"
			defs 4,0
			
ayplaybin: 	; ARK Block playroutine
			incbin "PLAY4BANK.bin.zx7"
			defs 4,0
			
screeninc:
			incbin "screen.scr.zx7"
			defs 4,0
