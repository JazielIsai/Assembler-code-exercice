;Este es el juego de la serpiente o snake


name "snake"

org     100h

; salta a a seccion de datos:
jmp     start

; ------ variables ------ 

s_tam  equ 4    ;3
s_tam2  equ 6    ;4
s_tam3  equ 8    ;5
s_tam4  equ 10   ;6
s_tam5  equ 12    ;7
s_tam6  equ 14    ;8

prueba dw 125,3,4  
prueba2 dw 0,0,0


snake dw s_tam dup(0)                   ;Tamano de snake
snake2 dw s_tam2 dup(0)
snake3 dw s_tam3 dup(0)
snake4 dw s_tam4 dup(0)
snake5 dw s_tam5 dup(0)
snake6 dw s_tam6 dup(0)               

; las coordenadas de la serpiente
; (de la cabeza a la cola)
; queda un byte bajo, byte alto
; esta arriba - [arriba, izquierda]

tail    dw      ?

; constantes de direccion
; (codigos clave de la BIOS):
left    equ     4bh
right   equ     4dh
up      equ     48h
down    equ     50h

; direccion de la serpiente:
cur_dir db      right

wait_time dw    0     

contorno dw '#$'
You_Lose dw 'GAME OVER :v$'

msg db '[//= JUEGO DEL SKANE =\\]$'

msg2 db '[_PRESIONA UNA TECLA PARA JUGAR_]$'
 
incremento db 1 
inicio db 1     

; ------ codigo ------
 
start:
call clrscr 
 
;== coordenadas para el mensaje 1
mov dh,10
mov dl,25



; oculta u obtiene el cursor con dl,dh
mov ah, 02h
int 10h

; imprime menjade de bienvenida
mov dx, offset msg
mov ah, 9
mov bl, 05h
int 21h



;== coordenadas para el mensaje2
mov dh,11
mov dl,25




mov ah, 02h
int 10h


mov dx, offset msg2
mov ah, 9
mov bl, 05h
int 21h 
   
; enter para avanzar
mov ah, 00h
int 16h 
             
call clrscr               
; ocultar del texto el cursor:     
mov     ah, 1
mov     ch, 2bh
mov     cl, 0bh
int     10h

;/////////////////////////////////////////////////////////////////////////////

;Dibujar una manzana :3
mov dh,10
mov dl,15

; obtener el cursor con dl,dh
mov     ah, 02h
int     10h

; imprime la manzanza 
mov     al, 'o'
mov     ah, 09h
mov     bl, 04h ; atribulo.
mov     cx, 1   ; solo un caracter.
int     10h

;/////////////////////////////////////////////////////////////////////////////           
 
game_loop:
mov incremento, 1

; === selecione la primera pagina del video
mov     al, 0  ; numero de pagina.
mov     ah, 05h
int     10h

; === mostrar nuevamente:
mov     dx, snake[0]

;       posicion de la serpiente
mov     ah, 02h  
int     10h 

; imprime serpiente:
mov     al, '*'
mov     ah, 09h
mov     bl, 0eh 
mov     cx, 1   ; solo char.
int     10h

call Choca 

call Colicion 

; === mantener la cola:
mov     ax, snake[s_tam * 2 - 2]
mov     tail, ax

call    move_snake


; === esconder la cola vieja:
mov     dx, tail

; set cursor at dl,dh      Snake posicion en el cuerpo
mov     ah, 02h
int     10h

; imprimer ' ':
mov     al, ' '
mov     ah, 09h
mov     bl, 0eh 
mov     cx, 1   ; solo char.
int     10h

;== comparar si se ha tocado la primer manzana
cmp dx,2575
je game_loop2 

check_for_key:

; === comprobar los comandos del jugador:
mov     ah, 01h
int     16h
jz      no_key

mov     ah, 00h
int     16h

cmp     al, 1bh    ; esc - llave?
je      stop_game  

mov     cur_dir, ah

no_key:



; === espere unos momentos aqui:
; obtener el numero de tics del reloj
; (alrededor de 18 por segundo)
; desde la medianoche en cx: dx
mov     ah, 00h
int     1ah
cmp     dx, wait_time
jb      check_for_key
add     dx, 4
mov     wait_time, dx


call Mapa  
     
     
; === bucle de juego eterno:
jmp     game_loop


;///////////////////////////////////////////////////////////////// -SNAKE CON 3 PARTES
game_loop2:
mov inicio,1 

call clrscr 

mov ax,2575 
mov snake2[0], ax
                                     
;/////////////////////////////////////////////////////////////////////////////

;Dibujar una manzana :3 

mov dh,20
mov dl,25

;obtener el cursor con dl,dh
mov     ah, 02h
int     10h
 
; imprime 'O' manzana:
mov     al, 'o'
mov     ah, 09h
mov     bl, 04h 
mov     cx, 1   
int     10h     
 

