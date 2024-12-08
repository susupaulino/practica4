; functions.asm
; Utility functions for namespace.asm
; Compile with: nasm -f elf functions.asm

SECTION .data
newline db 0xA, 0 ; Line feed (newline character)

SECTION .text

global sprint
global iprint
global iprintLF
global sprintLF
global quit

; Print a string (EAX contains the address of the string)
sprint:
    pusha                   ; Save registers
.print_loop:
    mov al, [eax]           ; Load the next byte of the string
    cmp al, 0               ; Check if it's the null terminator
    je .done                ; If yes, we're done
    mov ebx, 1              ; File descriptor: stdout
    mov ecx, eax            ; Pointer to the string
    mov edx, 1              ; Write one byte
    mov eax, 4              ; Syscall number: sys_write
    int 0x80                ; Make the system call
    inc eax                 ; Move to the next character
    jmp .print_loop         ; Repeat for the next character
.done:
    popa                    ; Restore registers
    ret

; Print an integer (EAX contains the integer)
iprint:
    pusha                   ; Save registers
    xor ecx, ecx            ; Clear ECX for digit storage
    mov ebx, 10             ; Divisor for modulo operation
.convert_loop:
    xor edx, edx            ; Clear EDX for division
    div ebx                 ; EAX / 10, remainder in EDX
    add dl, '0'             ; Convert remainder to ASCII
    push dx                 ; Store ASCII character on the stack
    inc ecx                 ; Increment digit count
    test eax, eax           ; Check if EAX is 0
    jnz .convert_loop       ; Repeat until all digits are processed
.print_loop:
    pop dx                  ; Retrieve character from stack
    mov al, dl              ; Move it into AL for output
    mov ebx, 1              ; File descriptor: stdout
    mov ecx, esp            ; Address of character
    mov edx, 1              ; Write one byte
    mov eax, 4              ; Syscall number: sys_write
    int 0x80                ; Make the system call
    loop .print_loop        ; Repeat until all characters are printed
    popa                    ; Restore registers
    ret

; Print an integer with a newline (EAX contains the integer)
iprintLF:
    call iprint             ; Print the integer
    mov eax, newline        ; Load the newline character
    call sprint             ; Print the newline
    ret

; Print a string with a newline (EAX contains the address of the string)
sprintLF:
    call sprint             ; Print the string
    mov eax, newline        ; Load the newline character
    call sprint             ; Print the newline
    ret

; Exit the program
quit:
    mov eax, 1              ; Syscall number: sys_exit
    xor ebx, ebx            ; Exit code: 0
    int 0x80                ; Make the system call
    ret
