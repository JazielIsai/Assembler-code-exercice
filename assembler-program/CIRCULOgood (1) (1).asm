DATA SEGMENT

X DW 0
Y DW 0   

X2 DW 0
Y2 DW 0 

CONT DW 0

DIAMETRO DW 0 



	XC 	  DW 0 ; Pos X del centro
	YC 	  DW 0  ; Pos Y del centro
	TEMPO DW ?    ; Temporal
	
	COLOR DB 2   ; Color inicial
	LAST  DB "5"
	RAD   DW 0	  ; Radio del círculo
	HOR   DW ?
	VER   DW ?
	VID   DB ?	; Salvamos el modo de video :) 
DATA ENDS

CODE SEGMENT
	ASSUME CS:CODE,DS:DATA,SS:PILA
INICIO: 
    MOV AX,DATA
	MOV DS,AX 


    MOV AL,13H
    MOV AH,0
    INT 10H
    
    OTRO:
    
;   RESET MOUSE AND GET ITS STATUS 
    MOV AX,0
    INT 33H
    
    
    ESPERA:

;RETURNS 
;IF LEFT BUTTON IS DOWN BX=1
;IF RIGTH BUTTON IS DOWN BX=2
;IF BOTH BUTTONS ARE DOWN BX=3 
;CX=X
;DX=Y  
      
    MOV AX,3
    INT 33H  
    SHR CX,1        ;DIVIDIMOS CX ENTRE 2
    CMP BX,1        ;NOS ESPERAMOS HASTA DAR CLICK CON EL BOTON IZQUIERDO   
                    ;SALTA A LA RUTINA DE DIBUJA UN PIXEL
    
    JE DIBUJA       ;SI PRECIONAMOS BOTON DERECHO SALIMOS 
    
    
    CMP BX,2 
    JE  MEDIA      ;SALTO PARA MEDIA 
    JMP ESPERA
    
    DIBUJA: 
    
;INPUT 
;AL=PIXEL COLOR
;CX=COLUM
;DX=ROW 
    
    ;SALTO CIRCULO COMPLETO
    INC CONT
    CMP CONT,3
    JE  COMPLETO
    
    
    ;COORDENADA 1 O 2
    MOV SI,Y 
    CMP SI,0
    JA COORDENADAS2
     
    ;AL GUARDAR AQUI SE GUARDAN POCICIONES DEL MOUSE DE ACUERDO AL ULTIMO CLICK
    MOV X,CX
    MOV Y,DX

    MOV AH,12
    MOV AL,10
    INT 10H
    JMP ESPERA 
    
    ;GUARDADO DE LA SEGUNDA COORDENADA DE X,Y  
    COORDENADAS2:
    
    MOV X2,CX
    MOV Y2,DX

    MOV AH,12
    MOV AL,10
    INT 10H 
    
    MOV CX,X
    MOV DX,X2
    
    MOV SI,0
    ADD SI,2 ;SI=0 NO TOMA PUNTOS COMO DIAMETRO 
             ;SI=2 SI LOS TOMA 
    
    DIAM:
    DEC DX
    INC SI
    CMP DX,CX
    JA DIAM
    
    MOV DIAMETRO,SI   
    MOV AX,0
    MOV BX,0
    
    MOV AX,SI
    MOV BL,2
    DIV BL 
    MOV BL,0
    MOV BL,X
    
    MOV RAD,AL 
    
    DEC AL
    ADD BL,AL
    
    MOV XC,BL
            
    MOV AX,0
    MOV BX,0
    MOV AX,Y
    MOV BX,Y2
    ADD AX,BX
    
    MOV BL,2
    DIV BL
    
    MOV YC,AL        
    JMP ESPERA
                                

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	COMPLETO:
	HALF2:
	MOV AH,0Fh	
	INT 10h		



	MOV CX,XC
	MOV DX,YC
	CALL PUNTEAR
	
	CALL INFI
	

    MOV X,0
    MOV Y,0

    MOV X2,0
    MOV Y2,0
    MOV HOR,0
    MOV VER,0
    MOV RAD,0
    MOV VID,0
    MOV TEMPO,0

    MOV DIAMETRO,0

    MOV CONT,0


    REPI1:
    
    MOV BX,0
    MOV AX,0
    INT 33H  
    
    MOV AX,3
    INT 33H
    
    SHR CX,1
    CMP BX,1
    JE EXIT1

    CMP BX,2
    JE OTRO
    JMP REPI1
    
    EXIT1:		  	
	
	MOV AH,004Ch
	INT 21h
	
	
	
	MEDIA:
	MOV AH,0Fh	
	INT 10h			

	MOV CX,XC
	MOV DX,YC
	CALL PUNTEARM
	
	CALL INFIM
	            ;COMPROBAR SI CREAR UN NUEVO CIRCULO O COMPLETAR EL YA CREADO
	COMPLETA:
	MOV AX,3
    INT 33H
    
    CMP BL,1
    JE GIVE
    
	CMP BL,2
    
	JE HALF2
	JMP COMPLETA
	
	GIVE:         ;RECET DE VAR
    MOV X,0
    MOV Y,0

    MOV X2,0
    MOV Y2,0
    MOV HOR,0
    MOV VER,0
    MOV RAD,0
    MOV VID,0
    MOV TEMPO,0

    MOV DIAMETRO,0

    MOV CONT,0



    REPI:
    
    MOV BX,0
    MOV AX,0
    INT 33H
    
    MOV AX,3
    INT 33H
     
    SHR CX,1 
    CMP BX,1
    JE EXIT

    CMP BX,2
    JE OTRO
    JMP REPI
    
    EXIT:		  	
	
	MOV AH,004Ch
	INT 21h		
	

    
