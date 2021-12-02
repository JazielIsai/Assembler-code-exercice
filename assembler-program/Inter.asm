TITLE EQUIPO 4,PRACTICA 5                        
DATOS SEGMENT PARA PUBLIC DATA     

TAM           DW  ?          
MATRIZ_A      DB  16    DUP(?) ;MATRIZ A
MATRIZ_B      DB  16    DUP(?) ;MATRIZ B
MAT_RESULT    DB  16    DUP(?)            ;MATRIZ R RESULTANTE
MAT_INTMEDIA  DB  16    DUP(?)            ;MATRIZ PARA ALMACENAR LOSMPRODUCTOS
IndB          DW  ?                       ;INDICE DE LA MATRIZ B
IndR          DW  0                       ;INDICE DE LA MATRIZ RESILTANTE C
IND_FILA     DW  ? 
TAM_MATRIZ_A DB  2     DUP(?) 
TAM_MATRIZ_B DB  2     DUP(?)
CONTA    DB ? 

TEMP DW 0 
IND_MAT_INT DW 0
TEMP_INDICE DW 0

OTR_VAR DW 0    
y3 db 0



;//////////////DIBUJO
EJEY DB 1 
ESPA DB 3
YC DB 8 
JAZ DB 0
         
LK DW 0   
;///////////////////////////////////
;agregadas para esta practica
MF1 db "numero de filas A $",0 
MC1 db "numero de columnas A $",0 
MENSAJEF db "Desea otra matris (1) si (2) no ",0   


MC2 db "numero de columnas B $",0  

TT1 DB 0 ;/  
             ;variables para el acomodo de los numeros de la matriz
TT2 DB 0 ;\ 
TAAMA DB 0  ;tamano total de la matriz A
TAAMB DB 0  ;tamano total de la matriz B
COL1 DB 0 ;columna A
COL2 DB 0 ;columna B
FIL1 DB 0 ;Fila A------ la fila B no se cuenta por ser la misma estructura que el que se hizo con la libreria
TT3  DB 0
COL3 DB 0
FIL3 DB 0

PP DB 0  ;/
            ;variables que guardan los 2 digitos
PP2 DB 0 ;\ 

DECEN DB 0
UNIDAD DB 0  
CENT DB 0
TAAMC DB 0 

MENSSSJA DB "A$" 
MENSSSJB DB "B$"
MENSSSJC DB "C$"    
            
;//////////////////////////////////////////            
MATRIZ_AJ   DB  1,22,3,42,5,62 ;MATRIZ A                          ;PARA- PARAMETRO QUE INDICA QUE EL CODIGO INICIA EN LOS
MATRIZ_BJ    DB  6,5,4,3,2,1 ;MATRIZ B                         ;LIMITES DE UN PARRAFO (DIRECCION DIVISIBLE POR 16 BITS)
MATRIZ_RJ   DB  22,3,42,5 ;MATRIZ R    
    
    ;Variables Nuevas                                             ;PUBLIC- INDICA QUE TODOS LOS SEGMENTOS CON EL MISMO ATRIBUTO
    X DB 3
    Y DB 1
    TempPrint1 DB 0
    TempPrint2 DB 0            
            
            
            


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
      
    
    
    
STAR:
;LImpiar pantalla
MOV AH,06h
MOV AL,0
MOV BH,07
MOV CH,0
MOV CL,0
MOV DH,84H
MOV DL,4AH
INT 10h       

MOV BH,0
MOV DL,0
MOV DH,0
MOV AH,02
INT 10h  

             

MOV TT1,1
MOV TT2,8     

MOV SI,0 
MOV IndR,0

LLE:     
MOV AH,0
MOV AL, 00H
INT 10H


MOV DX,OFFSET MF1  
MOV AH,9                ;TAMANO DE LA FILA A
INT 21H

MOV AH,1
INT 21H  
SUB AL,30H   
MOV FIL1,AL             ;se coloca en la variable 
MOV TAM_MATRIZ_A[0],AL

MOV AH,0EH
MOV AL,10
INT 10H

MOV AH,0EH
MOV AL,13 
INT 10H


