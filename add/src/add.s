%define TRUE 1
%define FALSE 0


global _start

section .text
_start: 


	

	call setup

	mov rdi, input1
	mov rsi, [len1]
	call atoi
	mov [num1], rax


	mov rdi, input2
	mov rsi, [len2]
	call atoi
	mov [num2], rax


	mov r9, [num1]
	add r9, [num2]

	mov rax, 60
	mov rdi, r9 
	syscall


setup:

	mov rdi, prompt1
	mov rsi, prompt1_len
	call print

	call get_input
	mov [input1], rax

	mov rdi, input1
	call get_len
	
	mov [len1], rax
	
	mov rsi, rax
	call check_if_numeric
	test rax, rax
	jz  if_not_alphanumeric
	

	mov rdi, prompt2
	mov rsi, prompt2_len
	call print
	

	call get_input
	mov [input2], rax

	mov rdi, input2
	call get_len
	

	mov [len2], rax
	
	mov rsi, rax
	call check_if_numeric
	test rax, rax
	jz  if_not_alphanumeric

	mov rsi, [len2]
	mov rdi, input2
	mov rdi, input2

	ret

if_not_alphanumeric:
	mov rdi, redo_text
	mov rsi, red_text_len
	call print
	jmp _start

get_input: 

//   returns stdin

	xor rax, rax // syscall read
	xor rdi, rdi // stdin fd
	mov rsi, input_buffer
	mov rdx, 100
	syscall
	mov rax, [input_buffer]
	ret

print: // arg0 = word, arg1 = len
	mov rdx, rsi
	mov rsi, rdi
	mov rax, 1 // syscall write
	mov rdi, 1 // stdout fd
	syscall
	ret

// returns true if all digits contain valid numeric ASCII, false if not
check_if_numeric: // arg0 buff, arg1 length
//	rsi = word
//	rcx = counter
//	al = current byte
//
	mov rcx, rsi
	mov rsi, rdi
_check_if_numeric_loop:

// loops over each character. If any character cant be a numeral, return false

	lodsb
	cmp al, 48 // highest numeral ascii representation
	jb _check_if_numeric_exit_bad
	cmp al, 57 // highest numeral ascii representation
	ja _check_if_numeric_exit_bad
	loop _check_if_numeric_loop
_check_if_numeric_exit_good:
	mov rax, TRUE
	ret
_check_if_numeric_exit_bad:
	mov rax, FALSE	
	ret


// places final word in itoa_buffer
itoa: // itoa(const buf* num, int len)
	// 38
	// 86
	// 

atoi: // arg0: buf, arg1: len
	xor r10, r10
	mov rcx, rsi
	mov rsi, rdi
	mov r11, 10
//
//	r9  = current_byte
//	r11 = multiplier	
//	r10  = final number
//


_atio_loop:
	lodsb

	movzx r9, al

	mov rax, r10
	mul r11
	mov r10, rax

	sub r9, 48 // make real number
	add r10, r9

	loop _atio_loop
_atio_exit:
	mov rax, r10
	ret
get_len: // arg0 buffer

//
//	rsi = word
//	rdx = counter
//	al  = current byte
//
	mov rsi, rdi 
	xor rdx, rdx 
_get_len_loop:
  lodsb
  test al, al
  jz _get_len_exit // end when current byte is null

  inc rdx
  
  jmp _get_len_loop
_get_len_exit:
	dec rdx
	mov rax, rdx 
	ret
section .data

redo_text db "Make sure you entered a number!", 0xa
red_text_len equ $-redo_text
prompt1 db "enter your first number: "
prompt1_len equ $-prompt1
prompt2 db "enter your second number: "
prompt2_len equ $-prompt2

section .bss

num1 resw 100
num2 resw 100

len1 resw 100
len2 resw 100

input_buffer resw 100
input1 resw 100
input2 resw 100
output_buffer resw 100

itoa_buffer resw 100