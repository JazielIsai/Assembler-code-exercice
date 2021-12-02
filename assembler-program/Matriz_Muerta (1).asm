TITLE EQUIPO 4,PRACTICA 5                        ;SEGMENT-PSEUDO OPERADOR QUE NO GENERA CODIGO MAQUINA
DATOS SEGMENT PARA PUBLIC DATA                                                 ;PARA- PARAMETRO QUE INDICA QUE EL CODIGO INICIA EN LOS
                                                 ;LIMITES DE UN PARRAFO (DIRECCION DIVISIBLE POR 16 BITS)
                                                 ;PUBLIC- INDICA QUE TODOS LOS SEGMENTOS CON EL MISMO ATRIBUTO
                                                 ;SE ENCADENARAN JUNTOS
                                                 ;DATA- LOS SEGMENTOS CON EL MISMO NOMBRE DE CLASE                                         ;EN MEMORIA SECUENCIALMENTE
;---------------------------------------------------------------------------------------------------------  
;*********************************************************************************************************
;---------------------------------------------------------------------------------------------------------
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




;//////////////DIBUJO
EJEY DB 1 
ESPA DB 3
YC DB 8 
JAZ DB 0
         
LK DW 0            
            
            
            
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
    MOV AX, 0   
;---------------------------------------------------------------------------------------------------------  
;*********************************************************************************************************
;---------------------------------------------------------------------------------------------------------            
               REINTENTAR:
               CALL CLEAR_SCREEN
               ;RESTAURAR VARIABLES
                MOV TAM,0
                MOV IndB,0
                MOV IndR,0
                MOV IND_FILA,0 
                MOV TAM_MATRIZ_A,2
                MOV TAM_MATRIZ_B,2
                MOV CONTA,0
                MOV TEMP,0
                MOV IND_MAT_INT,0
                MOV TEMP_INDICE,0
                MOV OTR_VAR,0
                MOV EJEY,1
                MOV ESPA,6
                MOV YC,8
                MOV JAZ,0
                MOV X,3
                MOV Y,1
                MOV TempPrint1,0
                MOV TempPrint2,0 
                MOV LK,0
                
                MOV AX,0
                MOV BX,0
                MOV CX,0
                MOV DX,0
                MOV SI,0
                MOV DI,0
                
               
                GOTOXY 1,1
                CALL PTHIS                         
                DB 'Tamano Columna de la matriz A :',0   
                CALL SCAN_NUM 
                MOV TAM_MATRIZ_A[0],CL
                GOTOXY 1,2
                CALL PTHIS                        
                DB 'Tamano Fila de la matriz A:',0 
                CALL SCAN_NUM
                MOV TAM_MATRIZ_A[1],CL 
                
                
                MOV AL,TAM_MATRIZ_A[0] 
                MOV BL,CL
                MUL BX  
                
                MOV TAM, AX
                LEA CX,AX  
                mov CONTA, 0  
                MOV SI,0 
DATOS_A:
                 
                MOV AL,CONTA
                ADD AL,1   
                MOV CONTA, AL
                
                
                mov TAM, CX
                
                
                
                GOTOXY 1,6
                CALL PTHIS  
                DB 'Ingresa los datos:',0  
                GOTOXY CONTA,7
                CALL SCAN_NUM 
                MOV MATRIZ_A [SI],CL
                INC SI
                MOV CX,TAM
                 
                



LOOP DATOS_A   


CALL CLEAR_SCREEN                

        
                MOV AX, 0
                MOV CL,TAM_MATRIZ_A[0]
                MOV TAM_MATRIZ_B[1],CL
                GOTOXY 1,1
                CALL PTHIS                         
                DB 'Tamano Columna de la matriz B:',0  
                CALL SCAN_NUM
                MOV  TAM_MATRIZ_B[0],CL 
                
                MOV AL,TAM_MATRIZ_B[1]
                MOV BL,CL
                MUL BX  
                
                MOV TAM, AX
                LEA CX,AX  
                mov CONTA, 0  
                MOV SI,0 
DATOS_B:
                  
                MOV AL,CONTA
                ADD AL,1   
                MOV CONTA, AL
                
                
                mov TAM, CX
                
                
                
                GOTOXY 1,6
                CALL PTHIS  
                DB 'Ingresa los datos:',0  
                GOTOXY CONTA,7
                CALL SCAN_NUM 
                MOV MATRIZ_B [SI],CL
                INC SI
                MOV CX,TAM
                 
                



LOOP DATOS_B     
                   
                   
                   


                  ;MOV AL,TAM_MATA[0]
                  ;MOV BL,TAM_MATA[1]
                  ;CMP AL,BL
                  ;JA SALIR:
                  
                  
                        
                        
                  ;////////////////////////////////////
                     