; <!--------- PROCEDIMIENTOS1 ---------------->
INFI PROC NEAR
ITERA:
	CALL GRAFICAR
	
	MOV AL,LAST

PUNTEAR PROC NEAR     
	                    ; Grafica un punto en CX,DX 
	MOV AH,0Ch		; Petición para escribir un punto
	MOV AL,COLOR	; Color del pixel
	MOV BH,00h		; Página
	INT 10H			; Llamada al BIOS
	RET
PUNTEAR ENDP

GRAFICAR PROC NEAR
                    ; Graficamos todo el circulo !
	MOV HOR,0
	MOV AX,RAD
	MOV VER,AX
	
BUSQUEDA:
	CALL BUSCAR
	
    MOV AX,VER
	SUB AX,HOR
	CMP AX,1
	JA BUSQUEDA
	RET
GRAFICAR ENDP

BUSCAR PROC NEAR
                    ; Se encarga de buscar la coord del pixel sgte.
	INC HOR ; Horizontalmente siempre aumenta 1
	
	MOV AX,HOR	
	MUL AX
	MOV BX,AX ; X^2 se almacena en BX
	MOV AX,VER
	MUL AX    ; AX almacena Y^2
	ADD BX,AX ; BX almacena X^2 + Y^2
	MOV AX,RAD
	MUL AX    ; AX almacena R^2
	SUB AX,BX ; AX almacena R^2 - (X^2+Y^2)
	
	MOV TEMPO,AX
	
	MOV AX,HOR	
	MUL AX
	MOV BX,AX ; BX almacena X^2
	MOV AX,VER
	DEC AX    ; una unidad menos para Y 
	MUL AX    ; AX almacena Y^2
	ADD BX,AX ; BX almacena X^2 + Y^2
	MOV AX,RAD
	MUL AX    ; AX almacena R^2
	SUB AX,BX ; AX almacena R^2 - (X^2+Y^2)
	
	CMP TEMPO,AX
	JB NODEC
	DEC VER
NODEC:
	CALL REPUNTEAR
	PUSH VER
	PUSH HOR
	POP VER
	POP HOR   ; Cambiamos valores
	CALL REPUNTEAR
	PUSH VER
	PUSH HOR
	POP VER
	POP HOR   ; Devolvemos originales 
	RET
BUSCAR ENDP
	
REPUNTEAR PROC NEAR
	; I CUADRANTE
	MOV CX,XC
	ADD CX,HOR
	MOV DX,YC
	SUB DX,VER
	CALL PUNTEAR
	; IV CUADRANTE
	MOV DX,YC
	ADD DX,VER
	CALL PUNTEAR
	; III CUADRANTE
	MOV CX,XC
	SUB CX,HOR
	CALL PUNTEAR
	; II CUADRANTE
	MOV DX,YC
	SUB DX,VER
	CALL PUNTEAR
	RET
REPUNTEAR ENDP
	
RET




; <!--------- PROCEDIMIENTOS2 ---------------->
INFIM PROC NEAR
ITERAM:
	CALL GRAFICARM
	
	MOV AL,LAST

PUNTEARM PROC NEAR     
	                ; Grafica un punto en CX,DX 
	MOV AH,0Ch		; Petición para escribir un punto
	MOV AL,COLOR	; Color del pixel
	MOV BH,00h		; Página
	INT 10H			; Llamada al BIOS
	RET
PUNTEARM ENDP

GRAFICARM PROC NEAR
                    ; Graficamos todo el circulo !
	MOV HOR,0
	MOV AX,RAD
	MOV VER,AX
	
BUSQUEDAM:
	CALL BUSCARM
	
    MOV AX,VER
	SUB AX,HOR
	CMP AX,1
	JA BUSQUEDAM
	RET
GRAFICARM ENDP

BUSCARM PROC NEAR
; Se encarga de buscar la coord del pixel sgte.
	INC HOR ; Horizontalmente siempre aumenta 1
	
	MOV AX,HOR	
	MUL AX
	MOV BX,AX ; X^2 se almacena en BX
	MOV AX,VER
	MUL AX    ; AX almacena Y^2
	ADD BX,AX ; BX almacena X^2 + Y^2
	MOV AX,RAD
	MUL AX    ; AX almacena R^2
	SUB AX,BX ; AX almacena R^2 - (X^2+Y^2)
	
	MOV TEMPO,AX
	
	MOV AX,HOR	
	MUL AX
	MOV BX,AX ; BX almacena X^2
	MOV AX,VER
	DEC AX    ; una unidad menos para Y 
	MUL AX    ; AX almacena Y^2
	ADD BX,AX ; BX almacena X^2 + Y^2
	MOV AX,RAD
	MUL AX    ; AX almacena R^2
	SUB AX,BX ; AX almacena R^2 - (X^2+Y^2)
	
	CMP TEMPO,AX
	JB NODECM
	DEC VER
NODECM:
	CALL REPUNTEARM
	PUSH VER
	PUSH HOR
	POP VER
	POP HOR   ; Cambiamos valores
	CALL REPUNTEARM
	PUSH VER
	PUSH HOR
	POP VER
	POP HOR   ; Devolvemos originales 
	RET
BUSCARM ENDP
	
REPUNTEARM PROC NEAR
	; I CUADRANTE
	MOV CX,XC
	ADD CX,HOR
	MOV DX,YC
	SUB DX,VER
	CALL PUNTEARM
	; III CUADRANTE
	MOV CX,XC
	SUB CX,HOR
	CALL PUNTEARM
	; II CUADRANTE
	MOV DX,YC
	SUB DX,VER
	CALL PUNTEARM
	RET
REPUNTEARM ENDP
	
RET

CODE ENDS
PILA SEGMENT STACK
DB 777 DUP(?)
PILA ENDS
END INICIO