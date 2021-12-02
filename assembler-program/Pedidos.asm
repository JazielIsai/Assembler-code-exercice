TITLE PEDIDOS                                                                                          TITLE AHORCADO

DATOS SEGMENT
    
    D:
    SEGMENU DB 'Carne Asada'
    ;SEGMENTO1 DB 13 DUP (?)
    SEGPEDIDO DB 11 DUP ('?')
    ;SEGMENTO3 DB 12 DUP (?)
    TAM = ($ - D) / 2
    
    PAGO DB 'Total a Pagar Cincuenta Pesos $'
    TEMP DB 11 DUP ('?')
    COMIDA DB 'HAY COMIDA $'
    ;count DB 0
        
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
 
 
    ;leer:
        ;mov ah,07h
        ;int 21h    
        ;mov dl,al
        ;mov ah,02h
        ;int 21h
        ;mov SEGMENU[si],al
        ;inc si
    ;loop leer
    
    ;VAMOR A VERIFICAR SI HAY CARNES EN EXISTENCIA
    
    MOV AH,07h
    INT 21h    
    
    MOV DI, OFFSET SEGMENU
    MOV AL, AL;'F'
    MOV CX, TAM 
    
    CLD
    REPNE SCASB
    DEC DI 
    

        ;HAY COMIDA
    
    MOV AH , 9        ; Funcion (Print String) Imprimir Cadena  
    LEA DX , COMIDA   ; Obtiene la Direccion de "PAGO" 
    INT 21H           ; Ejecutar   
    
     
    
    ;MOV count, 0
    MOV CX, TAM
    LEA SI, SEGMENU
    LEA DI, SEGPEDIDO
    ;MOV SI, OFFSET SEGMENTO1;[count] ; SI APUNTA AL SEGMENTO 1
    ;DEC DI
    ;MOV DI, OFFSET SEGMENTO2;[count] ; DI APUNTA AL SEGMENTO 2
    
        
    REP MOVSB                ; Copia bytes
    ;REP MOSVW         
          
     
     
          
   ;Comparar si el pedido del cliente es el mismo que ha recibido el cocinero     
    LEA SI, SEGMENU
    LEA DI, SEGPEDIDO
    MOV CX, TAM
    
   REPE CMPSB      ;Compara los bytes de ambos arreglos hasta el limite donde 
   ;REPE CMPSW      ;iguales. Si no son iguales ZF=0
    
    JNZ NO
    
    MOV AL,'S'
    MOV AH, 0Eh
    INT 10h
     
     
    ;Su Pago es de
    
    MOV AH , 9      ; Funcion (Print String) Imprimir Cadena  
    LEA DX , PAGO   ; Obtiene la Direccion de "PAGO" 
    INT 21H         ; Ejecutar    
     
     
    JMP SALIR

NO:
    MOV AL, 'N'
    MOV AH, 0EH
    INT 10h

SALIR:
    ;MOV AH,0
    ;INT 16h    
    

 
  
    ;Limpiar lo que ha ordenado el cleinte
    
    MOV CX, TAM
    MOV AL, '?'                    ; ESTABLECE EL CONTADOR REP
    MOV DI, OFFSET SEGPEDIDO;[count] ; SI APUNTA AL SEGMENTO 1
    

    CLD
    REP STOSB     
    
    
    ;MOV AH,0
    ;INT 16H
    ;MOV BL, AL
    
    ;CLD
    ;REPNE SCASB
    ;JNZ salir
    ;DEC DI
    ;MOV AL,[DI]
    
    
    
 ;salir:   
    

 ;

   
   ;Buscamos la 
    
   ;INC count
                        
    
    
    
    
    
    ;REP MOVSB                ; Copia bytes
    ;REP MOSVW
    
    

    
    
    
    
    
    
    
    RET
    
    
INICIO ENDP
CODIGO ENDS

    END     INICIO
