; Solution for Programming Assignment #7

%include "asm_io.inc"

segment .bss
	Array	resd	10

segment .text
        global  asm_main

asm_main:
	enter	0,0			; setup
	pusha				; setup

	; Call function inputArray
	push 	dword 10
	push	Array
	call	inputArray
	add	esp, 8

	; Call function printArray
	push	dword 10
	push	Array
	call	printArray
	add	esp, 8

	popa				; cleanup
	mov	eax, 0			; cleanup
	leave				; cleanup
	ret				; cleanup

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;; DO NOT MODIFY ANYTHING ABOVE THIS LINE ;;;;;;;;;;;;;;;

;; To implement: function inputArray 
;; takes two arguments, an address and a number, and asks the user for
;; n 4-byte signed numbers which are stored one after the other starting
;; at the address passed in as the first argument.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

segment .data
	msg1	db	"Enter an integer: " , 0
	index	dd	0

segment .bss

segment .text

inputArray:
	push 	ebp			; save base pointer
	mov 	ebp, esp		; update base pointer to stack pointer (top of stack)
	mov 	ebx, DWORD [ebp+12]	; move argument 2 (n number of integers) into ebx

inputStart:
	mov	ecx, [ebp+8]		; move argument 1 (@ of first element in array) into ecx
	cmp 	DWORD [index], ebx	; compare index and n
	jz	inputEnd		; if n number of integer has been entered, jump out of loop
	mov	eax, msg1		; move msg1 into eax
	call	print_string		; else print message
	xor	eax, eax		; zero out eax
	call	read_int		; read in user input
	mov	edx, DWORD [index]	; move index into edx (working register)
	imul	edx, 4			; point to next element in array
	add	ecx, edx		; add offset to ecx
	mov	DWORD [ecx], eax	; move user input into array
	inc	DWORD [index]		; increment index
	jmp	inputStart		; jump to the start of loop

inputEnd:
	mov	esp, ebp		; point stack pointer to base pointer
	pop	ebp			; pop back ebp
	ret				; return


;; To implement: function printArray
;; takes two arguments, an address and a number, and prints comma-separated
;; list of all the integers.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

segment .data
	msg2	db	"List: ", 0	;
	comma	db	", ", 0		;

segment .bss

segment .text

printArray:
	push	ebp			; save base pointer
	mov	ebp, esp		; update base pointer to stack pointer (top of stac
	mov	DWORD [index], 0	; set index to 0, first element of array
	mov	ebx, [ebp+12]		; move argument 2 (n number of integers) into ebx
	mov	eax, msg2		; move msg2 into eax
	call	print_string		; print message
                                                                                            
outputStart:                                                                                 
	mov	ecx, [ebp+8]		; move argument 1 (@ of first element in array) into ecx
	cmp	DWORD [index], ebx	; compare index and n
	jz	outputEnd		; if n number of integer has been entered, jump out of loop
	mov	edx, DWORD [index]	; move index into edx (working register)
	imul	edx, 4			; point to next element in array
	add	ecx, edx		; add offset to ecx
	xor	eax, eax			; zero pout eax
	mov	eax, DWORD [ecx]	; move element in array into eax
	call	print_int		; print integer
	mov	eax, ebx		; move n number of integers into eax
	dec	DWORD eax		; decrement n
	cmp	DWORD [index], eax	; compare index and eax
	jz	outputEnd		; if n number of integers have been printed, exit loop
	mov	eax, comma		; move comma into eax
	call	print_string		; print comma
	inc	DWORD [index]		; increment index
	jmp	outputStart		; jump to start of loop

outputEnd:
	call	print_nl		; print new line
	mov	esp, ebp		; point stack pointer to base pointer
	pop	ebp			; pop back ebp
	ret				; return

	


























