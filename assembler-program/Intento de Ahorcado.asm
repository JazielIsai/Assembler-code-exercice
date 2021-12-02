TITLE AHORCADO

DATOS SEGMENT
    
    D:
    SEGMENTO1 DB 'Interfaz'
    ;SEGMENTO1 DB 13 DUP (?)
    SEGMENTO2 DB 20 DUP (?)
    TAM = ($ - D) / 2
    
    TEMP DB 0
    count DB 0
        
    ;D:
    ;SEGMENTO1 DW 10 DUP (OFFFFH)
    ;SEGMENTO2 DW 10 DUP (?)
    ;TAM = ($ - D) / 4
    
DATOS ENDS


PILA SEGMENT 
    
    DW  64  DUP(0)
    
PILA ENDS

CODIGO SEGMENT 
INICIO PROC FAR
    
    
    
    
    PUSH    DS
    MOV     AX,0
    PUSH    AX
    
    MOV     AX,DATOS
    MOV     DS,AX
    MOV     ES,AX
    
    
    
    
    
    ;CODIGO DEL PROGRAMA EN ESTA SECCION
    ;-----------------------------------
    ;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    ;------------------------------------
RECOLECTAR:
    
    mov ah,07h
    int 21h    
    ;mov dl,al    
    MOV SI, OFFSET SEGMENTO2
    MOV DI, OFFSET SEGMENTO1
    MOV AL, AL;'F'
    MOV CX, TAM
    
    CLD
    REPNE SCASB
    DEC DI       
    
    
    MOV SI,DI
    ;MOV SI, OFFSET SEGMENTO2
    
    
    MOV SEGMENTO2[SI], AL ; poner valor en la posición actual
                 ; mover DI a la siguiente posicion
    

    
LOOP RECOLECTAR    
    
    
    
    
    
    
    MOV count, 0
    MOV CX, TAM                     ; ESTABLECE EL CONTADOR REP
    MOV DI, OFFSET SEGMENTO1;[count] ; SI APUNTA AL SEGMENTO 1
    ;MOV DI, OFFSET SEGMENTO2;[count] ; DI APUNTA AL SEGMENTO 2
    MOV AH,0
    INT 16H
    ;MOV BL, AL
    CLD
    REPNE SCASB
    JNZ salir
    DEC DI
    MOV AL,[DI]
    
    
    
 salir:   
    
    
   MOV DI, OFFSET SEGMENTO2[AL]
   CLD
   REP STOSB     
    
    
   ;INC count
                        
    
    
    
    
    
    ;REP MOVSB                ; Copia bytes
    ;REP MOSVW
    
    
    
    
    
    
    
    
    
    
    
    
    RET
    
    
INICIO ENDP
CODIGO ENDS

    END     INICIO
    