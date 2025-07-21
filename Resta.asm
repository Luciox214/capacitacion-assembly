.model small        
.stack 100h          ; Reserva una pila de 256 bytes 

.data                

.code                

main PROC            

   
    mov cx,7         ; Guardamos 7 en el registro CX
    mov dx,3         ; Guardamos 3 en el registro DX

    
    sub cx,dx        ; CX = CX - DX ? CX = 4

    
    ; CL es la parte baja de CX, contiene el valor 4
    add cl,30h       ; Le sumamos 30h (48 decimal) ? CL = '4' en ASCII

    
    mov dl,cl        ; Ponemos el caracter en DL (donde DOS espera recibirlo)
    mov ah,2         ; Funcion 2 de int 21h para mostrar caracter en pantalla
    int 21h          ; Llamada a la interrupción DOS ? imprime '4'

    
    mov ah,4ch       ; Funcion 4Ch de int 21h para terminar programa
    int 21h          ; Llamada a la interrupcion que termina el programa

main ENDP            
end main             
