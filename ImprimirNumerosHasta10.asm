.MODEL SMALL
.STACK 100h

.DATA
saltoLinea DB 13,10,'$'     


.CODE
main PROC

    mov ax, @data
    mov ds, ax
    xor si,si        
    mov ch,1
    
    for:
        cmp si,10d
        je salirFor  
        mov al,ch 
        aam  
        add ah,30h
        mov dl,ah
        mov ah,2
        mov cl,al
        int 21h  
        
        add cl,30h
        mov dl,cl
        mov ah,2
        int 21h
                       
        
        LEA DX, saltoLinea
        MOV AH, 09h
        INT 21h
        
        inc si   
        inc ch
        jmp for
        
    salirFor:
    mov ah, 4Ch
    int 21h

main ENDP
END main
