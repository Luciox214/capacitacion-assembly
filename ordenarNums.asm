.MODEL SMALL
.STACK 100h

.DATA
    saltoLinea DB 13,10,'$'        
    ingreso     DB 'Ingrese un numero:', 13,10,'$'
    resultado   DB 'Numeros ordenados:', 13,10,'$'   
    arreglo     DB 3 DUP(?)     

.CODE
main PROC
    mov ax, @data
    mov ds, ax
    xor si, si

leer:
    cmp si, 3
    je ordenar

    lea dx, ingreso
    mov ah, 09h
    int 21h

    mov ah, 1
    int 21h
    sub al, 30h           
    mov arreglo[si], al

    inc si
    jmp leer

ordenar:
    ; comparar [0] y [1]
    mov al, arreglo[0]
    cmp al, arreglo[1]
    jbe skip1
    xchg al, arreglo[1]
    mov arreglo[0], al
skip1:

    ; comparar [1] y [2]
    mov al, arreglo[1]
    cmp al, arreglo[2]
    jbe skip2
    xchg al, arreglo[2]
    mov arreglo[1], al
skip2:

    ; comparar [0] y [1] otra vez (por si cambio antes)
    mov al, arreglo[0]
    cmp al, arreglo[1]
    jbe imprimir
    xchg al, arreglo[1]
    mov arreglo[0], al


imprimir:
    lea dx, saltoLinea
    mov ah, 09h
    int 21h

    lea dx, resultado
    mov ah, 09h
    int 21h

    xor si, si

mostrar:
    cmp si, 3
    je fin

    mov al, arreglo[si]
    add al, 30h           
    mov dl, al
    mov ah, 2
    int 21h

    inc si
    jmp mostrar

fin:
    mov ah, 4Ch
    int 21h
main ENDP
END main
