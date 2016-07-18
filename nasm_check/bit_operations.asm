; This simple program simply adds to 32-bit integers together
; and stores the results bac in memory

%include "asm_io.inc"

segment .data	
	hex1		dd	0FFFFA123h
	hex2		dd	07D06Fh
	hex3		dd	04B6A56EBh
	hex4		dd	0BBBBBBBBh
	pattern1	dd	090000000h
	pattern2	dd	0B0000000h
	mask		dd	0F0000000h
segment .bss
segment .text
	global asm_main
asm_main:
	enter	0,0
	pusha	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	xor	eax, eax
	xor	ebx, ebx
	xor	ecx, ecx
	xor	edx, edx

	mov	eax, DWORD [hex4]	; move integer -41251 into eax
	mov	dh, 28			; loop counter
start:
	mov	ecx, eax		; move eax into ecx (working register)
	dump_regs 0
	and	ecx, DWORD [mask]	; zero out unintrested bits
	;xor	ecx, DWORD [pattern2]	; check if pattern matches
	cmp	ecx, DWORD [pattern2]
	
	je	inc_count		

	dump_regs 0

shift_mask:
	shr	DWORD [mask], 1		; shift mask one bit to the right
	shr	DWORD [pattern2], 1	; shift pattern one bit to the right
	dec	dh
	cmp	dh, 0
	jnz	start
	jmp 	end

inc_count:
	inc 	dl			; increment pattern match count
	cmp	dh, 0
	jnz	shift_mask
end:
	mov	eax, DWORD [pattern2]
	mov	ebx, DWORD [mask]
	dump_regs 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	popa
	mov	eax, 0
	leave
	ret