MOV DX,OFFSET MC1  
MOV AH,9
INT 21H 

MOV AH,1                 ;TAMANO DE LA COLUMNA A
INT 21H   
SUB AL,30H         
MOV COL1,AL
MOV TAM_MATRIZ_A[1],AL

 
MOV AL,TAM_MATRIZ_A[0] 
MOV BL,TAM_MATRIZ_A[1]       ;Tamano total de la matriz A
MUL BX 
MOV TAAMA,AL

MOV AH,0EH
MOV AL,10
INT 10H       ;/
                ;salto de linea
              
MOV AH,0EH    ;\
MOV AL,13
INT 10H  


MOV DX,OFFSET MC2 
MOV AH,9
INT 21H 

MOV AH,1                 ;TAMANO DE LA COLUMNA A
INT 21H    
SUB AL,30H 
MOV COL2,AL
MOV TAM_MATRIZ_B[1],AL 
 
MOV CL,TAM_MATRIZ_A[1]
MOV TAM_MATRIZ_B[0],CL 
MOV AL,TAM_MATRIZ_B[0]   ;Tamamo de la Matriz B
MOV BL,TAM_MATRIZ_B[1]
MUL BX 
MOV TAAMB,AL 

MOV AL,COL1
MOV BL,8        ;Tamano de la columna A para su desplazamiento
MUL BX
MOV COL1,AL  

MOV AL,COL2
MOV BL,8         ;Tamano de la columna B para su desplazamiento
MUL BX 
MOV COL2,AL   
MOV AL,TAM_MATRIZ_A[0]
MOV FIL3,AL
MOV AL,TAM_MATRIZ_B[1]
MOV COL3,AL 
MOV AL,FIL3
MOV BX,COL3
MUL BX
MOV TAAMC,AL 
MOV AL,COL3
MOV BX,8
MUL BX
MOV COL3,AL


  

MOV AH,06h
MOV AL,0
MOV BH,07
MOV CH,0
MOV CL,0
MOV DH,84H
MOV DL,4AH
INT 10h       

MOV BH,0
MOV DL,0
MOV DH,0
MOV AH,02
INT 10h  
MOV DX,OFFSET MENSSSJA
MOV AH,9
INT 21H


MOV CL,TAAMA    

;MATRIZ A
LLEN:

MOV AH,2
MOV DH,TT1   ;colocamos las cordenadas
MOV DL,TT2
INT 10h 


MOV AH,0
INT 16H    

MOV AH,0EH
INT 10h       ;colocamos el numero con los comandos de interrupcion

MOV TT3,AL



MOV AH,0
INT 16H               







        
        
        



SUB TT3,30H
MOV AL, TT3
MOV MATRIZ_A[SI],AL
INC SI
ADD TT2,8                ; SE COLOCA EL NUMERO EN LA VARIABLE PARA LA MATRIZ
MOV AL,TT2

CMP AL,COL1
JG INCFIL1

LOOP LLEN

INCFIL1:
MOV TT2,8
ADD TT1,1
LOOP LLEN  

;limpiamos
;MOV AH,06h
;MOV AL,0
;MOV BH,07
;MOV CH,0
;MOV CL,0
;MOV DH,84H
;MOV DL,4AH
;INT 10h       
;
;MOV BH,0
;MOV DL,0
;MOV DH,0
;MOV AH,02
;INT 10h  
            
MOV AH,0EH
MOV AL,10
INT 10H       
                
              
MOV AH,0EH    
MOV AL,13
INT 10H   

MOV AH,0EH
MOV AL,10
INT 10H       
               
ADD TT1,2              
MOV AH,0EH    
MOV AL,13
INT 10H   
MOV DX,OFFSET MENSSSJB
MOV AH,9
INT 21H  

MOV AH,0EH    
MOV AL,13
INT 10H   

MOV AH,0EH
MOV AL,10
INT 10H 

       

MOV CL,TAAMB   
;MOV TT1,4
;MOV TT2,8 
MOV SI,0



;MATRIZ B
LLEN2:
MOV AH,2
MOV DH,TT1
MOV DL,TT2
INT 10h