game_loop2_1: 


call Mapa_new

; === seleciona el primer video de la pagina
mov     al, 0  ; numero de pagina.
mov     ah, 05h
int     10h

;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


; === mostrar nuevo tamano
mov     dx, snake2[0]

; obtenr el cursor con dl,dh
mov     ah, 02h
int     10h

; imprime '*' serpiente:
mov     al, 'x'
mov     ah, 09h
mov     bl, 0eh ; attribute.
mov     cx, 1   ; single char.
int     10h
             
call Choca  


call Colicion2

                                 
; === mantener la cola:
mov     ax, snake2[s_tam2 * 2 - 2]
mov     tail, ax

call    move_snake2


; === ocultar cola de la vieja serpiente:
mov     dx, tail


mov     ah, 02h
int     10h

; imprime ' ' 
mov     al, ' '
mov     ah, 09h
mov     bl, 0eh 
mov     cx, 1   
int     10h 

 
;== comparar si se ha tocado la primer manzana
cmp dx,5145
je game_loop3 


check_for_key2:

; === comprobar los comandos del jugador:
mov     ah, 01h
int     16h
jz      no_key2

mov     ah, 00h
int     16h

cmp     al, 1bh    
je      stop_game  

mov     cur_dir, ah

no_key2:



; === espere unos momentos aqui:
; obtener el numero de tics del reloj
; (alrededor de 18 por segundo)
; desde la medianoche en cx: dx
mov     ah, 00h
int     1ah
cmp     dx, wait_time
jb      check_for_key2
add     dx, 4
mov     wait_time, dx
 

 
; === bucle eterno del juego
jmp     game_loop2_1
;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -SNAKE CON 4 PARTES
game_loop3:

mov inicio,1 

call clrscr 

mov ax,5145 
mov snake3[0], ax

mov inicio,1 
;///////////////////////////////////////////////////////////////////////////// 
   
   
;Dibujar una manzana :3
mov dh,12
mov dl,60


mov     ah, 02h
int     10h

; print 'O'
mov     al, 'o'
mov     ah, 09h
mov     bl, 04h 
mov     cx, 1  
int     10h
            
            
;/////////////////////////////////////////////////////////////////////////////

game_loop3_1:

call Mapa_new 
              ;primera pagina del video

mov     al, 0  
mov     ah, 05h
int     10h

;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++




; === mostrar el tamano:
mov     dx, snake3[0]

; obtener el cursor
mov     ah, 02h
int     10h

; imprime '*' 
mov     al, '*'
mov     ah, 09h
mov     bl, 0eh 
mov     cx, 1   
int     10h
             
call Choca 
          
call Colicion3             
             

mov     ax, snake3[s_tam3 * 2 - 2]
mov     tail, ax

call    move_snake3



mov     dx, tail


mov     ah, 02h
int     10h

; imprime ' ':
mov     al, ' '
mov     ah, 09h
mov     bl, 0eh 
mov     cx, 1  
int     10h
 
 
 
;3132
;== comparar si se ha tocado la primer manzana
cmp dx,3132
je game_loop4 

check_for_key3:

; === comprobar los comandos del jugador:
mov     ah, 01h
int     16h
jz      no_key3

mov     ah, 00h
int     16h

cmp     al, 1bh    
je      stop_game  

mov     cur_dir, ah

no_key3:



; === espere unos momentos aqui:
; obtener el numero de tics del reloj
; (alrededor de 18 por segundo)
; desde la medianoche en cx: dx
mov     ah, 00h
int     1ah
cmp     dx, wait_time
jb      check_for_key3
add     dx, 4
mov     wait_time, dx



; === bucle de juego eterno:
jmp     game_loop3_1

;--------------------------------------------------------------SERPIENTE CON 5 PARTES
game_loop4:

mov inicio,1 

call clrscr

mov ax,3132 
mov snake4[0], ax 
 
mov inicio,1  
;///////////////////////////////////////////////////////////////////////////// 
    
  
;Dibujar una manzana :3
mov dh,5
mov dl,9


mov     ah, 02h
int     10h

; print 'O' 
mov     al, 'o'
mov     ah, 09h
mov     bl, 04h 
mov     cx, 1  
int     10h

;/////////////////////////////////////////////////////////////////////////////

game_loop4_1: 

call Mapa_new 

; === slecionar primera pagina del video
mov     al, 0  ;numero de pagina.
mov     ah, 05h
int     10h

;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++




;mostrar
mov     dx, snake4[0]

; obtener  dl,dh
mov     ah, 02h
int     10h

; print '*' 
mov     al, 'x'
mov     ah, 09h
mov     bl, 0eh 
mov     cx, 1   
int     10h
           
call Choca 

call Colicion4                     
           

