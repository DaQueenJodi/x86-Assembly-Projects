global _start

section .text

_start:
	mov rax, 1 ; write
	mov rdi, 1 ; stdout fd
	mov rsi, message
	mov rdx, len
	syscall
	
	mov rax, 60 ; exit
	xor rdi, rdi ; exit normally (same as 'mov rdi, 0'. this is more efficient because science idfk)
	syscall

section .data

message: db "Hello World!", 0xa
len  equ $-message
