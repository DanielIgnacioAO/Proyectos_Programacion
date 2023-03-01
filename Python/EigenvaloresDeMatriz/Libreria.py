from math import*
#funcion para crear una matriz nxm
def crearMatriz(m, n):
    return [[0 for j in range(n)] for i in range(m)]

#funcion para llenar una matriz 
def llenarMatriz(matriz):
    i=0
    j=0
    for i in range(len(matriz)): 
        for j in range(len(matriz[i])):
            print("Fila: "+str(i)+" Columna: "+str(j))
            matriz[i][j]=float(input())
            j=j+1
        i=i+1

    return matriz

#funcion para transponer una matriz nxn
def transpuesta(matriz):
    matrizTra = crearMatriz(len(matriz),len(matriz))
    i=0
    j=0
    for i in range(len(matriz)): 
        for j in range(len(matriz[i])):
            matrizTra[j][i]=matriz[i][j]
            #j=j+1
        #i=i+1
    return matrizTra
 
#producto de Matrices filaA x columnaB
def productoMatrices(matrizA, matrizB):
    matrizProducto=crearMatriz(len(matrizA), len(matrizB[0]))
    A=[]
    B=[]
    A=matrizA
    B=matrizB
    i=0
    j=0
    for i in range(len(matrizA)):
        for j in range(len(matrizB[0])):
            matrizProducto[i][j]=productoPunto(matrizA[i], matrizColumna(matrizB, j))
 
    return matrizProducto
            
    

#metodo que regresa un vector con los elementos de i columna
def matrizColumna(matriz, i):
    columna=[None]*len(matriz)
    A=[]
    A=matriz
    j=0
    for j in range(len(matriz)):
        columna[j]=matriz[j][i]
    return columna

#Producto Punto
def productoPunto(vectorA, vectorB):
    
    if len(vectorA)==len(vectorB):
        i=0
        suma=0
        producto=0
        for i in range(len(vectorA)):
            producto=vectorA[i]*vectorB[i]
            suma=suma+producto
        return suma

    else:
        return None

    
#funcion que comprueba si una matriz es triangular superior
#i son fila j son columnas 
def isTriangularSuperior(matriz):
    A=[]
    A=matriz
    for i in range(len(matriz)):
        for j in range(len(matriz[0])):
            if j < i:
                if A[i][j] == 0:
                    {}
                else:
                    return 0
    return 1

#Grand-Schmidt
#Q es el ortogonalizado
#V no la original
def GrandSchmidt(matriz):
    V=[]
    V=matriz
    Q=crearMatriz(len(matriz), len(matriz[0]))
    Q[0]=V[0]
    suma=[0]*len(V[0])
    for i in range(len(V)):
        for j in range(i):
            aux=( PIGV(V[i], Q[j]) / PIGV(Q[j], Q[j]) )
            aux2=productoEscVec(aux, Q[j])
            suma=sumaVectorial(suma, aux2)
        suma=productoEscVec(-1,suma)
        Q[i]=sumaVectorial(V[i], suma)
        suma=[0]*len(V[0])



    return Q

#Producto Interno General de Vectores
def PIGV(vectorA, vectorB):
    if len(vectorA) == len(vectorB):
        producto=0
        for i in range(len(vectorA)):
            producto=producto + vectorA[i]*vectorB[i]
        return producto

#funcion que multiplica un escalar por vector
def productoEscVec(escalar, vector):
    B=[None]*len(vector)
    for i in range(len(vector)):
        B[i]=escalar * vector[i]
    return B

#funcion que suma dos vectores
def sumaVectorial(vectorA, vectorB):
    if len(vectorA) == len(vectorB):
        C=[None]*len(vectorA)
        for i in range(len(vectorA)):
            C[i]=vectorA[i]+vectorB[i]
        return C

#metodo que ortonormaliza las columnas de una matriz
def ortonormalizarMatCol(matriz):
    A=[]
    A=transpuesta(matriz)
    A=GrandSchmidt(A)
    B=crearMatriz(len(A), len(A[0]))
    try:
        for i in range(len(A)):
            B[i]=normalizarVector(A[i])
    except ValueError as e:
        print("Las columnas de la Matriz son Linealmente Dependientes")
    B=transpuesta(B)
    return B

#metodo que obtiene la norma de un vector
def normaVector(vector):
    norma=0
    for i in vector:
        norma=norma + i**2
    norma=sqrt(norma)
    return norma

#metodo que normaliza un vector
def normalizarVector(vector):
    A=[None] * len(vector)
    norma=normaVector(vector)
    if norma == 0:
        raise ValueError("La norma es 0") 
    for i in range(len(vector)):
        A[i]=vector[i] / norma
    return A

#Algoritmo QR para obtener eigenvalores
def eigenQR(matriz):
    Ai=matriz
    Qi=crearMatriz(len(matriz), len(matriz[0]))
    Ri=crearMatriz(len(matriz), len(matriz[0]))
    Ai_mas=matriz
    j=0
    while(isTriangularSuperior(Ai_mas)==0):
        Qi=ortonormalizarMatCol(Ai)
        aux=transpuesta(Qi)
        Ri=productoMatrices(aux,Ai)
        Ai_mas=productoMatrices(Ri,Qi)
        Ai=Ai_mas
        j=j+1
        Ai_mas=redondearMatriz(Ai_mas)
        if j==10000:
            break
       
    return Ai_mas

    resultado=[None]*len(matriz)
    for i in range(len(resultado)):
        resultado[i]=Ai_mas[i][i]
    return resultado

def redondearMatriz(matriz):
    B=[]
    B=matriz
    for i in range(len(B)):
        for j in range(len(B[0])):
            B[i][j]=round(B[i][j],10)
    return B