; User enters numbers
; Program prints them in binary
; Program counts the 10*1 pattern

%include "asm_io.inc"

segment .data
	msg1	db	"Enter an integer: ", 0
	msg2	db	"binary representation: ", 0
	msg3	db	"# patterns: ", 0

segment .bss
	integer	resd	1	; entered integer
	mask1	resd	1	; bitmask #1
	mask2	resd	1	; bitmask #2
	mask3	resd	1	; bitmask #3

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
	jl	near end		; if < 0, terminate	

	mov	[integer], eax		; store the integer in memory

	;;
	;; Print the binary representation
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov	eax, msg2		; print msg2
	call	print_string		; print msg2

	mov	ecx, [integer]		; put the integer in ecx
	mov	bl, 32			; bl = 32 (loop index)
bin_loop:
	mov	al, 48			; al = ASCII code of '0'
	shl	ecx, 1			; shift by 1 bit
	adc 	al, 0			; add the carry to al
	call 	print_char		; print '0' or '1'

	dec 	bl			; bl-- (loop index)
	jnz 	bin_loop		; if bl != 0, loop again
	call	print_nl		; print a new line

	;;
	;; Count the number of patterns
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov	eax, msg3		; print msg3
	call	print_string		; print msg3

	mov	dl, 28		; set the loop counter to 28
	mov	ebx, 0		; set the pattern count to 0
	; Initialize the 3 bitmasks
	mov	dword [mask1], 01111b
	mov	dword [mask2], 00010b
	mov	dword [mask3], 01011b
pattern_loop:
	mov	ecx, [integer]	; ecx = entered number
	or	ecx, [mask2]	; Turn on the 3rd bit of the 4-bit 
				; tentative pattern to 1 to deal with the
				; wildcard, so that now we can look only
				; for pattern 1011
	and	ecx, [mask1]	; zero out all bits that are not in the 
				; tentative pattern
	cmp	ecx, [mask3]	; compare to the pattern
	jnz	not_a_match	; if no match, jump
	inc	ebx		; increment the count
not_a_match:
 	shl	dword [mask1],1	; shift the bitmasks
 	shl	dword [mask2],1	; shift the bitmasks
 	shl	dword [mask3],1	; shift the bitmasks
	dec	dl		; decrement the loop counter
	jnz	pattern_loop	; if non-zero, loop back

	mov	eax, ebx	; put ebx in eax for printing
	call	print_int	; print the count
	call	print_nl	; print a new line

	jmp	main_loop
end:

	popa				; cleanup
	mov	eax, 0			; cleanup
	leave				; cleanup
	ret				; cleanup

