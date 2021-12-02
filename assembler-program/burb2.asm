 
    
DATOS SEGMENT PARA PUBLIC DATA  
   include 'emu8086.inc' 
;-------------------------------------------------------------------------------------------
;*******************************************************************************************


X dw  0
y db  50 dup(?)      
ele dw  0    
x2 db 0
y2 db 0

          


;*******************************************************************************************
;-------------------------------------------------------------------------------------------


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
    MOV ES, AX  
    
    
      
       
            
              
   
    ;imprimos el mensaje para decir que cantidad de numeros queremos
    mov si,0  
    
    iniciod:  
    call pthis
    db 'Cantidad de numeros: ',0
    call SCAN_NUM 
    mov x,cx  
    dec x
    
   
   
   
   ;se colocan los numeros verificando respecto a la cantidad de cuantos pusimos al principio
   star: 
   
    call clear_screen
    gotoxy 4,10
    call pthis 
    db 'Numero: ',0
    call scan_num
    mov [si],cx 
    inc si
    cmp si,x
    jbe star
                
                
   
   
   ;elegimos si los queremos de menor a mayor
   ;o mayor a menor
   elegir:
     mov cx,0           
    
    gotoxy 4,10
    call pthis 
    db 'Presiona (1) para Menor a Mayor o (2) para Mayor a menor: ',0
    call scan_num  
    mov ele,cx
    cmp ele,1
    je MENOR 
    ja MAYOR 
    
    
    ;procedimiento de menor a mayor
    MENOR:
    
   MOV CX,x
   MOV SI,0
   MOV DI,0 
   
   
  CICLO:
  PUSH CX
  LEA SI,y
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
  
 
    
    
  
  
    
  ;imprime el mensaje de confirmacion
  s:  
  mov di,0   
  mov ax,0
  mov x2,2
  mov y2,3   
  call clear_screen
  
  GOTOXY x2,y2
  PRINTN 'MENOR A MAYOR ES: '   
  add y2,5
  
 
 
 ;imprime los valores acomodados
 imprc:
   
  mov al,y[di]  
  GOTOXY x2,y2
  CALL PRINT_NUM_UNS  
  add x2,4
  inc di
  cmp di,x
  jbe imprc
  JMP elegir
  
  
  
  
  ;procedimiento de mayor a menor
  MAYOR:
    
   MOV CX,x
   MOV SI,0
   MOV DI,0 
   
   
  CICLO3:
  PUSH CX
  LEA SI,y
  MOV DI,SI 
  
  CICLO4: 
  INC DI
  MOV AL,[SI]
  CMP AL,[DI]
  JB INTERC2
  JA MEY
  
  
  INTERC2:
  MOV AH,[DI]
  MOV [DI],AL
  MOV [SI],AH
  
  MEY:
  INC SI
  LOOP CICLO4
  POP CX
  LOOP CICLO3  
                                       
    
   
   ;imprime el mensaje 
   sa:  
  mov di,0   
  mov ax,0
  mov x2,2
  mov y2,3   
  call clear_screen
  
  GOTOXY x2,y2
  PRINTN 'MAYOR A MENOR ES: '   
  add y2,5
             
             
  
  ;acomoda e imprime los numeros 
  imprc2:
   
  mov al,y[di]  
  GOTOXY x2,y2
  CALL PRINT_NUM_UNS  
  add x2,4
  inc di
  cmp di,x
  jbe imprc2   
  
    JMP SALIR              
            
            
SALIR:            
  RET    
INICIO ENDP

CODIGO ENDS




DEFINE_SCAN_NUM
DEFINE_PRINT_STRING
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS  ; required for print_num.
DEFINE_PTHIS  
DEFINE_CLEAR_SCREEN
  
ff:  
END INICIO               