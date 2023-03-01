from Libreria import* 
from fractions import Fraction
from decimal import Decimal
import numpy as np
import os

grado=1

#D:\Documents\Archivos
puntos = open("D:\Documents\Archivos\Puntos.txt", "r")
lineas = puntos.readlines()
puntos.close()

x=[]
y=[]
i=1
aux=""
for l in lineas:
    if(l==lineas[0]):
        grado=int(l)
        continue
    i=1
    while(l[i]!=','):
        aux=aux+l[i]
        i=i+1
    x.append(float(aux))
    i=i+1 #salta la coma
    aux=""
    while(l[i]!=')'):
        aux=aux+l[i]
        i=i+1
    y.append(float(aux))
    aux=""

print("==============================================================================================================")    
print("Grado=", grado)
print("Xs= ", x)
print("Ys= ", y)

print("==============================================================================================================")
print("MATRIZ\n")
matriz=crearMatriz(x,y,grado)
print(matriz)

print("==============================================================================================================")
print("Solucion de Gauss-Jordan\n")
G=GaussJordan(matriz)
print(G)

print("==============================================================================================================")
print("Polinomio Ajustado\n")
for i in G:
    print(i, "(X^"+str(grado)+")")
    grado=grado-1

print("==============================================================================================================")
os.system("pause")