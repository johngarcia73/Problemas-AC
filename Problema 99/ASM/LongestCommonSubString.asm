%include "io.inc"
section .data
    ;;input
    n_1 dd 6
    array_1 dd 1,1,0,0,1,1  ;; 4 bytes de espaciamiento
    n_2 dd 5
    array_2 dd 0,1,0,0,1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    max dd 0
    posMaxFila dd 0
    posMaxCol  dd 0
    
    matrix dd 0

section .text


GetIndex: ; guarda en eax la pos d me [ecx,ebx]
    
    mov eax, [n_1]
    inc eax
    push edx
    mul ecx
    add eax,ebx
    mov edx,4
    mul edx
    add eax, matrix    
    pop edx
    ret
    
global main
main:
    mov ebp, esp; for correct debugging
    mov ecx ,0
    mov ebx ,0
    
    pop eax
    push eax

;; inicializo la primera fila de la matrix en 0
loop0:
    call GetIndex
    mov edx,0
    mov [eax],edx
    cmp ebx, [n_1]
        je endloop0
    inc ebx
    jmp loop0
endloop0:
    mov ecx,1
    mov ebx,0

  
loop1: ; ecx el contador de las filas
    loop2: ; ebx el contador de las col
         cmp ebx , 0
            jg principal
         
         cmp ebx,[n_1]
            jg endloop2
         
         call GetIndex
          mov edx,0
          mov [eax],edx
         inc ebx
         jmp loop2
         
         principal:
         mov eax , ebx
         dec eax
         mov edx ,4
         mul edx
         mov eax ,[array_1 + eax]
         push eax
         
         mov eax , ecx
         dec eax
         mov edx ,4
         mul edx
         mov eax ,[array_2 + eax]
         pop edx
         cmp eax,edx
            jne else
         call GetIndex
         mov edx,eax
         dec ecx
         dec ebx
         call GetIndex
         inc ecx
         inc ebx
         mov eax,[eax]
         inc eax
         mov [edx],eax
         
         cmp eax,[max]
            jle beforeEnd
         mov [max],eax
         mov [posMaxFila], ecx
         mov [posMaxCol],ebx
         jmp beforeEnd
       
         else:
            call GetIndex
            mov edx,0
            mov [eax],edx
            
         beforeEnd:
         cmp ebx,[n_1]
            je endloop2
         inc ebx
         jmp loop2

    endloop2:
    cmp ecx, [n_2]
        je endloop1
    inc ecx
    mov ebx,0
    jmp loop1
    
endloop1:
    pop eax
    push eax
    mov ecx ,[max]
    mov ebx, [posMaxCol]
    dec ebx
   ; jmp end
    SAVE:
    mov eax,ebx
    mov edx,4
    mul edx
    mov edx ,[array_1 + eax]
    push edx
    
    dec ebx
    loop SAVE
    
    mov ecx,[max]
    Pop_Print:
    pop eax
    PRINT_UDEC 4,eax
    dec ecx
    cmp ecx,0
        je end
    jmp Pop_Print

end:    
    xor eax, eax
    ret
    