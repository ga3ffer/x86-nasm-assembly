; ICS 312
; HW5 Exercise #3
; Author: Ryne Okimoto

; include directives
%include "asm_io.inc"

; Initialized data 
segment .data
	prompt db "Enter an integer: ",0
	resultMsg db "The number of integers divisible by ",0
	isMsg db " is ",0	
; Uninitialized data
segment .bss
	counters resd 50
	temp resd 1
; Code segment
segment .text
	global asm_main
	asm_main:
		enter 0,0
		pusha
		; Start code
read:
		mov ecx,1 ; ecx is the loop index
		mov ebx,counters ; ebx is the array index
		mov eax,prompt ; Print prompt
		call print_string ; Print prompt
		call read_int ; Read int into eax
		mov [temp],eax ; Store the integer
		cmp eax,0 ; Check for negative number
		jle end ; Jump to end if eax <= 0
start_loop:
		mov edx,0 ; Init edx for division
		div ecx ; Divide by the loop index
		cmp edx,0 ; Check remainder in edx
		jz inc_counter
update:
		mov eax,[temp] ; Restore the input integer
		add ebx,4 ; Increment the array index
		inc ecx ; Increment the loop counter	
		cmp ecx,51 ; Check for loop termination
		jl start_loop ; Keep checking divisors
		jge read ; Read a new integer
inc_counter:
		mov eax,[ebx]
		inc eax
		mov [ebx],eax
		jmp update	
end:
		mov ecx,1 ; Reset the loop index
		mov ebx,counters ; Reset the array index
print_results:
		mov eax,resultMsg ; Print result message
		call print_string ; Print result message
		mov eax,ecx ; Move the loop index into eax for printing
		call print_int ; Print the index
		mov eax,isMsg ; Print is message
		call print_string ; Print is message
		mov eax,[ebx] ; Move the counter into eax for printing
		call print_int ; Print the counter
		call print_nl ; Print a new line
		inc ecx ; Increment the loop index
		add ebx,4 ; Increment the array index
		cmp ecx,51 ; Check for loop termination
		jl print_results ; Keep printing
		; End code	
		popa
		mov eax,0
		leave
		ret

