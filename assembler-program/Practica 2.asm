TITLE PRACTICA2

DATOS SEGMENT
    
    A   DW  0           ;Estamos Definiendo las variables por medio de DW (Define World)
    B   DW  300
    C   DW  200
    D   DW  200
    E   DW  150
    F   DW  100
    G   DW  80
    H   DW  70
    I   DW  60
    J   DW  50
    
DATOS ENDS

PILA SEGMENT
    
    DW  64  DUP(0)  ;DW Sirve para definir una variabe o iniciar un area de memoria 
    
                    ; con DUP generamos 64 repeticiones de la cadena     
PILA ENDS  


CODIGO SEGMENT

INICIO PROC FAR
    
    PUSH DS
    MOV AX, 0
    PUSH AX
    
    
    MOV AX, DATOS
    MOV DS, AX
    
    
    ;CODIGO DEL PROGRAMA
    
    MOV     BX, OFFSET A        ; Vamos a obtener la direccion de A
    MOV     SI, 4               ; Cargamos a SI un 4
    MOV     AX, [BX + SI]       ; AX recibe la direccion de BX + S1 seria 0 + 4 = 4, 
                                ; Entonces AX = obtendria la direccion de C
    MOV     AX, [BX + SI + 2]   ; De igual forma la variable que obtendra AX es la C
                                ; ya que seria BX + SI + un desplasamiento
    MOV     DI, 6               ; DI recibe el valor de 6
    MOV     AX, [BX + DI]       ; Y es el mismo procedimiento que ya se hizo anteriormente
    MOV     AX, [BX + DI + 6]
    
    MOV     BP, OFFSET  A       ; Vamos a obtener la direccion de A
    MOV     SI, 4               ; SI obtiene el valor de 4
    MOV     AX, [BP + SI]       
    MOV     AX, [BP + SI + 2]
    MOV     DI, 6
    MOV     AX, [BP + DI]
    MOV     AX, [BP + DI + 6]
    
    MOV     AX, [SI]            ;Se carga el contenido de la direccion que apunta SI que es 4 
                                ;ahi se encuentra la variable C
    MOV     AX, [SI + 2]        ;  Encontramos la variable D
    MOV     AX, [BP + 8]        ;   Encontramos la variable E
    MOV     AX, [BX + 8]        ;  Encontramos la variable  E
    
    RET                         ; Por cada punto de salida en el procedimiento se debe incluir 
                                ; una isntruccion de retorno RET
                                ; Indicamos el fin de procedimiento Inicio
INICIO  ENDP        
CODIGO ENDS
        END INICIO