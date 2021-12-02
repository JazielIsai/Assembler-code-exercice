Title Examen GarcíaBarrón          ;TITULO
     
include 'emu8086.inc'     
     
DATOS SEGMENT PARA PUBLIC DATA
indice  DB 0
TOTAL   DB 0
tempo   DB 0
temp2   DB 0             ;Variable para pasar argumento a la función Muestra
temp3   DB 0             ;Variable para almacenar y recuperar CX al utilizar la directiva   
arreglo DB 20 DUP ('?')  
BIENVENIDA DB "INGRESA LAS MEDIDAS DE TU TRIANGULO :) $ ",0
TRIANGULO_EQUILATERO    DB    "ES UN TRIANGULO EQUILATERO $",0
TRIANGULO_ISOSCELES    DB    "ES UN TRIANGULO ISOSCELES $",0
TRIANGULO_ESCALENO    DB    "ES UN TRIANGULO ESCALENO $",0
MENSAJEPROFE    DB "   ¡PROFE AHI DISCULPE, TIENE QUE CERRAR EL PROGRAMA Y VOLVER ABRIR PARA OTRA OPERACION! :(",0
DATOS ENDS 
 
  
PILA SEGMENT
    DB 64 DUP(0)
PILA ENDS     

CODIGO SEGMENT
INICIO PROC FAR

    ASSUME DS:DATOS,CS:CODIGO, SS:PILA

        PUSH DS
        MOV  AX,0
        PUSH AX
        MOV AX, DATOS
        MOV DS, AX
        MOV ES, AX  


;------------
; LADO 1 DEL TRIANGULO
    MOV DX,OFFSET BIENVENIDA  
    MOV AH,9                
    INT 21H
    MOV AH,1
    INT 21H  
    SUB AL,30H   
    MOV tempo,AL             ;se coloca en la variable 
    MOV arreglo[0],AL     
    MOV AH,0EH
     MOV AL,10
     INT 10H
    ;LADO 1 DEL TRIANGULO
    MOV DX,OFFSET BIENVENIDA 
    MOV AH,9                
    INT 21H   
    MOV AH,1
    INT 21H  
    SUB AL,30H   
    MOV tempo,AL             ;se coloca en la variable 
    MOV arreglo[1],AL
     MOV AH,0EH
     MOV AL,10
     INT 10H
    ;LADO 3 DEL TRIANGULO
    MOV DX,OFFSET BIENVENIDA  
    MOV AH,9                
    INT 21H
    MOV AH,1
    INT 21H  
    SUB AL,30H   
    MOV tempo,AL             ;se coloca en la variable 
    MOV arreglo[2],AL 
    MOV AH,0EH
     MOV AL,10
     INT 10H
  
     ;//Inicializamos los índices del arreglo en 0
    MOV		SI, 0          
    MOV		DI, 0 
    MOV		AL, 0
    MOV		BL, 0
    MOV		CL, 0
    MOV     CX, indice  
    
    LEA     SI, arreglo
    MOV     AX, 0          ;//EAX se usa como contador 

    ;PROBABLE 
    MOV     AL, [SI] ;OBTENEMOS EL VALOR DE LA POSICION DEL ARREGLO - SI
    ADD     SI, 1     ;CAMBIAMOS DE POSICIÓN EN ESI DEL ARREGLO
    MOV     BL, [SI] ;OBTENEMOS EL VALOR DE LA POSICIÓN DEL ARREGLO DE SI
    CMP     AL, BL    ;COMPARAMOS LOS LADOS DEL TRIANGULO
    JE      ISOSCELES   ;SI SON IGUALES SALTAMOS A LA ETIQUETA ISOSCLES COMO UN PROBABLE
    JNE     ESCALENO 
    

EQUILATERO: ;TRES LADOS IGUALES
  
    ADD     SI, 1
    MOV     Cl,[SI]
    CMP     Cl, Al
    JNZ     ISOSCELES
    ;MANDAR A IMPRIMIR QUE ES UN TRIANGULO EQUILATERO
    MOV     DX, OFFSET TRIANGULO_EQUILATERO ;Cargamos en EDX la dirección de inicio del arreglo del mensaje
    JZ IMPRIME1

ESCALENO:
   
    ADD     SI, 1;8
    MOV     Cl,[SI]
    CMP     Cl, Bl
    JZ      ISOSCELES
    CMP     Al, Bl
    JZ      ISOSCELES 
    CMP     Al, Cl
    JZ      ISOSCELES    
    ;MANDAR A IMPRIMIR QUE ES UN TRIANGULO ESCALENO
    MOV     Dl, OFFSET TRIANGULO_ESCALENO ;Cargamos en EDX la dirección de inicio del arreglo del mensaje
    JNZ IMPRIME1

ISOSCELES:
    ;MANDAR A IMPRIMIR QUE ES UN TRIANGULO ISOSCELES
     MOV     Dl, OFFSET TRIANGULO_ISOSCELES ;Cargamos en EDX la dirección de inicio del arreglo del mensaje
    JNZ IMPRIME1

IMPRIME1:
   
 MOV AH,9                
 INT 21H
    
    RET                         ; Por cada punto de salida en el procedimiento se debe incluir 
                         ; Indicamos el fin de procedimiento Inicio
INICIO  ENDP        
CODIGO ENDS
END INICIO