.MODEL SMALL
.STACK 100h

.DATA
saltoLinea DB 13,10,'$'

.CODE
main:

    mov ax, @data
    mov ds, ax

    mov al,2          ; AL=2
    mov bl,9    ; BL=9

    xchg al, bl       ; AL=9, BL=2

    
    mov dl, al
    add dl,30h        
    mov ah,2
    int 21h           ; Muestra '9'

    mov dx, OFFSET saltoLinea
    mov ah,9
    int 21h           ; Salto de línea

    
    mov dl, bl
    add dl,30h        
    mov ah,2
    int 21h           ; Muestra '2'

    mov ah,4ch
    int 21h


END main
