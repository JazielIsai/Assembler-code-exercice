.286
title salto incondicional
pila segment stack
  db 125 dup(?)
pila ends
datos segment
	msg1 db '  No salto...$'
	msg2 db '  Terminado...$'
datos ends
;
codigo segment
	assume ds:datos,cs:codigo,ss:pila
	principal proc far	
		mov ax,datos
		mov ds,ax
        ;================================== INICIO ==========================================
		jmp Efin		; saltar hasta la etiqueta Efin
		call nuevaLinea
		lea dx, msg1
		call mostrarDXmsg
		Efin:
		call nuevaLinea
		lea dx, msg2
		call mostrarDXmsg
		;=============================== FIN ==============================================
		call pausa
		mov ah,4ch
		int 21h	
		ret
	principal endp
	mostrarDXmsg proc near
		mov ah,9
		int 21h
		ret
	mostrarDXmsg endp
	nuevaLinea proc near
		mov dl,10
		mov ah,2
		int 21h
		ret
	nuevaLinea endp	
	pausa proc near
		mov ah,08h
		int 21h
		ret
	pausa endp
codigo ends
end principal