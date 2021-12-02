TITLE IMPRIMEMATRIZOrdenada


                      ;SEGMENT-PSEUDO OPERADOR QUE NO GENERA CODIGO MAQUINA
DATOS SEGMENT PARA PUBLIC DATA
    
    MATRIZ_A    DB  1,22,3,42,5,62 ;MATRIZ A                                                 ;PARA- PARAMETRO QUE INDICA QUE EL CODIGO INICIA EN LOS
    MATRIZ_B    DB  6,5,4,3,2,1 ;MATRIZ B                                             ;LIMITES DE UN PARRAFO (DIRECCION DIVISIBLE POR 16 BITS)
    
    ;Variables Nuevas                                             ;PUBLIC- INDICA QUE TODOS LOS SEGMENTOS CON EL MISMO ATRIBUTO
    X DB 0
    Y DB 0
    TempPrint1 DB 0
    TempPrint2 DB 0
 
     
 
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
    MOV ES, AX                                              ;SE ENCADENARAN JUNTOS
   ;-----------------
   
    MOV SI,0
    MOV AX,0
    MOV X,2 ;FILAS
    MOV Y,2 ;COLUMAS
    
    MOV BL,3;TAM_MATRIZ_A[0] ;COLUMNAS  ;AQUI SE CAMBIA AL TAMANO DE LA MATRIZ EN A

    MOV CL,2;TAM_MATRIZ_A[1] ;FILAS    ;AQUI SE CAMBIA AL TAMAÑO DE LA MATRIZ EN A


    call CLEAR_SCREEN


   MOV TempPrint1,0 
   MOV TempPrint2,0
   
   COLUMNAS:
   FILAS:            

    GOTOXY X,Y
    
    MOV AL,MATRIZ_A[SI]
    CALL PRINT_NUM
    
    ADD X,4          
    
    INC SI           
    INC TempPrint1
    
    CMP BL,TempPrint1  
    JNE COLUMNAS       ;imprime las columnas 
    
    ADD Y,2            
    INC TempPrint2
    MOV TempPrint1,0
    MOV X,2           
    
    CMP CL,TempPrint2
    JNE FILAS          ;imprime las filas
   
   
   
   
   



                
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