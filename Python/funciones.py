import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

x=[]
y1=[]
y2=[]
y3=[]
for i in range(25):
    x.append(i)
    y1.append(x[i])
    y2.append(x[i]**2)
    y3.append(x[i]**3)

plt.plot(x, y1, linestyle = 'dotted')
plt.plot(x, y2, linestyle = 'dashed')
plt.plot(x, y3, linestyle = 'dashdot')
plt.show()
