.MODEL SMALL
.STACK 100h

.DATA              
    ingreso     DB 'Ingrese el digito:', 13,10,'$'
    resultado   DB 'El total acumulado es:', 13,10,'$'
    saltoLinea  DB 13,10,'$'  
    cond        DB 0   ; flag para salir

.CODE
main PROC

    mov ax, @data
    mov ds, ax                  

    xor cx, cx  ; limpiar acumulador

while:      
    
    cmp cond, 0
    jnz salirWhile
    ; Mostrar salto de línea
    lea dx, saltoLinea
    mov ah, 09h
    int 21h

    ; Mostrar mensaje
    mov ah, 09h
    lea dx, ingreso
    int 21h

    ; Leer un dígito
    mov ah, 1
    int 21h
    sub al, 30h   

    cmp al, 0
    je  setCondBandera   ; si el ingreso es 0, cambio flag

    
    add ch, al
    jmp while

setCondBandera:
    mov cond, 1    
    jmp while
    

salirWhile:   
    ; Mostrar resultado
    lea dx, saltoLinea
    mov ah, 09h
    int 21h         

    mov al, ch      
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
