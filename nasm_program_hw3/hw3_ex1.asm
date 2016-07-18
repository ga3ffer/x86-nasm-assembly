; This program asks the user for input and displays what was entered

%include "asm_io.inc"

segment .data
	msg1	db	"Enter a character: ", 0
	msg2	db	"Enter an integer: ", 0
	msg3	db	"The character entered was: '", 0
	msg4	db	"The integer entered was: ", 0
	msg5	db	"' ", 0

segment .bss
	integer1		resd     1	; first integer	
	integer2		resd     1	; second integer

segment .text
        global  asm_main
asm_main:
	enter	0,0			; setup
	pusha				; setup
	;------------------------------------------------------------------
	mov 	eax, msg1	    	; note that this is a pointer!
	call	print_string		
	call	read_char	    	; read the character entered
	mov 	[integer1], eax   	; store it in memory
	mov	eax, msg2		; note that this is a pointer!
	call 	print_string
	call	read_int	    	; read the integer entered
	mov 	[integer2], eax   	; store it in memory
	mov	eax, msg3		; move eax to point to msg3
	call 	print_string
	mov	eax, [integer1]		; move contents of [integer1] into eax
	call	print_char	
	mov	eax, msg5		; move eax to point to msg5
	call	print_string
	call	print_nl	
	mov	eax, msg4		; move eax to point to msg4
	call	print_string
	mov	eax, [integer2]		; move contents of [integer2] into eax
	call	print_int
	call	print_nl
	;------------------------------------------------------------------
	popa				; cleanup
	mov	eax, 0			; cleanup
	leave				; cleanup
	ret				; cleanup

