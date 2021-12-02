            Title Practica 6          ;TITULO



DATOS SEGMENT PARA PUBLIC DATA 
    
;-------------------------------------------------------------------------------------------
;*******************************************************************************************

;VARIABLE PARA LA EL NUMERO A CONVERTIR
;COLOCAR VARIABLE COMO UNSIGNED Y MOSTRAR SOLO 1 EN LA EMULACION
NUM DW 156 

;VARIABLE PARA INTRODUCIR EL NUMERO BINARIO A CONVERTIR (MAXIMO 1 BYTE)
;COLOCAR VARIABLE COMO UNSIGNED Y MOSTRAR 8 EN LA EMULACION
NUM_BIN DB 1,0,0,0,0,0,0,1

;COLOCAR VARIABLE COMO UNSIGNED Y MOSTRAR SOLO 3 EN LA EMULACION
NUM_OCT DB 0,0,0

;VARIABLES PARA MOSTRAR LOS RESULTADOS
;COLOCAR VARIABLE COMO UNSIGNED Y MOSTRAR 8 EN LA EMULACION
RESULT DB 8 DUP (0)

;COLOCAR VARIABLE COMO HEX Y MOSTRAR SOLO 4 EN LA EMULACION
RES_HEXA DB 4 DUP (0)

;COLOCAR VARIABLE COMO UNSIGNED Y MOSTRAR SOLO 1 EN LA EMULACION
RES_SUMBIN DB 0


;COLOCAR VARIABLE COMO UNSIGNED Y MOSTRAR 8 EN LA EMULACION
RES_BIN DB 8 DUP (0)


;VARIABLES PARA SELECCIONAR LA BASE DE ENTRADA Y BASE DE SALIDA
;BINARIO=2, OCTAL= 8, DECIMAL=10, HEXADECIMAL=16

;----COLOCAR VARIABLE COMO UNSIGNED Y MOSTRAR SOLO 1---
ENTRADA DW 10   
SALIDA DW 2

;*******************************************************************************************
;-------------------------------------------------------------------------------------------


DATOS ENDS 
 
 
 
PILA SEGMENT PARA STACK 'STACK'
    DB 64 DUP('STACK')     
PILA ENDS



CODIGO SEGMENT PARA PUBLIC 'CODE'
INICIO PROC FAR
    
    
    
    ASSUME  CS:CODIGO,DS:DATOS,PILA:STACK
    PUSH    DS
    MOV     AX,0
    PUSH    AX
    MOV     AX, DATOS
    MOV     DS, AX
    MOV     ES, AX 
   

 
;-------------------------------------------------------------------------------------------
;*******************************************************************************************

;============= BASE DE LA ENTRADA =========; 

MOV CX,ENTRADA
MOV DX,SALIDA

        ;^^^^^^^^^^ BINARIOS ^^^^^^^^^^
        
CMP CX,2
JZ  BINA

        ;^^^^^^^^^^ DECIMAL ^^^^^^^^^^^ 
        
CMP CX,10
JZ  DECIM

        ;^^^^^^^^^^ OCTAL ^^^^^^^^^^
        
CMP CX,8
JZ  OCTA

     ;^^^^^^^^^^ HEXAGECIMAL ^^^^^^^^^^
     
CMP CX,16
JZ  HEXA

JMP SALIR 

;============ BASE DE LA SALIDA ===========; 
                                
                                ;NOTA: LOS ELEMENTOS CON ;* YA FUNCIONAN :D

BINA:

CMP DX,8
JZ BIN_OCTA;*

CMP DX,10
JZ BIN_DEC;*

CMP DX,16
JZ BIN_HEXA;*

OCTA:

CMP DX,2
JZ OCTA_BIN;*

CMP DX,10
JZ OCTA_DEC

CMP DX,16
JZ OCTA_HEXA

DECIM:
CMP DX,2
JZ DEC_BIN;* (EJEMPLO DEL MAESTO, CON CAMBIOS xD)

CMP DX,8
JZ DEC_OCTA;*

CMP DX,16
JZ DEC_HEXA;*

HEXA:
CMP DX,2
JZ HEXA_BIN

CMP DX,8
JZ HEXA_OCTA

CMP DX,10
JZ HEXA_DEC


JMP SALIR 
 
                                            
;-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_       
        
                                ;///{ BINARIO A OCTAL }\\\
 
BIN_OCTA:

        MOV CX,8
        
        MOV SI,7
        MOV DI,4
REP2_BO:
        
        MOV ENTRADA,4        
        MOV DL, RES_SUMBIN
        MOV NUM_OCT[DI],DL
        
        CMP SI,65535
        JZ SALIR
        
        DEC DI
        MOV RES_SUMBIN,0       
        MOV BL,1
        MOV AX,1
REP_BO: 
              
        
        MUL BL
        MOV NUM,AX     
        MUL NUM_BIN[SI]
        MOV RES_BIN[SI],AL  ;ES UN ARREGLO
        ADD RES_SUMBIN,AL   ;UN SOLO DIGITO
        DEC SI
        DEC ENTRADA
        CMP SI,65535        ;CUANDO SE HALLA CALCULADO EL ULTIMO NUMERO DEL NUM_BIN
        JZ REP2_BO  
        CMP ENTRADA,0
        JZ REP2_BO
         
        
                
        MOV BL,2
        MOV AX,NUM
        
        LOOP REP_BO
        JMP SALIR
               
        
