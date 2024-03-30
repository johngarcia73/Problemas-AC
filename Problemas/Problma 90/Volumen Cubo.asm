%include "io.inc"

section .data
lado dw 3

section .text
global main
main:
    
    mov eax, [lado]
    mov ebx, [lado]
    mul ebx
    mul ebx
    
    PRINT_UDEC 4, eax
    xor eax, eax
    ret