;  fib.asm : Calculates fibonacci i-number
;
; assemble: nasm -f elf64 fib.asm
; link: gcc fib.o -o fib
; run: ./fib
; output is: Integer number (Fibonacci(n)=i-number)
;
; Grupo 6
; Dayanne Fernandes da Cunha 13/0107191
; Yuri Castro do Amaral 14/0033718
; Arthur Augusto Coutinho Bizzi 13/0102636
; Heron T Fonseca 11/0121058
; Marcus Vinícius da Silva Borges 13/0032891


extern printf

; Print output
%macro print_fib 2
section .text
  mov	rax,[%1]	; put "a" from store into register
  mov	rdi,fmt   ; format for printf
  mov	rsi,[%1]  ; first parameter for printf
  mov	rdx,[%2]  ; second parameter for printf
  mov	rax,0     ; no xmm registers
  call printf		; Call C function
%endmacro

%macro fibonacci 1
section .data
  a_cond: dq 0  ; 64-bit variable a initialized to 0
  b_cond: dq 1  ; 64-bit variable a initialized to 1
  param_print: dq %1

section .bss 	; uninitialized space
  a:	resq	1		; reserve a 64-bit word
  b:	resq	1		; reserve a 64-bit word
  c:	resq	1		; reserve a 64-bit word
  
section .text
  %if %1 < 1d
    print_fib param_print,a_cond
  %elif %1 < 2d
    print_fib param_print,b_cond
  %else
    mov rax, 0d
    mov [a], rax ; a
    mov rax, 1d
    mov [b], rax ; b
    %rep %1-1
      mov rax, [a]  ; a
      add rax, [b]  ; a + b
      mov [c], rax  ; c = a + b
      mov rax, [b]  ; b
      mov [a], rax  ; a = b
      mov rax, [c]  ; c
      mov [b], rax  ; b = c
    %endrep
    print_fib param_print,b
  %endif
%endmacro

section .data
  fmt: db "Fibonacci(%ld)=%ld", 10, 0	; The printf format, "\n",'0'

section .text
  global main

main:
  fibonacci 32d

  mov	rax,0		; normal, no error, return value
  ret         ; return
