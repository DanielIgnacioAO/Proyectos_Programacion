; Programa: expresion.asm 
; Infija: a*b+c-d
; Posfija: ab*c+d-
text		segment 
			assume cs:text, ds:text, ss:text 
			org 100h
main:
			mov nomvar, 'a' 
			mov dx, offset msg1
			mov ah,9 
			int 21h 
			call lecdec 
			mov a,ax
			call saltaren
			mov nomvar, 'b' 
			mov dx, offset msg1
			mov ah,9 
			int 21h 
			call lecdec 
			mov b,ax
			call saltaren
			mov nomvar, 'c' 
			mov dx, offset msg1
			mov ah,9 
			int 21h 
			call lecdec 
			mov c,ax
			call saltaren
			mov nomvar, 'd' 
			mov dx, offset msg1
			mov ah,9 
			int 21h 
			call lecdec 
			mov d,ax
			call saltaren

			PUSH a
			PUSH b
			POP bx 
			POP ax 
			MUL bx 
			PUSH ax
			PUSH c
			POP bx 
			POP ax 
			ADD ax,bx 
			PUSH ax
			PUSH d
			POP bx 
			POP ax 
			SUB ax,bx 
			PUSH ax
			POP ax 

			mov res,ax 
			mov dx, offset msg2 
			mov ah,9
			int 21h 
			mov ax,res 
			call impdec 
			call saltaren 
			int 20h

buffer		db 6,0,6 dup(?) 
msg1		db 'Da el valor de '
nomvar		db 0 
			db ': $'
msg2		db 'El resultado es $' 
res			dw 0
a			dw 0
b			dw 0
c			dw 0
d			dw 0

impdec		proc near 
			push ax 
			push bx 
			push cx 
			push dx 
			mov bx,10 
			xor cx,cx
impdec0:	xor dx,dx 
			div bx 
			add dl,'0' 
			push dx 
			inc cx 
			cmp ax,0 
			jne impdec0
impdec1:	pop dx 
			mov ah,2 
			int 21h 
			loop impdec1 
			pop dx 
			pop cx 
			pop bx 
			pop ax 
			ret
impdec		endp

lecdec		proc near 
			push bx 
			push cx 
			push dx 
			push si 
			mov dx, offset buffer 
			mov ah,0ah 
			int 21h 
			xor ax,ax 
			mov bx,10 
			mov si, offset buffer 
			inc si 
			mov cl,[si] 
			xor ch,ch
lecdec0:	mul bx 
			inc si 
			mov dl,[si] 
			sub dl,'0' 
			xor dh,dh 
			add ax,dx 
			loop lecdec0 
			pop si 
			pop dx 
			pop cx 
			pop bx 
			ret
lecdec		endp

saltaren	proc 
			push ax 
			push dx 
			mov dl,0dh 
			mov ah,2 
			int 21h 
			mov dl,0ah 
			mov ah,2 
			int 21h 
			pop dx 
			pop ax 
			ret 
saltaren	endp

text		ends 
			end main