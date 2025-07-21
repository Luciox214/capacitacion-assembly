.MODEL SMALL
.STACK 100h

.DATA
saltoLinea DB 13,10,'$'     


.CODE
main PROC

    mov ax, @data
    mov ds, ax
    xor si,si
    for:
        cmp si,5d
        je salirFor  
        mov al,1
        add al,30h
        mov dl,al
        mov ah,2
        int 21h
        inc si
        jmp for
        
    salirFor:
    mov ah, 4Ch
    int 21h

main ENDP
END main
