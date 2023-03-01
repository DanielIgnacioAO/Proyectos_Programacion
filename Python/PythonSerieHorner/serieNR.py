#Importación de la librería con la palabra IMPORT
from PythonSerieHorner import *

# A partir de esta línea de código empieza el bloque principal. 
i = 0 

# Declarar una lista vacía.
coeficientes = []

print ("introduce el grado del polinomio")
grado = int(input())

# Una vez conocido el grado del polinomio, pedimos los (grado+1) coeficientes:
while (i <= grado):
 print ("introduce el coeficiente a_",i)
 coeficientes.append(float(input()))
 i = i + 1
# al término de este ciclo WHILE, la lista está llena

print ("los coeficientes del polinomio son:")
print (coeficientes)

# Creación de una lista vacía para almacenar la derivada calculada por la función DERIV de la librería.
derivada = []
derivada = deriv(grado, coeficientes)
print ("La derivada es:")
print (derivada)

""" A partir de las siguientes instrucciones se implementa el código para el algoritmo de Newton-Raphson. Se plantea con un número fijo de iteraciones para hacerlo funcionar. Eventualmente este número fijo de iteraciones se sustituirá por el error y la tolerancia.

Recordar que el método de N-R consiste en iterar la expresión 

x_(i+1) = xi - f(xi)/f'(xi)

"""
# Pedir el valor inicial x0. Se guarda en la variable xi.
print ("introduce el valor inicial de prueba")
xi = float(input())

# reiniciar la variable i en 0. Ésta nos ayudará a contar las veces que repetimos el algoritmo. 
i = 0
while (i < 10):
 # Obtener el valor actual x_(i+1)
 x_imas1 = xi-(horner(grado,coeficientes,xi)/horner(grado-1,derivada,xi))

 print("la aproximacion de la raiz numero ",i,"es :")
 print(x_imas1)

 # El valor que se acaba de obtener es la i-ésima aproximación actual. Una vez obtenida, se toma como el valor xi y se vuelve a meter al polinomio. 
 xi = x_imas1
 i = i + 1
# Al término de este ciclo WHILE, la variable x_imas1 contiene la décima aproximación a la raíz del polinomio.

