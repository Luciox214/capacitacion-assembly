.model small
.stack 100h
.data
.code
 main PROC
    mov ax,5
    mov bx,2
    add ax,bx     
    mov dx, ax 
    mov ah,9
    int 21h        
    .exit

 main ENDP   

end main