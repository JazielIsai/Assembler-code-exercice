TITLE STACK 

DATOS SEGMENT           
;------------------------------------------------------------------
    PALABRAS   DB "EQUIPO 4"
    TAM =  ($ - D) / 4
    
DATOS ENDS    
;------------------------------------------------------------------
PILA SEGMENT
    DB 64 DUP(0)
PILA ENDS     
CODIGO SEGMENT
INICIO PROC FAR

    ASSUME DS:DATOS,CS:CODIGO, SS:PILA

        PUSH DS
        MOV  AX,0
        PUSH AX
        MOV AX, DATOS
        MOV DS, AX
        MOV ES, AX  

;----------------------------------------------------------------------   
MOV CX,8
MOV SI,0
L1: MOV AL,PALABRAS[SI]
PUSH AX
INC SI
LOOP L1
MOV CX, 8
MOV SI,0
L2: POP AX
MOV PALABRAS[SI], AL
INC SI  
LOOP L2
;-----------------------------------------------------------------------
RET   
INICIO ENDP
CODIGO ENDS
END INICIO     