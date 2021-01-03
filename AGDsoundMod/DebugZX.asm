; Debugger code -----------------------------------------------------------------
; This code will have to be written in contended RAM at the start of the game.
; Will therefore need to build with new compiler switch for debug: -d.
; In main loop, jp mloop needs replacing with jp DEBUG and DEBUG needs definition
; either as mloop or dbloop.

; Init the debug screen.

idebug di                  ; interrupts off.
       xor a               ; zero in accumulator.
       ld (dbflag),a       ; reset step flag.
       ld (togscr),a       ; set game screen.
       call ramd           ; bring in debug RAM.
       ld hl,49152         ; address of screen.
       ld de,49153         ; second byte.
       ld bc,6911          ; bytes to write.
       ld (hl),0           ; clear first byte.
       ldir                ; clear debug screen.
       ld hl,dbtxt0        ; debug text.
       call dbstr          ; show string.
       call ramg           ; bring in game RAM.
       ld a,8              ; default debug screen.
       ld (togscr),a       ; set debug screen.
       ei                  ; interrupts back on.
       jp start

dbloop ld a,(dbflag)       ; get step flag.
       and a               ; has it been set?
       jr nz,dbstop        ; yes, pause for next step.
       call 654            ; get keypress.
       ld a,d              ; get shift status.
       cp 39               ; CAPS pressed?
       jp nz,mloop         ; no, return to main loop.
       ld a,e              ; get status of other keys.
       cp 32               ; SPACE pressed?
       jp nz,mloop         ; no, return to main loop.
dbstop xor a               ; zero in accumulator.
       ld (dbflag),a       ; reset step flag.
dbmain di                  ; interrupts off.
       ld hl,scno          ; variables.
       ld de,dbscno        ; destination.
       ld bc,dbgend-dbscno ; size of variables area.
       ldir                ; copy to lower RAM.
       call ramd           ; bring in debug RAM.
       call dbsv           ; show variables.
dbmen0 call dbdeb          ; debounce keys.
dbmenu call 654            ; read keyboard.
       ld a,e              ; get key pressed.
       cp 5                ; T for toggle?
       jr z,dbtog          ; toggle screen display.
       cp 30               ; S for step?
       jr z,dbstp          ; yes, step through another frame.
       cp 13               ; R to run?
       jr z,dbrun          ; continue game as normal.
       cp 8                ; N for next sprite?
       jr z,dbnxt          ; next sprite in table.
       cp 34               ; P for previous sprite?
       jr z,dbprv          ; next sprite in table.
       jr dbmenu
dbtog  ld a,(togscr)       ; display screen flag.
       xor 8               ; toggle screen shown in debug.
       ld (togscr),a       ; set new screen.
       call ramd           ; show new debug screen display.
       jr dbmen0
dbstp  ld (dbflag),a       ; set step flag.
       call ramg           ; bring the game RAM back in.
       jr dbrun0           ; return to game.
dbrun  xor a               ; game screen.
       ld (togscr),a       ; set up display screen.
       call ramg           ; page in the game RAM.
       ld a,8              ; default debug screen.
       ld (togscr),a       ; set debug screen.
dbrun0 ei                  ; restore interrupts.
       jp mloop            ; back to game.
dbdeb  call 654            ; d=shift, e=key.
       inc e               ; is it 255?
       jr nz,dbdeb         ; no - loop until key is released.
       ret
dbnxt  ld a,(sprno)        ; get sprite number.
       add a,TABSIZ        ; next one.
       cp SPRBUF           ; reached size of table?
       jr c,dbnxt0         ; no, this is okay.
       xor a               ; start at first sprite again.
dbnxt0 ld (sprno),a        ; set new sprite displacement.
       call dbsv0          ; show next sprite parameters.
       jr dbmen0           ; back to menu.
dbprv  ld a,(sprno)        ; get sprite number.
       and a               ; at start of sprite table?
       jr nz,dbprv0        ; no, carry on.
       ld a,SPRBUF         ; end of table.
dbprv0 sub TABSIZ          ; previous one.
       jr dbnxt0           ; make this our next sprite.

; Show variables.

