;  fib.asm : Calculates fibonacci number
;
; assemble: nasm -f elf64 fib.asm
; link: gcc fib.o -o fib
; run: ./fib
; output is: Integer number

extern printf

; Print output
%macro print_fib 2
__SECT__
  push    rbp		; set up stack frame
  mov	rax,[%1]	; put "a" from store into register
  mov	rdi,fmt   ; format for printf
  mov	rsi,[%1]  ; first parameter for printf
  mov	rdx,[%2]  ; second parameter for printf
  mov	rax,0     ; no xmm registers
  call printf		; Call C function

  pop	rbp       ; restore stack
%endmacro

%macro fibonacci 2
  print_fib %1,%2
%endmacro

section .data
  a: dq 5
  b: dq 7
  fmt: db "Fibonacci(%ld)=%ld", 10, 0	; The printf format, "\n",'0'

section .text
  global main

main:
  print_fib a,b

  mov	rax,0		; normal, no error, return value
  ret         ; return
