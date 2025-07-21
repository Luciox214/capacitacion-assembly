.model small        
.stack 100h          ; Reserva una pila de 256 bytes 

.data       
 num1 DW 5
 num2 DW 3
 resultado DB ?

.code                

main PROC            

   
    mov ax,@data  
    mov ds, ax
    mov ax, num1
    mov bx, num2    
    add bx,ax        

    mov resultado, bl
    add bl,30h       ; Le sumamos 30h   
    

    
    mov dl,bl        ; Ponemos el caracter en DL (donde DOS espera recibirlo)
    mov ah,2         ; Funcion 2 de int 21h para mostrar caracter en pantalla
    int 21h          ; Llamada a la interrupción DOS ? imprime '4'

    
    mov ah,4ch       ; Funcion 4Ch de int 21h para terminar programa
    int 21h          ; Llamada a la interrupcion que termina el programa

main ENDP            
end main             