mov     ax, snake4[s_tam4 * 2 - 2]
mov     tail, ax

call    move_snake4



mov     dx, tail


mov     ah, 02h
int     10h

; print ' ' 
mov     al, ' '
mov     ah, 09h
mov     bl, 0eh 
mov     cx, 1   
int     10h

 
;1289
;== comparar si se ha tocado la manzana
cmp dx,1289
je game_loop5 


check_for_key4:

; === comprobar los comandos del jugador:
mov     ah, 01h
int     16h
jz      no_key4

mov     ah, 00h
int     16h

cmp     al, 1bh    ; esc - key?
je      stop_game  ;

mov     cur_dir, ah

no_key4:



; === espere unos momentos aqui:
; obtener el numero de tics del reloj
; (alrededor de 18 por segundo)
; desde la medianoche en cx: dx
mov     ah, 00h
int     1ah
cmp     dx, wait_time
jb      check_for_key4
add     dx, 4
mov     wait_time, dx

 

; === bucle de juego eterno:
jmp     game_loop4_1
;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++SNAKE CION 6 PARTES
game_loop5: 

mov inicio,1 

call clrscr

mov ax,1289 
mov snake5[0], ax 

mov inicio,1 
;///////////////////////////////////////////////////////////////////////////// 

call Mapa_new

;Dibujar una manzana :3
mov dh,35
mov dl,30


mov     ah, 02h
int     10h

; print 'O'
mov     al, 'o'
mov     ah, 09h
mov     bl, 04h 
mov     cx, 1  
int     10h

;/////////////////////////////////////////////////////////////////////////////

game_loop5_1:

call Mapa_new 

; === selecionar la primera pagina del video
mov     al, 0  ; numero de pagina
mov     ah, 05h
int     10h

;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

; === mostrar:
mov     dx, snake5[0]


mov     ah, 02h
int     10h


mov     al, '*'
mov     ah, 09h
mov     bl, 0eh
mov     cx, 1   
int     10h
               
call Choca 

call Colicion5  
              

mov     ax, snake5[s_tam5 * 2 - 2]
mov     tail, ax

call    move_snake5



mov     dx, tail


mov     ah, 02h
int     10h

; print ' '
mov     al, ' '
mov     ah, 09h
mov     bl, 0eh 
mov     cx, 1   
int     10h

 
;8990
;== comparar si se ha tocado la manzana
cmp dx,8990
je game_loop5


check_for_key5:

; === comprobar los comandos del jugador:
mov     ah, 01h
int     16h
jz      no_key5

mov     ah, 00h
int     16h

cmp     al, 1bh   
je      stop_game  

mov     cur_dir, ah

no_key5:



; === espere unos momentos aqui:
; obtener el numero de tics del reloj
; (alrededor de 18 por segundo)
; desde la medianoche en cx: dx
mov     ah, 00h
int     1ah
cmp     dx, wait_time
jb      check_for_key5
add     dx, 4
mov     wait_time, dx



; === bucle de juego eterno:
jmp     game_loop5_1
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
game_loop6:
mov ax,8990 
mov snake6[0], ax 

;///////////////////////////////////////////////////////////////////////////// 

;;Dibujar una manzana :3
;mov dh,7
;mov dl,15
;
;; set cursor at dl,dh
;mov     ah, 02h
;int     10h
;
;; print 'O' at the location:
;mov     al, 'o'
;mov     ah, 09h
;mov     bl, 04h ; attribute.
;mov     cx, 1   ; single char.
;int     10h
;
;/////////////////////////////////////////////////////////////////////////////

game_loop6_1:

; === selecion del aprimera pagina del video
mov     al, 0  ; numero de pagina.
mov     ah, 05h
int     10h

;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

; === muestra nuevo tamamo
mov     dx, snake6[0]

; set cursor at dl,dh
mov     ah, 02h
int     10h

; print '*' 
mov     al, 'x'
mov     ah, 09h
mov     bl, 0eh 
mov     cx, 1   
int     10h
              
call Choca  

call Colicion6            
              

mov     ax, snake6[s_tam6 * 2 - 2]
mov     tail, ax

call    move_snake6



mov     dx, tail


mov     ah, 02h
int     10h

; print ' '
mov     al, ' '
mov     ah, 09h
mov     bl, 0eh 
mov     cx, 1   
int     10h

;3132


check_for_key6:

; === comprobar los comandos del jugador:
mov     ah, 01h
int     16h
jz      no_key6

mov     ah, 00h
int     16h

cmp     al, 1bh    ; esc - key?
je      stop_game  ;

mov     cur_dir, ah

no_key6:
; === espere unos momentos aqui:
; obtener el numero de tics del reloj
; (alrededor de 18 por segundo)
; desde la medianoche en cx: dx
mov     ah, 00h
int     1ah
cmp     dx, wait_time
jb      check_for_key6
add     dx, 4
mov     wait_time, dx



