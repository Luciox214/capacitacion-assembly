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
    ADD BL, AL       ; Sumar                   
    
    
    
    LEA DX, saltoLinea
    MOV AH, 09h
    INT 21h


    ; Convertir resultado a ASCII
    ADD BL, 30h
    MOV DL, BL
    MOV AH, 2
    INT 21h          ; Mostrar resultado

    MOV AH, 4Ch
    INT 21h
main ENDP
END main
