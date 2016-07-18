; This program takes one floating point argument, then the function
; compute_exp is called and computes the exponential function.

%include "asm_io.inc"

%define x DWORD [ebp + 8]		; argument

segment .data	

segment .bss
	counter	resq	1		

segment .text
	global compute_exp
compute_exp:
	enter	0,0
	pusha	


	fld1				; ST0 =  x^n/n!
	fld1				; ST0 = x^n/n!, ST1 = summation
	mov	ebx, 0

add_loop:
	cmp	ebx, 40			; loop 40 times
	jz	add_loop_end
	inc	ebx

	fxch	st1			; updating x^n/n
	fmul	DWORD x			; x^(n-1)/(n-1) * x = x^n/(n-1)
	mov	[counter], ebx
	fidiv	DWORD [counter]		;( x^n/(n-1))/n = x^n/n
	fxch	st1			; update summation
	fadd	st1			; add new x^n/n
	jmp	add_loop

add_loop_end:

	popa
	mov	eax, 0
	leave
	ret



