MOV AH,0
INT 16H    

MOV AH,0EH
INT 10h

MOV TT3,AL
MOV AH,0
INT 16H    



 
           
SUB TT3,30H
MOV AL, TT3


MOV MATRIZ_B[SI],AL
INC SI
ADD TT2,8
MOV AL,TT2

CMP AL,COL2
JG INCFIL2

LOOP LLEN2

INCFIL2:
MOV TT2,8
ADD TT1,1
LOOP LLEN2     



;llenado de la matriz
MOV CL,TAM_MATRIZ_A[1]
MOV TEMP, CL
DEC TEMP   

MOV SI,0              
MOV OTR_VAR,0

MOV AL,TAM_MATRIZ_A[0]
MOV JAZ,AL

WHILE:     
                  
                  CMP JAZ,0
                  JE SIG
                  
                  MOV AX,0
                                        
                  MOV IND_MAT_INT, 0
                  MOV DI,0              ;CARGAMOS 0 EN EL INDICE DI
                                   
                              
                  MOV  AL,TAM_MATRIZ_B[1]  
                  
                  
                  MOV IND_FILA,AX        ;CARGAMOS EL LIMITE DE OPERECIONES 
                  ;MOV IndR,0           ;CARGAMOS UN 0 EN IndR
                        
MULTI1:
                  MOV IndB,DI           ;SE ALMACENO DI EN IndB
                                                          
                    

                     
                     
MULTI2:
                 MOV   AL,MATRIZ_A [SI]    ;CARGAMOS EL PRIMER ELEMENTO DE A Y LO GUARDAMOS EN AL
                 MOV   BL,MATRIZ_B [DI]    ;CARGAMOS  EL PRIMER ELEMENTO DE B
                 MUL   BL             ;HACEMOS LA MULTIPLICACION
                 
                 MOV TEMP_INDICE,SI
                 MOV SI,IND_MAT_INT
                  
                 MOV   MAT_INTMEDIA[SI],AL  ;[SI] ;GUARDAMOS EL RFESULTADO EN LA MATRIZ INTERMEDIA 
                 
                 MOV SI,TEMP_INDICE 
                 
                 MOV AX,0 
                 MOV   AL,TAM_MATRIZ_B[1]
                 
                 ADD   DI,AX          ;SUMADOS UN 3 A DI
                 
                 INC   IND_MAT_INT
                 INC   SI             ;INCREMENTAMOS SI
                 CMP   SI,TEMP           ;COMPARAMOS EL VALOR DE SI CON EL 2
                 JBE   MULTI2          ;SI EL RESULTADO ES 2 VUELVE A HACER LA OPERACION
                
                
                 MOV   AL,MAT_INTMEDIA[0]   ;CARGAMOS EL PRIMER VALOR DE LA MATRIZ INTERMEDIA EN AL
                 ADD   AL,MAT_INTMEDIA[1]   ;SUMAMOS EL SEGUNDO VALOR DE LA MATRIZ INTERMEDIA
                 ADD   AL,MAT_INTMEDIA[2]   ;SUMAMOS EL TERCER VALOR DE LA MATRIZ INTERMEDIA
                 ADD   AL,MAT_INTMEDIA[3]
                       
                 MOV   SI,IndR        ;CARGAMOS EN SI EL INDICE DE LA MATERIA RESULTANTE
                 MOV   MAT_RESULT [SI],AL    ;CARGAMOS EL AL EN LA POCISION SI DE LA MATRIZ MATR
                 INC   IndR           ;INCREMENTAMOS IndR
                           
                 MOV   IND_MAT_INT,0
                 MOV   SI,OTR_VAR           ;CARGAMOS EN EL INDICE SI EL 0
                 MOV   DI,IndB        ;CARGAMOS IndB EN DI
                 INC   DI             ;INCREMENTAMOS DI
                 DEC   IND_FILA        ;DECREMENTAMOS Indfila
                 CMP   IND_FILA,0      ;COMPARAMOS SI Indfils ES IGUAL A 0
                 JA    MULTI1 
                 ;Incrementarlo

                 
                 INC TEMP
                 MOV DL,TEMP
                 MOV SI,TEMP                        ;SI 1,2,4
                 MOV OTR_VAR,DL                     ;   2 3 4
                 ADD DL,TAM_MATRIZ_A[1]
                 MOV TEMP, DL
                 
                 DEC TEMP
                 DEC JAZ
                 
                 CMP   IND_FILA,0 
                 JZ WHILE:  
                 
