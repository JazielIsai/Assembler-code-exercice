          DATOS SEGMENT PARA PUBLIC DATA 
    
;-------------------------------------------------------------------------------------------
;*******************************************************************************************
FILA DB 1
TAMMA DW ? 
PORA DW ?

TAMMB DW ? 
PORB DW ?
MATA DB 1,2,3,4,5,6,7,8,9,9,10,11
MATB DB 11,10,9,9,8,7,6,5,4,3,2,1
MATR DB       16 DUP (?)
MatInt DB     16 DUP (?)
IndB  DW       ?
IndR  DW        ?
Indfila DW       ?


;*******************************************************************************************
;-------------------------------------------------------------------------------------------


DATOS ENDS 
 
include 'emu8086.inc' 
 
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
                
GOTOXY 1,FILA 
CALL PTHIS                        
DB 'INTRODUSCA TAMANO DE MA:',0 
                
;TAM MA                
GOTOXY 1,FILA 
CALL PTHIS                        
DB 'INTRODUSCA TAMANO DE MA:',0 
CALL SCAN_NUM             
MOV TAMMA,CX
INC FILA
GOTOXY 1,FILA 
CALL PTHIS                        
DB 'POR:',0 
CALL SCAN_NUM             
MOV PORA,CX
INC FILA               

       
;TAM MB
GOTOXY 1,FILA 
CALL PTHIS                        
DB 'INTRODUSCA TAMANO DE MB:',0 
CALL SCAN_NUM             
MOV TAMMB,CX 
INC FILA                 
GOTOXY 1,FILA 
CALL PTHIS                        
DB 'POR:',0 
CALL SCAN_NUM             
MOV PORB,CX
INC FILA               
                

;COMPARACIONES     
MOV SI,TAMMA
MOV DI,TAMMB
CMP SI,DI
JB JUMP

MOV DI,PORA

CMP SI,1
JZ SALTOA1

CMP SI,2
JZ SALTOA2

CMP SI,3
JZ SALTOA3

CMP SI,4
JZ SALTOA4



SALTOA1:
CMP DI,1
JZ JUMPA1.1

CMP DI,2
JZ JUMPA1.2

CMP DI,3
JZ JUMPA1.3

CMP DI,4
JZ JUMPA1.4


JUMPA1.1:

JUMPA1.2:

JUMPA1.3:

JUMPA1.4:



SALTOA2:
CMP DI,1
JZ JUMPA2.1

CMP DI,2
JZ JUMPA2.2

CMP DI,3
JZ JUMPA2.3

CMP DI,4
JZ JUMPA2.4


JUMPA2.1:

JUMPA2.2:

JUMPA2.3:

JUMPA2.4:



SALTOA3:
CMP DI,1
JZ JUMPA3.1

CMP DI,2
JZ JUMPA3.2

CMP DI,3
JZ JUMPA3.3

CMP DI,4
JZ JUMPA3.4


JUMPA3.1:

JUMPA3.2:

JUMPA3.3:

JUMPA3.4:



SALTOA4:
CMP DI,1
JZ JUMPA4.1

CMP DI,2
JZ JUMPA4.2

CMP DI,3
JZ JUMPA4.3

CMP DI,4
JZ JUMPA4.4


JUMPA4.1:

JUMPA4.2:

JUMPA4.3:

JUMPA4.4:

 
 
 
JUMP:                                         
;CMP DI,1
;JZ SALTOB1
;
;CMP DI,2
;JZ SALTOB2
;
;CMP DI,3
;JZ SALTOB3
;
;CMP DI,4
;JZ SALTOB4
;
;
;SALTOB1: 
;
;
;SALTOB2:
;
;
;SALTOB3:
;
;
;SALTOB4:                
;                
                
                
                
                
            
            ;Inicio
    MOV SI,0
    MOV DI,0         ;Se cargan los primeros datos para 4 Filas 
    MOV Indfila,4
    MOV IndR,0
    
MULT:
MOV IndB,DI   ;Se carga Di en IndB
                                      



MULT2:


