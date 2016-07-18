; This simple program simply adds to 32-bit integers together
; and stores the results back in memory

%include "asm_io.inc"

segment .data	
	integer1	dd    15	; first int
	integer2	dd     6	; second int

segment .bss
	result	resd	1	; result

segment .text
	global asm_main
asm_main:
	enter	0,0
	pusha	
	mov 	eax, [integer1] 	; eax = first integer
	add 	eax, [integer2]		; eax += second integer
	mov 	[result], eax		; result = eax
	call	print_int		; print the result
	popa
	mov	eax, 0
	leave
	ret

