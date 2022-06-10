





%define INPUT_LEN 4

bits 64
global _start

section .text
_start:
	mov rdi, input_buffer
	call get_input

	mov rdi, rax
	call print


	mov rax, 60
	xor rdi, rdi
	syscall


get_input: 

;   returns stdin

	xor rax, rax ; syscall read
	xor rdi, rdi ; stdin fd
	mov rsi, input_buffer
	mov rdx, 20 
	syscall
	mov rax, [input_buffer]
	ret
	
print: ; arg0: word to write


;  saves arg0 to 'output_buffer', then uses that in the write syscall

	mov [output_buffer], rdi 
	mov rax, 1 ; syscall write
	mov rdi, 1 ; stdout fd
	mov rsi, output_buffer
	mov rdx, 20
	syscall
	ret

section .bss
input_buffer resw 20
input1 resw 4
input2 resw 4
output_buffer resw 20


