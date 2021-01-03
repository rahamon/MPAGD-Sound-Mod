; subroutines 

bank0:	; swap to bank 0 - original @ 49152 - 16k
		;di
		ld a,(23388)   
		and 248
		or 0 
		ld bc,32765
		ld (23388),a
		out (c),a
		;ei
		ret

bank4:	; swap to bank 4 @ 49152 - 16k
		;di
		ld a,(23388)   
		and 248
		or tBank 
		ld bc,32765
		ld (23388),a
		out (c),a
		;ei
		ret 