; === buce eterno
jmp     game_loop6_1
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


stop_game:

; mostrar cursor anterior:
mov     ah, 1
mov     ch, 0bh
mov     cl, 0bh
int     10h

ret

; ------ seccion de funciones ------

; este procedimiento crea el
; animacion moviendo todas las serpientes
; partes del cuerpo un paso a la cola,
; la vieja cola se va:
; [ultima parte (cola)] -> desaparece
; [parte i] -> [parte i + 1]
        
Choca proc
cmp inicio, 7   ;Ya salio de su casa ??
jne no_toca 
;//////Choco con la pared?? I dont know

;Constantes de las paredes primeras evaluaciones 
cmp dl, 0
je pared_izq

cmp dh, 0 
je techo

cmp dl, 79
je pared_der 

cmp dh, 23
je suelo
jne no_toca


pared_izq:
cmp dh, incremento
je  Perdiste
inc incremento
cmp incremento, 24
jne pared_izq  
je no_toca

techo:
cmp dl, incremento
je  Perdiste
inc incremento
cmp incremento, 80
jne techo  
je no_toca  

pared_der:
cmp dh, incremento
je  Perdiste
inc incremento
cmp incremento, 24
jne pared_der  
je no_toca  

suelo:
cmp dl, incremento
je  Perdiste
inc incremento
cmp incremento, 80
jne suelo  
je no_toca 


no_toca:
               
ret

Choca endp


Colicion proc
     
mov al, 0  
  
cmp     cur_dir, right
je right_pos
jne no_pega  
 
right_pos:
mov si, snake[0]

inc si
      
mov dx, si
mov ah, 02h
int 10h      
            
mov ah, 08h
mov bh, 0
int 10h

cmp al, 042
je Perdiste  

no_pega:
 
 
  
cmp     cur_dir, left
je left_pos
jne no_pega2

left_pos:
mov si, snake[0]

dec si
      
mov dx, si
mov ah, 02h
int 10h      
            
mov ah, 08h
mov bh, 0
int 10h

cmp al, 042
je Perdiste  
            

no_pega2:  


cmp     cur_dir, down
je down_pos
jne no_pega3

down_pos:
mov dx, b.snake[0]

inc dh

mov ah, 02h
int 10h      
            
mov ah, 08h
mov bh, 0
int 10h

cmp al, 042
je Perdiste  
            

no_pega3: 


cmp     cur_dir, up
je up_pos
jne no_pega4

up_pos:
mov dx, b.snake[0]

dec dh

mov ah, 02h
int 10h      
            
mov ah, 08h
mov bh, 0
int 10h

cmp al, 042
je Perdiste  
            

no_pega4:

ret

Colicion endp 



Colicion2 proc
     
mov al, 0  
 
  
cmp     cur_dir, right
je right_posx
jne no_pegax  
 
right_posx:
mov si, snake2[0]

inc si
      
mov dx, si
mov ah, 02h
int 10h      
            
mov ah, 08h
mov bh, 0
int 10h

cmp al, 120
je Perdiste  

no_pegax:
 
 
  
cmp     cur_dir, left
je left_posx
jne no_pega2x

left_posx:
mov si, snake2[0]

dec si
      
mov dx, si
mov ah, 02h
int 10h      
            
mov ah, 08h
mov bh, 0
int 10h

cmp al, 120
je Perdiste  
            

no_pega2x:  


cmp     cur_dir, down
je down_posx
jne no_pega3x

down_posx:
mov dx, b.snake2[0]

inc dh

mov ah, 02h
int 10h      
            
mov ah, 08h
mov bh, 0
int 10h

cmp al, 120
je Perdiste  
            

no_pega3x: 


cmp     cur_dir, up
je up_posx
jne no_pega4x

up_posx:
mov dx, b.snake2[0]

dec dh

mov ah, 02h
int 10h      
            
mov ah, 08h
mov bh, 0
int 10h

cmp al, 120
je Perdiste  
            

no_pega4x:

ret

Colicion2 endp


Colicion3 proc
     
mov al, 0  
  
cmp     cur_dir, right
je right_pos3
jne no_pega_13  
 
right_pos3:
mov si, snake3[0]

inc si
      
mov dx, si
mov ah, 02h
int 10h      
            
mov ah, 08h
mov bh, 0
int 10h

cmp al, 042
je Perdiste  

no_pega_13:
 
 
  
cmp     cur_dir, left
je left_pos3
jne no_pega_23

left_pos3:
mov si, snake3[0]

dec si
      
mov dx, si
mov ah, 02h
int 10h      
            
mov ah, 08h
mov bh, 0
int 10h

cmp al, 042
je Perdiste  
            

no_pega_23:  


cmp     cur_dir, down
je down_pos3
jne no_pega_33

