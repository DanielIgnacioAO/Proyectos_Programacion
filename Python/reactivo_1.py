#Arellano Ochoa Daniel Ignacio
#Numer de control: 19141118
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv('ventas.csv')

beneficio = df.loc[:, 'total_profit'] 

print(beneficio)

ypoints = beneficio
xpoints = [1,2,3,4,5,6,7,8,9,10,11,12]
plt.xticks(range(13))
plt.title('Company profit per month')
plt.xlabel('Numero de mes')
plt.ylabel('Beneficio total')
plt.plot(xpoints,ypoints)
plt.show()
