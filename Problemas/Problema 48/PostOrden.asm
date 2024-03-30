%include "io.inc"
section .data
n dd 15
mitad dd 0
array dw 1,2,6,-1,3,-1,-1,-1,-1,4,5,-1,-1,-1,-1
;array dw 1,2,6,-1,-1,-1,8


section .text
global main


ValueOf: ; se guarda en ebx
    
    push ebp
    mov ebp, esp
    push eax
    mov eax,[ebp+8]
    mov ecx, 2
    mul ecx
    mov bx,[array + eax]
    pop eax
    
    pop ebp
    
    ret
    
    
PostOrden:
   
    mov eax,ecx
    mov ebx,2
    mul ebx
    add eax ,1
    push eax; pos del primer hijo
    call ValueOf
    pop eax ; quito el parametro agregado a la pila
    
   
    cmp bx, -1 ;; cheqeo si  el hijo izq es un valor nulo , 
        je Hijo2
    
   
    cmp eax,[mitad]; chequeo si el hijo izq es hoja
        jle next
    push bx
    call Imprime
    pop bx
    jmp Hijo2
    
    
    next:    
    mov ecx, eax
    push ecx ;guardo pos del primer hijo
    
    
    call PostOrden
    
    
    
    pop ecx
     

    Hijo2:
    push ebp
    mov ebp, esp
    mov eax,[ebp+8];;;;;;;;;;;;
    mov ebx,2
    mul ebx
    add eax ,2
    pop ebp
    push eax; pos del segundo hijo
    call ValueOf
    pop eax ; quito el parametro agregado a la pila
    
    
     cmp bx, -1 ;; cheqeo si  el hijo derc es un valor nulo , 
        je Base
    
    
    cmp eax,[mitad]; chequeo si el hijo derec es hoja
        jle next2
    push bx
    call Imprime
    pop bx
    jmp Base
    
    next2:
    mov ecx, eax
    push ecx ;guardo pos del primer hijo
    
   
    
    call PostOrden
    
    
    pop ecx
          
    Base:
    push ebp
    mov ebp,esp
    mov eax,[ebp+8]
    mov ebx,2
    mul ebx
    mov eax, [array + eax]
    push eax
    call Imprime
    pop eax
    pop ebp
    ret
 
    
    
Imprime:
    push ebp
    mov ebp, esp
    mov eax,[ebp+8]
    PRINT_UDEC 2,eax
    NEWLINE
    pop ebp
    ret
    

main:
    mov ebp, esp; for correct debugging
     
    
    mov eax, [n]
    mov ebx ,2
     xor edx,edx
    div ebx
    xor edx,edx
    mov [mitad], eax

    mov ecx,0
    push ecx ; guardo la pos de la raiz
    call PostOrden
    pop ecx

     
       
    xor eax, eax
    ret