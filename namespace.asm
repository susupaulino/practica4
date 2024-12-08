; namespace.asm
; Este archivo solo debe llamar a las funciones definidas en functions.asm

%include 'functions.asm'  ; Incluye las funciones definidas en functions.asm

SECTION .data
msg1 db 'Jumping to finished label.', 0h
msg2 db 'Inside subroutine number: ', 0h
msg3 db 'Inside subroutine "finished".', 0h

SECTION .text
global _start

_start:
    ; Primera subrutina
subrountineOne:
    mov eax, msg1         ; Mueve la dirección de msg1 a eax
    call sprintLF         ; Llama a la función sprintLF desde functions.asm
    jmp .finished         ; Salta al final

.finished:
    mov eax, msg2         ; Mueve la dirección de msg2 a eax
    call sprint           ; Llama a la función sprint desde functions.asm
    mov eax, 1            ; Establece el número 1 para la primera subrutina
    call iprintLF         ; Llama a la función iprintLF desde functions.asm

    ; Segunda subrutina
subrountineTwo:
    mov eax, msg1         ; Mueve la dirección de msg1 a eax
    call sprintLF         ; Llama a la función sprintLF desde functions.asm
    jmp .finished         ; Salta al final

.finished:
    mov eax, msg2         ; Mueve la dirección de msg2 a eax
    call sprint           ; Llama a la función sprint desde functions.asm
    mov eax, 2            ; Establece el número 2 para la segunda subrutina
    call iprintLF         ; Llama a la función iprintLF desde functions.asm

    ; Llama nuevamente a sprintLF y salta a finished
    mov eax, msg1
    call sprintLF         ; Llama a la función sprintLF
    jmp finished          ; Salta al final

finished:
    mov eax, msg3         ; Mueve la dirección de msg3 a eax
    call sprintLF         ; Llama a la función sprintLF desde functions.asm
    call quit             ; Llama a la función quit desde functions.asm
