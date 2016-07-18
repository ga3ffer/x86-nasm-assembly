%include "asm_io.inc"

segment .data
	msg_input	db	"Enter an integer: ",0
	msg_output1	db	"The number of integers divisible by ",0
	msg_output2	db	" is ",0
	
segment .bss
	num		resd 1	; The integer
	count_2		resd 1	; Counts number of numbers divisible by 2
	count_3		resd 1	; Counts number of numbers divisible by 3
	count_5		resd 1	; Counts number of numbers divisible by 5

segment .text
        global  asm_main
asm_main:
        enter   0,0           	; setup routine
        pusha

	; initialize the counters
	mov	dword [count_2], 0
	mov	dword [count_3], 0
	mov	dword [count_5], 0

main_loop:
	mov	eax, msg_input	; print "Enter an integer: "
	call	print_string	; print "Enter an integer: "
	call	read_int	; read in an integer from the keyboard
	cmp	eax, 0		; compare the integer to zero
	jl	end_loop	; If < 0, exit the main loop

	mov	[num], eax	; Save the integer to memory
	
	; Check whether the number is divisible by 2
	mov	edx, 0		; initialize edx:eax (high bits)
	mov	eax, [num]	; initialize edx:eax (low bits)
	mov	ecx, 2		; set ecx to 2
	idiv	ecx		; divide edx:eax by ecx
	cmp	edx, 0		; compare edx (the remainder) with 0
	jnz	next_2		; If non-zero, then continue
	inc	dword [count_2]	; Increment the counter
next_2:

	; Check whether the number is divisible by 3
	mov	edx, 0		; initialize edx:eax (high bits)
	mov	eax, [num]	; initialize edx:eax (low bits)
	mov	ecx, 3		; set ecx to 3
	idiv	ecx		; divide edx:eax by ecx
	cmp	edx, 0		; compare edx (the remainder) with 0
	jnz	next_3		; If non-zero, then continue
	inc	dword [count_3]	; Increment the counter
next_3:
	
	; Check whether the number is divisible by 5
	mov	edx, 0		; initialize edx:eax (high bits)
	mov	eax, [num]	; initialize edx:eax (low bits)
	mov	ecx, 5		; set ecx to 5
	idiv	ecx		; divide edx:eax by ecx
	cmp	edx, 0		; compare edx (the remainder) with 0
	jnz	next_5		; If non-zero, then continue
	inc	dword [count_5]	; Increment the counter
next_5:

	jmp main_loop		; loop back
end_loop:

	; print the number of integers divisible by 2
	mov	eax, msg_output1
	call	print_string
	mov	eax, 2
	call	print_int
	mov	eax, msg_output2
	call	print_string
	mov	eax, [count_2]
	call	print_int
	call	print_nl

	; print the number of integers divisible by 3
	mov	eax, msg_output1
	call	print_string
	mov	eax, 3
	call	print_int
	mov	eax, msg_output2
	call	print_string
	mov	eax, [count_3]
	call	print_int
	call	print_nl

	; print the number of integers divisible by 5
	mov	eax, msg_output1
	call	print_string
	mov	eax, 5
	call	print_int
	mov	eax, msg_output2
	call	print_string
	mov	eax, [count_5]
	call	print_int
	call	print_nl

        popa			; return back to C
        mov     eax, 0         
        leave                     
        ret