;-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_


                              ;///{ BINARIO A DECIMAL}\\\

BIN_DEC:

        MOV CX,8
        MOV SI,7
        MOV BL,1
        MOV AX,1
 
REP_BD:        
        
        MUL BL
        MOV NUM,AX     
        MUL NUM_BIN[SI]
        MOV RES_BIN[SI],AL  ;ES UN ARREGLO
        ADD RES_SUMBIN,AL   ;UN SOLO DIGITO
        DEC SI
        
        MOV BL,2
        MOV AX,NUM
        
        LOOP REP_BD
        JMP SALIR 
        
 ;-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_       
        
                             ;///{ BINARIO A HEXADECIMAL }\\\
 
 BIN_HEXA:
 
 MOV CX,8
        
        MOV SI,7
        MOV DI,4
REP2_BH:
        
        MOV ENTRADA,4        
        MOV DL, RES_SUMBIN
        MOV RES_HEXA[DI],DL
        
        CMP SI,65535
        JZ SALIR
        
        DEC DI
        MOV RES_SUMBIN,0       
        MOV BL,1
        MOV AX,1
REP_BH: 
              
        
        MUL BL
        MOV NUM,AX     
        MUL NUM_BIN[SI]
        MOV RES_BIN[SI],AL  ;ES UN ARREGLO
        ADD RES_SUMBIN,AL   ;UN SOLO DIGITO
        DEC SI
        DEC ENTRADA
        CMP SI,65535        ;CUANDO SE HALLA CALCULADO EL ULTIMO NUMERO DEL NUM_BIN
        JZ REP2_BH  
        CMP ENTRADA,0
        JZ REP2_BH
         
        
                
        MOV BL,2
        MOV AX,NUM
        
        LOOP REP_BH
 
 
 JMP SALIR  
;-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_       
       
                             ;///{ OCTAL A BINARIO }\\\
 
OCTA_BIN:

        MOV SI,7
        MOV DI,3    ;SE DECEREMENTARA 1 EN DI 
 REP_OB:
        CMP DI,0
        JZ  SALIR
 
        DEC DI       
        
        MOV AX,NUM_OCT[DI]
        AND AX,0X00FF
        MOV BL,2
        MOV CX,8
        
 CALCULOOB:
 
        DIV BL
        
        MOV RESULT[SI],AH
        
        AND AX,0X00FF
        ;CMP NUM_OCT[DI],
        DEC SI
        CMP AL,0
        JZ  ADDNUM0                ;REP_OD
        
        LOOP CALCULOOB
        JMP SALIR:
        
ADDNUM0:
CMP SI,0
JZ SALIR

CMP NUM_OCT[DI],4
JLE ADDNUM1
CMP NUM_OCT[DI],5
JGE REP_OB         

ADDNUM1:
MOV RESULT[SI],0
DEC SI
JMP REP_OB
  
;-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_       
        
                             ;///{ OCTAL A DECIMAL }\\\
 
OCTA_DEC:
JMP SALIR  
;-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_       
        
                             ;///{ OCTAL A HEXADECIMAL }\\\
 
OCTA_HEXA:
 JMP SALIR     
;-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_       
 
                            ;\\\{ DECIMAL A BINARIO }///
DEC_BIN:                
        
        MOV SI,7
 
        
        MOV AX,NUM
        MOV BL,2
        MOV CX,8
        
 CALCULODB:
 
        DIV BL
        
        MOV RESULT[SI],AH
        DEC SI
        AND AX,0X00FF
        CMP AL,0
        JZ SALIR
        

        LOOP CALCULODB
        

        JMP SALIR
 ;-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_                 
        
                                ;///{ DECIMAL A OCTAL }\\\
 
 DEC_OCTA:
        
        MOV SI,7
                        ;COMPARAMOS SI EL NUMERO ES IGUAL A 0,1,2,3,4,5,6 o 7
        MOV DX,NUM
        
        MOV AX,NUM
        MOV BL,8
        MOV CX,8
        
 CALCULODO:
 
        DIV BL
        
        MOV RESULT[SI],AH
        DEC SI
        AND AX,0X00FF
        CMP AL,0
        
        JZ SALIR
        LOOP CALCULODO
        
                                           
  ;-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_                 
        
                             ;///{ DECIMAL A HEXADECIMAL }\\\
 
 DEC_HEXA:
 
        MOV SI,3
                        ;COMPARAMOS SI EL NUMERO ES IGUAL A 0,1,2,3,4,5,6 o 7
        
        
        MOV AX,NUM
        MOV BL,16
        MOV CX,7
        
 CALCULODH:
 
        DIV BL

               
        MOV RES_HEXA[SI],AH
        DEC SI
        AND AX,0X00FF
        CMP AL,0
        JZ SALIR
        LOOP CALCULODH
         
       
        
        
        

 ;-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_       
        
                                ;///{ HEXADECIMAL A BINARIO }\\\
 HEXA_BIN:
 JMP SALIR
 ;-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_       
        
                                ;///{ HEXADECIMAL A OCTAL }\\\
 HEXA_OCTA:
 JMP SALIR
 ;-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_       
        
                                ;///{ HEXADECIMAL A DECIMAL }\\\
HEXA_DEC:
JMP SALIR                                                   
               
              
 SALIR:          

 ;*******************************************************************************************
;-------------------------------------------------------------------------------------------

         
         
;return to operating system:
		RET

INICIO ENDP

CODIGO ENDS

END INICIO