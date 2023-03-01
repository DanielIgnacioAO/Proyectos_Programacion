
"""Declaración de la función.
Con esto damos a conocer la función al compilador. Desde este momento se puede mandar llamar.
la funcion horner permite evaluar a un polinomio en x valor dando de -parametros el valor de x, 
los coeficientes del polinomio y el grado"""
def horner(grado, coeficientes, x):
    polinomio = coeficientes[grado]
    k = grado - 1
    while (k >= 0):
        polinomio = coeficientes[k] + (polinomio*x)
        k = k - 1
	# Al término de este ciclo WHILE, la variable polinomio tiene el valor del P(x)
    return polinomio


i = 0
# pedir el grado
print("Ingrese el grado del polinomio")
grado = int(input())

# declara el polinomio como una lista vacía
coeficientes = []

# leer el polinomio
print("Ingrese los coeficientes empezando del término independiente:")
while (i <= grado):
	coeficientes.append(float(input()))
	i = i + 1
# Al término de este ciclo WHILE se tiene la lista de coeficientes del polinomio.

# pedir el valor para evaluar el polinomio
print ("Introduce x ")
x = float(input())

# Mandar llamar la función HORNER e imprimir.
print(horner(grado,coeficientes,x))

