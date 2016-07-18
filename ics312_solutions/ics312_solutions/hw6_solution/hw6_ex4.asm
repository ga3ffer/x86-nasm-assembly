; User enters a number
; Program prints it in binary
; Program counts number of occurrences of pattern "1101"
; using the setXX instructions

%include "asm_io.inc"

segment .data
	msg1	db	"Enter an integer: ", 0
	msg2	db	"Enter a binary motif: ", 0
	msg3	db	"The binary representation is: ", 0
	msg4	db	"The number of motifs is: ", 0

segment .bss
	integer		resd    1	; integer input
	motif		resd	1	; motif
	mask		resd	1	; bit mask 0*1*

segment .text
        global  asm_main
asm_main:
	enter	0,0			; setup
	pusha				; setup

	;;
	;; Read the integer
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov 	eax, msg1	    	; print msg1
	call	print_string		; print msg1
	call	read_int	    	; read integer #1
	mov	[integer], eax		; store integer #1
	call	read_char		; read a bogus character
	
        ;;
        ;; Print the binary representation
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov	eax, msg3		; print msg3
	call	print_string		; print msg3
        mov     bl, 32                  ; bl = 32 (loop index)
	mov	ecx, [integer]		; ecx = input
bin_loop:
	mov	al, 48			; al = ASCII code of '0'
        shl     ecx, 1                  ; shift by 1 bit
	adc	al,0			; al = al + carry
        call    print_char              ; print '0' or '1'

        dec     bl                      ; bl-- (loop index)
        jnz     bin_loop                ; if bl != 0, loop again
        call    print_nl                ; print a new line

	;;
	;; Read the motif
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov	eax, msg2		; print msg2
	call	print_string		; print msg2
	mov	dword [motif], 0	; set the motif to zero
	mov	dword [mask], 0		; set the mask to zero
	mov	cl, 0			; counter for the length of the motif
motif_loop:
	call	read_char		; read a character
	cmp	eax, 10			; compare the character to NL
	jz 	end_motif_loop		; if NL, then done
	shl	dword [mask], 1		; shift the mask by 1 to the left
	inc 	dword [mask]		; add a 1 to the mask
	shl	dword [motif],1		; shift the motif by 1 to the left
	cmp	eax, 49			; compare character to '1'
	jnz	motif_loop_next		; if not '1' go to loo1_next
	inc	dword [motif]		; add one to the motif
motif_loop_next:
	inc	cl			; increment the length of the motif
	jmp 	motif_loop
end_motif_loop:

	;;
	;; Count the number of motifs
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
 	mov 	bl, 32			; bl = 32 (loop index)
	sub	bl, cl			; bl = bl - cl (-= motif length)
	inc	bl			; bl += 1 (number of shifts to perform)
	mov	cl, 0			; cl = 0  (count)
count_loop:
	mov	edx, [mask]		; edx = 0..01..1
	and	edx, [integer]		; edx = edx and [integer]
	xor	edx, [motif]		; edx = edx xor [motif]
	jnz	count_no_dice		; if edx != 0, pattern not found
	inc	cl			; pattern found: count++
count_no_dice:

	shr	dword [integer], 1	; shift [integer] to the right
	dec	bl			; bl-- (loop index)
	jnz	count_loop		; if bl != 0, loop again

	mov	eax, msg4		; print msg3
	call	print_string		; print msg3
	movzx	eax, cl			; print count
	call	print_int		; print count
	call	print_nl		; print a new line

end:
	popa				; cleanup
	mov	eax, 0			; cleanup
	leave				; cleanup
	ret				; cleanup

