TITLE EQUIPO 2,PRACTICA 5                        ;SEGMENT-PSEUDO OPERADOR QUE NO GENERA CODIGO MAQUINA
DATOS SEGMENT PARA PUBLIC DATA                                                 ;PARA- PARAMETRO QUE INDICA QUE EL CODIGO INICIA EN LOS
                                                 ;LIMITES DE UN PARRAFO (DIRECCION DIVISIBLE POR 16 BITS)
                                                 ;PUBLIC- INDICA QUE TODOS LOS SEGMENTOS CON EL MISMO ATRIBUTO
                                                 ;SE ENCADENARAN JUNTOS
                                                 ;DATA- LOS SEGMENTOS CON EL MISMO NOMBRE DE CLASE 
                                                 ;EN MEMORIA SECUENCIALMENTE
;---------------------------------------------------------------------------------------------------------  
;*********************************************************************************************************
;---------------------------------------------------------------------------------------------------------
TAM  DW  ?          
MATRIZ_A    DB  16    DUP(?) ;MATRIZ A
MATRIZ_B    DB  16    DUP(?) ;MATRIZ B
MAT_RESULT   DB  16    DUP(?)            ;MATRIZ R RESULTANTE
MAT_INTMEDIA  DB  16    DUP(?)            ;MATRIZ PARA ALMACENAR LOSMPRODUCTOS
IndB    DW  ?                       ;INDICE DE LA MATRIZ B
IndR    DW  ?                       ;INDICE DE LA MATRIZ RESILTANTE C
IND_FILA DW  ? 
TAM_MATRIZ_A DB  2     DUP(?) 
TAM_MATRIZ_B DB  2     DUP(?)
CONTA DB ?



                       ;INDICE PARA CUBRIR LOS 3 ELEMENTOS DE CADA FILA


;---------------------------------------------------------------------------------------------------------  
;*********************************************************************************************************
;---------------------------------------------------------------------------------------------------------   
DATOS ENDS 
 
include emu8086.inc 
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
    MOV AX, 0   
;---------------------------------------------------------------------------------------------------------  
;*********************************************************************************************************
;---------------------------------------------------------------------------------------------------------             
                
                GOTOXY 1,1
                CALL PTHIS                         
                DB 'Tamano Columna de la matriz A:',0   
                CALL SCAN_NUM 
                MOV TAM_MATRIZ_A[0],CL
                GOTOXY 1,2
                CALL PTHIS                        
                DB 'Tamano Fila de la matriz A:',0 
                CALL SCAN_NUM
                MOV TAM_MATRIZ_A[1],CL 
                
                ;multiplicacion para sacar cuantos alores tendra la matriz
                
                MOV AL,TAM_MATRIZ_A[0] 
                MOV BL,CL
                MUL BX  
                
                MOV TAM, AX
                LEA CX,AX  
                mov CONTA, 0  
                MOV SI,0 
DATOS_A:
                 ;contador para mover la insercion de los datos  
                MOV AL,CONTA
                ADD AL,1   
                MOV CONTA, AL
                
                
                mov TAM, CX
                
                
                
                GOTOXY 1,6
                CALL PTHIS  
                DB 'Ingresa los datos:',0  
                GOTOXY CONTA,7
                CALL SCAN_NUM 
                MOV MATRIZ_A[SI],CL
                INC SI
                MOV CX,TAM
                 
                



LOOP DATOS_A   


CALL CLEAR_SCREEN                
   ;PEDIR NUMEROS PARA MATRIZ B             
     
        MOV AX, 0
                
                
                GOTOXY 1,1
                CALL PTHIS                         
                DB 'Tamano Columna de la matriz B:',0   
                CALL SCAN_NUM 
                MOV TAM_MATRIZ_B[0],CL
                GOTOXY 1,2
                CALL PTHIS                        
                DB 'Tamano Fila de la matriz B:',0 
                CALL SCAN_NUM 
                MOV TAM_MATRIZ_B[1],CL
                
                ;multiplicacion para sacar cuantos alores tendra la matriz
                
                MOV AL,TAM_MATRIZ_B[0]
                MOV BL,CL
                MUL BX  
                
                MOV TAM, AX
                LEA CX,AX  
                mov CONTA, 0  
                MOV SI,0 
