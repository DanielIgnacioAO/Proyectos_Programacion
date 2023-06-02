import numpy as np
import pandas as pd

d = {'col1': [1, 2,3,4,5,6,7,8,9,10,11], 'col2': [11, 12,13,14,15,16,17,18,19,20,21]}
df = pd.DataFrame(data=d)

print(df.tail())
