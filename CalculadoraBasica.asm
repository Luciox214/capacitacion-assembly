.MODEL SMALL
.STACK 100h

.DATA                            

    ingreso     DB 'Ingrese la operacion a realizar', 13,10,'$'
    negativo    DB 'El resultado es: - $', 
    resultado   DB 'El resultado es:', 13,10,'$'
    saltoLinea  DB 13,10,'$'     

.CODE
main PROC
    MOV AX, @DATA
    MOV DS, AX                   
    
    mov ah, 09h
    lea dx, ingreso
    int 21h
    ; Leer primer dígito
    MOV AH, 1
    INT 21h
    SUB AL, 30h      ; Convertir de ASCII a número
    MOV Bh, AL       ; Almaceno el primer numero en bh   
    
    mov ah,1
    int 21h
    ;Ingreso de operacion 
    
    mov dl,43; Guardo signo '+' en dl para comparar
    mov dh,45; Guardo signo '-' en dl para comparar
    mov cl,42; Guardo signo '*' en dl para comparar

 
    cmp al,dl
    je SUMA  
    cmp al,dh
    je RESTA
    cmp al,cl
    je MULTIPLICACION
    jmp DIVISION
    
    lea dx, resultado
    int 21h   
    add bh,30h
    MOV DL,bh
    mov ah,2
    int 21h
    jmp FIN
    
    SUMA:       
        mov ah,1
        int 21h
        sub al,30h
        add bh,al       
        LEA DX, saltoLinea
        MOV AH, 09h
        INT 21h 
        mov ah, 09h
        lea dx, resultado
        int 21h
        mov al,bh        
        aam
        add ah,30h
        MOV DL,ah
        mov ah,2 
        
        mov bl,al
        int 21h  
        
        add bl,30h
        mov dl,bl
        mov ah,2
        int 21h  
        jmp FIN
        
    RESTA:       
        mov ah,1
        int 21h
        sub al,30h
        sub bh,al       
        LEA DX, saltoLinea
        MOV AH, 09h
        INT 21h 
        mov ah, 09h
        lea dx, resultado
        int 21h   
        
        mov dl,bh   
        add dl,30h
        mov ah,2
        int 21h
        jmp FIN
    
    MULTIPLICACION:          
        mov ah,1
        int 21h
        sub al,30h     
        
          
        LEA DX, saltoLinea
        MOV AH, 09h    
        mov bl,al
        INT 21h 
        mov ah, 09h
        lea dx, resultado
        int 21h   
        
        mov al,bl
        mul bh      
        aam
        add ah,30h
        
        MOV DL,ah
        mov ah,2 
        
        mov bl,al
        int 21h  
        
        add bl,30h
        mov dl,bl
        mov ah,2
        int 21h  
        jmp FIN
                                 
    
    DIVISION: 
    mov ah, 1
    int 21h
    sub al, 30h     
    mov bl, al      
  
    mov al, bh      
    mov ah, 0       

    div bl    
    mov cl,ah ;GUARDO RESTO EN CL
    mov bh,al      

    LEA DX, saltoLinea
    MOV AH, 09h
    INT 21h 
    mov ah, 09h
    lea dx, resultado
    int 21h
       
    add bh, 30h
    mov dl, bh
    mov ah, 2                  
    int 21h                             
    
    cmp cl,0
    je FIN
    
    mov dl,44
    
    mov ah,2
    int 21h
    
    mov al,cl
    mov cl,10
    mul cl
    div bl
    
    mov dl,al
    add dl,30h
    mov ah,2
    int 21h
    
    FIN:  

        MOV AH, 4Ch
        INT 21h

main ENDP
END main
                       
                       
                       
                       
                 
    signoNegativo:      
    
        LEA DX, saltoLinea
        MOV AH, 09h
        INT 21h      
        mov dx, OFFSET negativo
        mov ah, 09h
        int 21h        
        xchg bh,bl
        sub bh,bl    
        mov dl,bh
        add dl,30h
        mov ah,2
        int 21h
        jmp FIN