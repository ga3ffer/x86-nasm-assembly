;Translate assembly code into C/Java

%include "asm_io.inc"

segment .data	
	a	db	2

segment .bss
	b	resd	1	

segment .text
	global asm_main
asm_main:
	enter	0,0
	pusha	


	push	dword	4
	push	dword	[a]
	call	f
	add	esp, 8
	mov	[b], eax
	call	print_int
	call	print_nl


	popa
	mov	eax, 0
	leave
	ret

f:
	push	ebp
	mov	ebp, esp
	sub	esp, 4
	mov	dword [ebp-4], 1
	cmp	dword [ebp+8], 0
	jz	endf
	mov	ebx, [ebp+8]
	dec	ebx
	push	ebx
	push	dword [ebp+12]
	call	f
	add	esp, 8
	mov	ebx, [ebp+12]
	add	ebx, eax
	mov	[ebp-4], ebx

endf:

	mov	eax, [ebp-4];
	mov	esp, ebp
	pop	ebp
	ret
