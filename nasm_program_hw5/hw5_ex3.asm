; This program asks the user for input and displays what was entered

%include "asm_io.inc"

segment .data
	msg1	db	"Enter an integer: ", 0
	msg2	db	"The number of integers idivisible by ", 0
	msg3	db	" is ", 0

segment .bss
	input		resd	1	; user input
	array		resd	50	; array of 50 double word counters

segment .text
        global  asm_main
asm_main:
	enter	0,0			; setup
	pusha				; setup
	;------------------------------------------------------------------

while:
	mov	ecx, 1			; loop counter
	mov	ebx, array		; point ebx to first byte of array
	mov	eax, msg1		; move msg1 into eax
	call	print_string		; print msg1
	call	read_int		; read input from keyboard
	mov	DWORD [input], eax	; store eax into input
	cmp	DWORD [input], 0	; check if input is < 0
	jle	end_while		; if input < 0 jump out of loop

check_div:
	mov	edx, 0			; initialize edx to 0
	idiv	ecx			; divide input by ecx
	cmp	edx, 0			; check remainder
	jz	inc_counter		; if remainder = 0, increment counter

next_idiv:
	mov	eax, DWORD [input]	; reset eax, move contents of input into eax
	add	ebx, 4			; point to next element in array
	inc	ecx			; increment divisor
	cmp	ecx, 50			; check if divisor is 50
	jle	check_div		; jmp to check_div, check if input is divisible by ecx
	jge	while			; if last divisor is reached, jmp to start of while loop, ask user for new input

inc_counter:
	mov	eax, [ebx]		; move memory content if address stored in ebx into eax
	inc	eax			; increment count
	mov	[ebx], eax		; move eax back into ebx
	jmp	next_idiv		; 

end_while:				; exit while loop

	mov	ecx, 1			; reset ecx to 1
	mov	ebx, array		; point to first element of array

output_loop:
	mov	eax, msg2		; mov msg2 into eax
	call	print_string		; print message
	mov	eax, ecx
	call	print_int		; print result
	mov     eax, msg3               ; mov msg3 into eax
        call    print_string            ; print message
	mov	eax, [ebx]
	call	print_int		; print result
	call    print_nl                ; print newline

	inc	ecx			; increment counter
	add	ebx, 4			; point to next element
	cmp	ecx, 50			; check if counter is <= 50
	jle	output_loop

	;dump_mem 0, array, 25
	;dump_regs 13

	;------------------------------------------------------------------
	popa				; cleanup
	mov	eax, 0			; cleanup
	leave				; cleanup
	ret					; cleanup

