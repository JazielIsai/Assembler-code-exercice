
#start=robot.exe#

name "robot"

#make_bin#
#cs = 500#
#ds = 500#
#ss = 500#    ; stack
#sp = ffff#
#ip = 0#

; este es un ejemplo de como controlar el robot.

; este codigo mueve aleatoriamente el robot,
; y hace que encienda y apague las lamparas.

; El robot es una criatura mecanica y se necesita
; algo de tiempo para que complete una tarea.
; El registro de estado se utiliza para ver 
;si el robot esta ocupado o no.

; c: \ emu8086 \ devices \ robot.exe usa los puertos 9, 10 y 11
; El codigo fuente del robot y otros dispositivos esta en:
; c: \ emu8086 \ dispositivos \ desarrollador \ fuentes \
; El robot esta programado en Visual Basic 6.0.

;VARIABLES NUEVAS POSIBLES
    
    COUNTLEFT DW 0
    COUNTRIGHT DW 0

; puerto de E / S de la base del robot:
r_port equ 9

;===================================

eternal_loop:
; espera hasta que el robot
; este listo:
call wait_robot

; examinar el area
; que esta delante del robot:
mov al, 4   
out r_port, al

call wait_exam

; obtener resultado del
; registro de datos:
in al, r_port + 1

; Nada Encontrado?
cmp al, 0
je cont  ; - si, entonces continua.

; pared?
cmp al, 255  
je cont  ; - si, entonces continua.

; lampara encendida?
cmp al, 7
jne lamp_off  ; - no, asi que salte.
; - si, apaguelo,
; y encienda:
call switch_off_lamp 
jmp  cont  ; continue

lamp_off: nop

; si llega aqui, 
;entonces hemos apagado la lámpara, 
;porque todas las demas situaciones 
;ya se verificaron:
call switch_on_lamp

cont:
call random_turn

call wait_robot

;intenta dar un paso adelante:
mov al, 1
out r_port, al

call wait_robot

; intenta dar un paso adelante de nuevo:
mov al, 1
out r_port, al

jmp eternal_loop ; ve otra vez!

;===================================

; este procedimiento 
;no regresa hasta que el robot 
;este listo para recibir 
;el siguiente comando:
wait_robot proc
; Compruebe si el robot esta ocupado:
busy: in al, r_port+2
      test al, 00000010b
      jnz busy ; ocupado, asi que espera. jnz --> Saltar si no es cero (no es igual).
ret    
wait_robot endp

;===================================

;; este procedimiento 
;no regresa hasta que el robot 
;completa el examen:
wait_exam proc
;comprobar si tiene nuevos datos:
busy2: in al, r_port+2
       test al, 00000001b
       jz busy2 ; no hay nuevos datos, asi que espere.
ret    
wait_exam endp

;===================================

; apagar la lampara:
switch_off_lamp proc
mov al, 6
out r_port, al  

;-----AGREGADO
;MOV AL,2
;OUT r_port,AL
;
;mov al, 4   
;out r_port, al
;
;in al, r_port + 1
;
;; Nada Encontrado?
;cmp al, 0
;je cont  ; - si, entonces continua.
;
;; pared?
;cmp al, 255  
;je cont       
CALL QUEHAGO

;-----FIN AGREGADO

ret
switch_off_lamp endp

;===================================

; encender la lampara:
switch_on_lamp proc
mov al, 5
out r_port, al 

;-----AGREGADO
;MOV AL,2
;OUT r_port,AL
;              
;mov al, 4   
;out r_port, al
;
;in al, r_port + 1
;
;; Nada Encontrado?
;cmp al, 0
;je cont  ; - si, entonces continua.
;
;; pared?
;cmp al, 255  
;je cont         
CALL QUEHAGO       

;-----FIN AGREGADO

ret
switch_on_lamp endp

;===================================

; genera un turno aleatorio usando
; temporizador del sistema:
random_turn proc

; obtener el numero de tics 
;del reloj desde la medianoche en cx: dx
mov ah, 0
int 1ah

; aleatorizar usando xor:
xor dh, dl
xor ch, cl
xor ch, dh

test ch, 2
jz no_turn

test ch, 1
jnz turn_right

; Gire a la izquierda:
REPTLEFT: ; AGREGADO
mov al, 2
out r_port, al

;---- AGREGADO -AVANZA
;MOV AL,1
;OUT r_port,AL    

;INCREMENTO EL CONTADOR IZQUIERDO
INC COUNTLEFT
CMP COUNTLEFT,2
;MOV COUNTLEFT,0
JZ REPTLEFT   
   
CALL QUEHAGO
;---- FIN AGREGADO

; salir del procedimiento:
ret  
;Gire a la derecha
turn_right:
REPTRIGHT: ;AGREGADO
mov al, 3
out r_port, al

;---- AGREGADO -AVANZA
;MOV AL,1
;OUT r_port,AL

;INCREMENTO EL CONTADOR DERECHO
INC COUNTRIGHT
CMP COUNTRIGHT,2
;MOV COUNTRIGHT,0
JZ REPTRIGHT  
 
;CALL QUEHAGO
ret
;---- FIN AGREGADO

no_turn:

;-----AGREGADO
;mov al, 4   
;out r_port, al
;
;in al, r_port + 1
;
;; Nada Encontrado?
;cmp al, 0
;je cont  ; - si, entonces continua.
;
;; pared?
;cmp al, 255  
;je cont                
 CALL QUEHAGO
;-----FIN AGREGADO

ret
random_turn endp
             
             
;-----AGREGADO  


QUEHAGO PROC
   MOV COUNTLEFT, 0

While:    

    mov al, 4   
    out r_port, al
    
    in al, r_port + 1
    
    ;VERIFICAR
    CMP COUNTLEFT,2
    JZ SALIR1
    
    ; Nada Encontrado?
    cmp al, 0
    JZ AVANZA
    ;JNZ GIRA
    
    cmp al,255
    JZ REVISA
    JNZ SALTA
    
    

AVANZA:
    ;avanzar
    mov al, 1   
    out r_port, al
    
    INC COUNTLEFT
    
    CMP AL,1 
    JZ While
    
    ret
    ;je cont  ; - si, entonces continua.
;GIRA:
    ;MOV AL,2
    ;OUT r_port,AL
;     CALL random_turn
    
    ret
    
REVISA:
    CALL REVISAyAVANZA
    
    ret
    
SALTA:
SALIR1:
  RET    

QUEHAGO ENDP


REVISAyAVANZA proc
    
    MOV COUNTLEFT, 0

WHILE0:    
WHILE1:

    mov al, 4   
    out r_port, al
    
    in al, r_port + 1
    
    CMP al,0
    JZ AVANZAR
    
    
    ;PARED?
    CMP AL,255
;    CMP COUNTLEFT,1
    JNZ LEFT
    CMP COUNTLEFT,3
    JZ RIGHT
    
    
LEFT:    
    ;GIRA A LA IZQUIERDA
    INC COUNTLEFT

    CMP COUNTLEFT,1
    JZ RIGHT    

    MOV AL,2 
    OUT r_port,al
    CMP AL,2
    JZ WHILE0
    
RIGHT:    
    ;GIRA A LA DERECHA
    INC COUNTLEFT
    MOV AL,3 
    OUT r_port,al
    CMP AL,3
    JZ WHILE1
    
AVANZAR:
    
    ret
    
REVISAyAVANZA endp

;-----FIN AGREGADO           
;===================================
