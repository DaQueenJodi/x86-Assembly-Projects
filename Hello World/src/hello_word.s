global _start

section .text

_start:
	mov eax, 0x1 ; write
	mov ebx, 1 ; stdout fd
	mov ecx, message
	mov edx, len
	syscall
	
	mov eax, 0x3c ; exit
	mov ebx, 0x0 ; exit normally
	syscall

section .data

message: db "Hello World!", 0xa
len  equ $-message
