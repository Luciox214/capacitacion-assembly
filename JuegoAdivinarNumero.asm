.MODEL SMALL
.STACK 100h

.DATA              
    ingreso     DB 'Ingrese un numero entre 0-99', 13,10,'$'
    menor       DB 'El numero secreto es menor al ingresado', 13,10,'$'    
    mayor     DB 'El numero secreto es mayor al ingresado', 13,10,'$'
    
    resultado   DB 'Ganaste! La cantidad de intentos fue de:', 13,10,'$'
    saltoLinea  DB 13,10,'$'  
    cond        DB 0   ; flag para salir  
    numero      DB 12

.CODE
main PROC

    mov ax, @data
    mov ds, ax                  

    xor cx, cx  ; limpiar acumulador

while:      
    
    cmp cond, 0
    jnz salirWhile
    ; Mostrar salto de linea
    lea dx, saltoLinea
    mov ah, 09h
    int 21h        

        
    ; Mostrar mensaje
    mov ah, 09h
    lea dx, ingreso
    int 21h

    ; Leer un digito
    mov ah, 1
    int 21h
    sub al, 30h 
    ;lo muevo a otro registro para que no se sobreescriba
    mov dl,al           
    
    
    mov ah, 1
    int 21h
    
    
    cmp al,0dh ;salta si el segundo digito NO es DD(Enter)
    jne dosDigito                                         
    
         
    cmp dl,numero
    je setCondBandera  
    cmp dl,numero
    ja esMenor
    jmp esMayor
    
    

    cmp al, numero
    je  setCondBandera   ; si el ingreso es 0, cambio flag

    dosDigito:           
         sub al,30h
         xchg al,dl;Primer digito estaria en AL
         mov bl,10
         mul bl
         add al,dl
         
         cmp al,numero
         je setCondBandera  
         cmp al,numero
         ja esMenor
         jmp esMayor
         
     esMayor:            
            
            lea dx, saltoLinea
            mov ah, 09h
            int 21h         
            mov ah,09h
            lea dx,mayor
            int 21h
            inc cl
            jmp while
     esMenor:   
     
            lea dx, saltoLinea
            mov ah, 09h
            int 21h         
            mov ah,09h
            lea dx,menor
            int 21h
            inc cl        

    jmp while

setCondBandera:
    mov cond, 1    
    jmp while
    

salirWhile:   
    ; Mostrar resultado
    lea dx, saltoLinea
    mov ah, 09h
    int 21h         

    mov al, cl    
    aam             
    mov bh, ah
    mov bl, al

    mov ah, 09h
    lea dx, resultado
    int 21h    

    lea dx, saltoLinea
    mov ah, 09h
    int 21h  

    add bh, 30h
    mov dl, bh
    mov ah, 2
    int 21h

    add bl, 30h
    mov dl, bl
    mov ah, 2
    int 21h     

    mov ah, 4Ch
    int 21h

main ENDP
END main