MOV CL,TAM_MATRIZ_A[0]
                  MOV TEMP, CL
                  DEC TEMP

;MOV SI,0 ;CARGAMOS 0 EN EL INDICE SI
;mov OtraVariable,0
MOV SI,0              
MOV OTR_VAR,0

MOV AL,TAM_MATRIZ_A[1]
MOV JAZ,AL
;ADD BL,TAM_MATRIZ_A[1]
;CMP AL,TAM_MATRIZ_A[1]
;JA MAYOR
;JB MENOR 

;MAYOR:
;MOV AX, 0
;MOV AL, TAM_MATRIZ_A[1]        ; 2   3
;MOV BL, TAM_MATRIZ_B[1]        ; 1   2
;MUL BL
;MOV SUMATEMP,AL
;MOV AX,0
;CMP AX,0
;JE MUL_MATRIZ1



;MENOR:
;MOV AX,0
;MOV AL, TAM_MATRIZ_A[1]
;MOV BL, TAM_MATRIZ_B[0]
;MUL BL
;MOV SUMATEMP,AL
;MOV AX,0
;
;MUL_MATRIZ1: 
;
                   
                     
                  ;////////////////////////////////// 
                   
                   
                   
                    
                    

WHILE:     
                  
                  CMP JAZ,0
                  JE SALIR
                  
                  MOV AX,0
                                        
                  MOV IND_MAT_INT, 0
                  MOV DI,0              ;CARGAMOS 0 EN EL INDICE DI
                                   
                              
                  MOV  AL,TAM_MATRIZ_B[0]  
                  
                  
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
                 MOV   AL,TAM_MATRIZ_B[0]
                 
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
                 ADD DL,TAM_MATRIZ_A[0]
                 MOV TEMP, DL
                 
                 DEC TEMP
                 DEC JAZ
                 
                 CMP   IND_FILA,0 
                 JZ WHILE: 
                           
                 
 ;//////////////////MATRIZES_DIBUJO////////////////////// 
                 SALIR:
                 MOV JAZ,0
                 MOV DX,0                
                 ;SOLO A
                 CALL CLEAR_SCREEN
                 GOTOXY 1,1
                 PRINTN 'A' 
                 MOV CL,TAM_MATRIZ_A[1]
                 
                 
                 LIM1A:
                 GOTOXY 2,EJEY
                 PRINTN '|'          
                 DEC CL
                 INC EJEY
                 CMP CL,0
                 JA LIM1A
                         
                  
                 MOV EJEY,1        
                 MOV CL,TAM_MATRIZ_A[0]
                 DEC CL
                 MOV BL,TAM_MATRIZ_A[1]
                 MOV SI,CL
                 DEC SI
                 
                 
                 ;EXEPCION ESPECIAL CL=0
                 CMP CL,0
                 JE CEROA
                 
                 
                 
                 REPITE:
                 ESPACA: 
                 GOTOXY ESPA,EJEY
                 PRINTN '-'
                 ADD ESPA,4
                 DEC CL
                 CMP CL,0
                 JA ESPACA
                 MOV DI,ESPA
                 
                 MOV ESPA,6
                 INC EJEY
                 MOV CL,TAM_MATRIZ_A[0]
                 DEC CL
                 DEC BL
                 CMP BL,0
                 JA REPITE
                 
                 
               
                 MOV ESPA,DI
                 CEROA:
                 MOV EJEY,1
                 MOV CL,TAM_MATRIZ_A[1]
                 
                 LIM2A:
                 GOTOXY ESPA,EJEY
                 PRINTN '|'
                 INC EJEY
                 DEC CL
                 CMP CL,0
                 JA LIM2A
                  
                   
                 MOV SI,0
                 MOV DX,0
                 MOV AX,0
                 MOV BX,0
                 MOV DI,0
                 MOV DX,0
                  
                 ;SOLO B
                 MOV EJEY,1
                 ADD ESPA,3 
                 GOTOXY ESPA,1
                 PRINTN 'B' 
                 MOV CL,TAM_MATRIZ_B[1]
                 ADD ESPA,1
                 MOV DL,ESPA
                 MOV JAZ,DL
                 
                 LIM1B:
                 GOTOXY ESPA,EJEY
                 PRINTN '|'          
                 DEC CL
                 INC EJEY
                 CMP CL,0
                 JA LIM1B
                 
                 MOV EJEY,1       
                 MOV ESPA,DL 
                 ADD ESPA,4 
                 MOV DL,ESPA   
                 MOV CL,TAM_MATRIZ_B[0]
                 DEC CL
                 MOV BL,TAM_MATRIZ_B[1]
                 MOV DI,CL
                 DEC DI 
                         
                         
                 ;EXEPCION ESPECIAL CL=0
                 CMP CL,0
                 JE CEROB
                 
                 
                 REPITEB:
                 ESPACB: 
                 GOTOXY ESPA,EJEY
                 PRINTN '-'
                 ADD ESPA,4
                 DEC CL
                 CMP CL,0
                 JA ESPACB
                 MOV SI,ESPA
                 
                 MOV ESPA,DL
                 INC EJEY
                 MOV CL,TAM_MATRIZ_B[0]
                 DEC CL
                 DEC BL
                 CMP BL,0
                 JA REPITEB
                 
                 
                 
                 
                 MOV ESPA,SI  
                 CEROB:
                 MOV EJEY,1
                 MOV CL,TAM_MATRIZ_B[1]
                 
                 LIM2B:
                 GOTOXY ESPA,EJEY
                 PRINTN '|'
                 INC EJEY
                 DEC CL
                 CMP CL,0
                 JA LIM2B



                 MOV ESPA,6
                 
                 ;SOLO C
                 GOTOXY 1,YC
                 PRINTN 'C' 
                 MOV CL,TAM_MATRIZ_A[1]
                 
                 
                 LIM1C:
                 GOTOXY 2,YC
                 PRINTN '|'          
                 DEC CL
                 INC YC
                 CMP CL,0
                 JA LIM1C
                         
                  
                 MOV YC,8                               
                 MOV CL,TAM_MATRIZ_B[0]             
                 DEC CL                             
                 MOV BL,TAM_MATRIZ_A[1]                
                 MOV SI,CL
                 DEC SI
                 
                 
                 ;EXEPCION ESPECIAL CL=0
                 CMP CL,0
                 JE CEROC
                 
                 
                 
                 REPITEC:
                 ESPACC: 
                 GOTOXY ESPA,YC
                 PRINTN '-'
                 ADD ESPA,4
                 DEC CL
                 CMP CL,0
                 JA ESPACC
                 MOV DI,ESPA
                 
                 MOV ESPA,6
                 INC YC
                 MOV CL,TAM_MATRIZ_B[0]
                 DEC CL
                 DEC BL
                 CMP BL,0
                 JA REPITEC
                 
                 
               
                 MOV ESPA,DI
                 CEROC:
                 MOV YC,8
                 MOV CL,TAM_MATRIZ_A[1]
                 
                 LIM2C:
                 GOTOXY ESPA,YC
                 PRINTN '|'
                 INC YC
                 DEC CL
                 CMP CL,0
                 JA LIM2C
                             
                            
                 
                 
                 
   MOV SI,0
   MOV AX,0
   
   MOV BL,TAM_MATRIZ_A[0] 

   MOV CL,TAM_MATRIZ_A[1]              
   ;A           
   MOV TempPrint1,0 
   MOV TempPrint2,0
   
   COLUMNAS:
   FILAS:            

    GOTOXY X,Y;///ACOMODAR
    
    MOV AL,MATRIZ_A[SI]
    CALL PRINT_NUM
    
    ADD X,4          
    
    INC SI           
    INC TempPrint1
    
    CMP BL,TempPrint1  
    JNE COLUMNAS       ;imprime las columnas 
    
    ADD Y,1 ;////ACOMODAR           
    INC TempPrint2
    MOV TempPrint1,0
    MOV X,3;////ACOMODAR           
    
    CMP CL,TempPrint2
    JNE FILAS          ;imprime las filas     
    
    
    
   MOV SI,0
   MOV DX,0
   MOV DI,0
   MOV AX,0 
   
   MOV DI,JAZ
   INC DI
   MOV X,DI
   MOV Y,1
   
   MOV BL,TAM_MATRIZ_B[0] 

   MOV CL,TAM_MATRIZ_B[1]              
   ;A           
   MOV TempPrint1,0 
   MOV TempPrint2,0
   
   COLUMNASB:
   FILASB:            

    GOTOXY X,Y;///ACOMODAR
    
    MOV AL,MATRIZ_B[SI]
    CALL PRINT_NUM
    
    ADD X,4          
    
    INC SI           
    INC TempPrint1
    
    CMP BL,TempPrint1  
    JNE COLUMNASB       ;imprime las columnas 
    
    ADD Y,1 ;////ACOMODAR
    MOV DL,Y          
    INC TempPrint2
    MOV TempPrint1,0
    MOV X,DI;////ACOMODAR
    MOV Y,DL   
          
    
    CMP CL,TempPrint2
    JNE FILASB          ;imprime las filas 
    
    
    
   MOV SI,0
   MOV DX,0
   MOV DI,0
   MOV AX,0 
   MOV X,3
   MOV YC,8  
   MOV BL,TAM_MATRIZ_B[0] 
   MOV CL,TAM_MATRIZ_A[1]              
   
   ;A           
   MOV TempPrint1,0 
   MOV TempPrint2,0
   
   COLUMNASC:
   FILASC:            

    GOTOXY X,YC;///ACOMODAR
    
    MOV AL,MAT_RESULT[SI]
    CALL PRINT_NUM
    
    ADD X,4          
    
    INC SI           
    INC TempPrint1
    
    CMP BL,TempPrint1  
    JNE COLUMNASC       ;imprime las columnas 
    
    ADD YC,1 ;////ACOMODAR           
    INC TempPrint2
    MOV TempPrint1,0
    MOV X,3;////ACOMODAR           
    
    CMP CL,TempPrint2
    JNE FILASC          ;imprime las filas 
               
    MOV CL,0
      
    
    GOTOXY 1,14  
    CALL PTHIS 
    DB '1)BURBUJA o 2)SALIR:',0  
    CALL SCAN_NUM
    CMP CL,2
    JE  SALIDA
    
    
    call clear_screen 
    
    
    ELEGIR: 
    MOV YC,0
    mov cx,0 
    MOV AL,TAM_MATRIZ_B[0] 
    MOV BL,TAM_MATRIZ_A[1]
    MUL BL
    MOV LK,AL
    dec LK         
    gotoxy 1,1
    call pthis
    db 'Presiona (1) para Menor a Mayor o (2) para Mayor a menor o (3) Salir: ',0  
    
    call scan_num
    mov YC,cx
    cmp YC,1
    je  ETIC_MEN
    cmp YC,2
    JE ETIC_MEY 
    CMP YC,3
    JE  SALIDA1
    
    
    ETIC_MEN: 
    call kk   
    
    ETIC_MEY:
    call kk2
    
    s:
    mov di,0  
    mov ax,0
    MOV EJEY,2
    MOV JAZ,1 
    call clear_screen 
    GOTOXY 1,EJEY
    PRINTN 'MENOR A MAYOR ES: '  
    add EJEY,5
    
    
  
   
    imprc:
    mov al,MAT_RESULT[di]
    GOTOXY JAZ,3
    CALL PRINT_NUM_UNS
    add JAZ,4
    inc di
    cmp di,LK
    jbe imprc
    JMP ELEGIR  
    
    
    
    s2:
    mov di,0  
    mov ax,0
    MOV EJEY,2
    MOV JAZ,1 

    GOTOXY 1,EJEY
    PRINTN 'MAYOR A MENOR ES: '  
    add EJEY,5
    jmp imprc2
  
  
   
    imprc2:
    mov al,MAT_RESULT[di]
    GOTOXY JAZ,3
    CALL PRINT_NUM_UNS
    add JAZ,4
    inc di
    cmp di,LK
    jbe imprc2
    JMP ELEGIR
     
     
                
    GOTOXY 1,6  
    CALL PTHIS 
    DB '1)REINTENTAR o 2)SALIR:',0  
    CALL SCAN_NUM
    CMP CL,1
    JE REINTENTAR 
    
    
    
    
                                   
                 

 ;---------------------------------------------------------------------------------------------------------  
