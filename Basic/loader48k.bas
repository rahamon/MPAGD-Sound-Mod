5 CLEAR VAL "31999"
10 LOAD "SC"SCREEN$: POKE 23739,111
20 LOAD "AG"CODE 32000
30 INK 7: PAPER 0: BORDER 0
40 LET H = 0: LET S = 0: DIM h$(6,11)
50 FOR f = 1 TO 5
60 LET h$(f) = "AAA  000000"
70 NEXT f
80 LET R = USR 32000
90 LET D = R : LET a$ = ""
100 FOR f = 0 TO 5
110 LET a$ = a$ + CHR$ PEEK (D + f)
120 NEXT f
130 LET M = VAL a$
200 CLS
300 FOR i = 1 TO 5
310 IF M = VAL h$(i,6 TO) THEN GO TO 650 
330 IF i = 6 THEN GO TO 650
340 IF M < VAL h$(i,6 TO) THEN NEXT i
405 PRINT AT 3, 9; "NUEVO RECORD!"
430 FOR j = 5 TO i STEP -1
440 LET h$(j+1) = h$(j)
450 NEXT j
510 LET b$="   " : LET n = 65: LET x = 1
520 GO SUB 800
570 PRINT AT (5 + i*2),10; b$ + "  " + a$
572 PRINT AT (5 + i*2),x+9; OVER 1; CHR$(143)
575 LET k$ = INKEY$: IF k$ = "" THEN GO TO 575
580 IF k$ = "w" AND n < 90 THEN LET n = n + 1: LET b$(x) = CHR$ (n)
585 IF k$ = "s" AND n > 65 THEN LET n = n - 1: LET b$(x) = CHR$ (n)
595 IF k$ = "a" AND x > 1 THEN LET x = x - 1
600 IF k$ = "d" AND x < 3 THEN LET x = x + 1
610 IF k$ = " " THEN LET h$(i) = b$ + "  " + a$: GO TO 650
620 BEEP .05,0 : GO TO 570
650 PRINT AT 3, 9; " MARCADORES  ": GO SUB 800
655 FOR f = 1 TO 500
660 IF INKEY$ <> "" THEN GO TO 80
670 NEXT f 
680 GO TO 80
810 FOR f = 1 TO 5
820 PRINT AT (5 + f*2),10; INK f; h$(f)
840 NEXT f
850 RETURN
