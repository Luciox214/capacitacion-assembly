.model small        
.stack 100h          ; Reserva una pila de 256 bytes 

.data                

.code                

main PROC              
    mov ax,5    
    mov bx,2     
    mov cx,3
    add ax,bx
    xor ax,ax
    mul cx

    add al,30h      

    
    mov dl,al        
    mov ah,2         
    int 21h          

    
    mov ah,4ch       
    int 21h          

main ENDP            
end main             
