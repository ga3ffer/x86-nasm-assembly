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
	msg2	db	"Value already entered, try again!", 0
	index	dd	0

segment .bss
	userInt		resd	1

segment .text

inputArray:
	push 	ebp			; saved base pointer
	mov 	ebp, esp		; update base pointer to stack pointer (top of stack)
	mov 	ebx, DWORD [ebp+12]	; move argument 2 (n number of integers) into ebx

inputStart:
	mov	ecx, [ebp+8]		; move argument 1 (@ of first element in array) into ecx
	cmp 	DWORD [index], ebx	; compare index and n
	jz	inputEnd		; if n number of integer has been entered, jump out of loop
	mov	eax, msg1		; move msg1 into eax
	call	print_string		; else print message
	xor	eax, eax			; zero out eax
	call	read_int		; read in user input
	mov	DWORD [userInt], eax	; move user input into memory
	;findValue function
	push	eax			; push argument 3 (4-byte integer to find) onto stack 
	mov	eax, DWORD [index]	; move index into eax
	push	eax			; push argument 2 (n number of integers) onto stack
	push	Array			; push argument 1 (@ of first element in array) onto stack
	call	findValue		; call function
	add	esp, 12			; clear stack

	cmp	eax, 0			; compare 0 to return value
	jz	skipError		; if returns 0, value not found in array skip error

	mov	eax, msg2		; move msg2 into eax
	call	print_string		; else print message
	call	print_nl		;
	jmp	skipInc			; 

skipError:
	mov	edx, DWORD [index]	; move index into edx (working register)
	imul	edx, 4			; point to next element in array
	add	ecx, edx		; add offset to ecx
	mov	eax, DWORD [userInt]	;
	mov	DWORD [ecx], eax	; move user input into array
	inc	DWORD [index]		; jump to the start of loop

skipInc:
	jmp	inputStart		;

inputEnd:
	mov	esp, ebp		; point stack pointer to base pointer
	pop	ebp			; pop back ebp
	ret				; return


;; To implement: function printArray
;; takes two arguments, an address and a number, and prints comma-separated
;; list of all the integers.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

segment .data
	msg3	db	"List: ", 0	;
	comma	db	", ", 0		;

segment .bss

segment .text

printArray:
	push	ebp			; save base pointer
	mov	ebp, esp		; update base pointer to stack pointer (top of stac
	mov	DWORD [index], 0	; set index to 0, first element of array
	mov	ebx, [ebp+12]		; move argument 2 (n number of integers) into ebx
	mov	eax, msg3		; move msg3 into eax
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
	
	
;; To implement: function findValue
;; takes three arguments, an address, a number, and a 4-byte signed integer.
;; findValue scans 4-byte values in an array of at most n values.  If a value
;; passed as the third argument is found, the address of that 4-byte value is 
;; returned.  If it is not found, it returns 0, if n = 0 it does nothing and
;; returns 0.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

segment .data
	index2	dd	0

segment .bss
	returnValue	resd	1

segment .text

findValue:
	push	ebp			; save base pointer
	mov	ebp, esp		; update base pointer to stack pointer (top of stack)
	pusha		; save all register s			

	mov	ebx, [ebp+12]		; move argument 2 (n number of integers) into ebx
	mov	edx, [ebp+16]		; move argument 3 (4-byte integer to be found) into edx

searchArray:
	mov	ecx, [ebp+8]		; move argument 1 (@ of first element in array) into ecx
	cmp	DWORD [index2], ebx	; compare index2 to n
	jz	notFound		; if index2 == n, exit loop, nothing found

	mov	eax, DWORD [index2]	; else, move index into eax (working register)
	imul	eax, 4			; point to next element in array
	add	ecx, eax		; add offset to ecx
	cmp	edx, DWORD [ecx]	; compare element in array to 4-byte integer to be found
	jz	found			; if found, exit loop
	inc	DWORD [index2]		; else increment index2
	jmp	searchArray		; jump to start of loop

found:
	mov	DWORD [returnValue], ecx	; move address of found value into [returnValue]
	jmp	searchArrayEnd		; jump to end of loop

notFound:
	mov	DWORD [returnValue], 0	; return 0

searchArrayEnd:
	mov	DWORD[index2], 0	; move 0 into [index2]
	popa		; restore all saved registers
	mov	eax, DWORD [returnValue]	; move [returnValue] into eax
	pop	ebp		; restore saved ebp
	ret			; return


