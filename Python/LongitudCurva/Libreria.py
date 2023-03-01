
from math import*
#metodo que deriva un polinomio
def deriv(grado, coeficientes):
	derivadas=[None]*grado
	i=1
	while(i<=grado):
		derivadas[i-1]=i*coeficientes[i]
		i=i+1
	return derivadas


#horner
def horner(grado, coeficientes, x):
	polinomio = coeficientes[grado]
	k = grado - 1
	while (k >= 0):
		polinomio = coeficientes[k] + (polinomio*x)
		k = k - 1
	# Al término de este ciclo WHILE, la variable polinomio tiene el valor del P(x)
	return polinomio

def distpuntos(polinomio, x):
	resultado=0
	
	polinomio=deriv(len(polinomio)-1, polinomio)
	resultado=resultado+horner(len(polinomio)-1,polinomio, x)
	resultado=resultado**2
	resultado=resultado+1
	resultado=sqrt(resultado)

	return resultado

def IntegralTrapecio(a, b, n, funcion):
	resultado=0
	deltaX=(b-a)/n
	xi=a
	for i in range(n-1):
		xi=xi+deltaX
		resultado=resultado + distpuntos(funcion, xi)
	resultado=resultado*2
	resultado=resultado+distpuntos(funcion, a)+distpuntos(funcion, b)
	resultado=resultado*deltaX
	resultado=resultado/2

	return resultado


def IntegralSimpson(a, b, n, funcion):
	if(n%2 != 0):
		raise ValueError("El metodo simpson requiere que n sea par")

	resultado=0
	deltaX=(b-a)/n

	aux1=0
	aux2=0

	xi=a+deltaX
	i=1
	while(i<=(n-1)):
		aux1=aux1 + distpuntos(funcion, xi)
		xi=xi+deltaX+deltaX
		i=i+2

	aux1=aux1*4

	xi=a+deltaX+deltaX
	i=2
	while(i<=(n-2)):
		aux2=aux2 + distpuntos(funcion, xi)
		xi=xi+deltaX+deltaX
		i=i+2

	aux2=aux2*2

	resultado=distpuntos(funcion, a)+aux1+aux2+distpuntos(funcion, b)
	resultado=resultado*deltaX
	resultado=resultado/3

	return resultado

#metodo 1= trapecio
#metodo 2=Simpson
def Longitud(coeficientes, a, b, cifras, metodo):
	tolerancia=0.5*(10**(2-cifras))
	errorRelativoNP=tolerancia+1
	xi=0
	x_imas1=0
	n=10
	t=0
	#x_imas1 es el valor actual
	#xi es el valor anterior
	
	if(metodo==1):
		while (abs(errorRelativoNP) >=tolerancia):
			
			t=t+1
			n=10**t
			x_imas1 = IntegralTrapecio(a,b,n,coeficientes)

			errorRelativoNP=((x_imas1-xi)/x_imas1)*100
			xi = x_imas1
			print("xi=", x_imas1, "n=", n, "Error=", round(errorRelativoNP, cifras+1))
	
		return (x_imas1, n)

	elif(metodo==2):
		while (abs(errorRelativoNP) >=tolerancia):
			
			t=t+1
			n=10**t
			x_imas1 = IntegralSimpson(a,b,n,coeficientes)
			
			errorRelativoNP=((x_imas1-xi)/x_imas1)*100
			xi = x_imas1
			print("xi=", x_imas1, "n=", n, "Error=", round(errorRelativoNP, cifras+1))
	
		return (x_imas1, n)

	else:
		raise ValueError("Solo existen 2 metodo: Trapecio(1) y Simpson(2)")
	


	
	
	