down_pos3:
mov dx, b.snake3[0]

inc dh

mov ah, 02h
int 10h      
            
mov ah, 08h
mov bh, 0
int 10h

cmp al, 042
je Perdiste  
            

no_pega_33: 


cmp     cur_dir, up
je up_pos3
jne no_pega_43

up_pos3:
mov dx, b.snake3[0]

dec dh

mov ah, 02h
int 10h      
            
mov ah, 08h
mov bh, 0
int 10h

cmp al, 042
je Perdiste  
            

no_pega_43:

ret

Colicion3 endp


Colicion4 proc
     
mov al, 0  
 
  
cmp     cur_dir, right
je right_pos4
jne no_pega_14  
 
right_pos4:
mov si, snake4[0]

inc si
      
mov dx, si
mov ah, 02h
int 10h      
            
mov ah, 08h
mov bh, 0
int 10h

cmp al, 120
je Perdiste  

no_pega_14:
 
 
  
cmp     cur_dir, left
je left_pos4
jne no_pega_24

left_pos4:
mov si, snake4[0]

dec si
      
mov dx, si
mov ah, 02h
int 10h      
            
mov ah, 08h
mov bh, 0
int 10h

cmp al, 120
je Perdiste  
            

no_pega_24:  


cmp     cur_dir, down
je down_pos4
jne no_pega_34

down_pos4:
mov dx, b.snake4[0]

inc dh

mov ah, 02h
int 10h      
            
mov ah, 08h
mov bh, 0
int 10h

cmp al, 120
je Perdiste  
            

no_pega_34: 


cmp     cur_dir, up
je up_pos4
jne no_pega_44

up_pos4:
mov dx, b.snake4[0]

dec dh

mov ah, 02h
int 10h      
            
mov ah, 08h
mov bh, 0
int 10h

cmp al, 120
je Perdiste  
            

no_pega_44:

ret

Colicion4 endp

 
 
Colicion5 proc
     
mov al, 0  
  
cmp     cur_dir, right
je right_pos5
jne no_pega_15  
 
right_pos5:
mov si, snake5[0]

inc si
      
mov dx, si
mov ah, 02h
int 10h      
            
mov ah, 08h
mov bh, 0
int 10h

cmp al, 042
je Perdiste  

no_pega_15:
 
 
  
cmp     cur_dir, left
je left_pos5
jne no_pega_25

left_pos5:
mov si, snake5[0]

dec si
      
mov dx, si
mov ah, 02h
int 10h      
            
mov ah, 08h
mov bh, 0
int 10h

cmp al, 042
je Perdiste  
            

no_pega_25:  


cmp     cur_dir, down
je down_pos5
jne no_pega_35

down_pos5:
mov dx, b.snake5[0]

inc dh

mov ah, 02h
int 10h      
            
mov ah, 08h
mov bh, 0
int 10h

cmp al, 042
je Perdiste  
            

no_pega_35: 


cmp     cur_dir, up
je up_pos5
jne no_pega_45

up_pos5:
mov dx, b.snake5[0]

dec dh

mov ah, 02h
int 10h      
            
mov ah, 08h
mov bh, 0
int 10h

cmp al, 042
je Perdiste  
            

no_pega_45:

ret

Colicion5 endp 
               
               
Colicion6 proc
     
mov al, 0  
 
  
cmp     cur_dir, right
je right_pos6
jne no_pega_16  
 
right_pos6:
mov si, snake6[0]

inc si
      
mov dx, si
mov ah, 02h
int 10h      
            
mov ah, 08h
mov bh, 0
int 10h

cmp al, 042
je Perdiste  

no_pega_16:
 
 
  
cmp     cur_dir, left
je left_pos6
jne no_pega_26

left_pos6:
mov si, snake6[0]

dec si
      
mov dx, si
mov ah, 02h
int 10h      
            
mov ah, 08h
mov bh, 0
int 10h

cmp al, 042
je Perdiste  
            

no_pega_26:  


cmp     cur_dir, down
je down_pos6
jne no_pega_36

down_pos6:
mov dx, b.snake6[0]

inc dh

mov ah, 02h
int 10h      
            
mov ah, 08h
mov bh, 0
int 10h

cmp al, 042
je Perdiste  
            

no_pega_36: 


cmp     cur_dir, up
je up_pos6
jne no_pega_46

up_pos6:
mov dx, b.snake6[0]

dec dh

mov ah, 02h
int 10h      
            
mov ah, 08h
mov bh, 0
int 10h

cmp al, 042
je Perdiste  
            

no_pega_46:

ret

Colicion6 endp               
               

Mapa_new proc
;////////Sale la serpiente de su casa y cierra la puera 
cmp inicio, 1
jne abajo_n 


;creacion del mapa o campo de juego     abajo 80
lado_iz_n:
mov ah, 02h
mov dh, incremento     
mov dl, 0           
int 10h 

