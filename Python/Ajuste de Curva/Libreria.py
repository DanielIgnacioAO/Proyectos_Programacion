from math import*
from fractions import Fraction
from decimal import Decimal
import numpy as np

def crearMatriz(x,y,grado):
    n=grado+1
    matriz=[]
    fila=[]
    k=0
    l=0

    for i in range(n):
        k=l
        for j in range(n):
            aux=sumatoriaPuntos(x,k)
            fila.append(aux)
            k=k+1
               
        aux=sumatoriaProducto(y,x,l)
        fila.append(aux)
        #print("fila ", fila)
        matriz.append(list.copy(fila))
        #print("matriz ", matriz)
        list.clear(fila)
        l=l+1

    matriz=np.array(matriz)
    return matriz

def sumatoriaPuntos(x, potencia):
    suma=0
    for v in x:
        suma=suma+(v**potencia)
    return suma

def sumatoriaProducto(y,x,potencia):
    suma=0
    for i in range(len(y)):
        suma=suma+(y[i]*(x[i]**potencia))
    return suma

def GaussJordan(matriz):
    # Método de Gauss-Jordan
    # Solución a Sistemas de Ecuaciones
    # de la forma A.X=B

    # PROCEDIMIENTO
    casicero = 1e-15 # Considerar como 0

    AB = np.copy(matriz)

    # Pivoteo parcial por filas
    tamano = np.shape(AB)
    n = tamano[0]
    m = tamano[1]

    # Para cada fila en AB
    for i in range(0,n-1,1):
        # columna desde diagonal i en adelante
        columna = abs(AB[i:,i])
        dondemax = np.argmax(columna)
    
        # dondemax no está en diagonal
        if (dondemax !=0):
            # intercambia filas
            temporal = np.copy(AB[i,:])
            AB[i,:] = AB[dondemax+i,:]
            AB[dondemax+i,:] = temporal
        
    AB1 = np.copy(AB)

    # eliminacion hacia adelante
    for i in range(0,n-1,1):
        pivote = AB[i,i]
        adelante = i + 1
        for k in range(adelante,n,1):
            factor = AB[k,i]/pivote
            AB[k,:] = AB[k,:] - AB[i,:]*factor
    AB2 = np.copy(AB)

    # elimina hacia atras
    ultfila = n-1
    ultcolumna = m-1
    for i in range(ultfila,0-1,-1):
        pivote = AB[i,i]
        atras = i-1 
        for k in range(atras,0-1,-1):
            factor = AB[k,i]/pivote
            AB[k,:] = AB[k,:] - AB[i,:]*factor
        # diagonal a unos
        AB[i,:] = AB[i,:]/AB[i,i]
    X = np.copy(AB[:,ultcolumna])
    #X = np.transpose([X])
    aux=list(X)
    aux.reverse()

    # SALIDA
    #print('Matriz aumentada:')
    #print(matriz)
    #print('Pivoteo parcial por filas')
    #print(AB1)
    #print('eliminacion hacia adelante')
    #print(AB2)
    #print('eliminación hacia atrás')
    #print(AB)
    #print('solución de X: ')
    return aux