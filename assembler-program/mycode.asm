TITLE MULTIPLICACION DE MATRICES

DATOS SEGMENT PARA PUBLIC 'DATA'
    
    
    
    MatA    DB  9,8,7,6,5,4,3,2,1
    MatB    DB  1,2,3,4,5,6,7,8,9
    MatR    DB  9 DUP(?)
    MatInt  DB  9 DUP(?)
    IndB    DW  ?
    IndR    DW  ?
    IndFila DW  ?
    
    
DATOS ENDS
     
     
PILA SEGMENT PARA STACK 'STACK'
    
    DB  64  DUP('STACK')
    
PILA ENDS


CODIGO SEGMENT PARA PUBLIC 'CODE'

INICIO PROC FAR
    
ASUME CS:CODIGO, DS: DATOS, SS: PILA


    PUSH DS
    MOV AX,0
    MOV AX
    
    MOV AX, DATOS
    MOV DS, AX
    MOV ES, AX
    
    
    
    
    MOV SI,0
    MOV DI,0
    MOV IndFila,3
    MOV InR, 0
    
    MULT:
    MOV IndB, DI
    
    
    
    MULT2:
    MOV AL, MatA[SI]
    MOV BL, MatB[DI]
    MUL BL
    MOV MatInt[SI], AL
    ADD DI,3
    INC SI
    CMP SI,2
    
    JBE MULT2
    
    
    MOV AL, MatInt[0]
    ADD AL, MatInt[1]
    ADD AL, MatInt[2]
    
    
    MOV SI,IndR
    
    MOV MatR[SI],AL
    INC IndR
    
    MOV SI,0
    MOV SI,IndB
    INC DI
    DEC IndFila
    CMP IndFila,0
    
    JA  MULT
    
    
    
RET