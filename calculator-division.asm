; Calculator (Division)
; Compile with: nasm -f elf calculator-division.asm
; Link with (64 bit systems require elf_i386 option): ld -m elf_i386 calculator-division.o -o calculator-division
; Run with: ./calculator-division
 
%include        'functions.asm'
 
SECTION .data
msg1        db      ' remainder '      ; a message string to correctly output result, followed by a null terminator
 
SECTION .text
global  _start
 
_start:
 
    mov     eax, 90     ; move our first number into eax
    mov     ebx, 9      ; move our second number into ebx
    div     ebx         ; divide eax by ebx (quotient in EAX, remainder in EDX)
    call    iprint      ; call our integer print function to print the quotient
    mov     eax, msg1   ; move the address of our message string into eax
    call    sprint      ; call our string print function to print the message
    mov     eax, edx    ; move the remainder (stored in EDX) into EAX
    call    iprintLF    ; call our integer printing function with linefeed to print the remainder
 
    call    quit        ; exit the program
