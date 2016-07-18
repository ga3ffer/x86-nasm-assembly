; Printing Binary Representation
; The program stops immediately if the integer is equal to zero.
; For each entered positive integer the program prints
;  out the binary representation of the number.
%include "asm_io.inc"
;
segment .data
	msg1	db	"Enter an integer: ", 0
	msg2	db	"binary representation: ", 0
segment .bss
segment .text
        global  asm_main
asm_main:
        enter   0,0   	; setup
        pusha	 	; setup
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
start:
	mov	eax, msg1	; move msg1 into eax
	call	print_string	; print msg1
	call	read_int	; read user input
	cmp	eax, 0		; check if user want to end program
	jz	end
	mov	ebx, eax	; move user input into ebx
	mov	eax, msg2	; move msg2 into eax
	call	print_string	; print msg2

	mov	cl, 32		; loop counter
print_binary:
	sal	ebx, 1		; logical left shift
	jc	print		; if  carry flag is set print 1
				; print 0
	mov	eax, 0		; move 0 into eax
	call	print_int	; print 0
	dec	cl		; decrement loop conter
	cmp	cl, 0		; check if counter is 0
	jne	print_binary	; if not check next bit
	call	print_nl	
	jmp	start
print:				; print 1
	mov	eax, 1		; move 1 into eax
	call	print_int	; print 1
	dec	cl		; decrement loop counter
	cmp	cl, 0		; check if counter is 0
	jne	print_binary	; if not check next bit
	call	print_nl
	jmp	start		
end:
	call	print_nl
	;dump_regs 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        popa		; cleanup
        mov     eax, 0	; cleanup
        leave           ; cleanup
        ret		; cleanup


