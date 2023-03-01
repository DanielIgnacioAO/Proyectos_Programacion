from Libreria import* 


#matriz[fila][columna]
"""
filas = int(input("FILAS: "))

#matriz = crearMatriz(filas, filas)
matriz = llenarMatriz(matriz)

print("Matriz")
for i in matriz:
    print(i)

matriz=transpuesta(matriz)


print("Transpuesta")
for i in matriz:
    print(i)

A=[[1,2,3],[4,5,6],[7,8,9]]
B=[[1,3,5],[2,4,6],[0,0,0]]
C=[[1,3,5],
   [0,3,6],
   [0,4,7]]


pro=productoMatrices(A,B)
print("Producto de matrices")
for i in pro:
    print(i)

val=isTriangularSuperior(C)

print(bool(val))"""

#A=[[1,1],[1,1]] #LD
#A=[[12, -51, 4],   [6, 167, -68],   [-4, 24, -41]] #Si lo obtiene
#A=[[1,2,3],[4,5,6],[7,8,9]] #no los obtiene
#A=[[1,2,3,4],[2,4,6,8],[1,3,5,7],[9,8,7,6]] #nan
#A=[[3,-1,0],[-1,2,-1],[0,-1,3]] #si puede
A=[[1,1,1],[2,0,-1],[1,-1,1]]

#A=ortonormalizarMatCol(A)
#A=GrandSchmidt(A)

for i in A:
    print(i)

print("Eigen")
B=eigenQR(A)
for j in B:
    print(j)


