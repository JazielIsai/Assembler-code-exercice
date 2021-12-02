            Title Practica 4          ;TITULO



DATOS SEGMENT PARA PUBLIC DATA

DATOS ENDS 
X DW 0
Y DW 0   

X2 DW 0
Y2 DW 0 


DIAMETRO DW 0 



;variables
;    XC 	  DW 100 ; Pos X del centro
;	YC 	  DW 100  ; Pos Y del centro
;	TEMPO DW ?    ; Temporal
;	
;	COLOR DB 2   ; Color inicial
;	LAST  DB "5"
;	RAD   DW 30	  ; Radio del círculo
;	HOR   DW ?
;	VER   DW ?
;	VID   DB ?	; Salvamos el modo de video :) 
 
 
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
               
;//////////////////////////////////////LLAMADA PANTALLA Y PROCDIMIENTOS DE DIBUJO    
    
    MOV AH,0
    MOV AL,13H
    INT 10H
    
    MOV AX,10
    MOV X,AX
    CALL HORIZONTAL
    MOV AX,190
    MOV X,AX
    CALL HORIZONTAL
    
    MOV AX,10
    MOV Y,AX
    CALL VERTICAL
    MOV AX,180
    MOV Y,AX
    CALL VERTICAL

    RET
     
INICIO ENDP    
    
    
;//////////////////////////////////////PROCEDIMIENTOS DE DIBUJO

HORIZONTAL PROC NEAR 
    
    MOV DX,X
    MOV CX,10              ;PINTA EL PRIMER PIXEL 
    
    
    
   ;INPUT
   ;AL PIXEL COLOR
   ;CX COLUM
   ;DX ROW
          
   
   PINTAR1:
   
   MOV AH,12
   MOV AL,14
   INT 10H
   INC CX
   CMP CX,180
   JNE PINTAR1
   RET
   
   
HORIZONTAL ENDP



VERTICAL PROC NEAR 
    
    MOV CX,Y
    MOV DX,10
    
    
    PINTAR2:
    
    MOV AH,12
    MOV AL,2
    INT 10H
    INC DX
    CMP DX,190
    JNE PINTAR2
    RET
    
VERTICAL ENDP
    
           

;INICIO ENDP
CODIGO ENDS
        END INICIO 