%include "asm_io.inc"

segment .data
	msg_input	db	"Enter an integer: ",0
	msg_output1	db	"The number of integers divisible by ",0
	msg_output2	db	" is ",0
	counts		times 50 dd 0	; 50 counters
	
segment .bss
	num		resd 1	; The integer entered by the user

segment .text
        global  asm_main
asm_main:
        enter   0,0           	; setup 
        pusha

main_loop:			; Beginning of the main loop
	mov	eax, msg_input	; print "Enter an integer: "
	call	print_string	; print "Enter an integer: "
	call	read_int	; read in an integer from the keyboard
	cmp	eax, 0		; compare the integer to zero
	jle	end_loop	; If <= 0, exit the main loop

	mov	[num], eax	; Save the integer to memory
	
	; Loop over all possible divisors, from 1 to 50
	mov	ecx, 1		; initialize the loop index, ecx, to 1
diviser_loop:
	; Divide [num] by ecx
	mov	edx, 0		; initialize edx:eax (high bits)
	mov	eax, [num]	; initialize edx:eax (low bits)
	idiv	ecx		; divide edx:eax by ecx
	cmp	edx, 0		; compare edx (the remainder) with 0
	jnz	next		; If non-zero, then move on to the 
                                ; next possible divisor

	; Compute the address of the counter to be incremented,
	; which is counts + 4 * (ecx - 1), into edx
	mov	edx, counts	; edx = counts
	mov	ebx, ecx	; ebx = ecx
	sub	ebx, 1		; ebx = ebx - 1
	imul	ebx, 4		; ebx *= 4
	add	edx, ebx	; edx += ebx

	; Increment the counter
	inc	dword [edx]

next:
	inc	ecx		; go to the next divisor
	cmp 	ecx, 50		; compare to 50
	jle	diviser_loop	; if <= 50 loop back to diviser_loop

	jmp 	main_loop	; loop back to main_loop
end_loop:


	; Print all the counts
	mov	ecx, 1		; initialize the loop index, ecx, to 1
diviser_loop2:
	; Compute the address of the counter
	; which is counts + 4 * (ecx - 1), into edx
	mov	edx, counts	; edx = counts
	mov	ebx, ecx	; ebx = ecx
	sub	ebx, 1		; ebx = ebx - 1
	imul	ebx, 4		; ebx *= 4
	add	edx, ebx	; edx += ebx

	mov	eax, msg_output1	; print "The number..."
	call	print_string		; print "The number..."
	mov	eax, ecx		; print the divisor
	call	print_int		; print the divisor
	mov	eax, msg_output2	; print " is "
	call	print_string		; print " is "
	mov	eax, [edx]		; print the counter
	call	print_int		; print the counter
	call	print_nl		; print a new line

	inc	ecx			; increment the loop index
	cmp 	ecx, 50			; compare it to 50
	jle	diviser_loop2		; if <= 50, loop back

        popa			; return back to C
        mov     eax, 0         
        leave                     
        ret

