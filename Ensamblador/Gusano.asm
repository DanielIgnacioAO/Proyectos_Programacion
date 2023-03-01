;iz de ab ar  
include LINEAS2.txt
org 100h

jmp start:   
x dw 0
y dw 0
col db 12  

start:      
    mov ah, 00
    mov al, 13h
    int 10h 

    CICLO:
        mov ah, 0     ;lee un caracter
        int 16h

        cmp ah, 48h   ;si es tecla arriba salta
        je AR

        cmp ah, 50h   ;si es tecla abajo salta
        je AB

        cmp ah, 4Dh   ;si es tecla derecha salta
        je DE

        cmp ah, 4Bh   ;si es tecla izquierda salta
        je IZ    
        
        cmp al, 31h
        je COLOR
        cmp al, 32h
        je COLOR
        cmp al, 33h
        je COLOR
        cmp al, 34h
        je COLOR
        cmp al, 35h
        je COLOR
        cmp al, 36h
        je COLOR
        cmp al, 37h
        je COLOR
        cmp al, 38h
        je COLOR  
        cmp al, 39h
        je COLOR
    
        cmp ah, 01h   ;si escape salta (esc= ah(01h)  al(1Bh))
        je FIN

    jmp CICLO


          
IZ:                             
    dec x
    HorizontalIzq x,y,1,col  ;Macro 
    jmp CICLO

DE:                             
    inc x
    HorizontalDer x,y,1,col  ;Macro  
    jmp CICLO

AB:  
    inc y
    VerticalAba x, y, 1,col  ;Macro  
    jmp CICLO
        
AR:                               
    dec y
    VerticalArr x, y, 1,col  ;Macro   
    jmp CICLO
    
COLOR:
    sub al, 30h
    mov col, al


FIN:    
    cmp al, 1Bh     ;si escape continua (esc= ah(01h)  al(1Bh))
        jne CICLO     
        
    mov ah, 00      ;cambio a modo texto
    mov al, 03
    int 10h       
    
    ret



