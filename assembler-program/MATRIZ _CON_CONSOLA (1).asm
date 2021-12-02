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
Tamano  DW  ?          
MatA    DB  16    DUP(?) ;MATRIZ A
MatB    DB  16    DUP(?) ;MATRIZ B
MatR    DB  16    DUP(?)            ;MATRIZ R RESULTANTE
MatInt  DB  16    DUP(?)            ;MATRIZ PARA ALMACENAR LOSMPRODUCTOS
IndB    DW  ?                       ;INDICE DE LA MATRIZ B
IndR    DW  0                       ;INDICE DE LA MATRIZ RESILTANTE C
Indfila DW  ? 
TAM_MATA DB  2     DUP(?) 
TAM_MATB DB  2     DUP(?)
contador DB ? 

TEMP DW 0 
indMatInter DW 0
TempIndice DW 0

OtraVariable DW 0



                       ;INDICE PARA CUBRIR LOS 3 ELEMENTOS DE CADA FILA


;---------------------------------------------------------------------------------------------------------  
;*********************************************************************************************************
;---------------------------------------------------------------------------------------------------------
  include emu8086.inc
 
     
 
 
 
 
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
       
;---------------------------------------------------------------------------------------------------------  
;*********************************************************************************************************
;---------------------------------------------------------------------------------------------------------            
                MOV AX, 0
                
                
                GOTOXY 0,1
                CALL PTHIS                         
                DB 'Dame tamano de la matriz A',0   
                CALL SCAN_NUM 
                MOV TAM_MATA[0],CL
                GOTOXY 1,2
                CALL PTHIS                        
                DB 'Dame tamano de la matriz A',0 
                CALL SCAN_NUM
                MOV TAM_MATA[1],CL 
                
                ;multiplicacion para sacar cuantos valores tendra la matriz
                
                MOV AL,TAM_MATA[0] 
                MOV BL,CL
                MUL BX  
                
                MOV Tamano, AX
                LEA CX,AX  
                mov contador, 0  
                MOV SI,0 
CICLO_PEDIR_NUMEROS_A:
                 ;contador para mover la insercion de los datos  
                MOV AL,contador
                ADD AL,1   
                MOV contador, AL
                
                
                mov Tamano, CX
                
                
                
                GOTOXY 1,6
                CALL PTHIS  
                DB 'Dame UN NUMERO',0  
                GOTOXY contador,7
                CALL SCAN_NUM 
                MOV MatA[SI],CL
                INC SI
                MOV CX,Tamano
                 
                



LOOP CICLO_PEDIR_NUMEROS_A   


CALL CLEAR_SCREEN                
   ;PEDIR NUMEROS PARA MATRIZ B             
     
        MOV AX, 0
                
                
                ;GOTOXY 0,1
                ;CALL PTHIS                         
                ;DB 'Dame tamano de la matriz B',0   
                ;CALL SCAN_NUM 
                MOV CL,TAM_MATA[1]
                MOV TAM_MATB[0],CL
                ;GOTOXY 1,2
                ;CALL PTHIS                        
                ;DB 'Dame tamano de la matriz B',0 
                ;CALL SCAN_NUM 
                MOV CL,TAM_MATA[0]
                MOV TAM_MATB[1],CL
                
                ;multiplicacion para sacar cuantos alores tendra la matriz
                
                MOV AL,TAM_MATB[0]
                MOV BL,CL
                MUL BX  
                
                MOV Tamano, AX
                LEA CX,AX  
                mov contador, 0  
                MOV SI,0 
CICLO_PEDIR_NUMEROS_B:
                 ;contador para mover la insercion de los datos  
                MOV AL,contador
                ADD AL,1   
                MOV contador, AL
                
                
                mov Tamano, CX
                
                
                
                GOTOXY 1,6
                CALL PTHIS  
                DB 'Dame UN NUMERO',0  
                GOTOXY contador,7
                CALL SCAN_NUM 
                MOV MatB[SI],CL
                INC SI
                MOV CX,Tamano
                 
                



LOOP CICLO_PEDIR_NUMEROS_B     

                  ;MOV AL,TAM_MATA[0]
                  ;MOV BL,TAM_MATA[1]
                  ;CMP AL,BL
                  ;JA SALIR:
                  MOV CL,TAM_MATA[0]
                  MOV TEMP, CL
                  DEC TEMP
                  
                  
                  MOV SI,0          ;CARGAMOS 0 EN EL INDICE SI
                  mov OtraVariable,0  

WHILE:                                    
                  MOV indMatInter, 0
                  
                  MOV DI,0             ;CARGAMOS 0 EN EL INDICE DI 
                  MOV  AL,TAM_MATB[0]
                  MOV Indfila,AX        ;CARGAMOS EL LIMITE DE OPERECIONES 
                  ;MOV IndR,0           ;CARGAMOS UN 0 EN IndR
                        
MULTI1:
                  MOV IndB,DI           ;SE ALMACENO DI EN IndB
                                                          
                    

                     
                     
MULTI2:
                 MOV   AL,MatA[SI]    ;CARGAMOS EL PRIMER ELEMENTO DE A Y LO GUARDAMOS EN AL
                 MOV   BL,MatB[DI]    ;CARGAMOS  EL PRIMER ELEMENTO DE B
                 MUL   BL             ;HACEMOS LA MULTIPLICACION
                 
                 MOV TempIndice,SI
                 MOV SI,indMatInter
                  
                 MOV   MatInt[SI],AL  ;[SI] ;GUARDAMOS EL RFESULTADO EN LA MATRIZ INTERMEDIA 
                 
                 MOV SI,TempIndice
                 
                 MOV AX,0 
                 MOV   AL,TAM_MATB[0]
                 
                 ADD   DI,AX          ;SUMADOS UN 3 A DI
                 
                 INC   indMatInter
                 INC   SI             ;INCREMENTAMOS SI
                 CMP   SI,TEMP           ;COMPARAMOS EL VALOR DE SI CON EL 2
                 JBE   MULTI2          ;SI EL RESULTADO ES 2 VUELVE A HACER LA OPERACION
                
                
                 MOV   AL,MatInt[0]   ;CARGAMOS EL PRIMER VALOR DE LA MATRIZ INTERMEDIA EN AL
                 ADD   AL,MatInt[1]   ;SUMAMOS EL SEGUNDO VALOR DE LA MATRIZ INTERMEDIA
                 ADD   AL,MatInt[2]   ;SUMAMOS EL TERCER VALOR DE LA MATRIZ INTERMEDIA
                
                 MOV   SI,IndR        ;CARGAMOS EN SI EL INDICE DE LA MATERIA RESULTANTE
                 MOV   MatR[SI],AL    ;CARGAMOS EL AL EN LA POCISION SI DE LA MATRIZ MATR
                 INC   IndR           ;INCREMENTAMOS IndR
                           
                 MOV  indMatInter,0
                 MOV   SI,OtraVariable           ;CARGAMOS EN EL INDICE SI EL 0
                 MOV   DI,IndB        ;CARGAMOS IndB EN DI
                 INC   DI             ;INCREMENTAMOS DI
                 DEC   Indfila        ;DECREMENTAMOS Indfila
                 CMP   Indfila,0      ;COMPARAMOS SI Indfils ES IGUAL A 0
                 JA    MULTI1 
                 ;Incrementarlo

                 
                 INC TEMP
                 MOV DL,TEMP
                 MOV SI,TEMP
                 MOV OtraVariable,DL
                 ADD DL,TAM_MATA[0]
                 MOV TEMP, DL
                 
                 DEC TEMP
                 
                 CMP   Indfila,0 
                 JZ WHILE:                   
                 

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