mov ah, 09
lea dx, contorno 
int 21h

inc incremento  
cmp incremento, 24
jne lado_iz_n 
 
mov incremento, 1 

parte_sup_n:
mov ah, 02h
mov dh, 0    
mov dl, incremento          
int 10h 

mov ah, 09
lea dx, contorno 
int 21h

inc incremento 
cmp incremento, 80
jne parte_sup_n 
              
mov incremento, 1            
            
lado_der_n:
mov ah, 02h
mov dh, incremento     
mov dl, 79           
int 10h 

mov ah, 09
lea dx, contorno 
int 21h

inc incremento 
cmp incremento, 24
jne lado_der_n 

mov incremento, 1 

parte_inf_n:
mov ah, 02h
mov dh, 23    
mov dl, incremento          
int 10h 

mov ah, 09
lea dx, contorno 
int 21h

inc incremento 
cmp incremento, 80
jne parte_inf_n 
 
abajo_n: 

cmp inicio, 7
je no_aumenta_n
inc inicio 

no_aumenta_n:  
;/////La variable ya no aumenta   
ret
Mapa_new endp 
 
        
Mapa proc
;////////Sale la serpiente de su casa y cierra la puera 
cmp inicio, 6 
je  llena
cmp inicio, 1 
jne abajo

mov cur_dir, 80
inc inicio
 
cmp inicio, 1
jne abajo
 
llena:

;creacion del mapa o campo de juego     abajo 80
lado_iz:
mov ah, 02h
mov dh, incremento     
mov dl, 0           
int 10h 

mov ah, 09
lea dx, contorno 
int 21h

inc incremento  
cmp incremento, 24
jne lado_iz 
 
mov incremento, 1 

parte_sup:
mov ah, 02h
mov dh, 0    
mov dl, incremento          
int 10h 

mov ah, 09
lea dx, contorno 
int 21h

inc incremento 
cmp incremento, 80
jne parte_sup 
              
mov incremento, 1            
            
lado_der:
mov ah, 02h
mov dh, incremento     
mov dl, 79           
int 10h 

mov ah, 09
lea dx, contorno 
int 21h

inc incremento 
cmp incremento, 24
jne lado_der 

mov incremento, 1 

parte_inf:
mov ah, 02h
mov dh, 23    
mov dl, incremento          
int 10h 

mov ah, 09
lea dx, contorno 
int 21h

inc incremento 
cmp incremento, 80
jne parte_inf 
 
abajo: 

cmp inicio, 7
je no_aumenta
inc inicio 

no_aumenta:  
;/////La variable ya no aumenta   
ret

Mapa endp
   
            
clrscr proc  
MOV AH,06h
MOV AL,0
MOV BH,07
MOV CH,0
MOV CL,0
MOV DH,84H
MOV DL,4AH
INT 10h       
;setea el mouse
MOV BH,0
MOV DL,0
MOV DH,0
MOV AH,02
INT 10h 

RET
clrscr endp


move_snake proc near

; establecer es en el segmento de informacion de BIOS:   
mov     ax, 40h
mov     es, ax

  ; punto DI a la cola
  mov   di, s_tam * 2 - 2
; mover todas las partes del cuerpo
   ; (el ultimo simplemente se va)
  mov   cx, s_tam-1
move_array:
  mov   ax, snake[di-2]
  mov   snake[di], ax
  sub   di, 2
  loop  move_array


cmp     cur_dir, left
  je    move_left
cmp     cur_dir, right
  je    move_right
cmp     cur_dir, up
  je    move_up
cmp     cur_dir, down
  je    move_down

jmp     stop_move       ; no hay direccion.


move_left:
  mov   al, b.snake[0]
  dec   al
  mov   b.snake[0], al
  cmp   al, -1
  jne   stop_move       
  mov   al, es:[4ah]    ; numero de columna.
  dec   al
  mov   b.snake[0], al  ; volver a la derecha
  jmp   stop_move

move_right:
  mov   al, b.snake[0]
  inc   al
  mov   b.snake[0], al
  cmp   al, es:[4ah]    ; numero de columna.  
  jb    stop_move
  mov   b.snake[0], 0   ; volver a la izquierda.
  jmp   stop_move

move_up:
  mov   al, b.snake[1]
  dec   al
  mov   b.snake[1], al
  cmp   al, -1
  jne   stop_move
  mov   al, es:[84h]    ;  numero de fila -1.
  mov   b.snake[1], al  ; volver al fondo.
  jmp   stop_move

move_down:
  mov   al, b.snake[1]
  inc   al
  mov   b.snake[1], al
  cmp   al, es:[84h]    ; numero de fila -1.
  jbe   stop_move
  mov   b.snake[1], 0   ; volver a la cima.
  jmp   stop_move

