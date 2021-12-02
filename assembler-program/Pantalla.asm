TITLE DIBUJAR EN LA INTERFAZ DE LA PANTALLA

DATOS segment PARA PUBLIC 'DATA' 
;------------------------------------------

    
;------------------------------------------
DATOS ends

Pila SEGMENT PARA STACK'STACK'
    
    DW 64 DUP('STACK') 
    
Pila ends     

codigo SEGMENT PARA PUBLIC 'CODE'

inicio PROC FAR
    
    ASSUME CS:CODIGO, DS:DATOS, SS:PILA
    
    PUSH DS
    MOV  AX, 0
    PUSH AX
    
    MOV AX, DATOS
    MOV DS, AX
    MOV ES, AX
;------------------------------------------

    MOV AL,13h
    MOV AH, 0
    INT 10h
    
    MOV AX,0
    INT 33h
    
    MOV AX,1
    INT 33h
 
 ESPERA:
    

    MOV AX,3
    INT 33h
    SHR cx,1
    cmp BX,1
    
    JE DIBUJA
    CMP BX,2
    JE SALIR
    JMP ESPERA
    
DIBUJA:
    MOV AH,12
    MOV AL,10
    INT 10h
    JMP ESPERA
    
SALIR:    

        
    


;------------------------------------------ 
RET
    
INICIO ENDP

CODIGO ENDS
        
        END INICIO