#Nombre: Arellano Ochoa Daniel Ignacio 
#No. de control: 19141118
import random
import os
from pynput import keyboard as kb

def juego():
    punto=0
    turno=1
    while(True):
        a = str(input("Presiona 1 para tirar, presiona 2 para finalizar el juego: "))
        os.system ("cls") 
        if(a=="1"):
            num1 = random.randint(1, 6)
            num2 = random.randint(1, 6)
            suma=num1 + num2
            print("Turno: " + str(turno))
            print("Tu tirada fue: " +  str(num1) + " y " + str(num2))
            print("Tu sumatoria es: " + str(suma))
            if(turno==1):
                if(suma == 7 or suma == 11):
                    print("---Ganaste---")
                    break
                elif(suma == 2 or suma == 8 or suma == 12):
                    print("---Pierdes---")
                    break
                else:punto=suma
            else:
                print("Tu punto es: " + str(punto))
                if(suma == 7):
                    print("---Pierdes---")
                    break
                elif(suma==punto):
                    print("---Ganas---")
                    break
            turno = turno + 1
        elif(a=="2"):
            break
        

op="1"
while(op=="1"):
    juego()
    os.system ("pause")
    os.system("cls")
    op=str(input("Desea volver a jugar: \n1)SI\n2)NO\n"))

print("Gracias por jugar")
os.system ("pause") 