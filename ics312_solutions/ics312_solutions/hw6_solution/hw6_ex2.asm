; User enters a number
; Program prints it in hex

%include "asm_io.inc"

segment .data
	msg1	db	"Enter an integer: ", 0
	msg2	db	"hex representation: ", 0
	digits	db	"0123456789ABCDEF"

segment .bss

segment .text
        global  asm_main
asm_main:
	enter	0,0			; setup
	pusha				; setup

	;;
	;; Read the integer
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
main_loop:
	mov 	eax, msg1	    	; print msg1
	call	print_string		; print msg1

	call	read_int	    	; read integer #1
	cmp	eax, 0			; compare the integer to 0
	jl	end			; if < 0, terminate	

	mov	edx, eax		; store the integer in edx
	
	;;
	;; Print the hex representation
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov	eax, msg2		; print msg2
	call	print_string		; print msg2

	mov	cl, 28		; cl = 28
bin_loop:
	mov	eax, edx	; eax = edx (entered number)
	shr	eax, cl		; right shift of eax by cl bits
				; so that the "next" group of 4 bits
				; become the 4 least significant bits of eax
	and	al, 000001111b	; zero out the 4 high bits of al

	movzx	eax, al		; size extend al into eax
	add	eax, digits	; compute the address of the hex digit to print
	mov	al, [eax]	; set al to the hex digit to print
	call 	print_char	; print it

	sub	cl, 4		; move on to the next group of 4 bits
	cmp	cl, 0		; compare to 0
	jge 	bin_loop	; if >= 0, loop again
	call	print_nl	; print a new line

	jmp	main_loop	; loop back up
end:

	popa				; cleanup
	mov	eax, 0			; cleanup
	leave				; cleanup
	ret				; cleanup

