;Realizar mutiplicacion de matrices, que consiste en tener dos arreglos que el primer arreglo de la primera
;fila multiplicara a todas las columnas del segundo arreglo, para poder guardar así los resultados
;en un tercer arreglo que almacenara todos los resultados de dichas multiplicaciones y esto es
;para que principalmente sean desarrolladas las habilidades, como la lógica, el dominio del
;lenguaje ensamblador, y para así poder correrlo en el emulador.


DATOS SEGMENT PARA PUBLIC DATA 
    
;-------------------------------------------------------------------------------------------
;*******************************************************************************************
      ;Declarendo tanto los arreglos como las varibles
MATA DB 1,2,3,4
MATB DB 4,3,2,1
MATR DB       4 DUP (?)
MatInt DB     4 DUP (?)
IndB  DW       ?
IndR  DW        ?
Indfila DW       ?


;*******************************************************************************************
;-------------------------------------------------------------------------------------------

DATOS ENDS 
 
 
 ;Libreria para trabajar con pilas en asambler
PILA SEGMENT PARA STACK 'STACK'
    DB 64 DUP('STACK')     
PILA ENDS        

;Inicio de programa
CODIGO SEGMENT PARA PUBLIC 'CODE'
INICIO PROC FAR     
 ASSUME DS:DATOS, CS:CODIGO, SS:PILA

    ;Inicio de pila
    PUSH DS
    ;inicio de registo en 0
    MOV AX,0
    PUSH AX
    ;Indicamos a los registros DS y ES las variables que usaremos y estan en data
    MOV AX, DATOS
    MOV DS, AX
    MOV ES, AX    
            
            
            ;Inicio
    
    MOV SI,0    ;iniciamos nuestro indice de registro en 0
    MOV DI,0       
    MOV Indfila,2 ;Se cargan los primeros datos para 4 Filas
    MOV IndR,0


;Etiqueta MULT le da la ubicacion al salto que realizara JA
MULT:
    MOV IndB,DI   ;Se carga Di en IndB
                                        
;Etiqueta MULT2 le da la ubicacion al salto que realizara JBE
MULT2:

    MOV AL,MATA[SI]    ;Se carga el primer elemento de MatrisA en AL
    MOV BL,MATB[DI]    ;Se carga el segundo elemento de MatrisB en BL 
    ;add al,3
    MUL BL             ;Se realiza la multiplicacion con BL 
    MOV MatInt[SI],AL  ;Se guarda el resultado en la matris intermedia 
    ADD DI,2           ;Se agrega un 4 a DI
    INC SI             ;Se incrementa S1 
    CMP SI,1           ;Se compara SI con 2
    JBE MULT2          ;Bucle que se acabara cuando se llegue a la 4ta multiplicacion 
    ;JBE si es menor o igual salta, si y solo si es mayor no salta y sigue con la ejecuion del programa

    ;Suma de los datos resultantes y almacenados en AL
    MOV AL,MatInt[0]   
    ADD AL,MatInt[1]    
    ADD AL,MatInt[2]    
    ADD AL,MatInt[3]       

    ;EL indice en IndR lo pasamos a el indece de regristo
    MOV SI,IndR        
    ;add si,4
    
    
    MOV MatR[SI],AL    ;Se pasa elemento de AL a MatR
    INC IndR           ;Se incrementra IndR para guardar en la siguente pocicion

    MOV SI,0           ;Se carga SI con 0
    MOV DI,IndB        ;Se carga DI con IndB
    INC DI             ;Aumento en DI para la siguiente posicion
    DEC Indfila        ;Decrementamos la fila para saber cuatos calculos quedan
    CMP Indfila,0      ;Se compara la IndFila si es 0
    JA MULT            ;Bucle que se caba cuando IndFila es 0
    ;SALTA JA A MULT, MIENTRAS NO SE ACTIVE LA BANDERA


    ;Se cargan los valores primarios de nuevo para continuar con la siguiente fila 
    MOV SI,0        
    MOV DI,0
    MOV Indfila,2
    MOV IndR,0    
    
    MOV MATINT[0],0
    MOV MATINT[1],0
    MOV MATINT[2],0
    MOV MATINT[4],0 

;Etiqueta MULT le da la ubicacion al salto que realizara JA
MULT3:
    MOV IndB,DI                    

;Etiqueta MULT2 le da la ubicacion al salto que realizara JBE
    mov si,2
MULT4:
    MOV AL,MATA[SI]
    MOV BL,MATB[DI] 
    ;add al,1
    dec si
    dec si
                  ;Recorre a la siguiente fila de la MatA Fila2 
    MUL BL
    MOV MatInt[SI],AL
    ADD DI,2
    
    inc si
    inc si
    
    INC SI
    CMP SI,3
    JBE MULT4

    ;Se realizan las suma que se guarda en AL
    MOV AL,MatInt[0]    
    ADD AL,MatInt[1]
    ADD AL,MatInt[2]    
    ADD AL,MatInt[3]       

    ;pasamos los indices a SE 
    MOV SI,IndR      
    add si,2           ;Sigueinte fila de la MatRes Fila 2 

    ;Pasamos el resultado de la suma en la Matriz R
    MOV MatR[SI],AL
    INC IndR
    
    ;En este bloque de codigo, vamos a verificar si hemos 
    ;terminado de hacer todas las operaciones correspondientes
    ;a la fila de la matriz, sino salta a MUL3
    MOV SI,0
    MOV DI,IndB
    INC DI
    DEC Indfila
    CMP Indfila,0
    JA MULT3      

RET

INICIO ENDP

CODIGO ENDS

END INICIO
