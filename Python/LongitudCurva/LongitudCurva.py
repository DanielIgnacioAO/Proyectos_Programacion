
from Libreria import* 
print("""Bienvenido al programa para obtener el la longitud de curva""")

i = 0

grado=0
coeficientes = []
cifras=0
rango=[None]*2
metodo=0
"""
cifras=int(input("Escriba el numero de cifras significativas: "))
grado=int(input("Escriba el grado del polinomio: "))

# leer el polinomio
print("Ingrese los coeficientes empezando del término independiente:")
while (i <= grado):
	coeficientes.append(float(input()))
	i=i+1

print("Escriba el rango (a, b)")
rango[0]=float(input("Valor de a: "))
rango[1]=float(input("Valor de b: "))

metodo=int(input("Elige el metodo:\n1->Trapecio\n2->Simpson \n"))
"""


grado=2
#coeficientes = [8,-2,3,0,5]
coeficientes = [1,2,1]
cifras=5
rango=[1,2]
metodo=1


S=0
n=0
cifras=cifras
try:
    (S, n)=Longitud(coeficientes, rango[0], rango[1], cifras, metodo)
except ValueError as e:
	print(e)

print("La longitud de curva es de:", S, "unidades, con", n, "particiones")

"""
aux=0
auxp=0
auxi=0
for i in range(0,10,1):
	if(i==0 or i==10):
		aux=aux+distpuntos(coeficientes, i)
	if(i%2==0 and i!=0 and i!=10):
		auxp=auxp+distpuntos(coeficientes, i)
	if(i%2!=0 and i!=0 and i!=10):
		auxi=auxi+distpuntos(coeficientes, i)


auxp=2*auxp
auxi=4*auxi
aux=aux+auxi+auxp
aux=aux/3
#print("auxi= ", auxi)
#print("auxp= ", auxp)
print("aux= ", aux)


aux2=IntegralSimpson(0, 10, 10, coeficientes)
print("aux2= ", aux2)
"""