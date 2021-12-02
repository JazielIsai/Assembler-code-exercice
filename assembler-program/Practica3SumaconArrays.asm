Title Practica 3          ;TITULO

DATOS SEGMENT PARA PUBLIC 'DATA'

SEGMENTO1 DB 1d,2d,3d,4d,5d,6d,7d,8d,9d  ;DECLARAMOS LOS TRES SEGMENTOS 
SEGMENTO2 DB 1d,2d,3d,4d,5d,6d,7d,8d,9d  ;Declaramos el vector

SEGMENTO3 DB 9 DUP(?)     ;Declaramos el vector con el mismo valor de ? duplicado 10 veces

NUMERO DW 9               ;Definimos variables de tipo palabra
SCORE  DB 0                ; definimos variables que podemos usar de tipo byte
TEMP   DB 0
 
;SEGMENTO3 DB 8 DUP ('?')  


DATOS ENDS 
PILA SEGMENT PARA STACK 'STACK'
    DB 64 DUP('STACK')     
PILA ENDS
CODIGO SEGMENT PARA PUBLIC 'CODE'
INICIO PROC FAR
    PUSH DS
    MOV AX,0
    PUSH AX
    MOV AX, DATOS
    MOV DS, AX
    MOV ES, AX 
;-----------------------
MOV CX, NUMERO                ; a Cx le damos el valor de numero que es 0
;MOV SI, OFFSET SEGMENTO1     ; obtiene la direccion de los segmentos
;MOV BX, OFFSET SEGMENTO2
;MOV DI, OFFSET SEGMENTO3
LEA SI, SEGMENTO1   ;         ; obtenemos la primera direccion del array en SI
LEA BX, SEGMENTO2             ; obtenemos la primera direccion del array en DI
LEA DI, SEGMENTO3             ; obtenemos la primera direccion del array en BI
        
MOV SCORE, 0

    ;MOV DI, SEGMENTO3
    
REPITE:

;XOR AX,AX                    
                              
;MOV SEGMENTO3[SCORE], [SI]   
;ADD AL, SEGMENTO3[SI]        ;sumamos a AL = AL + lo que contenga la direccion del array que esta apuntando
;MOV SEGMENTO3[SCORE], [DI]
;ADD AL, SEGMENTO3[DI]        ;sumamos a AL = AL + lo que contenga la direccion del array que esta apuntando
;MOV [BX], AL;SUMA[SCORE]

                              
;MOV AL, +[SI]                ;Pasamos por medio de una suma a AL, el contenido a la direccion que apunta SI
;ADD AL, +[DI]                ;Sumamos lo que ya contenia AL mas el contenido a la direccion que apunta DI
;MOV [BX],AL                  ; Finalmente accemos una transiccion de la suma la pasamos a la direccion a la que apunta BX que serian en las posiciones del SEGMENTO3



;MOV AL,[SI]
;MOV [DI],AL

MOV AL,[SI];SEGMENTO1[0];     ;Pasamos el contenido a la que esta apuntando a SI a AL
MOV SCORE,AL                  ;para verificar la direccion que se paso a AL 
                              ;simplemente agregamos una variable SCORE que obtedra el valor que tiene AL
MOV AL,[BX];SEGMENTO2[0]; 
ADD AL,SCORE                  ;Hacemos la suma, lo que SCORE vale mas lo que ahora vale AL a partir del valor dado por SI
MOV [DI],AL                   ;Pasamos el valor a la direccion que apunta DI que seria al segmento
          
          
                               ;Incrementamos
INC SI 
INC DI
INC BX
;INC SCORE
DEC CX                           ;Derementamos

JNZ REPITE                   ; hacemos un ciclo hasta que la bandera nos lo indique cambindo de valor

;LOOP REPITE                 ; hacemos un ciclo
    
RET  
INICIO ENDP
CODIGO ENDS
END INICIO
                          
                          
