@echo OFF
cls
rem ------------------------------------------------------
rem MODO
rem 0 = Standard MPAG
rem 1 = Modificacion cargador para Pac-man compatible
set mod=0
rem ------------------------------------------------------
rem Modificaciones de cargador:
rem nombre para tu juego
set gamename=pacman
rem ------------------------------------------------------
rem Modificaciones de sonido
rem 0 = Standard
rem 1 = ZX Spectrum 48k Beeper
rem 2 = ZX Spectrum 128/+2/+3 AY-3-8912 Musicizer
rem 3 = ZX Spectrum 128/+2/+3 AY-3-8912 Arkos Traker
set modsnd=2
rem ------------------------------------------------------

rem empacaje standard
if %mod% == 0 (
	if %modsnd% == 0 (
		rem Compile AGD file
			copy AGDsource\%1.agd AGD
			cd AGD
			CompilerZX %1
		rem Assemble game
			copy %1.asm ..\sjasmplus\
			copy ..\..\user.asm ..\sjasmplus\
			del %1.*
			cd ..\sjasmplus
			copy leader.txt+%1.asm+trailer.txt agdcode.asm
			sjasmplus.exe agdcode.asm --lst=list.txt
			copy test.tap ..\speccy
		rem limpieza en sjasmplus
			del %1.asm
			del user.asm
			del agdcode.asm
			del test.tap
		rem Start emulator
			cd ..\speccy
			speccy -128 test.tap
			del test.tap
			cd ..
			exit
	)
)
rem compile
	if %modsnd% == 0 (
		rem Compile AGD file
			copy AGDsource\%1.agd AGD
			cd AGD
			CompilerZX %1
	) else (
		rem Compilar AGD file Modificado
			echo Sound Mod build ....
			copy AGDsource\%1.agd AGDsoundMod
			cd AGDsoundMod
			..\AGD\CompilerZX %1
	)
rem actualizar assemble game
	copy %1.asm ..\assembly\
	copy ..\..\user.asm ..\assembly\
	del %1.*
	cd ..\assembly
rem actualizar fuentes
	if %modsnd% == 1 (
		rem actualizar fuenter para Beeper
			xcopy /I /C /Y /q ..\AGDsoundMod\Beeper\*.asm ..\assembly
			xcopy /I /C /Y /q ..\sound\*.asm ..\assembly
	)
	if %modsnd% == 2 (
		rem Actualizar fuentes a través de MAGDmusicizer para VT
			xcopy /E /I /C /Y /q ..\AGDsoundMod\AY\MAGDmusicizer ..\..\MAGDmusicizer
			xcopy /I /C /Y /q ..\Sound\*.pt3 ..\..\MAGDmusicizer\bin
			copy ..\Sound\sfxBank.afb ..\..\MAGDmusicizer\asm
			copy ..\Tapes\screen.scr ..\..\MAGDmusicizer
			cd ..\..\MAGDmusicizer
			tools\zx7 screen.scr
			AGDmusicizerII /nc
			echo Joining tape data       : Ignored by MPAGD-Sound Mod, all is OK.
			tools\fart --remove asm\music.asm "..\bin\\"
			xcopy /I /C /Y /q  bin\*.zx7 asm
			copy tools\vt49152.bin.zx7 asm
			copy screen.scr.zx7 asm
			xcopy /I /C /Y /q asm "..\Suite ZX\Assembly"
		rem limpiar
			cd ..
			rd /s /q MAGDmusicizer
			cd "Suite ZX\Assembly"
	)
	if %modsnd% == 3 (
		rem Actualizar fuentes para Arkos Traker 2
			xcopy /I /C /Y /q ..\AGDsoundMod\AY\Arkos\*.asm ..\assembly
			xcopy /I /C /Y /q ..\sound\*.asm ..\assembly
			copy ..\Tapes\screen.scr ..\assembly
	)
rem construir Cargadores
	if %mod% == 0 (
		if %modsnd% LEQ 1 (
			echo Cargador Standard minimalista
			copy ..\Basic\loader.bas ..\assembly\
			..\Tools\bas2tap -e -a1 -s%gamename% loader.bas loader.tap
		) else (
			echo Cargador Standard para AY-3-8912
			copy ..\Basic\loader128k.bas ..\assembly\
			..\Tools\bas2tap -e -a1 -s%gamename% loader128k.bas loader.tap			
		)
	)
	if %mod% == 1 (
		if %modsnd% LEQ 1 (
			echo Cargador con Marcadores
			copy ..\Basic\marcadores48k.bas ..\assembly\
			..\Tools\bas2tap -e -a1 -s%gamename% marcadores48k.bas loader.tap
		) else (
			echo Cargador para AY-3-8912 con Marcadores 
			copy ..\Basic\marcadores128k.bas ..\assembly\
			..\Tools\bas2tap -e -a1 -s%gamename% marcadores128k.bas loader.tap
		)
		..\Tools\fart %1.asm 24832 32000
		..\Tools\fart %1.asm "jp gamelp " "jp game"
	)
rem modificaciones de código
	if %modsnd% == 1 (
		..\tools\fart %1.asm "plsnd  ret" "	   include \"48k.asm\""
	)
	if %modsnd% == 2 (
		..\tools\fart %1.asm "jp start" "include \"128kAYEngine.asm\""
		..\tools\fart %1.asm "eop    equ $" "	   include \"trailer.asm\""
		if %mod% == 0 (
			..\tools\fart bank4driver.asm 32000 24832
		)
	)
	if %modsnd% == 3 (
		..\tools\fart %1.asm "jp start" "include \"128k.asm\""
		..\tools\fart %1.asm "eop    equ $" "	   include \"trailer.asm\""
		if %mod% == 0 (
			..\tools\fart bank4driver.asm 32000 24832
		)
	)
rem empacaje
	if %modsnd% == 2 (
		..\tools\rasm FX4BANK.asm -o FX4BANK
		..\tools\zx7 FX4BANK.bin
		..\tools\Pasmo.exe --tap --name MUD bank4driver.asm MUD.tap
	)
	if %modsnd% == 3 (
		..\tools\rasm PLAY4BANK.asm -o PLAY4BANK
		..\tools\zx7 PLAY4BANK.bin
		..\tools\zx7 screen.scr
		..\tools\rasm %1.asm -o source
		..\tools\rasm bank4driver.asm -o mpack
		..\tools\bin2tap source.bin -o AG.tap
		..\tools\bin2tap mpack.bin -o MUD.tap	
	) else (
		..\Tools\Pasmo --tap --name AG %1.asm AG.tap
	)
rem montaje
	copy ..\Tapes\SC.tap ..\assembly\
	if %modsnd% LEQ 1 (
		copy /b loader.tap + SC.tap + AG.tap %gamename%.tap
	) else (
		copy /b loader.tap + MUD.tap + AG.tap %gamename%128.tap
	)

rem Start emulator
	copy %gamename%*.tap ..\
	if %modsnd% LEQ 1 (
		..\speccy\speccy -128 ..\%gamename%.tap
	) else (
		..\speccy\speccy -128 ..\%gamename%128.tap
	)

rem limpieza en assembly
	del /q *.*
	

