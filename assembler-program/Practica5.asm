            Title Practica 4          ;TITULO



DATOS SEGMENT PARA PUBLIC DATA 
    
;-------------------------------------------------------------------------------------------
;*******************************************************************************************

DTOS DB 1,2,3,4,5,6,7,8,9,10,11,12,13

RESULTADO1 DW 0

RESULTADO2 DW 0,0

NUM DW 0

VAR DW 0

VAR2 DW 0 

VAR3 DW 0

;*******************************************************************************************
;-------------------------------------------------------------------------------------------


DATOS ENDS 
 
 
 
PILA SEGMENT PARA STACK 'STACK'
    DB 64 DUP('STACK')     
PILA ENDS



CODIGO SEGMENT PARA PUBLIC 'CODE'
INICIO PROC FAR
    
    
    
    PUSH DS
    MOV AX,0
    PUSH AX
    MOV AX, DATOS
    MOV DS, AX
    MOV ES, AX 
   

 
;-------------------------------------------------------------------------------------------
;*******************************************************************************************
                                            
            LEA DI,RESULTADO2                                               
                                            
                                            ;La multiplicacion permite guardar
            MOV AX,0                        ;los resultados en dos registos (DXAX)=LX*operando cuando operando = Word
            MOV NUM,12                       ;Guardar los resultados de cada registro
            DEC NUM                         ;en dos arreglos
            MOV CX,NUM
            CMP CX,0
            JE  ES_UNO
            MOV SI,0
            MOV AL,DTOS[SI]
            INC SI
 FACTORIAL:    
            CMP AX,40320                   ;cuando se llega a 9 se brinca a FACTORIAL2
            JE  MAYOR
            MOV BL,DTOS[SI]
            MUL BX
            INC SI
            LOOP FACTORIAL
            
            MOV RESULTADO1,AX
            JMP SALIR                       ;Salta para no setear 0 en AX
ES_UNO:     MOV AX,1
            MOV RESULTADO1,AX
            JMP SALIR
MAYOR:      
FACTORIAL2:
            MOV VAR,DX 
            MOV BL,DTOS[SI]
            MUL BX
            MOV VAR3,DX
            
            
            MOV VAR2,AX
            MOV AX,BX
            MOV BX,VAR
            MUL BX
            MOV VAR,AX
            MOV DX,VAR3
            ADD DX,VAR
            MOV AX,VAR2
            
            
            INC SI
            LOOP FACTORIAL2
            MOV  [DI],DX
            INC DI
            INC DI
            MOV [DI],AX
             
SALIR:                        
 
 ;*******************************************************************************************
;-------------------------------------------------------------------------------------------

         
         
;return to operating system:
		RET

INICIO ENDP

CODIGO ENDS

END INICIO