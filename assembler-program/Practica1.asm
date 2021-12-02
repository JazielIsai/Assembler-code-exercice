 title Practica 1
Datos segment  
;------------------------------------------
    A   DW  0
    B   DW  300
    C   DW  200
    D   DW  150
    E   DW  125
    F   DW  100
    G   DW  80
    H   DW  70
    I   DW  60
    J   DW  50 
;------------------------------------------
Datos ends

Pila SEGMENT 
    
    DW 64 DUP(0)  
    
Pila ends    
codigo SEGMENT
inicio PROC FAR
    push DS
    MOV  AX, 0
    PUSH AX
    
    MOV AX, DATOS
    MOV DS, AX
    MOV ES, AX
;------------------------------------------
        
    MOV AX,18D 
    SUB AX,AX
    MOV AX,B
    MOV BX,OFFSET C
    MOV AX,[BX]
    MOV AX,[BX+2]
    MOV SI,2
    MOV AX,E[SI]
    MOV BX,OFFSET B
    MOV SI,8
    MOV AX,[BX][SI+2]
;------------------------------------------ 
RET
    
INICIO ENDP
CODIGO ENDS
END INICIO