MOV AL,MATA[SI]    ;Se carga el primer elemento de MatrisA en AL
MOV BL,MATB[DI]    ;Se carga el segundo elemento de MatrisB en BL 
;add al,3
MUL BL             ;Se realiza la multiplicacion con BL 
MOV MatInt[SI],AL  ;Se guarda el resultado en la matris intermedia 
ADD DI,4           ;Se agrega un 4 a DI
INC SI             ;Se incrementa S1 
CMP SI,2           ;Se compara SI con 2
JBE MULT2          ;Bucle que se acabara cuando se llegue a la 4ta multiplicacion 




MOV AL,MatInt[0]   ;Suma de los datos resultantes y almacenados en AL
ADD AL,MatInt[1]    
ADD AL,MatInt[2]    
ADD AL,MatInt[3]       






MOV SI,IndR        
;add si,4


MOV MatR[SI],AL    ;Se pasa elemento de AL a MatR
INC IndR           ;Se incrementra IndR para guardar en la siguente pocicion

MOV SI,0           ;Se carga SI con 0
MOV DI,IndB        ;Se carga DI con IndB
INC DI             ;Aumento en DI para la siguiente posicion
DEC Indfila        ;Decrementamos la fila para saber cuatos calculos quedan
CMP Indfila,0      ;Se compara la IndFila si es 0
JA MULT            ;Bucle que se caba cuando IndFila es 0




MOV SI,0        ;Se cargan los valores primarios de nuevo para continuar con la siguiente fila 
MOV DI,0
MOV Indfila,4
MOV IndR,0
  
  
  
    
MULT3:
MOV IndB,DI
                                      



MULT4:


MOV AL,MATA[SI]
MOV BL,MATB[DI] 
add al,3              ;Recorre a la siguiente fila de la MatA Fila2 
MUL BL
MOV MatInt[SI],AL
ADD DI,4
INC SI
CMP SI,2
JBE MULT4




MOV AL,MatInt[0]    
ADD AL,MatInt[1]
ADD AL,MatInt[2]    
ADD AL,MatInt[3]       






MOV SI,IndR      
add si,4           ;Sigueinte fila de la MatRes Fila 2 


MOV MatR[SI],AL
INC IndR

MOV SI,0
MOV DI,IndB
INC DI
DEC Indfila
CMP Indfila,0
JA MULT3       



MOV SI,0
    
    MOV DI,0
    MOV Indfila,4
    MOV IndR,0
    
MULT5:
MOV IndB,DI
                                      



MULT6:


MOV AL,MATA[SI]
MOV BL,MATB[DI] 
add al,6              ;;Recorre a la siguiente fila de la MatA Fila 3 
MUL BL
MOV MatInt[SI],AL
ADD DI,4
INC SI
CMP SI,2
JBE MULT6




MOV AL,MatInt[0]    
ADD AL,MatInt[1]
ADD AL,MatInt[2]    
ADD AL,MatInt[3]       






MOV SI,IndR      
add si,8               ;Sigueinte fila de la MatRes Fila 3


MOV MatR[SI],AL
INC IndR

MOV SI,0
MOV DI,IndB
INC DI
DEC Indfila
CMP Indfila,0
JA MULT5   


 
MOV SI,0
    
    MOV DI,0
    MOV Indfila,4
    MOV IndR,0
    
MULT7:
MOV IndB,DI
                                      



MULT8:


MOV AL,MATA[SI]
MOV BL,MATB[DI] 
add al,8               ;Recorre a la siguiente fila de la MatA Fila 4
MUL BL
MOV MatInt[SI],AL
ADD DI,4
INC SI
CMP SI,2
JBE MULT8




MOV AL,MatInt[0]    
ADD AL,MatInt[1]
ADD AL,MatInt[2]    
ADD AL,MatInt[3]       






MOV SI,IndR      
add si,12               ;Sigueinte fila de la MatRes Fila 4 


MOV MatR[SI],AL
INC IndR

MOV SI,0
MOV DI,IndB
INC DI
DEC Indfila
CMP Indfila,0
JA MULT7   
 










RET

INICIO ENDP

CODIGO ENDS 

DEFINE_SCAN_NUM            
            
DEFINE_PTHIS

END INICIO