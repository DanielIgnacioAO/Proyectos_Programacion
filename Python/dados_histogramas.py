import random
import matplotlib.pyplot as plt
import numpy as np

plt.rcParams["figure.figsize"] = (15, 10)
plt.subplots_adjust(hspace=0.5,wspace=0)

#Un dado
numeros_un_dado=[]
datos_un_dado=[0,0,0,0,0,0]
for _ in range(10000):
    num = random.randint(1, 6)
    numeros_un_dado.append(num)
    datos_un_dado[num-1]=datos_un_dado[num-1]+1
    
etiquetas=['1','2','3','4','5','6']

plt.subplot(2, 2, 1)
plt.bar(etiquetas,datos_un_dado, color='pink')
plt.xlabel('Puntos')
plt.ylabel('Numero de tiradas')
plt.title('Un dado')
plt.grid(axis = 'y')

media = np.mean(numeros_un_dado)
desviacion = np.std(numeros_un_dado)

plt.subplot(2, 2, 2)
plt.text(0,0.75,'     Media: ' + str(media), fontsize=15)
plt.text(0,0.25, '     Desviacion Estandar: ' + str(round(desviacion,4)), fontsize=15)
plt.axis(False)

#Dos dados
numeros_dos_dados=[]
datos_dos_dados=[0,0,0,0,0,0,0,0,0,0,0,0]
for _ in range(10000):
    suma= random.randint(1, 6) + random.randint(1, 6)
    numeros_dos_dados.append(suma)
    datos_dos_dados[suma-1] = datos_dos_dados[suma-1] + 1
    
etiquetas=['1','2','3','4','5','6','7','8','9','10','11','12']

plt.subplot(2, 2, 3)
plt.bar(etiquetas,datos_dos_dados, color='green')
plt.xlabel('Puntos')
plt.ylabel('Numero de tiradas')
plt.title('Dos dados')
plt.grid(axis = 'y')

media = np.mean(numeros_dos_dados)
desviacion = np.std(numeros_dos_dados)

plt.subplot(2, 2, 4)
plt.text(0,0.75,'     Media: ' + str(media), fontsize=15)
plt.text(0,0.25, '     Desviacion Estandar: ' + str(round(desviacion,4)), fontsize=15)
plt.axis(False)

plt.suptitle('Tirar dados 10,000 veces')
plt.show()