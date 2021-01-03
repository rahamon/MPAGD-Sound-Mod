
@echo off
cls
rem 1m,1d,m
set name=%~n1
del "%name%".VT*.txt

rem Brief instructions for the converter parameters: 

rem autosiril.exe <file.mid> <channel1>, <channel2>, <channel3> N1 N2 N3 N4 N5 N6 N7 

rem N1 - lines per quarter note (beat) (default 4,
rem 	with a bar in the editor VTi will fall 4 * 4 = 16 stitches
rem		and 64 rows of the pattern will contain 4 measures) 
rem N2 - shift in the lines for the primary echo (default 3) 
rem N3 - shift in the lines of the secondary echo (default 6)

rem  d - (Drums) - drums. 
rem  m - (Mono melody) - melody (monophonic) - chords on track with this
rem 	type will be converted to a single note (the highest note of the chord) 
rem  p - (Polyphonic melody) - Harmony (polyphony) - chords on track with this type
rem 	will be converted into ornaments. 
rem  Type of track is indicated after its number: "1m" or "2p" or "4d". 
rem Subtype track: 
rem  e - (Envelope) - combined with a track like "m", indicated after the type used 
rem 	primarily for bass notes will be converted using the envelope: "1me". 
rem Modifiers properties tracks: 
rem  u - (mUte echo) - to echo the track will not be generated 

rem opciones escogidas para Pac-man theme 
autosiril.exe %1 1m,2du,2me 4 0 1
ren %1e.txt "%name%".VT1.txt

rem opciones escogidas para Pac-man intermission or Pac-man theme
autosiril.exe %1 1me,2m,2p 2 0 1
ren %1e.txt "%name%".VT2.txt

