; This simple program demonstrates the use of valid arithmetic
; shifts to perform multplication/divisions of signed numbers, 
; and the use of imul whenever shifts cannot be used
%include "asm_io.inc"
;
segment .data
segment .text
        global  asm_main
asm_main:
        enter   0,0   	; setup 
        pusha	 	; setup
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov	al, 0C3h 	; al contains signed number  -61d
	dump_regs 1
	sal	al, 1		; multiply it by 2: -122d
	dump_regs 2
	sar	al, 3		; divide it by 8 and lose bits: -16d
	dump_regs 3
	movsx	ax, al		; sign extension to enable use of imul
	dump_regs 6
	imul	ax, 16		; multiply by 16
	dump_regs 7
	movsx 	eax, ax		; sign extension to eax for printing!
	dump_regs 8
	call	print_int	; print the result: -256
	call 	print_nl
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        popa		; cleanup
        mov     eax, 0	; cleanup
        leave           ; cleanup
        ret		; cleanup


