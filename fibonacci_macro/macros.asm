; Define variables in the data section
SECTION .DATA
	hello:     db 'Ainda loop!!',10,0

; Code goes in the text section
SECTION .TEXT
	GLOBAL main

main:

;do while
	%macro do 0
		%push doit
		%$begin:
	%endmacro

	%macro while 1
		j%+1 %$begin
		%pop
	%endmacro

fib:
	%assign i 0
	%assign j 1
	do




	;i = 0
	mov di,0

	do
		;i++
		inc 	di

		;print
		mov     edx, 13     ; number of bytes to write - one for each letter plus 0Ah (line feed character)
		mov     ecx, hello  ; move the memory address of our message string into ecx
	    mov     ebx, 1      ; write to the STDOUT file
	    mov     eax, 4      ; invoke SYS_WRITE (kernel opcode 4)
	    int     80h

	    cmp 	di,3

	while ne


	; Terminate program
    mov eax,1            ; 'exit' system call
    mov ebx,0            ; exit with error code 0
    int 80h              ; call the kernel
