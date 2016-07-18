%include "asm_io.inc"

segment .data
	msg_input	db	"Enter an integer: ",0
	msg_output1	db	"The number of integers divisible by ",0
	msg_output2	db	" is ",0
	counts		times 50 dd 0	; 50 counters
	xaxisbar	db	"--------------------------------------------------",0
	
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

	; At this point we have all the counter values
	; and we can output the histogram

	; Compute the number of rows in the histogram
	mov	ecx, 1		; initialize the loop index, ecx, to 1
  	mov 	eax, 0		; initialize the maximum to be computed to zero
max_loop:
	; Compute the address of the counter
	; which is counts + 4 * (ecx - 1), into edx
	mov	edx, counts	; edx = counts
	mov	ebx, ecx	; ebx = ecx
	sub	ebx, 1		; ebx = ebx - 1
	imul	ebx, 4		; ebx *= 4
	add	edx, ebx	; edx += ebx

	cmp 	eax, [edx]	; compare the current max with the counter
	jnbe	max_next	; if not larger, then skip
	mov	eax, [edx]	; update the current max
max_next:

	inc	ecx		; increment the loop index
	cmp 	ecx, 50		; compare it to 50
	jle	max_loop	; if <= 50, loop back

	; At this point eax contains the maximum number of rows 
	; Let's increment by 1 and save it in ebx
	mov	ebx, eax	; ebx = maximum number of rows

	; loop on the number of rows (decrement ebx until its 0)
hist_loop:

	mov	ecx, 1		; initialize the loop index, ecx, to 1
histrow_loop:
	; Compute the address of the counter
	; which is counts + 4 * (ecx - 1), into edx
	mov	edx, counts	; edx = counts
	mov	eax, ecx	; eax = ecx
	sub	eax, 1		; eax = eax - 1
	imul	eax, 4		; eax *= 4
	add	edx, eax	; edx += eax

	mov	eax, ebx	; eax = current row
	dec 	eax		; eax = eax - 1
	cmp 	eax, [edx]	; compare eax to the counter value
	jge	no_bar		; If greater or equal, then print a '#'
	mov	al, 35;		; print a '#'
	call	print_char	
	jmp	end_bar		; skip the "white space" clause
no_bar
	mov	al, 32		; otherwise print a white space
	call	print_char
end_bar:
	inc	ecx		; increment the loop index
	cmp 	ecx, 50		; compare it to 50
	jle	histrow_loop	; if <= 50, loop back

	call	print_nl	; terminate the row
	dec	ebx		; decrement the row index
	cmp	ebx, 0		; compare to zero
	jnz	hist_loop	; if non-zero, loop back

	mov	eax, xaxisbar	; print the xaxisbar
	call	print_string
	call	print_nl	; finish with a new line

        popa			; return back to C
        mov     eax, 0         
        leave                     
        ret

