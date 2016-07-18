; This program takes two floating point arguments, then the function
; compute_f is called and computes x^2 + (1+y)/sqrt(x) of the two inputs
; postfix notation: x 2 ^ 1 y + sqrtx / +


%include "asm_io.inc"

%define x DWORD [ebp + 8]	; define first argument
%define y DWORD [ebp + 12]	; define second argument

segment .data	

segment .text
	global compute_f
compute_f:
	enter	0,0
	pusha	
	
	fld	x	; ST0 = x
	fmul	st0	; ST0 = x^2		
;	dump_math 0
	fld1		; ST0 = 1, ST1 = x^2
;	dump_math 1
	fadd	y	; ST0 = 1+y, ST1 = x^2
;	dump_math 2
	fld	x	; ST0 = x, ST1 = 1+y, ST2 = x^2
;	dump_math 3 
	fsqrt		; ST0 = sqrt(x), ST1 = 1+y, ST2 = x^2
;	dump_math 4
	fxch	st1	; ST0 = 1+y, ST1 = sqrt(x), ST2 = x^2
	fdiv	st1	; ST0 = 1+y/sqrt(x), ST1 = sqrt(x), ST2 = x^2
;	dump_math 5
	fadd	st2	; ST0 = 1+y/sqrt(x) + x^2, ST1 = sqrt(x), ST2 = x^2
;	dump_math 6

	popa
	mov	eax, 0
	leave
	ret

