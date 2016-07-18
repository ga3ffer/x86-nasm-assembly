; This program takes one floating point argument which should 
; be strictly larger than .5, then the function compute_ln is called 
; and computes the natural logarithm function.

%include "asm_io.inc"

%define x	DWORD [ebp + 8]		; argument 1t
%define item	DWORD [ebp - 4]		; local variable (x-1)/x
%define counter	DWORD [ebp - 8]		; local variable swap space

segment .data	

segment .text
	global compute_ln 
compute_ln:
	enter	0,0
	pusha	
	sub	esp, 8			; two local variables

	fld1				; ST0 = 1
	fsub	x			; ST0 = 1-x
	fstp	item			; item = 1-x
	fldz				; ST0 = 0
	fsub	item			; ST0 = x-1
	fdiv	x			; sST = (x-1)/x
	fst	item			; item = (x-1)/x
	fld	item			; ST0 = ST! =(x-1)/
	mov	ebx, 0			; loop counter

add_loop:
	cmp	ebx, 5000		; loop 5000 times
	jz	add_loop_end
	inc	ebx

	fxch	st1
	fmul	item			; ST0 = ((x-1)/x)^n
	mov	counter, ebx		; ST0 = ((x-1)/x)^n*(n-1)
	fimul	counter
	inc	counter			; ST0 = ((x-1)/x)^n*(n-1)/n
	fidiv	counter
	
	fxch	st1			; update summation
	fadd	st1			; add new item to summation
	jmp	add_loop

add_loop_end:

	add	esp, 8
	popa
	mov	eax, 0
	leave
	ret

