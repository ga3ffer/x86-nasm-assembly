; User enters numbers
; Program prints them in binary
; "Clever" use of the adc instruction

%include "asm_io.inc"

segment .data
	msg1	db	"Enter an integer: ", 0
	msg2	db	"binary representation: ", 0

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

	mov	ecx, eax		; store the integer in ecx
	
	;;
	;; Print the binary representation
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov	eax, msg2		; print msg2
	call	print_string		; print msg2

	mov	bl, 32			; bl = 32 (loop index)
bin_loop:
	mov	al, 48			; al = ASCII code of '0'
	shl	ecx, 1			; shift by 1 bit
	adc 	al, 0			; add the carry to al
	call 	print_char		; print '0' or '1'

	dec 	bl			; bl-- (loop index)
	jnz 	bin_loop		; if bl != 0, loop again
	call	print_nl		; print a new line

	jmp	main_loop		; loop back
end:

	popa				; cleanup
	mov	eax, 0			; cleanup
	leave				; cleanup
	ret				; cleanup

