; a short program to check how
; set and get pixel color works
name "pixel"
org  100h   
PUTC    MACRO   char
        PUSH    AX
        MOV     AL, char
        MOV     AH, 0Eh
        INT     10h     
        POP     AX
ENDM
;;;;;
; first and second number:
num1 dw ?
num2 dw ? 
num3 dw ?
start:
lea dx, msg1
mov ah, 09h    ; output string at ds:dx
int 21h  
; get the multi-digit signed number
; from the keyboard, and store
; the result in cx register:
call scan_num
; store first number:
mov num1, cx ;x coordinate
; new line:
putc 0Dh
putc 0Ah  
lea dx, msg2
mov ah, 09h
int 21h  
; get the multi-digit signed number
; from the keyboard, and store
; the result in cx register:
call scan_num
; store second number:
mov num2, cx  
putc 0Dh
putc 0Ah  
lea dx, msg3
mov ah, 09h
int 21h  
; get the multi-digit signed number
; from the keyboard, and store
; the result in cx register:
call scan_num
; store third number:
mov num3, cx 
mov si,num1 ;x coordinate
mov di,num2 ;y coordinate
mov bp,num3 ;radius
mov ah, 0   ; set display mode function.
mov al, 13h ; mode 13h = 320x200 pixels, 256 colors.
int 10h     ; set it!   
mov sp,0 ;center point
         ;radius
          ;first point
mov bx,1  ;(1-r) condition
sub bx,bp ;same as above  
jmp x1
x1:
cmp bx,0  ;condition compare 
JL condt1
jmp condt2
condt1:
            ;increment x by 1
add bx,1;value for P(k+1)
mov ax,2 
add sp,1
mul sp
add bx,ax 
cmp sp,bp
jae done
mov cx, sp ;1(x,y)
add cx,si  ; column
mov dx, bp
add dx,di  ; row
mov al, 15  ; white
mov ah, 0ch ; put pixel
int 10h
xor al, al  ; al = 0
mov cx, 10  ; column
mov dx, 20  ; row
mov ah, 0dh ; get pixel
int 10h
; pause the screen for dos compatibility:  
mov cx, bp ;2(y,x)
add cx,si  ; column
mov dx, sp
add dx,di  ; row
mov al, 15  ; white
mov ah, 0ch ; put pixel
int 10h
xor al, al  ; al = 0
mov cx, 10  ; column
mov dx, 20  ; row
mov ah, 0dh ; get pixel
int 10h
  ;3  (-x,-y)
mov ax,-1
mul sp
add ax,si
mov cx, ax ; column
mov ax,-1
mul bp
add ax,di
mov dx,ax  ; row
mov al, 15  ; white
mov ah, 0ch ; put pixel
int 10h
xor al, al  ; al = 0
mov cx, 10  ; column
mov dx, 20  ; row
mov ah, 0dh ; get pixel
int 10h 
;4  (-y,-x)
mov ax,-1
mul bp
add ax,si 
mov cx, ax ; column
mov ax,-1
mul sp
add ax,di
mov dx,ax  ; row
mov al, 15  ; white
mov ah, 0ch ; put pixel
int 10h
xor al, al  ; al = 0
mov cx, 10  ; column
mov dx, 20  ; row
mov ah, 0dh ; get pixel  
int 10h  
mov cx, sp ;5(x,-y)
add cx,si  ; column
mov ax,-1
mul bp
add ax,di
mov dx,ax  ; row
mov al, 15  ; white
mov ah, 0ch ; put pixel
int 10h
xor al, al  ; al = 0
mov cx, 10  ; column
mov dx, 20  ; row
mov ah, 0dh ; get pixel
int 10h
mov cx, bp ;6(y,-x)
add cx,si  ; column
mov ax,-1
mul sp
add ax,di
mov dx,ax  ; row
mov al, 15  ; white
mov ah, 0ch ; put pixel
int 10h
xor al, al  ; al = 0
mov cx, 10  ; column
mov dx, 20  ; row
mov ah, 0dh ; get pixel
int 10h 
;7  (-y,x)
mov ax,-1
mul bp
add ax,si 
mov cx, ax ; column
mov dx, sp
add dx,di  ; row
mov al, 15  ; white
mov ah, 0ch ; put pixel
int 10h
xor al, al  ; al = 0
mov cx, 10  ; column
mov dx, 20  ; row
mov ah, 0dh ; get pixel
int 10h
;8(-x,y)
mov ax,-1
mul sp
add ax,si 
mov cx, ax ; column
mov dx, bp
add dx,di  ; row
mov al, 15  ; white
mov ah, 0ch ; put pixel
int 10h
xor al, al  ; al = 0
mov cx, 10  ; column
mov dx, 20  ; row
mov ah, 0dh ; get pixel
int 10h
jmp x1
condt2: 
mov ax,2
sub bp,1
mul bp
sub bx,ax
mov ax,2
add sp,1
mul sp
add bx,ax
add bx,1 
cmp sp,bp
jae done
mov cx, sp ;1(x,y)
add cx,si  ; column
mov dx, bp
add dx,di  ; row
mov al, 15  ; white
mov ah, 0ch ; put pixel
int 10h
xor al, al  ; al = 0
mov cx, 10  ; column
mov dx, 20  ; row
mov ah, 0dh ; get pixel
int 10h
; pause the screen for dos compatibility:  
mov cx, bp ;2(y,x)
add cx,si  ; column
mov dx, sp
add dx,di  ; row
mov al, 15  ; white
mov ah, 0ch ; put pixel
int 10h
xor al, al  ; al = 0
mov cx, 10  ; column
mov dx, 20  ; row
mov ah, 0dh ; get pixel
int 10h
 ;3  (-x,-y)
