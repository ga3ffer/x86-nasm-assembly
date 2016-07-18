; This program asks the user for input and displays what was entered

%include "asm_io.inc"

segment .data
	msg1	db	"Enter an integer: ", 0
	msg2	db	"The number of integers idivisible by 2 is ", 0
	msg3	db	"The number of integers idivisible by 3 is ", 0
	msg4	db	"The number of integers idivisible by 5 is ", 0

segment .bss
	input		resd	1	; user input
	result1		resd	1
	result2		resd    1
	result3		resd    1

segment .text
        global  asm_main
asm_main:
	enter	0,0			; setup
	pusha				; setup
	;------------------------------------------------------------------

while:
	mov	eax, msg1		; move msg1 into eax
	call	print_string		; print message
	call	read_int		; read in integer from input
	mov	DWORD [input], eax	; move eax into memory
	cmp	DWORD [input], 0	; conditional to check if user wants to continue
	jl	end_while		; if user enters a number less than 0, program will exit

	mov	eax, DWORD [input]	; mov memory contents of [input] into eax
	mov	edx, 0			; zero out edx
	mov	ecx, 2			; 2 divisior
	idiv	ecx			; divide user input by 2
	cmp	edx, 0			; check for aero remainder
	jg	idiv_by_3		; if not jmp to next divisor

idiv_by_2:
	mov	ecx, result1		; move result1 into ecx
	inc	DWORD [ecx]		; increment ecx

idiv_by_3:
	mov	edx, 0			; zero out edx
	mov	eax, DWORD [input]	; move memory contents of [input] into eax
	mov	ecx, 3			; 3 divisor
	idiv	ecx			; divide user input by 3
	cmp	edx, 0			; check for zero remainder
	jg	idiv_by_5		; if not jmo to next divisor

	mov	ecx, result2		; move result2 into ecx
	inc	DWORD [ecx]		; increment ecx

idiv_by_5:
	mov	edx, 0			; zero out edx
	mov	eax, DWORD [input]	; move memory contents of [input] into eax
	mov	ecx, 5			; 5 divisor
	idiv	ecx			; divide user input by 5
	cmp	edx, 0			; check for zero remainder
	jg	while			; if not jmp to start of while loop

	mov	ecx, result3		; move result3 into ecx
	inc	DWORD [ecx]		; increment ecx
	jmp	while			;jmp to start of while loop

end_while:				; exit while loop
	mov	eax, msg2		; mov msg2 into eax
	call	print_string		; print message
	mov	eax, [result1]		; move result1 into eax
	call	print_int		; print result
	call    print_nl                ; print newline

	mov     eax, msg3               ; mov msg3 into eax
        call    print_string            ; print message
	mov	eax, [result2]		; move result2 into eax
	call	print_int		; print result
	call    print_nl                ; print newline

	mov     eax, msg4               ; mov msg4 into eax
        call    print_string            ; print message
	mov	eax, [result3]		; move result3 into eax
	call	print_int		; print result
	call 	print_nl		; print newline

	;dump_mem 0, result1, 4
	;dump_regs 13

	;------------------------------------------------------------------
	popa				; cleanup
	mov	eax, 0			; cleanup
	leave				; cleanup
	ret					; cleanup

