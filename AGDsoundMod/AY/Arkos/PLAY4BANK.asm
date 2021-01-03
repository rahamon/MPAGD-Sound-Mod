		
		org 49152

Main_Player_Start:
        ;Selects the hardware. Mandatory, as Amstrad CPC is default.
        PLY_AKG_HARDWARE_SPECTRUM = 1
        
        ;IMPORTANT: enables the sound effects in the player. This must be declared BEFORE the player itself.
        PLY_AKG_MANAGE_SOUND_EFFECTS = 1
        
        ;Want a ROM player (a player without automodification)?
        ;PLY_AKG_Rom = 1                         ;Must be set BEFORE the player is included.
            
        ;Include here the Player Configuration source of the songs (you can generate them with AT2 while exporting the songs).
        ;If you don't have any, the player will use a default Configuration (full code used), which may not be optimal.
        ;If you have several songs, include all their configuration here, their flags will stack up!
        ;Warning, this must be included BEFORE the player is compiled.
        ;Warning, if you use player configuration, you must ALSO include the configuration file for the sound effects.

		jp PLY_AKG_Init															; PLAY4BANK + 0.
		jp PLY_AKG_Play															; PLAY4BANK + 3.
		jp PLY_AKG_Stop															; PLAY4BANK + 6.
		PLAY4BANK_MUSICDATA:				defw MUSICDATA						; PLAY4BANK + 9.
		PLAY4BANK_EMPTYSONG:				defw EMPTYSONG						; PLAY4BANK + 11.
		PLAY4BANK_PLY_AKG_Endofthesong:		defw PLY_AKG_Endofthesong			; PLAY4BANK + 13.
        jp PLY_AKG_InitSoundEffects												; PLAY4BANK + 15.
        jp PLY_AKG_PlaySoundEffect												; PLAY4BANK + 18.
		PLAY4BANK_SoundEffects:				defw SoundEffects					; PLAY4BANK + 21.
		PLAY4BANK_longitud 					defw EndOfBin - Main_Player_Start	; PLAY4BANK + 23.
		
        include "PlayerAkg.asm"
        
        ;Declares the buffer for the ROM player, if you're using it. You can declare it anywhere of course.
        ;LIMITATION: the SIZE of the buffer (PLY_AKG_ROM_BufferSize) is only known *after* ther player is compiled.
        ;A bit annoying, but you can compile once, get the buffer size, and hardcode it to put the buffer wherever you want.
        ;Note that the size of the buffer shrinks when using the Player Configuration feature. Use the largest size and you'll be safe.
        IFDEF PLY_AKG_Rom
                PLY_AKG_ROM_Buffer = #c000
        ENDIF
Main_Player_End:
		
MUSICDATA:							
        include "AKMUSIC.asm"
		defs 4,0
EMPTYSONG:
        include "Music_Empty.asm"		;Useful to listen to the sound effects alone.
SoundEffects:
        include "AKFX.asm"

EndOfBin equ $