;*********************************************************************************************************
;---------------------------------------------------------------------------------------------------------            
  SALIDA: 
  SALIDA1:
      call clear_screen         
                
                RET 
INICIO ENDP                       
       
 
kk proc

   MENOR:

   MOV CX,LK
   MOV SI,0
   MOV DI,0


   CICLO:
   PUSH CX
   LEA SI,MAT_RESULT
   MOV DI,SI
   
   CICLO2:
   INC DI
   MOV AL,[SI]
   CMP AL,[DI]
   JA INTERC
   JB MEN


   INTERC:
   MOV AH,[DI]
   MOV [DI],AL
   MOV [SI],AH

   MEN:
   INC SI
   LOOP CICLO2
   POP CX
   LOOP CICLO
   jmp s   
   
   
   
   kk2 proc

   Mayor:

   MOV CX,LK
   MOV SI,0
   MOV DI,0


   CICLO3:
   PUSH CX
   LEA SI,MAT_RESULT
   MOV DI,SI
   
   CICLO4:
   INC DI
   MOV AL,[SI]
   CMP AL,[DI]
   Jb INTERC2
   Ja MEy


   INTERC2:
   MOV AH,[DI]
   MOV [DI],AL
   MOV [SI],AH

   MEy:
   INC SI
   LOOP CICLO4
   POP CX
   LOOP CICLO3
   jmp s2          
   
   
   

 
 
DEFINE_SCAN_NUM
DEFINE_PRINT_STRING
DEFINE_PRINT_NUM 
DEFINE_PRINT_NUM_UNS
DEFINE_PTHIS
DEFINE_CLEAR_SCREEN 





CODIGO ENDS  
   

END INICIO




