
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt
include LINEAS.txt
org 100h
jmp start:
lado dw 90  ;tam de cada lado del cuadrado
x dw 0      ;posicion de x
y dw 0      ;posicion de y   
msg1 db "Dame un numero menor a 100: ",24h
vecNum db 3, ?, 2 dup(' ')  ;2=tam, ?=No. caracteres leido, 2=espacio es blanco, tam                                   

start:
    
    mov dx, offset msg1
    mov ah, 09h
    int 21h
    
    mov dx, offset vecNum
    mov ah, 0ah
    int 21h
    
    mov cx, 0h
    mov cl, vecNum[1]      
      
    cmp cl, 02
    je dosDigitos
  
    cmp cl, 01
    je unDigito

dosDigitos:
    mov ax, 0h
    mov al, vecNum[2]
    sub al, 30h
    mov bl, 10
    mul bl
    
    mov cx, 0h
    mov cl, vecNum[3]
    sub cl, 30h
    add cx, ax
    
    mov lado, cx
    jmp Cuadrado          

unDigito:
    mov cx, 0h
    mov cl, vecNum[2] 
    sub cl, 30h
    mov lado, cx
    jmp Cuadrado
 
Cuadrado:
    mov ah, 00    ;cambio a modo grafico
    mov al, 13h
    int 10h 


    HorizontalDer x,y,lado  ;Macro 
        mov ax, x           ;aumenta la posicion en x
        add ax, lado   
        mov x, ax
    VerticalAba x, y, lado  ;Macro
        mov ax, y           ;aumenta la posicion en y
        add ax, lado
        mov y, ax
    HorizontalIzq x,y,lado  ;Macro
        mov ax, x           ;disminuye la posicion en x
        sub ax, lado
        mov x, ax 
    VerticalArr x, y, lado  ;Macro
 
    mov  ah, 00     ;espera un key
    int 16h 
 
    mov ah, 00      ;cambio a modo texto
    mov al, 03
    int 10h     

ret