stop_move:
  ret      
         
move_snake endp    


move_snake2 proc near

; establecer es en el segmento de informacion de BIOS:   
mov     ax, 40h
mov     es, ax

  ; point di to tail
  mov   di, s_tam2 * 2 - 2
  ; move all body parts
  ; (last one simply goes away)
  mov   cx, s_tam2-1
move_array2:
  mov   ax, snake2[di-2]
  mov   snake2[di], ax
  sub   di, 2
  loop  move_array2


cmp     cur_dir, left
  je    move_left2
cmp     cur_dir, right
  je    move_right2
cmp     cur_dir, up
  je    move_up2
cmp     cur_dir, down
  je    move_down2

jmp     stop_move2       ; no direction.


move_left2:
  mov   al, b.snake2[0]
  dec   al
  mov   b.snake2[0], al
  cmp   al, -1
  jne   stop_move2       
  mov   al, es:[4ah]    ; col number.
  dec   al
  mov   b.snake2[0], al  ; return to right.
  jmp   stop_move2

move_right2:
  mov   al, b.snake2[0]
  inc   al
  mov   b.snake2[0], al
  cmp   al, es:[4ah]    ; col number.   
  jb    stop_move2
  mov   b.snake2[0], 0   ; return to left.
  jmp   stop_move2

move_up2:
  mov   al, b.snake2[1]
  dec   al
  mov   b.snake2[1], al
  cmp   al, -1
  jne   stop_move2
  mov   al, es:[84h]    ; row number -1.
  mov   b.snake2[1], al  ; return to bottom.
  jmp   stop_move2

move_down2:
  mov   al, b.snake2[1]
  inc   al
  mov   b.snake2[1], al
  cmp   al, es:[84h]    ; row number -1.
  jbe   stop_move2
  mov   b.snake2[1], 0   ; return to top.
  jmp   stop_move2

stop_move2:
  ret
move_snake2 endp

;------------------------------------------------------------------------
move_snake3 proc near

; set es to bios info segment:  
mov     ax, 40h
mov     es, ax

  ; point di to tail
  mov   di, s_tam3 * 2 - 2
  ; move all body parts
  ; (last one simply goes away)
  mov   cx, s_tam3-1
move_array3:
  mov   ax, snake3[di-2]
  mov   snake3[di], ax
  sub   di, 2
  loop  move_array3


cmp     cur_dir, left
  je    move_left3
cmp     cur_dir, right
  je    move_right3
cmp     cur_dir, up
  je    move_up3
cmp     cur_dir, down
  je    move_down3

jmp     stop_move3       ; no direction.


move_left3:
  mov   al, b.snake3[0]
  dec   al
  mov   b.snake3[0], al
  cmp   al, -1
  jne   stop_move3       
  mov   al, es:[4ah]    ; col number.
  dec   al
  mov   b.snake3[0], al  ; return to right.
  jmp   stop_move3

move_right3:
  mov   al, b.snake3[0]
  inc   al
  mov   b.snake3[0], al
  cmp   al, es:[4ah]    ; col number.   
  jb    stop_move3
  mov   b.snake3[0], 0   ; return to left.
  jmp   stop_move3

move_up3:
  mov   al, b.snake3[1]
  dec   al
  mov   b.snake3[1], al
  cmp   al, -1
  jne   stop_move3
  mov   al, es:[84h]    ; row number -1.
  mov   b.snake3[1], al  ; return to bottom.
  jmp   stop_move3

move_down3:
  mov   al, b.snake3[1]
  inc   al
  mov   b.snake3[1], al
  cmp   al, es:[84h]    ; row number -1.
  jbe   stop_move3
  mov   b.snake3[1], 0   ; return to top.
  jmp   stop_move3

stop_move3:
  ret
move_snake3 endp
;------------------------------------------------------------------------
move_snake4 proc near

; set es to bios info segment:  
mov     ax, 40h
mov     es, ax

  ; point di to tail
  mov   di, s_tam4 * 2 - 2
  ; move all body parts
  ; (last one simply goes away)
  mov   cx, s_tam4-1
move_array4:
  mov   ax, snake4[di-2]
  mov   snake4[di], ax
  sub   di, 2
  loop  move_array4


cmp     cur_dir, left
  je    move_left4
cmp     cur_dir, right
  je    move_right4
cmp     cur_dir, up
  je    move_up4
cmp     cur_dir, down
  je    move_down4

jmp     stop_move4       ; no direction.


move_left4:
  mov   al, b.snake4[0]
  dec   al
  mov   b.snake4[0], al
  cmp   al, -1
  jne   stop_move4       
  mov   al, es:[4ah]    ; col number.
  dec   al
  mov   b.snake4[0], al  ; return to right.
  jmp   stop_move4

