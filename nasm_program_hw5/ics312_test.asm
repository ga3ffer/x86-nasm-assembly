; This simple program simply adds to 32-bit integers together
; and stores the results bac in memory

%include "asm_io.inc"

segment .data	
	itworks		db    "It works!",0

segment .text
	global asm_main
asm_main:
	enter	0,0
	pusha	
	mov 	eax, itworks	; print "It works!"
	call 	print_string	; print "It works!"
	call	print_nl	; print a new line
	popa
	mov	eax, 0
	leave
	ret

