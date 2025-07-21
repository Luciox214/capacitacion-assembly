.MODEL SMALL
.STACK 100h

.DATA
saltoLinea DB 13,10,'$'        
ingreso     DB 'Ingrese un char:', 13,10,'$'
resultado   DB 'La cantidad de vocales es:', 13,10,'$'   
arreglo     DB 20 DUP(?)     ;vector para guardar los caracteres



.CODE
main PROC

    mov ax, @data
    mov ds, ax
    xor si,si   
    xor cx,cx 
    
    for:
        cmp si,20d
        je salirFor  
        
        LEA DX, saltoLinea
        MOV AH, 09h
        INT 21h    
        
        mov ah, 09h
        lea dx, ingreso
        int 21h          
 
        ;Leo el char
        MOV AH, 1
        INT 21h 
        
        MOV arreglo[si], AL     ; Guardar el char en el arreglo
        
        cmp al,'a'
        je sumarVocal
                     
        cmp al,'e'
        je sumarVocal  
        
        cmp al,'e'
        je sumarVocal
        
        cmp al,'i'
        je sumarVocal
        
        cmp al,'o'
        je sumarVocal
        
        cmp al,'u' 
        je sumarVocal
        inc si   
        jmp for     
        
    sumarVocal:    
    inc cl 
    inc si    
    jmp for  
        
    salirFor:
    mov ah, 09h
    lea dx, resultado
    int 21h          
    
    mov al,cl
    aam
    mov dl,ah
    add dl,30h
    mov ah,2h
    mov cl,al
    int 21h  
    
    mov dl,cl
    add dl,30h
    mov ah,2h
    int 21h          
    
    LEA DX, saltoLinea
    MOV AH, 09h
    INT 21h    
        
    xor si,si
    mostrarArreglo:
    cmp si, 20
    je finPrograma

    mov dl, arreglo[si]
    mov ah, 2
    int 21h
    inc si
    jmp mostrarArreglo

finPrograma:
    mov ah, 4Ch
    int 21h 

main ENDP
END main
