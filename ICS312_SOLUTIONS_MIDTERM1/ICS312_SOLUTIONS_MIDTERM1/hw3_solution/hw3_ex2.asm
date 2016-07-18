%include "asm_io.inc"
;
;
segment .data
	msg1	db "Enter a 5-character string: ",0
	msg2	db "String #1: ",0
	msg3	db "String #2: ",0

	string1 dd "?????",0
	string2 dd "?????",0

segment .bss
	string1	resb	6
	string2	resb	6

segment .text
        global  asm_main

asm_main:
        enter   0,0               ; setup routine
        pusha
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

        ; Null-terminate string1
	mov	ebx, string1	; ebx = address of the 1st 
                                ; of the 6 bytes for string1
	add	ebx, 5		; ebx = address of the last 
                                ; of the 6 bytes for string1
	mov	byte [ebx], 0	; set the 6th byte to 0 to 
                                ; null-terminate string1

        ; Null-terminate string2
	mov	ecx, string2	; ecx = address of the 1st 
                                ; of the 6 bytes for string2
	add	ecx, 5		; ebx = address of the last 
                                ; of the 6 bytes for string2
	mov	byte [ecx], 0	; set the 6th byte to 0 to 
                                ; null-terminate string2

 	; Set ebx and ecx to the next byte to 
        ; update in string1 and string2
	dec	ebx		; ebx = address of the 
                                ; 5th byte of string1
	mov	ecx, string2	; ecx = address of the 
                                ; 1st byte of string2

 	; print msg1
	mov	eax, msg1
	call	print_string	

	; Process a character
	call	read_char	; read a character
	mov	[ebx], al	; store the character at address ebx
	dec	ebx		; decrement ebx to point to 
                                ; the previous byte
	sub	al, 32		; subtract 32 to the ASCII code 
                                ; of the character
	mov	[ecx], al	; store the character at address ecx
	inc	ecx		; increment ecx to point to the 
                                ; next byte

	; Process a character
	call	read_char	; read a character
	mov	[ebx], al	; store the character at address ebx
	dec	ebx		; decrement ebx to point to 
                                ; the previous byte
	sub	al, 32		; subtract 32 to the ASCII code 
                                ; of the character
	mov	[ecx], al	; store the character at address ecx
	inc	ecx		; increment ecx to point to 
                                ; the next byte

	; Process a character
	call	read_char	; read a character
	mov	[ebx], al	; store the character at address ebx
	dec	ebx		; decrement ebx to point to 
                                ; the previous byte
	sub	al, 32		; subtract 32 to the ASCII 
                                ; code of the character
	mov	[ecx], al	; store the character at address ecx
	inc	ecx		; increment ecx to point to 
                                ; the next byte

	; Process a character
	call	read_char	; read a character
	mov	[ebx], al	; store the character at address ebx
	dec	ebx		; decrement ebx to point to 
                                ; the previous byte
	sub	al, 32		; subtract 32 to the ASCII code 
                                ; of the character
	mov	[ecx], al	; store the character at address ecx
	inc	ecx		; increment ecx to point to 
                                ; the next byte

	; Process a character
	call	read_char	; read a character
	mov	[ebx], al	; store the character at address ebx
	dec	ebx		; decrement ebx to point 
                                ; to the previous byte
	sub	al, 32		; subtract 32 to the ASCII code 
                                ; of the character
	mov	[ecx], al	; store the character at address ecx
	inc	ecx		; increment ecx to point to 
                                ; the next byte


	; Print "String #1:"
	mov	eax, msg2	
	call	print_string	

	; Print string1 (the reversed string) followed by a new line
	mov	eax, string1	
	call	print_string	
	call	print_nl	; print a new line

	; Print "String #2:"
	mov	eax, msg3	
	call	print_string	

  	; Print string2 (the -32 string) followed by a new line
	mov	eax, string2
	call	print_string
	call	print_nl	; print a new line
	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