DATOS_B:
                 ;contador para mover la insercion de los datos  
                MOV AL,CONTA
                ADD AL,1   
                MOV CONTA, AL
                
                
                mov TAM, CX
                
                
                
                GOTOXY 1,6
                CALL PTHIS  
                DB 'Ingresa los datos:',0  
                GOTOXY CONTA,7
                CALL SCAN_NUM 
                MOV MATRIZ_B[SI],CL
                INC SI
                MOV CX,TAM
                 
                



LOOP DATOS_B     

                                    
                  MOV SI,0             ;CARGAMOS 0 EN EL INDICE SI
                  MOV DI,0             ;CARGAMOS 0 EN EL INDICE DI 
                  MOV   AL,4
                  MOV IND_FILA,AX        ;CARGAMOS EL LIMITE DE OPERECIONES 
                  MOV IndR,0           ;CARGAMOS UN 0 EN IndR
                        
MULTI1:
                  MOV IndB,DI           ;SE ALMACENO DI EN IndB
                                                          
                    

                     
                     
MULTI2:
                 MOV   AL,MATRIZ_A[SI]    ;CARGAMOS EL PRIMER ELEMENTO DE A Y LO GUARDAMOS EN AL
                 MOV   BL,MATRIZ_B[DI]    ;CARGAMOS  EL PRIMER ELEMENTO DE B
                 MUL   BL             ;HACEMOS LA MULTIPLICACION 
                 MOV   MAT_INTMEDIA[SI],AL  ;GUARDAMOS EL RFESULTADO EN LA MATRIZ INTERMEDIA 
                 MOV AX,0 
                 MOV   AL,TAM_MATRIZ_B[0]
                 
                 ADD   DI,AX          ;SUMADOS UN 3 A DI
                 INC   SI             ;INCREMENTAMOS SI
                 CMP   SI,2           ;COMPARAMOS EL VALOR DE SI CON EL 2
                 JBE   MULTI2          ;SI EL RESULTADO ES 2 VUELVE A HACER LA OPERACION
                
                
                 MOV   AL,MAT_INTMEDIA[0]   ;CARGAMOS EL PRIMER VALOR DE LA MATRIZ INTERMEDIA EN AL
                 ADD   AL,MAT_INTMEDIA[1]   ;SUMAMOS EL SEGUNDO VALOR DE LA MATRIZ INTERMEDIA
                 ADD   AL,MAT_INTMEDIA[2]   ;SUMAMOS EL TERCER VALOR DE LA MATRIZ INTERMEDIA
                
                 MOV   SI,IndR        ;CARGAMOS EN SI EL INDICE DE LA MATERIA RESULTANTE
                 MOV   MAT_RESULT[SI],AL    ;CARGAMOS EL AL EN LA POCISION SI DE LA MATRIZ MATR
                 INC   IndR           ;INCREMENTAMOS IndR
                           
                 MOV   SI,0           ;CARGAMOS EN EL INDICE SI EL 0
                 MOV   DI,IndB        ;CARGAMOS IndB EN DI
                 INC   DI             ;INCREMENTAMOS DI
                 DEC   IND_FILA        ;DECREMENTAMOS Indfila
                 CMP   IND_FILA,0      ;COMPARAMOS SI Indfils ES IGUAL A 0
                 JA    MULTI1
                                    
                 

 ;---------------------------------------------------------------------------------------------------------  
;*********************************************************************************************************
;---------------------------------------------------------------------------------------------------------            
                            
                 
                
                RET

INICIO ENDP 

DEFINE_SCAN_NUM
DEFINE_PRINT_STRING
DEFINE_PRINT_NUM 
DEFINE_PRINT_NUM_UNS
DEFINE_PTHIS
DEFINE_CLEAR_SCREEN 





CODIGO ENDS

END INICIO




