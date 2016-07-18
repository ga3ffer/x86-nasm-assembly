%include "asm_io.inc"

segment .data
	msg_input	db	"Enter an integer: ",0
	msg_white	db	"It's the ASCII code for a white space.",0
	msg_digit	db	"It's the ASCII code for a digit.",0
	msg_other	db	"It's some non-extended ASCII code.",0
	msg_ext		db	"It's some extended ASCII code.",0
	msg_not		db	"It's not an ASCII code.",0

segment .text
        global  asm_main
asm_main:
        enter   0,0           	; setup routine
        pusha

main_loop:
	mov	eax, msg_input	; print "Enter an integer: "
	call	print_string	; print "Enter an integer: "
	call	read_int	; read in an integer from the keyboard
	cmp	eax, 0		; compare the integer to zero
	jl	end_loop	; If < 0, exit the main loop
	
        ; Is it outside the ASCII range?
	cmp	eax, 255	; compare the integer with 255
	jle	next1		; in range, continue
	mov	eax, msg_not	; print "It's not an ASCII code."
	call	print_string	; print "It's not an ASCII code."
	call	print_nl	; print a new line
	jmp	main_loop	; loop back

next1: 
	; Is it a white space?
	cmp	eax, 32		; compare the integer with 32 (ASCII for ' ')
	jnz	next2		; not a white space, continue
	mov	eax, msg_white	; print "It's the ASCII code for a white space."
	call	print_string	; print "It's the ASCII code for a white space."
	call	print_nl	; print a new line
	jmp	main_loop	; loop back

next2:
	; Is it a digit?
	cmp 	eax, 48		; compare the integer with 48 (ASCII for '0')
	jl	next3		; if < 48, not a digit, continue
	cmp	eax, 57		; compare the integer with 57 (ASCII for '9')
	jg	next3		; if > 57, not a digit, continue
	mov	eax, msg_digit	; print "It's the ASCII code for a digit."
	call	print_string	; print "It's the ASCII code for a digit."
	call	print_nl	; print a new line
	jmp	main_loop	; loop back

next3:
	; It is an extended ASCII code?
	cmp	eax, 127	; compare the integer with 127 (largest non-extended)
	jle	next4		; if <= 127, not an extended, continue...
	mov	eax, msg_ext	; print "It's some extended ASCII code."
	call	print_string	; print "It's some extended ASCII code."
	call	print_nl	; print a new line
	jmp	main_loop	; loop back

next4:
	; At this point, we have a non-extended ASCII code
	mov	eax, msg_other	; print "It's some non-extended ASCII code."
	call	print_string	; print "It's some non-extended ASCII code."
	call	print_nl	; print a new line

	jmp main_loop		; loop back
end_loop:
  	
        popa			; return back to C
        mov     eax, 0         
        leave                     
        ret

