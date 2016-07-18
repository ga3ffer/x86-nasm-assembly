; This simple program simply adds to 32-bit integers together
; and stores the results bac in memory

%include "asm_io.inc"

segment .data	
	msg1		db	"Enter an integer: ", 0
	msg2		db	"binary representation: ", 0
	msg3		db	"# patterns: ", 0
	pattern1	dd	090000000h
	pattern2	dd	0B0000000h
	mask		dd	0F0000000h
segment .bss
	input		resd	1
	pattern_count	resd	1
segment .text
	global asm_main
asm_main:
	enter	0,0
	pusha
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

start:
	mov	eax, msg1	; move msg1 into eax
	call	print_string	; print msg1
	call	read_int	; read user input
	cmp	eax, 0		; check if user want to end program
	jz	end
	mov	ebx, eax	; move user input into ebx
	mov	[input], eax	; save user input in memory
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
	jmp	init_regs

print:				; print 1
	mov	eax, 1		; move 1 into eax
	call	print_int	; print 1
	dec	cl		; decrement loop counter
	cmp	cl, 0		; check if counter is 0
	jne	print_binary	; if not check next bit
	call	print_nl

init_regs:
	mov	ebx, DWORD [pattern1]	; load bitmask pattern1 in ebx
	mov	ecx, DWORD [pattern2]	; load bitmask pattern2 in ecx
	mov	edx, DWORD [mask]	; load bitmask into edx
	
check_pattern1:
	mov	eax, DWORD [input]	; load user input into eax
	and	eax, edx 		; 'and' user input and bitmask to zero out unintrested bits
	cmp	eax, ebx		; check for match -  pattern1 '1001'
	je	inc_count

check_pattern2:
	cmp	eax, ecx 		; check for match -  pattern2 '1011'
	jne	shift_mask

inc_count:
	inc	DWORD [pattern_count]	; increment pattern match count

shift_mask:
	shr	edx, 1			; shift masks right by one
	shr	ebx, 1
	shr	ecx, 1
	cmp	edx, 000000007h		; keep shifting by one until last pattern is checked 
	jg	check_pattern1

	mov	eax, msg3			; move msg3 into eax
	call	print_string			; print msg3
	mov	eax, DWORD [pattern_count]	; move contents of pattern_countin eax
	call	print_int			; print count
	call	print_nl
	xor	eax, eax			; clear eax
	mov	DWORD [pattern_count], eax	; reset pattern_count
	jmp	start
end:
	call	print_nl
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	popa
	mov	eax, 0
	leave
	ret

