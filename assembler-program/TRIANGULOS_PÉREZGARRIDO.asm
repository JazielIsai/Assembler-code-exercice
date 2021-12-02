TITLE EXAMEN_PEREZ_GARRIDO

DATOS SEGMENT PARA PUBLIC DATA
    
    ;Estamos Definiendo las variables por medio de DW (Define World)
INDEX   DB 0
TOTAL   DB 0
FILA    DB 0
temp2   DB 0          
temp3   DB 0
          
COUNT   DB 0

SUMAR_LADOS DB 0
SUMA1 DB 0
SUMA2 DB 0
SUMA3 DB 0

VECTOR  DB 20 DUP ('?')

MSJ_LADO_TRI DB "INGRESE LA MEDIDA DEL LADO DEL TRIANGULO $",0

MSJ_EQUILATERO    DB    "TRIANGULO EQUILATERO $",0
MSJ_ISOSCELES    DB    "TRIANGULO ISOSCELES $",0
MSJ_ESCALENO    DB    "TRIANGULO ESCALENO $",0 
MSJ_TRIANGULOFALSO DB "NO ES UN TRIANGULO $",0
     
    
DATOS ENDS   

include emu8086.inc 

PILA SEGMENT PARA STACK 'STACK'
    
    DB 64 DUP('STACK')  ;DW Sirve para definir una variabe o iniciar un area de memoria 
    
                    ; con DUP generamos 64 repeticiones de la cadena     
PILA ENDS  


CODIGO SEGMENT PARA PUBLIC 'CODE'

INICIO PROC FAR   
    ASSUME DS:DATOS, CS:CODIGO, SS:PILA
    
    PUSH DS
    MOV AX, 0
    PUSH AX
    
    
    MOV AX, DATOS
    MOV DS, AX
    MOV ES, AX 
    
    ;CODIGO DEL PROGRAMA
  
    ;LImpiar pantalla
 ;   MOV AH,06h
;    MOV AL,0
;    MOV BH,07
;    MOV CH,0
;    MOV CL,0
;    MOV DH,84H
;    MOV DL,4AH
;    INT 10h       
;
;    MOV BH,0
;    MOV DL,0
;    MOV DH,0
;    MOV AH,02
;    INT 10h
    
     
    MOV SI,0
    ;LEA SI,VECTOR 
    
PIDE_VALORES:

     
    ;TAMANO DEL LADO 1 DEL TRIANGULO
    MOV DX,OFFSET MSJ_LADO_TRI  
    MOV AH,9                
    INT 21H
    
 
    
    MOV AH,1
    INT 21H  
    SUB AL,30H   
    MOV FILA,AL             ;se coloca en la variable 
    MOV VECTOR[SI],AL
    ADD SI, 1
    CMP SI, 3
    MOV AH,0EH    ;\
    MOV AL,13
    INT 10H
;    MOV AH,0EH
;    MOV AL,10
;    INT 10H 
    JNE PIDE_VALORES          
    
    
        LEA     SI, VECTOR
        MOV     AX, [SI]; [0]
        INC     SI;ADD     SI, 4
        ADD     AX, [SI]; [1]
        INC     SI;ADD     SI, 4
        CMP     AX, [SI]; [0 + 1] , [2]
        JB      NOESTRIANGULO

        LEA     SI, VECTOR
        INC     SI;ADD     SI, 4; [1]
        MOV     AX, [SI]
        INC     SI;ADD     SI, 4; [2]
        ADD     AX, [SI]
        SUB     SI, 2; [0]
        CMP     AX, [SI]; [1 + 2] , [0]
        JB      NOESTRIANGULO

        LEA     SI, VECTOR
        MOV     AX, [SI]; [0]
        ADD     SI, 2
        ADD     AX, [SI]; [2]
        SUB     SI, 1; [1]
        CMP     AX, [SI]; [0 + 2] , [1]
        JB      NOESTRIANGULO              
 
 
 
