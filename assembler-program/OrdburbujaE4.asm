DATOS SEGMENT PARA PUBLIC DATA 
    
;-------------------------------------------------------------------------------------------
;*******************************************************************************************

DTOS DB 1,7,10,5,2,77,25,4,6,3,44,12,14,26,83,22,66,16,55,33

d:
MENMAY DB  20 DUP (0)
MAYMEN DB  20 DUP (0)   
tam = ($-d)/2l

;*******************************************************************************************
;-------------------------------------------------------------------------------------------


DATOS ENDS 
 
 
 
PILA SEGMENT PARA STACK 'STACK'
    DB 64 DUP('STACK')     
PILA ENDS        

CODIGO SEGMENT PARA PUBLIC 'CODE'
INICIO PROC FAR     
    ASSUME DS:DATOS, CS:CODIGO, SS:PILA

 PUSH DS
    MOV AX,0
    PUSH AX
    MOV AX, DATOS
    MOV DS, AX
    MOV ES, AX 
   
   
  
   MOV CX,tam
   MOV SI,OFFSET DTOS
   MOV DI,OFFSET MENMAY   
   rep movsb    
                               ;Ciclos para asignacion de valores dentro de SI y DI 
   MOV CX,tam
   MOV SI,OFFSET DTOS
   MOV DI,OFFSET MAYMEN
   rep movsb
  
                     
   MOV CX,19
   MOV SI,0
   MOV DI,0 
   
   
  CICLO1:
  PUSH CX
  LEA SI,MENMAY      ;Se asignan los valores a evaluar tanto en DI como en SI
  MOV DI,SI 
  
  CICLO2: 
  INC DI             ;Luego se aumenta DI para comparar el dato 0 con el 1
  MOV AL,[SI]
  CMP AL,[DI]
  JA INTERC          ;Salto para cuando es un numero Mayor (JA primer operando esta por encima del Segundo)
  JB MEN             ;Salto para cuando es un numero Menor (JB primer operando esta por debajo del Segundo)
  
  
  INTERC:            ;Si esta por encima entonces:
  MOV AH,[DI]        ;Se movera el segundo dato a la parte alta de A
  MOV [DI],AL        ;Se movera el contenido de AL dentro del arreglo que esta dentro de DI
  MOV [SI],AH        ;Se movera el contenido de AH dentro del arreglo que esta dentro de SI
  
  MEN:               ;Si esta por debajo entonces:
  INC SI             ;Se realiza un incrmento en SI para pasar al sigueinte dato que sera el dato N.2
  LOOP CICLO2        ;Se retorna al Ciclo 2
  POP CX
  LOOP CICLO1        ;Se retorna al Ciclo 1
  
  MOV CX,19          ;Se restablecen nuestros datos
   MOV SI,0
   MOV DI,0 
  
  
  
  CICLO3:            
  PUSH CX            ;Utilizamos el contador para un tercer ciclo
  LEA SI,MAYMEN      ;Lee los valores del segmento y se asignan los valores a evaluar en DI y SI
  MOV DI,SI 
  
  CICLO4:            ;Aumenta DI para comparar el dato 0 con el 1
  INC DI
  MOV AL,[SI]
  CMP AL,[DI]        ;Salto para cuando es un numero Menor (JB primer operando esta por debajo del Segundo)
  JB INTERC2
  JA MEN2            ;Salto para cuando es un numero Mayor (JA primer operando esta por encima del Segundo)
  
  
  INTERC2:            ;Se movera el segundo dato a la parte alta de A
  MOV AH,[DI]         ;Se movera el contenido de AL dentro del arreglo que esta dentro de DI
  MOV [DI],AL         ;Se movera el contenido de AH dentro del arreglo que esta dentro de SI
  MOV [SI],AH
  
  MEN2:
  INC SI              ;Se realiza un incrmento en SI para pasar al sigueinte dato que sera el dato N.2
  LOOP CICLO4         ;Se retorna ciclo 4
  POP CX
  LOOP CICLO3         ;Se retorna ciclo 3
  
  
  EXIT:
  RET

INICIO ENDP

CODIGO ENDS

END INICIO