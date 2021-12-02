TITLE ALGORITMOProfe
DATOS segment  
;------------------------------------------
    X   DW  0
    Y   DW  0
    TEMP DW 0
    
;------------------------------------------
DATOS ends

Pila SEGMENT 
    
    DW 64 DUP(0)  
    
Pila ends    
codigo SEGMENT
inicio PROC FAR
    PUSH DS
    MOV  AX, 0
    PUSH AX
    
    MOV AX, DATOS
    MOV DS, AX
    MOV ES, AX
;------------------------------------------

     
    
    MOV X,144
    MOV AX,X
    MOV TEMP,AX ;TEMP = X
    MOV Y,AX   ; Y = X
    
    ;Y = Y / 2
    
    MOV AX, Y ; 
    MOV BX, 2 ; 
    DIV BX    
    MOV Y, AL

    ;EMPIEZA EL CICLO
CICLO1:    
    
    ;La operacion es X = INT (X/Y)
    MOV AX,X
    MOV BX,Y
    DIV BL
    MOV X,AL
    
    ;Operacion es X = X+Y
    MOV AX,X
    ADD AX,Y
    MOV X,AX
     
   ;La operacion es X = INT(X/2)
    MOV AX,X
    MOV BX,2
    DIV BL
    MOV X,AL 
    
    ;Comparacion si Y == X
    MOV BX,Y
    CMP BX,X
    
    JZ COMPARACION1:
    
    
    ;X - Y = 1
    MOV AX,X
    SUB AX,Y
    CMP AX,1  
    
    JZ COMPARACION2:
   
    ;X - Y = -1
    MOV AX,X
    SUB AX,Y
    CMP AL,-1
    
   JZ COMPARACION3:
    
    ;Y = X
    MOV DL,X
    MOV Y,DL
    ;MOV AX,Y
    ;CMP AX,X
    
    ;X = TEMP
    MOV DL,TEMP
    MOV X,DL
    
    JMP CICLO1 
    
COMPARACION1:

COMPARACION2:

COMPARACION3:

    MOV AX,X    
   
    



;------------------------------------------ 
RET
    
INICIO ENDP
CODIGO ENDS
END INICIO