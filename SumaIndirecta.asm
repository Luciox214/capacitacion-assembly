.MODEL SMALL
.STACK 100h

.DATA
num DB 4
resultado DB ?
saltoLinea DB 13,10,'$'

.CODE
main PROC

    mov ax, @data
    mov ds, ax
    lea si, num     ;Guardo en SI la ubicacion de memoria de NUM
    mov al,[si]     ;Guardo en AL el valor que esta guardado en la ubicacion de SI, osea NUM (4). 
    add al,4
    mov resultado,al
    
    
    add al,30h
    mov dl, al
    mov ah, 2
    int 21h   


    mov ah, 4Ch
    int 21h

main ENDP
END main