dbsv   ld a,15             ; white on blue.
       ld (dbcol),a        ; set up colour attributes for variables.
       defb 33,9,2         ; set coordinates.
       ld a,(dbga)         ; get variable.
       call dbnum          ; show variable.
       defb 33,9,10        ; set coordinates.
       ld a,(dbgb)         ; get variable.
       call dbnum          ; show variable.
       defb 33,9,18        ; set coordinates.
       ld a,(dbgc)         ; get variable.
       call dbnum          ; show variable.
       defb 33,9,26        ; set coordinates.
       ld a,(dbgd)         ; get variable.
       call dbnum          ; show variable.
       defb 33,11,2        ; set coordinates.
       ld a,(dbge)         ; get variable.
       call dbnum          ; show variable.
       defb 33,11,10       ; set coordinates.
       ld a,(dbgf)         ; get variable.
       call dbnum          ; show variable.
       defb 33,11,18       ; set coordinates.
       ld a,(dbgg)         ; get variable.
       call dbnum          ; show variable.
       defb 33,11,26       ; set coordinates.
       ld a,(dbgh)         ; get variable.
       call dbnum          ; show variable.
       defb 33,13,2        ; set coordinates.
       ld a,(dbgi)         ; get variable.
       call dbnum          ; show variable.
       defb 33,13,10       ; set coordinates.
       ld a,(dbgj)         ; get variable.
       call dbnum          ; show variable.
       defb 33,13,18       ; set coordinates.
       ld a,(dbgk)         ; get variable.
       call dbnum          ; show variable.
       defb 33,13,26       ; set coordinates.
       ld a,(dbgl)         ; get variable.
       call dbnum          ; show variable.
       defb 33,15,2        ; set coordinates.
       ld a,(dbgm)         ; get variable.
       call dbnum          ; show variable.
       defb 33,15,10       ; set coordinates.
       ld a,(dbgn)         ; get variable.
       call dbnum          ; show variable.
       defb 33,15,18       ; set coordinates.
       ld a,(dbgo)         ; get variable.
       call dbnum          ; show variable.
       defb 33,15,26       ; set coordinates.
       ld a,(dbgp)         ; get variable.
       call dbnum          ; show variable.
       defb 33,17,2        ; set coordinates.
       ld a,(dbgq)         ; get variable.
       call dbnum          ; show variable.
       defb 33,17,10       ; set coordinates.
       ld a,(dbgr)         ; get variable.
       call dbnum          ; show variable.
       defb 33,17,18       ; set coordinates.
       ld a,(dbgs)         ; get variable.
       call dbnum          ; show variable.
       defb 33,17,26       ; set coordinates.
       ld a,(dbgt)         ; get variable.
       call dbnum          ; show variable.
       defb 33,19,2        ; set coordinates.
       ld a,(dbgu)         ; get variable.
       call dbnum          ; show variable.
       defb 33,19,10       ; set coordinates.
       ld a,(dbgv)         ; get variable.
       call dbnum          ; show variable.
       defb 33,19,18       ; set coordinates.
       ld a,(dbgw)         ; get variable.
       call dbnum          ; show variable.
       defb 33,19,26       ; set coordinates.
       ld a,(dbgz)         ; get variable.
       call dbnum          ; show variable.
       defb 33,21,19       ; set coordinates.
       ld a,(dblif)        ; get variable.
       call dbnum          ; show variable.
       defb 33,21,7        ; set coordinates.
       ld a,(dbscno)       ; get screen number variable.
       call dbnum          ; show variable.
       defb 33,21,29       ; set coordinates.
       ld a,(dbgrnd)       ; get screen number variable.
       call dbnum          ; show variable.
dbsv0  call ramg           ; bring in game RAM.
       ld a,(sprno)        ; sprite number.
       ld e,a              ; copy to de.
       ld d,0
       ld hl,sprtab        ; sprite table.
       add hl,de           ; point to sprite.
       ld de,dbspbf        ; buffer.
       ld bc,13            ; bytes to transfer.
       ldir                ; copy to debug area.
       call ramd           ; get debug RAM back.
       ld ix,dbspbf        ; point to buffer.
       ld a,(ix+5)         ; get type.
       defb 33,0,20        ; set coordinates.
       call dbnum          ; show sprite parameter.
       ld a,(ix+6)         ; get image.
       defb 33,2,20        ; set coordinates.
       call dbnum          ; show sprite parameter.
       ld a,(ix+7)         ; get frame.
       defb 33,4,20        ; set coordinates.
       call dbnum          ; show sprite parameter.
       ld a,(ix+10)        ; get direction.
       defb 33,6,20        ; set coordinates.
       call dbnum          ; show sprite parameter.
       ld a,(ix+9)         ; get AGD y/MPAGD x.
       defb 33,0,29        ; set coordinates.
       call dbnum          ; show sprite parameter.
       ld a,(ix+8)         ; get AGD x/MPAGD y.
       defb 33,2,29        ; set coordinates.
       call dbnum          ; show sprite parameter.
       ld a,(ix+11)        ; get setting a.
       defb 33,4,29        ; set coordinates.
       call dbnum          ; show sprite parameter.
       ld a,(ix+12)        ; get setting b.
       defb 33,6,29        ; set coordinates.
       call dbnum          ; show sprite parameter.
       ret

