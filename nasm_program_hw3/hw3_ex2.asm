; This program asks the user for a 5 character input then prints two strings
; The first string prints the 5 charater input in reverse order
; The second string is printed with each ASCII code decremented by 32

%include "asm_io.inc"

segment .data
	msg1	db	"Enter a 5-character string: ", 0
	msg2	db	"String #1: ", 0
	msg3	db	"String #2: ", 0

segment .bss
	char1		resd     1	; first char
	char2		resd     1	; second char
	char3		resd     1	; third char
	char4		resd     1	; fourth char
	char5		resd     1	; fifth char

segment .text
        global  asm_main
asm_main:
	enter	0,0			; setup
	pusha				; setup
	;------------------------------------------------------------------
	;prints message to get 5-character string	
	mov 	eax, msg1	    	; note that this is a pointer!
	call	print_string		
	call	read_char	    	; read the character entered
	mov	[char1], eax		; store in memory
	call 	read_char		; read the character entered
	mov	[char2], eax		; store in memory
	call	read_char	    	; read the character entered
	mov	[char3], eax		; store in memory
	call 	read_char		; read the character entered
	mov	[char4], eax		; store in memory
	call	read_char	    	; read the character entered
	mov	[char5], eax		; store in memory

	;prints 5-character string in reverse
	mov	eax, msg2		; pointer to msg2
	call	print_string
	mov	eax, [char5]		; move contents of [char5] into eax
	call	print_char
	mov	eax, [char4]		; move contents of [char4] into eax
	call	print_char
	mov	eax, [char3]		; move contents of [char3] into eax
	call	print_char
	mov	eax, [char2]		; move contents of [char2] into eax
	call	print_char
	mov	eax, [char1]		; move contents of [char1] into eax
	call	print_char
	call	print_nl
	
	;prints 5-character string's acsii code decremented by 32
	mov 	eax, msg3		; pointer to msg3
	call	print_string
	mov	eax, [char1]		; move contents of [char1] into eax
	sub 	eax, 32			; decrement by 32
	call 	print_char
	mov	eax, [char2]		; move contents of [char2] into eax
	sub	eax, 32			; decrement by 32
	call 	print_char
	mov	eax, [char3]		; move contents of [char3] into eax
	sub 	eax, 32			; decrement by 32
	call 	print_char
	mov	eax, [char4]		; move contents of [char4] into eax
	sub 	eax, 32			; decrement by 32
	call 	print_char
	mov	eax, [char5]		; move contents of [char5] into eax
	sub 	eax, 32			; decrement by 32
	call 	print_char
	call	print_nl
	;------------------------------------------------------------------
	popa				; cleanup
	mov	eax, 0			; cleanup
	leave				; cleanup
	ret				; cleanup

