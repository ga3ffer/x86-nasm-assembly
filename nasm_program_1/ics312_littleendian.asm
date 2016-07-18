; This simple program demonstrate that the processor
; uses Little Endian

%include "asm_io.inc"

segment .data	
	bytes	dd	06C697665h	; "live"
	end	db	0	       	; null

segment .text
	global asm_main
asm_main:
	enter		0,0
	pusha
	mov		eax, bytes	; note that this is an address
	call		print_string	; print the string at that address
	call		print_nl	; print a new line
	mov		eax, [bytes]	; load the 4-byte value into eax
	dump_mem	0, bytes, 1	; display the memory
	dump_regs	0		; display the registers
	pusha
	popa
	mov		eax, 0
	leave
	ret

