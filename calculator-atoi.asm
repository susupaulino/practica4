section .data
    arg1 db "20", 0
    arg2 db "1000", 0
    arg3 db "317", 0
    msg db "Result: ", 0

section .text
    global _start
    extern iprint, iprintLF, quit, atoi

_start:
    ; Convertir y sumar arg1
    mov eax, arg1        ; Dirección de "20"
    call atoi            ; Convierte cadena a número
    mov ebx, eax         ; Almacena resultado en ebx

    ; Convertir y sumar arg2
    mov eax, arg2        ; Dirección de "1000"
    call atoi            ; Convierte cadena a número
    add ebx, eax         ; Suma al acumulador en ebx

    ; Convertir y sumar arg3
    mov eax, arg3        ; Dirección de "317"
    call atoi            ; Convierte cadena a número
    add ebx, eax         ; Suma al acumulador en ebx

    ; Imprimir resultado
    call iprintLF        ; Salto de línea
    mov eax, ebx         ; Carga el resultado final en eax
    call iprint          ; Imprime el número
    call iprintLF        ; Salto de línea

    ; Salir
    call quit
