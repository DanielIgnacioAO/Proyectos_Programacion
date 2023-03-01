'''
    Programa: rangoPrimos.py
    Funcion: Determian la cantidad de numeros primos en un rango de dos numeros,
            ademas de calcular el tiempo que tarda en hacerlo.
    
    Nombre: Arellano Ochoa Daniel Ignacio
    No. de control: 19141118 
'''
import time
inf = int(input('Limite inferior= '))
sup = int(input('Limite superior= '))
lista = []
cont =0
inicio = time.time()
for n in range(inf, sup + 1):
    for d in range(1, (n + 1)):
        if n % d == 0:
            cont += 1
            if cont > 2:
                break
    if cont == 2:
        lista.append(n)
    cont = 0

fin = time.time()
print('Numero de primos:',len(lista))
print('Tiempo de ejecucion:',fin-inicio,'seg.')