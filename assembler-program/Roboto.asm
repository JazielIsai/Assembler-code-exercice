                                      
#start=robot.exe#

name "robot"

#make_bin#
#cs = 500#
#ds = 500#
#ss = 500#    ; stack
#sp = ffff#
#ip = 0#

; this is an example of contoling the robot.

; this code randomly moves the robot,
; and makes it to switch the lamps on and off.

; robot is a mechanical creature and it takes 
; some time for it to complete a task.
; status register is used to see if robot is busy or not.

; c:\emu8086\devices\robot.exe uses ports 9, 10 and 11
; source code of the robot and other devices is in:
; c:\emu8086\devices\developer\sources\
; robot is programmed in visual basic 6.0


; robot base i/o port:
r_port equ 9
MOV SI,0

;===================================

eternal_loop:
; wait until robot
; is ready:

call wait_robot

; examine the area
; in front of the robot:
mov al, 4                         ;EXAMINA EL AREA ALREDEDOR
out r_port, al


call wait_exam
;CALL Giro_Derecha

; get result from               ;AQUI SE OBTIENE EL RESULTADO DEL wait_exam Y SE GUARDA EN AL
; data register:                ;PUERTO 10
in al, r_port + 1

; nothing found?
cmp al, 0
je cont  ; - yes, so continue.

; wall?
cmp al, 255  
je noCont  ; - yes, so continue.

;seguir:

; switched-on lamp?
cmp al, 8
je lamp_on  ; - no, so skip.
; - yes, so switch it off,
;   and turn:

lamp_off: nop


call switch_off_lamp              ;APAGA LA LAMPARA
;mov al, 4                         ;EXAMINA EL AREA ALREDEDOR.HAY UNA LAMPARA DESPUES DE APAGARLA
;out r_port, al
;
;call wait_exam
;
;in al, r_port + 1                 ;RECUPERA EL VALOR DEL EXAMEN
;
;; LAMP?
;cmp al, 8  
;je noCont  ; - yes, so continue.
 
jmp  noCont  ; continue



; if gets here, then we have
; switched-off lamp, because
; all other situations checked
; already:
;lamp_off: nop

lamp_on:

call switch_on_lamp
JMP noCont
;mov al, 4                         ;EXAMINA EL AREA ALREDEDOR.HAY UNA LAMPARA DESPUES DE APAGARLA
;out r_port, al
;
;call wait_exam
;
;in al, r_port + 1                 ;RECUPERA EL VALOR DEL EXAMEN
;
; ; wall?                            ;;COMPARA SI HAY PARED O UNA LAMPARA DESPUES DE PRENDERLA
;cmp al, 8  
;je noCont  

 
  
CALL wait_robot
cont:


; try to step forward:
mov al, 1
out r_port, al
MOV SI,0

call wait_robot

; try to step forward again:
mov al, 1
out r_port, al

jmp eternal_loop ; go again!

;//////////////////////////////////////////////
noCont:
INC SI                   ;para las vueltas a la derecha que da

CALL wait_robot

CALL Giro_Izquierda

mov al, 4                         ;EXAMINA EL AREA ALREDEDOR
out r_port, al

CALL wait_exam

in al, r_port + 1

CMP SI,2
JGE back
  

JMP eternal_loop

back:
;CMP AL,0
;JE eternal_loop
CALL wait_exam
CALL Giro_Izquierda
CALL wait_robot
;CAll Giro_Derecha
;CALL wait_robot
;CALL wait_exam
;CAll Giro_Derecha
;
JMP cont

;///////////////////////////////////////////////

;===================================

; this procedure does not                 ;TRABAJA EN EL PUERTO 11
; return until robot is ready
; to receive next command:
wait_robot proc
; check if robot busy:
busy: in al, r_port+2
      test al, 00000010b
      jnz busy ; busy, so wait.
ret    
wait_robot endp

;===================================

; this procedure does not
; return until robot completes
; the examination:
wait_exam proc                          ;PROCEDIMIENTO QUE EXAMINA SI EL ROBOT ESTA OCUPADO
; check if has new data:                ;TRABAJA EN EL PUERTO 11
busy2: in al, r_port+2
       test al, 00000001b
       jz busy2 ; no new data, so wait.
ret    
wait_exam endp

;===================================

; switch off the lamp:
switch_off_lamp proc
mov al, 6
out r_port, al
ret
switch_off_lamp endp

;===================================

; switch on the lamp:
switch_on_lamp proc
mov al, 5
out r_port, al
ret
switch_on_lamp endp

;===================================

; generates a random turn using
; system timer:
random_turn proc

; get number of clock
; ticks since midnight
; in cx:dx
mov ah, 0
int 1ah

; randomize using xor:
xor dh, dl
xor ch, cl
xor ch, dh

test ch, 2
jz no_turn

test ch, 1
jnz turn_right

; turn left:
mov al, 2
out r_port, al
; exit from procedure:
ret  

turn_right:
mov al, 3
out r_port, al

no_turn:
ret
random_turn endp 

Giro_Derecha PROC  
    
Gira_Derecha:
mov al, 3
out r_port, al
RET

Giro_Derecha ENDP

Giro_Izquierda PROC  
    
Gira_Izq:
mov al, 2
out r_port, al
RET

Giro_Izquierda ENDP



;===================================
