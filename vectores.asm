.MODEL SMALL
.STACK 100h

.DATA
arreglo DB 3,3,3,4      
saltoLinea DB 13,10,'$'

.CODE
main PROC

    mov ax, @data
    mov ds, ax

    xor ax, ax          ; limpiar AX
    xor si, si          ; índice = 0
    mov cx, 4           ; 4 elementos

suma_loop:
    mov bl, arreglo[si] ; cargar elemento en BL
    add al, bl          ; acumular en AL
    inc si              ; siguiente elemento
    loop suma_loop

    aam                 ; convierte AL en decenas (AH) y unidades (AL)
                        ; AL = unidad, AH = decena

    add ah, 30h         ; convertir decena a ASCII
    add al, 30h         ; convertir unidad a ASCII     
    mov cl, al

    mov dl, ah          ; DL = decena
    mov ah, 2
    int 21h             ; imprimir decena

    mov dl, cl          ; DL = unidad
    mov ah, 2
    int 21h             ; imprimir unidad

    mov ah, 9
    lea dx, saltoLinea  ; salto de línea
    int 21h

    mov ah, 4Ch
    int 21h

main ENDP
END main