; Page in game RAM.

ramg   ld a,(togscr)       ; game/debug screen.
       add a,16            ; ROM 1, RAM 0.
       jr ramx

; Page in debug RAM.

ramd   ld a,(togscr)       ; game/debug screen.
       add a,23            ; ROM 1, RAM 7.
ramx   ld bc,32765         ; memory paging port.
       out (c),a           ; page in required RAM bank.
       ret                 ; done.


; Debug print address.

dbpra  ld a,(debugx)       ; x position.
       ld e,a              ; place in e for now.
       and 24              ; which of 3 segments do we need?
       add a,192           ; add 192 for start address of screen.
       ld d,a              ; that's our high byte.
       ld a,e              ; restore x coordinate.
       rrca                ; multiply by 32.
       rrca
       rrca
       and 224             ; lines within segment.
       ld e,a              ; set up low byte for x.
       ld a,(debugy)       ; now get y coordinate.
       add a,e             ; add to low byte.
       ld e,a              ; final low byte.
       ret

; Debug attribute address of char in de.

dbattr ld a,(debugx)       ; x coordinate.
       rrca                ; multiply by 32.
       rrca
       rrca
       ld e,a              ; store shift in low byte.
       and 3               ; high byte bits.
       add a,216           ; 216 * 256 = 55296, start of screen attributes.
       ld d,a              ; that's our high byte.
       ld a,e              ; restore shift result.
       and 224             ; only want low bits.
       ld e,a              ; put into low byte.
       ld a,(debugy)       ; fetch y coordinate.
       and 31              ; should be in range 0 - 31.
       add a,e             ; add to low byte.
       ld e,a              ; new low byte.
       ret

dbflag defb 0              ; step flag - stops after each frame when set.
dbcol  defb 71             ; debug text colour attribute.
debugx defb 0              ; debug cursor position.
debugy defb 0
dbnmwk defb 48,48,48,0     ; number display workspace.
togscr defb 0              ; toggle screen display flag.
sprno  defb 0              ; sprite number.
dbspbf defb 0,0,0,0,0,0,0  ; sprite buffer.
       defb 0,0,0,0,0,0

; Display debug number.

dbnum  ld (debugx),hl      ; set coordinates.
       ld bc,dbnmwk        ; display workspace.
       call num2td         ; convert accumulator to three-digit string.
       ld hl,dbnmwk        ; point to number string.

; Display debug string.

dbstr  ld a,(hl)           ; get next character.
       inc hl              ; next byte.
       cp 22               ; AT code?
       jr z,dbstr0         ; set new cursor position.
       cp 16               ; new colour code?
       jr z,dbstr1         ; set new cursor position.
       ret c               ; any value below that terminates the string.
       push hl             ; save text pointer.
       call dbchr          ; show character.
       pop hl              ; restore text pointer.
       jr dbstr            ; repeat for rest of screen.
dbstr0 ld e,(hl)           ; get coordinate.
       inc hl              ; next byte.
       ld d,(hl)           ; get coordinate.
       inc hl              ; next byte.
       ld (debugx),de      ; set new text coordinates.
       jr dbstr            ; continue displaying string.
dbstr1 ld a,(hl)           ; get attribute.
       ld (dbcol),a        ; set
       inc hl              ; next byte.
       jr dbstr            ; continue displaying string.

; Display debug character.

dbchr  rlca                ; multiply char by 8.
       rlca
       rlca
       ld e,a              ; store shift in e.
       and 7               ; only want high byte bits.
       ld d,a              ; store in d.
       ld a,e              ; restore shifted value.
       and 248             ; only want low byte bits.
       ld e,a              ; that's the low byte.
       ld hl,15360         ; address of font.
       add hl,de           ; add displacement.
       call dbpra          ; get screen address.
       ld b,8              ; rows to write.
