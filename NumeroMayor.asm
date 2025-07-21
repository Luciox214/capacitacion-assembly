.MODEL SMALL
.STACK 100h

.DATA
    resultado DB ?
    saltoLinea DB 13,10,'$'

.CODE
main PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Leer primer dígito
    MOV AH, 1
    INT 21h
    SUB AL, 30h      ; Convertir de ASCII a número
    MOV BL, AL       ; 
    
    
    LEA DX, saltoLinea
    MOV AH, 09h
    INT 21h

    ; Leer segundo dígito
    MOV AH, 1
    INT 21h
    SUB AL, 30h      ; Convertir de ASCII a número
    
    mov bh, al       
     
    LEA DX, saltoLinea
    MOV AH, 09h
    INT 21h
    
    cmp bh,bl
    jg L1   

        add bl,30h
        MOV DL,BL
        mov ah,2
        int 21h       
        jmp fin
    
    L1: 
        add bh,30h
        MOV DL,bh
        mov ah,2
        int 21h
    fin:
    
        MOV AH, 4Ch
        INT 21h


main ENDP
END main
