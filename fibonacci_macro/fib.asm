;  fib.asm : Calculates fibonacci number
;
; assemble: nasm -f elf64 fib.asm
; link: gcc fib.o -o fib
; run: ./fib
; output is: Integer number

extern printf

; Print output
%macro print_fib 2
section .text
  push    rbp		; set up stack frame
  mov	rax,[%1]	; put "a" from store into register
  mov	rdi,fmt   ; format for printf
  mov	rsi,[%1]  ; first parameter for printf
  mov	rdx,[%2]  ; second parameter for printf
  mov	rax,0     ; no xmm registers
  call printf		; Call C function

  pop	rbp       ; restore stack
%endmacro

%macro fibonacci 1
section .data
  a: dq 0
  b: dq 1
  param_print: dq %1
section .text
  ; %%rep 100
  ; %%if j > 65535
  ; %%exitrep
  ; %%endif
  		; dw j
  ; %%assign k j+i
  ; %%assign i j
  ; %%assign j k
  ; %%endrep
  %if %1 < 1d
    print_fib param_print,a
  %elif %1 < 2d
    print_fib param_print,b
  %endif
%endmacro

section .data
  fmt:    db "Fibonacci(%ld)=%ld", 10, 0	; The printf format, "\n",'0'

section .text
  global main

main:
  fibonacci 0d

  mov	rax,0		; normal, no error, return value
  ret         ; return
