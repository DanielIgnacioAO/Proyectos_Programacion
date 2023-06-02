#Three lines to make our compiler able to draw:
import sys
import matplotlib
matplotlib.use('Agg')

import pandas
from sklearn import tree
from sklearn.tree import DecisionTreeClassifier, plot_tree
import matplotlib.pyplot as plt

data = {
        'Breathing':['No', 'Yes', 'No', 'Yes', 'Yes', 'No', 'Yes', 'Yes', 'Yes', 'No', 'No', 'Yes', 'Yes', 'No'],
        'Fever':    ['No', 'Yes', 'Yes', 'Yes', 'Yes', 'No', 'Yes', 'Yes', 'No', 'Yes', 'No', 'No', 'No', 'Yes'],
        'Cough':    ['No', 'Yes', 'Yes', 'No', 'Yes', 'Yes', 'No', 'No', 'Yes', 'Yes', 'Yes', 'Yes', 'Yes', 'Yes'],
        'Infected': ['No', 'Yes','No', 'Yes', 'Yes', 'No', 'Yes', 'Yes', 'Yes', 'Yes', 'No', 'Yes', 'No', 'No']
    }
df = pandas.DataFrame(data=data)

d = {'Yes': 1, 'No': 0}
df['Breathing'] = df['Breathing'].map(d)
df['Fever'] = df['Fever'].map(d)
df['Cough'] = df['Cough'].map(d)
df['Infected'] = df['Infected'].map(d)

features = ['Breathing','Fever','Cough']

X = df[features]
Y = df['Infected']

print(df)

dtree = DecisionTreeClassifier()
dtree = dtree.fit(X, Y)

print(dtree)

dtree.decision_path