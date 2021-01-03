eop		equ $
		if ($%256 != 0)
			org (($/256)*256)+256				; Align to a 256 byte page boundary
		endif
IJUMPA	equ $
