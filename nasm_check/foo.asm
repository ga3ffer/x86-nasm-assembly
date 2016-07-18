; This simple program simply adds to 32-bit integers together
; and stores the results bac in memory

%include "asm_io.inc"

segment .data	
	L1	db	"abc"
	L2	dd	0AABBCCAAh
	L3	times 4	dw 25
	L4	db	"d",0

segment .text
	global asm_main
asm_main:
	enter	0,0
	pusha
	;

	dump_mem 2, L1, 1

	mov	eax, L2
	add	eax, 3
	mov	word [eax], 23
	dump_mem 2, L1, 1


	mov	ebx, L3
	dump_regs 1
	mov	ebx, [ebx]
	dump_regs 3
	movsx	eax, bh
	dump_regs 3

	mov	[L3], eax

	dump_regs 0
	dump_mem 1, L1, 1
	;
	popa
	mov	eax, 0
	leave
	ret