SIG:                 

;MOV AH,06h
;MOV AL,0
;MOV BH,07
;MOV CH,0
;MOV CL,0
;MOV DH,84H
;MOV DL,4AH
;INT 10h       
;
;MOV BH,0
;MOV DL,0
;MOV DH,0
;MOV AH,02
;INT 10h   

;MOV TT1,4
;MOV TT2,8 

            
  

 
MOV AH,0EH    
MOV AL,13
INT 10H   

MOV AH,0EH
MOV AL,10
INT 10H 



ADD TT1,2              
MOV AH,0EH    
MOV AL,13
INT 10H   
MOV DX,OFFSET MENSSSJC
MOV AH,9
INT 21H  

MOV AH,0EH    
MOV AL,13
INT 10H   

MOV AH,0EH
MOV AL,10
INT 10H 

MOV SI,0 
MOV DX,0  
MOV CL,TAAMC  


;se debe  imprimir caracter por caracter por ser interrupciones
;de modo que separaremos cada numero de la matriz en 2 digitos
; por ejemplo 10 en 1 y 0
;para esto se dividira en 10 la cantidad y se almacenara cada digito en una variable
IMPRC: 
MOV DECEN,0
MOV UNIDAD,0 
MOV CENT,0
MOV AX,0
MOV AL,MAT_RESULT [SI]
CMP AL,100
JAE CENNT
CMP AL,10
JAE DECC 
JMP UNID


CENNT: 
MOV BL,100
DIV BL
MOV CENT,AL 
MOV DECEN,AH 
MOV AX,0
MOV AL,DECEN
MOV BL,10
DIV BL
MOV DECEN,AL
MOV UNIDAD,AH   
JMP IMPRR



DECC: 
MOV BL,10
DIV BL
MOV DECEN,AL 
MOV UNIDAD,AH   
JMP IMPRR




UNID:
MOV UNIDAD,AL
JMP IMPRR   


IMPRR:   
MOV AH,2
MOV DH,TT1   ;colocamos las cordenadas
MOV DL,TT2
INT 10h    


MOV AH,02H 
MOV DL,CENT
ADD DL,30H
INT 21H




MOV AH,02H 
MOV DL,DECEN
ADD DL,30H
INT 21H

MOV AH,02H 
MOV DL,UNIDAD
ADD DL,30H
INT 21H  

INC SI
ADD TT2,8
MOV AL,TT2

CMP AL,COL3
JG INCFIL4

LOOP IMPRC

INCFIL4:
MOV TT2,8
ADD TT1,1
LOOP IMPRC 

MOV SI,0
MOV AH,0EH
MOV AL,10
INT 10H

MOV AH,0EH
MOV AL,13 
INT 10H   

MMK:
MOV AL,MENSAJEF[SI]
CMP AL,0
JE SALIR

MOV AH,0EH
INT 10H
INC SI
JMP MMK



SALIR:
MOV AH,0
INT 16H   
MOV MAT_RESULT[0],0  
MOV MAT_RESULT[1],0  
MOV MAT_RESULT[2],0
MOV MAT_RESULT[3],0
MOV MAT_RESULT[4],0
MOV MAT_RESULT[5],0
MOV MAT_RESULT[6],0
MOV MAT_RESULT[7],0
MOV MAT_RESULT[8],0
MOV MAT_RESULT[9],0
MOV MAT_RESULT[10],0
MOV MAT_RESULT[11],0
MOV MAT_RESULT[12],0
MOV MAT_RESULT[13],0
MOV MAT_RESULT[14],0
MOV MAT_RESULT[15],0


CMP AL, 31H
JE STAR 


            

 RET 
INICIO ENDP                       
       

   

CODIGO ENDS  
   

END INICIO
