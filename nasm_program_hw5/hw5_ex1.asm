; This program asks the user for input and displays what was entered

%include "asm_io.inc"

segment .data
	msg1	db	"Enter an integer: ", 0
	msg2	db	"It's the ASCII code for a white space.", 0
	msg3	db	"It's the ASCII code for a digit.", 0
	msg4	db	"It's some non-extended ASCII code.", 0
	msg5	db	"It's some extended ASCII code.", 0
	msg6	db	"It's not an ASCII code.", 0

segment .bss
	integer1	resd	1	; first integer	
	integer2	resd	1	; second integer

segment .text
        global  asm_main
asm_main:
	enter	0,0			; setup
	pusha				; setup
	;------------------------------------------------------------------
while:
	mov	eax, msg1		; print message
	call	print_string		; print message
	call	read_int		; read in integer from input
	mov 	[integer1], eax		; move integer into memory
	cmp	eax, 0			; compare eax, 0
	jl	end_while		; if eax is less than 0 exit loop
	cmp	eax, 255		; compare eax, 255 decimal
	jg	non_ascii		; if eax is greater than 255 jump to non_ascii
	jle	valid_ascii		; if eax is leass than or equal to 255 jump to valid_ascii

valid_ascii:				; ascii codes less than or equal to 255
	cmp	eax, 127		; compare eax, 127
	jg	extended_ascii		; if eax is greater than 127 ascii code is extended-ascii
	jle	nonextended_ascii	; if eax is less than or equal 127 ascii code is non-extended ascii

extended_ascii:				; ascii codes greater than 127
	mov	eax, msg5		; move message into eax
	call	print_string		; print message
	call	print_nl		; print new line
	jmp	while			; jump to start of while loop

nonextended_ascii:			; ascii codes less than  or equal to 127
	cmp	eax, 57			; compare eax to 57 (digit 9)
	jle	digits			; if eax is less than 57 jump to digits

non_digit:				; ascii codes not including 48-57(digits) inclusive
	mov	eax, msg4		; move message into eax
	call	print_string		; print message
	call	print_nl		; print new line
	jmp 	while			; jump to start of while loop

white_space:				; ascii code 32
	cmp	eax, 32			; compare eax with 32
	jl	non_digit		; if eax is less than 32 ascii code is a non_digit
	jg	non_digit		; if eax is greater than 32 ascii code is a non_digit
	mov 	eax, msg2		; move message into eax
	call	print_string		; print message
	call	print_nl		; print new line
	jmp	while			; jump to start of while loop

digits:					; ascii (digit) codes 48-57 inclusive
	cmp	eax, 48			; compare eax to 48
	jl	white_space		; if eax is less than 48 jump tp white_space
	mov	eax, msg3		; move msg3 into eax
	call	print_string		; print string
	call	print_nl		; print new line
	jmp	while			; jump to start of while loop

non_ascii:				; non-ascii codes greater than 255
	mov	eax, msg6		; move msg6 into eax
	call	print_string		; print message
	call	print_nl		; print new line
	jmp while			; jump to start of while loop

end_while:				; exit while loop
	call print_nl			; print new line
	;------------------------------------------------------------------
	popa				; cleanup
	mov	eax, 0			; cleanup
	leave				; cleanup
	ret				; cleanup

