.MODEL SMALL
.STACK 100h

.DATA

resultado DB ?
saltoLinea DB 13,10,'$'
   num1 DB 2
   num2 DB 9
.CODE
main PROC

    mov ax, @data
    mov ds, ax 
    lea si,num1
    lea di,num2
    mov bl,[si]
    mov al,[di]
    
    add al,30h
    mov dl, al
    mov ah, 2
    int 21h   
    
    mov dx, OFFSET saltoLinea
    mov ah, 9
    int 21h
    
    add bl,30h
    mov dl,bl  
    mov ah,2
    int 21h
    
    


    mov ah, 4Ch
    int 21h

main ENDP
END main
