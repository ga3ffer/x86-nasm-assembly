%include "asm_io.inc"
;
;
segment .data
	msg1	db "Enter an integer: ",0
	msg2	db "Enter a character: ",0
	msg3	db "The integer entered was: ",0
	msg4	db "The character entered was: ",0
        char    db "'",'?',"'",0 

segment .bss
	integer	resd	1

segment .text
        global  asm_main

asm_main:
        enter   0,0               ; setup routine
        pusha
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	mov	eax, msg2	; Print "Enter a character: "
	call	print_string	; Print "Enter a character: "
	call	read_char	; Get a character from the keyboard
	mov	ebx, char	; eax points to the "'" in label char
	inc	ebx		; eax points to the '?' in label char
	mov	[ebx], al	; Replace '?' by the character

        mov	eax, msg1	; Print "Enter an integer: "
  	call	print_string	; Print "Enter an integer: "
	call 	read_int	; Get an integer from the keyboard
	mov	[integer], eax	; Save the integer to memory
	
	mov	eax, msg4	; Print "The character entered was: "
	call	print_string	; Print "The integer entered was: "
	mov	eax, char       ; Print the quoted character
	call	print_string	; print the quote character
    	call	print_nl	; print a new line

	mov	eax, msg3	; Print "The integer entered was: "
	call	print_string	; Print "The integer entered was: "
	mov	eax, [integer]	; eax = the entered integer
	call	print_int	; print the integer
	call	print_nl	; print a new line
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