;    ;SUMAR Y COMPARAR
;    ;MOV  SI,0        
;    MOV  AL,0
;    MOV  BL,0
;    MOV  CL,0
;    MOV  DL,0
;;SUMARVECTOR:
; 
;    MOV  AL,VECTOR[0]    
;    ADD  AL,VECTOR[1]
;    ADD  AL,VECTOR[2]
;    MOV  SUMAR_LADOS,AL
;    
;    MOV  AL,0
;    MOV  AL,VECTOR[0] 
;    ADD  AL,VECTOR[1]
;    MOV  SUMA1, AL
;    
;    ;VERIFICAR SI ES MENOR
;    MOV  BL, SUMAR_LADOS
;    CMP  SUMA1,BL
;    JB  NOTRIANGULO
;    
;                    
;    MOV  AL,0               
;    MOV  AL,VECTOR[0] 
;    ADD  AL,VECTOR[2]
;    MOV  SUMA2, AL
;    MOV  BL, SUMAR_LADOS
;    CMP  SUMA2,BL
;    JNB  NOTRIANGULO
;          
;    MOV  AL,0      
;    MOV  AL,VECTOR[1] 
;    ADD  AL,VECTOR[2]
;    MOV  SUMA3, AL  
;    MOV  BL, SUMAR_LADOS
;    CMP  SUMA3,BL
;    JNB  NOTRIANGULO
    
;COMPARACIONES DE LOS TRIANGULOS PARA VERIFICAR EL TIPO DE TRIANGULO           
    MOV		SI, 0          
    MOV		DI, 0
    MOV     AL,0
    MOV     BL,0
    MOV     CL,0 
    MOV	    CX, INDEX     ;//Cargamosel contador con el indice
    ;SUB	    CX, 1
    ;DEC     INDEX
    LEA     SI, VECTOR    ;//Cargamos en SI la direccion de inicio del arreglo
    MOV     AX, 0         ;//AX se usa como contador 


;VAMOS A TOMAR EN UN TRIANGULO LOS DIFERENTES LADOS
; AX - LADO A
; BX - LADO B
; CX - LADO C
    MOV     AL, [SI] ;OBTENEMOS EL VALOR DE LA POSICION DEL ARREGLO - SI
    ADD     SI, 1     ;CAMBIAMOS DE POSICIÓN EN ESI DEL ARREGLO
    MOV     BL, [SI] ;OBTENEMOS EL VALOR DE LA POSICIÓN DEL ARREGLO DE SI
    CMP     AL, BL    ;COMPARAMOS LOS LADOS DEL TRIANGULO
    JE      ETQ_ISOSCELES   ;SI SON IGUALES SALTAMOS A LA ETIQUETA ISOSCLES COMO UN PROBABLE
    JNE     ETQ_ESCALENO        

ETQ_ISOSCELES:
    ADD     SI, 1
    MOV     CL, [SI]
    CMP     CL, BL
    JE      ETQ_EQUILATERO
    CMP     CL, AL
    JE      ETQ_EQUILATERO

    ;IMPRIME UN TRIANGULO ISOSCELES
    MOV     DX, OFFSET MSJ_ISOSCELES      ;Cargamos en DX la dirección de inicio del arreglo del mensaje
    JNE PRINT
            

ETQ_ESCALENO:   
    ADD     SI, 1      ;8
    MOV     CL,[SI]
    CMP     CL, BL
    JE      ETQ_ISOSCELES
    CMP     AL, BL
    JE      ETQ_ISOSCELES  
    CMP     AL, CL
    JE      ETQ_ISOSCELES  
    ;IMPRIME UN TRIANGULO ESCALENO
    MOV     DX, OFFSET MSJ_ESCALENO ;Cargamos en DX la dirección de inicio del arreglo del mensaje
    JNE PRINT

ETQ_EQUILATERO:             ;TRES LADOS IGUALES
    ;IMPRIME UN TRIANGULO EQUILATERO
    MOV     DX, OFFSET MSJ_EQUILATERO ;Cargamos en DX la dirección de inicio del arreglo del mensaje
    JE PRINT
    
NOESTRIANGULO:
     MOV     DX, OFFSET MSJ_TRIANGULOFALSO ;Cargamos en DX la dirección de inicio del arreglo del mensaje
    JE PRINT
         

PRINT:
     MOV AH,0EH
     MOV AL,10
     INT 10H 
    
     MOV AH,9                
     INT 21H
    
    ;MOV    CX, TOTAL        ;//Recuperamos total de elementos en CX
    ;MOV    SI, 0
    ;LEA    SI, VECTOR

              
    
  
    RET                         ; Por cada punto de salida en el procedimiento se debe incluir 
                                ; una isntruccion de retorno RET
                                ; Indicamos el fin de procedimiento Inicio
INICIO  ENDP        
CODIGO ENDS
        END INICIO