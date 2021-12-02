TITLE SALTOS EN LENGUAJE ENSAMBLADOR

INCLUDE "emu8086.inc"

DATOS SEGMENT 
    


    
DATOS ENDS


PILA SEGMENT 
    
    DW  64  DUP(0)
    
PILA ENDS
              
              
              
CODIGO SEGMENT
    
INICIO PROC FAR
    
    PUSH DS
    MOV AX,0
    PUSH AX
    
    
    MOV AX,DATOS
    MOV DS,AX
    MOV ES,AX
    
    
    
    ;CODIGO AQUI
    
    
    ;Ejemplo de JMP
    mov    ax, 5          ; set ax to 5. 
    mov    bx, 2          ; set bx to 2. 
    
    jmp    calc           ; go to 'calc'. 

back:  jmp stop       ; go to 'stop'. 

calc:
    add    ax, bx         ; add bx to ax. 
    jmp    back           ; go 'back'. 

stop:  


    ;Ejemplo de JZ
    
    MOV AL,5
    CMP AL,5
    JZ EXIT
    ADD AL,6
    
EXIT:
    
   
   ;Ejemplo JNZ
   
    MOV AL,5
    CMP AL,5
    JNZ EXIT1
    ADD AL,6
    
EXIT1: 
    
   ;Ejemplo JE 
    
    MOV AL,5
    CMP AL,5
    JE EXIT2
    ADD AL,6
    
EXIT2:  
    
  
   ;Ejemplo JB
   
   MOV AL, 1
   CMP AL, 5
   JB  label1
   add al,10
   
label1:
      
   
   ;Ejemplo JNAE
   
   MOV AL,6
   CMP AL,5
   JNAE label2
   ADD AL,10
   
label2: 

    
   ;Ejemplo JP
   MOV AL, 00000101b   ; AL = 5
   OR  AL, 0           ; just set flags.
   JP label3
   ADD AL,5 
label3:
  

   ;Ejemplo JO
   
   MOV AL, -5
   SUB AL, 127   ; AL = 7Ch (124)
   JO  label4
   ADD AL,3
   
label4:
   
   
   
   ;Ejemplo JE
   

   mov    al, 25          ; set al to 25. 
   mov    bl, 10          ; set bl to 10. 
   
   cmp    al,bl          ;Compare al = bl
    
   je     equal
    
   putc    'n'
   jmp     STOPS

equal:
    
    putc    'y'
    
STOPS: 



       RET

INICIO ENDP

CODIGO ENDS


    END INICIO

