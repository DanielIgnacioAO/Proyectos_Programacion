import sys
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from sklearn import tree
from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier
import graphviz
from sklearn import datasets
from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier
from sklearn.tree import export_graphviz


#lee los datos
df = pd.read_csv('mall_customers.csv')

#mapea la caracteristica de genero a un valor numero 0=Masculino 1=Femenino
d = {'Male' : 0, 'Female' : 1}
df['gender'] = df['gender'].map(d)

#Caracteristicas a tomar para formar el arbol
features = ['gender','age','annual_income']

#Se define cuales seran los datos independientes (x) y el dependiente (y)
x = df[features]
y = df['spending_score']

#Se crea un objeto de arbol para luego entrenarlo
dtree = DecisionTreeClassifier()
dtree = dtree.fit(x,y)

#Predecir el spendig score de una mujer con 21 años y annual income de 74
dates_prediction = {
    'gender':[1],
    'age':[23],
    'annual_income':[54]}

#Se crea un data frame con los datos a predecir
df_prediction = pd.DataFrame(dates_prediction)

#se obtiene la predeccion
prediction = dtree.predict(df_prediction)

print(df_prediction)
print("Predicion de spending_score: " + str(prediction))

#genera un pdf con el arbol de decision
dot_data = export_graphviz(dtree, out_file=None, feature_names=features, class_names=None, filled=True, rounded=True)
graph = graphviz.Source(dot_data)
graph.render("mall_customers_tree_decision")

#muestra una grafica de distribuicion con relacion a:
feature = 'annual_income'
#feature = 'gender'
#feature ='age'
x = df[feature]
plt.title('Mall customers')
plt.xlabel(feature)
plt.ylabel('spending_score')
plt.scatter(x,y)
plt.show()
