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
cont    DB 0

temporalSI  DW 0 
indMat DW 0
tind  DW 0

Var2  DW 0




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

 
 START: 
  CALL CLEAR_SCREEN
          
    
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
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
                
                
                 
                MOV CL,TAM_MATA[1]
                MOV TAM_MATB[0],CL
              
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
                ADD AL,3   
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

                  
                  MOV CL,TAM_MATA[0]
                  MOV temporalSI, CL
                  DEC temporalSI
                  
                  
                  MOV SI,0          ;CARGAMOS 0 EN EL INDICE SI
                  mov Var2,0  
                  
                  MOV CX,16
                  
CICLO2:                                    
                  MOV indMat, 0
                  
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
                 
                 MOV tind,SI
                 MOV SI,indMat
                  
                 MOV   MatInt[SI],AL  ;[SI] ;GUARDAMOS EL RFESULTADO EN LA MATRIZ INTERMEDIA 
                 
                 MOV SI,tind
                 
                 MOV AX,0 
                 MOV   AL,TAM_MATB[0]
                 
                 ADD   DI,AX          ;SUMADOS UN 3 A DI
                 
                 INC   indMat
                 INC   SI             ;INCREMENTAMOS SI
                 CMP   SI,temporalSI           ;COMPARAMOS EL VALOR DE SI CON EL 2
                 JBE   MULTI2          ;SI EL RESULTADO ES 2 VUELVE A HACER LA OPERACION
                
                
                 MOV   AL,MatInt[0]   ;CARGAMOS EL PRIMER VALOR DE LA MATRIZ INTERMEDIA EN AL
                 ADD   AL,MatInt[1]   ;SUMAMOS EL SEGUNDO VALOR DE LA MATRIZ INTERMEDIA
                 ADD   AL,MatInt[2]   ;SUMAMOS EL TERCER VALOR DE LA MATRIZ INTERMEDIA
                
                 MOV   SI,IndR        ;CARGAMOS EN SI EL INDICE DE LA MATERIA RESULTANTE
                 MOV   MatR[SI],AL    ;CARGAMOS EL AL EN LA POCISION SI DE LA MATRIZ MATR
                 INC   IndR           ;INCREMENTAMOS IndR
                           
                 MOV  indMat,0
                 MOV   SI,Var2           ;CARGAMOS EN EL INDICE SI EL 0
                 MOV   DI,IndB        ;CARGAMOS IndB EN DI
                 INC   DI             ;INCREMENTAMOS DI
                 DEC   Indfila        ;DECREMENTAMOS Indfila
                 CMP   Indfila,0      ;COMPARAMOS SI Indfils ES IGUAL A 0
                 JA    MULTI1 
                 ;Incrementarlo

                 
                 INC temporalSI
                 MOV DL,temporalSI
                 MOV SI,temporalSI
                 MOV Var2,DL
                 ADD DL,TAM_MATA[0]
                 MOV temporalSI, DL
                 
                 DEC temporalSI
                 
                 CMP   Indfila,0 
LOOP CICLO2 
 
 call CLEAR_SCREEN
MOV AL,TAM_MATA[0]
CMP AL,2
JBE CX_2:
CMP AL,4
JBE CX_4: 

CX_2:
                MOV CX,8
                JMP MOSTRAR: 
CX_4:
                MOV CX,16
                JMP MOSTRAR:                 

                  
MOSTRAR:  
                                                    ;DECLARAMOS EL NUMERO DE VECES QUE SE EJECUTARA EL CICLO.
                 MOV SI,0                           ;DECLARAMOS EL TAMAÑO DE LAS VARIABLES QUE VAMOS A UILIZAR PARA IMPRIMIR LOS NUMEROS EN PANTALLA.
                 MOV CONT, 1                        ;DECLARAMOS LA VARIABLE CONTADOR QUE NOS AYUDARA A POSICIONAR EL CURSOR EN PANTALLA.
                 
                 CALL PTHIS                           ;IMPRIMIMOS EN PANTALLA EL MENSAJE QUE INDICARA EL ORDENAMIETNO MAYOR MENOR.
                 DB 'MATRIZ: ',0  
                 
   
 CICLOIMP1:                  ;INICAMOS UN CICLO QUE NOS AYUDARA A IMPRIMIR EL VALOR DE LOS NUMEROS GUARDADOS EN LAS CADENAS.
 
                  GOTOXY 1,CONT                    ;INDICAMOS LA POSICION DE CURSOR CAMBIANDO EN CADA VUELTA EN FUNCION DE LA VARIABLE CONT.
                   MOV AX,0                        ;LIMPIAMOS AX
                   MOV AL, MatR[SI]         ;INDICAMOS LA POSICION DEL ARREGLO EN DONDE DESEAMOS OBTENER EL VALOR.
                 CALL PRINT_NUM                    ;IMPRIMIMOS EL NUMERO EN PANTALLA.
                   
                 INC SI                            ;INCREMENTAMOS SI
                 INC CONT                          ;INCREMENTAMOS LA VARIABLE CONT UTILIZADA PARA ESTABLECER LA POSICON DE EL CURSOR.
                 
LOOP CICLOIMP1                                   ;INDICAMOS QUE SERA UN CICLO.
                           
                          
                MOV CX, 0    ;REINICIAMOS CX
   
                GOTOXY 2,25  ;POSICIONAMOS EL CURSOR.
                CALL PTHIS  ;LLAMAMOS LA INSTRUCCION A IMPRIMIR.                      
                DB '?DESEA INGRESAR OTROS NUMEROS? 1-SI     2-NO',0;IMPRIMIMOS EL MENSAJE EN PANTALLA.
                GOTOXY 2,26  ;POSICIONAMOS EL CURSOR. 
                CALL SCAN_NUM   ;CON ESTA INSTRUCCION ESCANEAMOS EL NUMERO INGRESADO EN PANTALLA.

                CMP CX,1   ;COMPARAMOS SI CX QUE ES EL NUMERO INGRESADO ES IGUAL A 1
                JE START   ;REDIRIGIMOS A LA ETIQUETA START QUE ESTA AL INICIO DEL PROGRAMA Y REINICIA LAS VARIABLES.
                
                CMP CX,2   ;COMPARAMOS SI CX QUE ES EL NUMERO INGRESADO ES IGUAL A 2
                JE FINAL ;REDIRIGIMOS A LA ETIQUETA FINAL QUE MOSTRARA UN MENSAJE DE FIN.
                
 FINAL:         
                CALL CLEAR_SCREEN       ;LIMPIAMOS LA PANTALLA.      
                CALL PTHIS  ;LLAMAMOS LA INSTRUCCION A IMPRIMIR.                      
                DB 'FIN DEL PROGRAMA  :D',0;IMPRIMIMOS EL MENSAJE EN PANTALLA.MOV CX, 0    ;REINICIAMOS CX
   
               
  
  
  
  
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




