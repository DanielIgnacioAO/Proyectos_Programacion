#Arellano Ochoa Daniel Ignacio
#Numer de control: 19141118
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv('ventas.csv')

facecream = df.loc[:, 'facecream'] 
facewash = df.loc[:, 'facewash']
toothpaste = df.loc[:,'toothpaste']
bathingsoap = df.loc[:,'bathingsoap']
shampoo = df.loc[:,'shampoo']
moisturizer = df.loc[:, 'moisturizer']

xpoints = [1,2,3,4,5,6,7,8,9,10,11,12]
plt.xticks(range(13))
plt.title('Company profit per month')
plt.xlabel('Numero de mes')
plt.ylabel('Beneficio total')
plt.plot(xpoints,facecream, linewidth=3, label="facecream", marker="o")
plt.plot(xpoints,facewash, linewidth=3, label="facewash", marker="o")
plt.plot(xpoints,toothpaste, linewidth=3, label="toothpaste", marker="o")
plt.plot(xpoints,bathingsoap,linewidth=3, label="bathingsoap", marker="o")
plt.plot(xpoints,shampoo, linewidth=3, label="shampoo", marker="o")
plt.plot(xpoints,moisturizer, linewidth=3, label="moisturizer", marker="o")
plt.legend(loc='upper left', fontsize=10)
plt.show()
