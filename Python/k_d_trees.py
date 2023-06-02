# A Python program to demonstrate operations of KD tree
import sys
import os
 
# Number of dimensions
k = 2
 
# A structure to represent node of kd tree
class Node:
    def __init__(self, point):
        self.point = point
        self.left = None
        self.right = None
 
# A method to create a node of K D tree
def newNode(point):
    return Node(point)
 
# Inserts a new node and returns root of modified tree
# The parameter depth is used to decide axis of comparison
def insertRec(root, point, depth):
    # Tree is empty?
    if not root:
        return newNode(point)
 
    # Calculate current dimension (cd) of comparison
    cd = depth % k
 
    # Compare the new point with root on current dimension 'cd'
    # and decide the left or right subtree
    if point[cd] < root.point[cd]:
        root.left = insertRec(root.left, point, depth + 1)
    else:
        root.right = insertRec(root.right, point, depth + 1)
 
    return root
 
# Function to insert a new point with given point in
# KD Tree and return new root. It mainly uses above recursive
# function "insertRec()"
def insert(root, point):
    return insertRec(root, point, 0)
 
# A utility method to determine if two Points are same
# in K Dimensional space
def arePointsSame(point1, point2):
    # Compare individual coordinate values
    for i in range(k):
        if point1[i] != point2[i]:
            return False
 
    return True
 
# Searches a Point represented by "point[]" in the K D tree.
# The parameter depth is used to determine current axis.
def searchRec(root, point, depth, father, num_comparacion):
    num_comparacion+=1
    # Base cases
    if not root:
        return False, father, num_comparacion
    if arePointsSame(root.point, point):
        return True, father, num_comparacion
 
    # Current dimension is computed using current depth and total
    # dimensions (k)
    cd = depth % k
 
    # Compare point with root with respect to cd (Current dimension)
    if point[cd] < root.point[cd]:
        return searchRec(root.left, point, depth + 1, root, num_comparacion)
 
    return searchRec(root.right, point, depth + 1, root, num_comparacion)
 
# Searches a Point in the K D tree. It mainly uses
# searchRec()
def search(root, point):
    # Pass current depth as 0
    return searchRec(root, point, 0, None,0)
 
#distancia euclidiana
def distancia_euclidiana(punto_p, punto_q):
    suma = 0
    for i in range(k):
        suma = suma + pow(punto_p[i] - punto_q[i],2)
    return pow(suma, 1/2)

# Driver program to test above functions
if __name__ == '__main__':
    root = None
    points = [[3, 6], [17, 15], [13, 15], [6, 12], [9, 1], [2, 7], [10, 19]]
 
    n = len(points)
 
    for i in range(n):
        root = insert(root, points[i])

    os.system("cls")
    repetir=True
    while(repetir):
        print("Para el punto de " + str(k) + " dimensiones escribe: ")
        pointx=[]
        for j in range(k):
            x=float(input("Valor del eje " + str(j+1) + ": "))
            pointx.append(x)

        encontrado, ultimo_nodo, comparaciones = search(root, pointx)
        if encontrado: 
            print(" FOUND!!!")
            print("     El nodo mas cercano es: " + str(ultimo_nodo.point))
            print("     Con una distancia euclidiana de: " + str(distancia_euclidiana(pointx, ultimo_nodo.point)))
            print("     Total de comparaciones: " + str(comparaciones))
        else: 
            insert(root, pointx)
            print(" NOT found, ha sido insertado")
            print("     El nodo mas cercano es: " + str(ultimo_nodo.point))
            print("     Con una distancia euclidiana de: " + str(distancia_euclidiana(pointx, ultimo_nodo.point)))
            print("     Total de comparaciones: " + str(comparaciones))
        repetir = True if( input("Deseas colocar otro punto?(y -> Si): ") == "y") else False
        print("")
    #point1 = [10, 19] Found
    #point2 = [12, 19] not found
         
# This code is contributed by Prajwal Kandekar