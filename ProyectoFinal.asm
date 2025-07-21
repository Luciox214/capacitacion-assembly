.MODEL SMALL
.STACK 100h

.DATA                            

    ingreso     DB 'Ingrese la operacion a realizar', 13,10,'$'
    binario     DB 'El resultado en binario es:  $', 
    octal       DB 'El resultado en octal es:  $', 
    hexa        DB 'El resultado en hexa es:  $', 
    resultado       DB 'El resultado es:', 13,10,'$'
    saltoLinea  DB 13,10,'$'
    result      DB 10               
    vector      DB 10 DUP(?)    
    vector2     DB 10 DUP(?)  
    vector3     DB 10 DUP(?)  

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
    SUB AL, 30h      ; Convertir de ASCII a numero
    MOV Bh, AL       ; Almaceno el primer numero en bh   
    
    mov ah,1
    int 21h
    ;Ingreso de operacion 
    
    mov dl,43; Guardo signo '+' en dl para comparar
    mov dh,45; Guardo signo '-' en dl para comparar
    mov cl,42; Guardo signo '*' en dl para comparar 
    ;Si no es ninguno de los anteriores, es '/' automaticamente

 
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
        mov result,al    
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
        
        xor ax,ax  
        xor si,si
        mov al,result
        jmp ciclo
                
        
    RESTA:       
        mov ah,1
        int 21h
        sub al,30h
        sub bh,al    
        
        mov result,bh    
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
        
        mov al,result
        xor si,si
        jmp ciclo
        
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
        mov result,al   
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
        
        mov al,result
        xor si,si
        jmp ciclo
        jmp FIN
                                 
    
    DIVISION: 
    mov ah, 1
    int 21h
    sub al, 30h     
    mov bl, al      
  
    mov al, bh      
    mov ah, 0       

    div bl           
    
    mov result,al
    
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
    xor si,si
    mov al,result
    jmp ciclo
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
       
 
       ciclo:
        MOV AH, 0             
        MOV BL, 2              ; divido por 2 para binario
        DIV BL                  
        MOV vector[SI], AH     ; guardamos el bit (resto)
        INC SI
        CMP AL, 0             
        JNE ciclo   
        
              
        LEA DX, saltoLinea
        MOV AH, 09h
        INT 21h 
        mov ah, 09h
        lea dx, binario
        int 21h
                   
        dec si
       imprimir:
        MOV DL, vector[SI]
        ADD DL, '0'     ; convertir 0/1 en ASCII
        MOV AH, 02h
        INT 21h
        DEC SI
        CMP SI, -1
        JNE imprimir 
       
    XOR SI, SI
    MOV AL, result
        
    ciclo2:
    MOV AH, 0
    MOV BL, 8
    DIV BL
    MOV vector2[SI], AH
    INC SI
    CMP AL, 0
    JNE ciclo2

    
    LEA DX, saltoLinea
    MOV AH, 09h
    INT 21h

    LEA DX, octal
    MOV AH, 09h
    INT 21h       
    
        dec SI       
       imprimir2:
        MOV DL, vector2[SI]
        ADD DL, '0'     ; convertir 0/1 en ASCII
        MOV AH, 02h
        INT 21h   
        DEC SI
        CMP SI, -1
        JNE imprimir2
        
        mov al,result
        xor si,si
        
       ciclo3:
        MOV AH, 0             
        MOV BL, 16              ; divido por 16 para hexa
        DIV BL         
        ;Comparo si es LETRA o NUM
        cmp ah,10      
        jne B
        
        A:  
        MOV vector3[SI],'A'     ; guardamos A en el vector
        jmp sinletra
        
        
        B:   
        cmp ah,11                                             
        jne C
        
        MOV vector3[SI],'B'     ; guardamos B en el vector
        jmp sinletra
        
        
        C:       
        cmp ah,12
        jne D                                         
        MOV vector3[SI],'C'     ; guardamos C en el vector
        jmp sinletra
        
        
        D:                                                
        cmp ah,13
        jne E
        MOV vector3[SI],'D'     ; guardamos D en el vector
        jmp sinletra
        
        
        E:                                                
        cmp ah,14
        jne F
        MOV vector3[SI],'E'     ; guardamos E en el vector
        jmp sinletra      
        
        
        F:                
        cmp ah,15
        jne numNormal
        
        MOV vector3[SI],'F'     ; guardamos F en el vector
        
        jmp sinletra
        numNormal:
        MOV vector3[SI], AH     ; guardamos el bit (resto)
        sinletra:
        INC SI
        CMP AL, 0             
        JNE ciclo3   
        
              
        LEA DX, saltoLinea
        MOV AH, 09h
        INT 21h 
        mov ah, 09h
        lea dx, hexa
        int 21h           
        
        
        dec SI
       imprimir3:
        MOV DL, vector3[SI]
        
        cmp DL,41
        ja esLetra
        
        ;No Letra
        add dl,30h
                   
        esLetra:
        MOV AH, 02h
        INT 21h
        DEC SI
        CMP SI, -1
        JNE imprimir3
       
    FIN:  

        MOV AH, 4Ch
        INT 21h

main ENDP
END main