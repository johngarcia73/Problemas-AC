%include "io.inc"

section .data
a dd -9
b dd 6
c dd 3
d dd 12

negativo dd 1  ;  Es uno si y solo si el resultado final es positivo
result1 dd 0
result2 dd 0

section .text
       
global main
main:
    mov ebp, esp; for correct debugging
    mov eax, [a]
    mov ebx, [c]
    imul ebx
    js signo1
    mov [result1], eax
    
    jmp C1
    signo1:     ; Controla el signo del numerador del resultado y lo vuelve positivo
    neg eax
    mov [result1], eax
    mov edi, [negativo]
    sub edi, 1
    mov [negativo], edi
    
    C1:
    
    mov eax, [b]
    mov ebx, [d]
    imul ebx
    js signo2
    mov [result2], eax
    
    jmp C2
    signo2: ; Controla el signo del denomidor del resultado y lo vuelve positivo
    neg eax
    mov edi, [negativo]
    add edi, 1
    mov [negativo], edi 
    mov [result2], eax
    
    C2:
    
    mov ebx, [result2]
    mov eax, [result1]
    
    mcdloop:
        cmp eax, ebx
        je endmcd
        jb swap
        sub eax, ebx
        jmp mcdloop
    swap:
        xchg eax, ebx
        jmp mcdloop
    endmcd:
        mov ebx, eax ; MCD
        ;;;;;;;;;;;;;;;;;;;;;;;;
        
    Simplificar:     ; Si ambos lo son se dividen por ese numero
        mov eax, [result1]
        xor edx, edx
        div ebx
        mov [result1], eax  
        mov eax, [result2]
        xor edx, edx
        div ebx
        mov [result2], eax
        
        mov cx, [negativo]  ; Revisa si el resultado final debe ser negativo y si es asi vuelve negativo al numerador
        cmp cx, 1
        je Fin
        mov eax, [result1]
        neg eax
        mov[result1], eax
        
    Fin: 
    mov eax, [result1]
    mov ebx, [result2]
    PRINT_DEC 4, eax
    NEWLINE
    PRINT_DEC 4, ebx
    NEWLINE
    xor eax, eax
    ret