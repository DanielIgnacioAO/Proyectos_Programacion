import matplotlib.pyplot as plt
import numpy as np

data_file = "data_banknote_authentication.txt"
data_x = np.loadtxt(data_file, delimiter="=", skiprows=0, usecols=(0) ,dtype=np.str0)
data_y = np.loadtxt(data_file, delimiter="=", skiprows=0, usecols=(1),dtype={'meses'})

plt.bar(data_x,data_y)
plt.show()