mov ax,-1
mul sp
add ax,si
mov cx, ax ; column
mov ax,-1
mul bp
add ax,di
mov dx,ax  ; row
mov al, 15  ; white
mov ah, 0ch ; put pixel
int 10h
xor al, al  ; al = 0
mov cx, 10  ; column
mov dx, 20  ; row
mov ah, 0dh ; get pixel
int 10h 
;4  (-y,-x)
mov ax,-1
mul bp
add ax,si 
mov cx, ax ; column
mov ax,-1
mul sp
add ax,di
mov dx,ax  ; row
mov al, 15  ; white
mov ah, 0ch ; put pixel
int 10h
xor al, al  ; al = 0
mov cx, 10  ; column
mov dx, 20  ; row
mov ah, 0dh ; get pixel  
int 10h  
mov cx, sp ;5(x,-y)
add cx,si  ; column
mov ax,-1
mul bp
add ax,di
mov dx,ax  ; row
mov al, 15  ; white
mov ah, 0ch ; put pixel
int 10h
xor al, al  ; al = 0
mov cx, 10  ; column
mov dx, 20  ; row
mov ah, 0dh ; get pixel
int 10h
mov cx, bp ;6(y,-x)
add cx,si  ; column
mov ax,-1
mul sp
add ax,di
mov dx,ax  ; row
mov al, 15  ; white
mov ah, 0ch ; put pixel
int 10h
xor al, al  ; al = 0
mov cx, 10  ; column
mov dx, 20  ; row
mov ah, 0dh ; get pixel
int 10h 
;7  (-y,x)
mov ax,-1
mul bp
add ax,si 
mov cx, ax ; column
mov dx, sp
add dx,di  ; row
mov al, 15  ; white
mov ah, 0ch ; put pixel
int 10h
xor al, al  ; al = 0
mov cx, 10  ; column
mov dx, 20  ; row
mov ah, 0dh ; get pixel
int 10h
;8(-x,y)
mov ax,-1
mul sp
add ax,si 
mov cx, ax ; column
mov dx, bp
add dx,di  ; row
mov al, 15  ; white
mov ah, 0ch ; put pixel
int 10h
xor al, al  ; al = 0
mov cx, 10  ; column
mov dx, 20  ; row
mov ah, 0dh ; get pixel
int 10h
jmp x1
 done:    
int 20h
SCAN_NUM        PROC    NEAR
        PUSH    DX
        PUSH    AX
        PUSH    SI      
        MOV     CX, 0
        ; reset flag:
      MOV     CS:make_minus, 0
next_digit:
        ; get char from keyboard
        ; into AL:
        MOV     AH, 00h
        INT     16h
        ; and print it:
        MOV     AH, 0Eh
        INT     10h
        ; check for MINUS:
        CMP     AL, '-'
        JE      set_minus
        ; check for ENTER key:
        CMP     AL, 0Dh  ; carriage return?
        JNE     not_cr
        JMP     stop_input
not_cr:
        CMP     AL, 8                   ; 'BACKSPACE' pressed?
        JNE     backspace_checked
        MOV     DX, 0                   ; remove last digit by
        MOV     AX, CX                  ; division:
        DIV     CS:ten                  ; AX = DX:AX / 10 (DX-rem).
        MOV     CX, AX
        PUTC    ' '                     ; clear position.
        PUTC    8                       ; backspace again.
        JMP     next_digit
backspace_checked:
        ; allow only digits:
        CMP     AL, '0'
        JAE     ok_AE_0
        JMP     remove_not_digit
ok_AE_0:        
        CMP     AL, '9'
        JBE     ok_digit
remove_not_digit:       
        PUTC    8       ; backspace.
        PUTC    ' '     ; clear last entered not digit.
        PUTC    8       ; backspace again.        
        JMP     next_digit ; wait for next input.       
ok_digit:
        ; multiply CX by 10 (first time the result is zero)
        PUSH    AX
        MOV     AX, CX
        MUL     CS:ten                  ; DX:AX = AX*10
        MOV     CX, AX
       POP     AX
        ; check if the number is too big
        ; (result should be 16 bits)
        CMP     DX, 0
        JNE     too_big
        ; convert from ASCII code:
        SUB     AL, 30h
        ; add AL to CX:
        MOV     AH, 0
        MOV     DX, CX      ; backup, in case the result will be too big.
        ADD     CX, AX
        JC      too_big2    ; jump if the number is too big.
        JMP     next_digit
set_minus:
        MOV     CS:make_minus, 1
        JMP     next_digit
too_big2:
        MOV     CX, DX      ; restore the backuped value before add.
        MOV     DX, 0       ; DX was zero before backup!
too_big:
        MOV     AX, CX
        DIV     CS:ten  ; reverse last DX:AX = AX*10, make AX = DX:AX / 10
        MOV     CX, AX
        PUTC    8       ; backspace.
        PUTC    ' '     ; clear last entered digit.
        PUTC    8       ; backspace again.        
        JMP     next_digit ; wait for Enter/Backspace.     
     stop_input:
        ; check flag:
        CMP     CS:make_minus, 0
        JE      not_minus
        NEG     CX
not_minus:
        POP     SI
        POP     AX
        POP     DX
        RET
make_minus      DB      ?       ; used as a flag.
SCAN_NUM        ENDP 
msg1 db "enter x coordinate:  $" 
msg2 db "enter y coordinate:  $"
msg3 db "enter radius:  $"  
ten             DW      10    
ret