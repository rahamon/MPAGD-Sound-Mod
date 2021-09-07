eop		equ $
		;defs 256,0						; parche: descomentra y reservar 256 bytes para PUTBLOCK en modo aventura
		if ($%256 != 0)
			org (($/256)*256)+256				; Align to a 256 byte page boundary
		endif
IJUMPA	equ $