move_right4:
  mov   al, b.snake4[0]
  inc   al
  mov   b.snake4[0], al
  cmp   al, es:[4ah]    ; col number.   
  jb    stop_move4
  mov   b.snake4[0], 0   ; return to left.
  jmp   stop_move4

move_up4:
  mov   al, b.snake4[1]
  dec   al
  mov   b.snake4[1], al
  cmp   al, -1
  jne   stop_move4
  mov   al, es:[84h]    ; row number -1.
  mov   b.snake4[1], al  ; return to bottom.
  jmp   stop_move4

move_down4:
  mov   al, b.snake4[1]
  inc   al
  mov   b.snake4[1], al
  cmp   al, es:[84h]    ; row number -1.
  jbe   stop_move4
  mov   b.snake4[1], 0   ; return to top.
  jmp   stop_move4

stop_move4:
  ret
move_snake4 endp 
;---------------------------------------------------------------
move_snake5 proc near

; set es to bios info segment:  
mov     ax, 40h
mov     es, ax

  ; point di to tail
  mov   di, s_tam5 * 2 - 2
  ; move all body parts
  ; (last one simply goes away)
  mov   cx, s_tam5-1
move_array5:
  mov   ax, snake5[di-2]
  mov   snake5[di], ax
  sub   di, 2
  loop  move_array5


cmp     cur_dir, left
  je    move_left5
cmp     cur_dir, right
  je    move_right5
cmp     cur_dir, up
  je    move_up5
cmp     cur_dir, down
  je    move_down5

jmp     stop_move5       ; no direction.


move_left5:
  mov   al, b.snake5[0]
  dec   al
  mov   b.snake5[0], al
  cmp   al, -1
  jne   stop_move5       
  mov   al, es:[4ah]    ; col number.
  dec   al
  mov   b.snake5[0], al  ; return to right.
  jmp   stop_move5

move_right5:
  mov   al, b.snake5[0]
  inc   al
  mov   b.snake5[0], al
  cmp   al, es:[4ah]    ; col number.   
  jb    stop_move5
  mov   b.snake5[0], 0   ; return to left.
  jmp   stop_move5

move_up5:
  mov   al, b.snake5[1]
  dec   al
  mov   b.snake5[1], al
  cmp   al, -1
  jne   stop_move5
  mov   al, es:[84h]    ; row number -1.
  mov   b.snake5[1], al  ; return to bottom.
  jmp   stop_move5

move_down5:
  mov   al, b.snake5[1]
  inc   al
  mov   b.snake5[1], al
  cmp   al, es:[84h]    ; row number -1.
  jbe   stop_move5
  mov   b.snake5[1], 0   ; return to top.
  jmp   stop_move5

stop_move5:
  ret
move_snake5 endp
;---------------------------------------------------------------
move_snake6 proc near

; set es to bios info segment:  
mov     ax, 40h
mov     es, ax

  ; point di to tail
  mov   di, s_tam6 * 2 - 2
  ; move all body parts
  ; (last one simply goes away)
  mov   cx, s_tam6-1
move_array6:
  mov   ax, snake6[di-2]
  mov   snake6[di], ax
  sub   di, 2
  loop  move_array6


cmp     cur_dir, left
  je    move_left6
cmp     cur_dir, right
  je    move_right6
cmp     cur_dir, up
  je    move_up6
cmp     cur_dir, down
  je    move_down6
jmp     stop_move6       ; no direction.


move_left6:
  mov   al, b.snake6[0]
  dec   al
  mov   b.snake6[0], al
  cmp   al, -1
  jne   stop_move6       
  mov   al, es:[4ah]    ; col number.
  dec   al
  mov   b.snake6[0], al  ; return to right.
  jmp   stop_move6

move_right6:
  mov   al, b.snake6[0]
  inc   al
  mov   b.snake6[0], al
  cmp   al, es:[4ah]    ; col number.   
  jb    stop_move6
  mov   b.snake6[0], 0   ; return to left.
  jmp   stop_move6

move_up6:
  mov   al, b.snake6[1]
  dec   al
  mov   b.snake6[1], al
  cmp   al, -1
  jne   stop_move6
  mov   al, es:[84h]    ; row number -1.
  mov   b.snake6[1], al  ; return to bottom.
  jmp   stop_move6

move_down6:
  mov   al, b.snake6[1]
  inc   al
  mov   b.snake6[1], al
  cmp   al, es:[84h]    ; row number -1.
  jbe   stop_move6
  mov   b.snake6[1], 0   ; return to top.
  jmp   stop_move6

stop_move6:
  ret 
  
Perdiste:   
mov ah, 02h
mov dh, 11     
mov dl, 33            ;De 0 a 79   39-mitad palabra            
int 10h 

mov ah, 09
lea dx, You_Lose 
int 21h

mov ah, 00h
int 16h    
       
ret       
move_snake6 endp