dbchr0 ld a,(hl)           ; get image byte.
       ld (de),a           ; copy to screen.
       inc hl              ; next image byte.
       inc d               ; next screen row down.
       djnz dbchr0         ; repeat for ramainder of character.
       call dbattr         ; get attribute address for cell.
       ld hl,dbcol         ; point to debug colours.
       ldi                 ; write attribute.
       ld hl,debugy        ; cursor position.
       inc (hl)            ; move right one column.
       ret

dbtxt0 defb 22,0,0,16,86
       defb 'MPAGD DEBUG'
       defb 22,2,0,16,68
       defb 'S Step frame'
       defb 22,3,0
       defb 'T Toggle screen'
       defb 22,4,0
       defb 'R Run'
       defb 22,5,0
       defb 'N/P Sprite'
       defb 22,7,0,16,86
       defb 'VARIABLES'
       defb 22,9,0,16,69
       defb 'A'
       defb 22,9,8
       defb 'B'
       defb 22,9,16
       defb 'C'
       defb 22,9,24
       defb 'D'
       defb 22,11,0
       defb 'E'
       defb 22,11,8
       defb 'F'
       defb 22,11,16
       defb 'G'
       defb 22,11,24
       defb 'H'
       defb 22,13,0
       defb 'I'
       defb 22,13,8
       defb 'J'
       defb 22,13,16
       defb 'K'
       defb 22,13,24
       defb 'L'
       defb 22,15,0
       defb 'M'
       defb 22,15,8
       defb 'N'
       defb 22,15,16
       defb 'O'
       defb 22,15,24
       defb 'P'
       defb 22,17,0
       defb 'Q'
       defb 22,17,8
       defb 'R'
       defb 22,17,16
       defb 'S'
       defb 22,17,24
       defb 'T'
       defb 22,19,0
       defb 'U'
       defb 22,19,8
       defb 'V'
       defb 22,19,16
       defb 'W'
       defb 22,19,24
       defb 'Z'
       defb 22,21,0
       defb 'SCREEN'
       defb 22,21,13
       defb 'LIVES'
       defb 22,21,25
       defb 'RND'
       defb 22,0,16
       defb 'TYP'
       defb 22,2,16
       defb 'IMG'
       defb 22,4,16
       defb 'FRM'
       defb 22,6,16
       defb 'DIR'
       defb 22,0,26
       defb 'X'
       defb 22,2,26
       defb 'Y'
       defb 22,4,26
       defb 'SA'
       defb 22,6,26
       defb 'SB'
       defb 0

dbscno defb 0              ; present screen number.
dblif  defb 3              ; number of lives.
dbga   defb 0              ; general-purpose variable.
dbgb   defb 0              ; general-purpose variable.
dbgc   defb 0              ; general-purpose variable.
dbgd   defb 0              ; general-purpose variable.
dbge   defb 0              ; general-purpose variable.
dbgf   defb 0              ; general-purpose variable.
dbgg   defb 0              ; general-purpose variable.
dbgh   defb 0              ; general-purpose variable.
dbgi   defb 0              ; general-purpose variable.
dbgj   defb 0              ; general-purpose variable.
dbgk   defb 0              ; general-purpose variable.
dbgl   defb 0              ; general-purpose variable.
dbgm   defb 0              ; general-purpose variable.
dbgn   defb 0              ; general-purpose variable.
dbgo   defb 0              ; general-purpose variable.
dbgp   defb 0              ; general-purpose variable.
dbgq   defb 0              ; general-purpose variable.
dbgr   defb 0              ; general-purpose variable.
dbgs   defb 0              ; general-purpose variable.
dbgt   defb 0              ; general-purpose variable.
dbgu   defb 0              ; general-purpose variable.
dbgv   defb 0              ; general-purpose variable.
dbgw   defb 0              ; general-purpose variable.
dbgz   defb 0              ; general-purpose variable.
       defb 0              ; control, 0 = keyboard, 1 = Kempston, 2 = Sinclair, 3 = Mouse.
       defb 0              ; cursor x position.
       defb 0              ; cursor y position.
       defb 0              ; last clock reading.
dbgrnd defb 255            ; last random number.
dbgobj defb 254            ; last object number.
dbgopt defb 255            ; last option chosen from menu.
dbgblk defb 255            ; block type.
dbgend equ $