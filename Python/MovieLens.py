import numpy as np
import pandas as pd

#13.2 MovieLens 1M Dataset

unames = ["user_id", "gender", "age", "occupation", "zip"]
users = pd.read_table("users.dat", sep="::",
                      header=None, names=unames, engine="python")

rnames = ["user_id", "movie_id", "rating", "timestamp"]
ratings = pd.read_table("ratings.dat", sep="::",
                        header=None, names=rnames, engine="python")

mnames = ["movie_id", "title", "genres"]
movies = pd.read_table("movies.dat", sep="::",
                       header=None, names=mnames, engine="python")

print("1.- Verificamos que hayan cargado los datos")
print("Users") 
print(users.head(5),end="\n\n\n")
print("Ratings")
print(ratings.head(5),end="\n\n\n")
print("Movies")
print(movies.head(5),end="\n\n\n")

print("2.- Fusionamos tablas")
data = pd.merge(pd.merge(ratings, users), movies)
print(data,end="\n\n\n")

print("3.- Datos de primer pelicula")
print(data.iloc[0],end="\n\n\n")

print("4.- Promedio de calificaciones de cada pelicula por genero")
mean_ratings = data.pivot_table("rating", index="title", columns="gender", aggfunc="mean")
print(mean_ratings.head(5), end="\n\n\n")

print("5.- Calificaciones en total por cada pelicula")
ratings_by_title = data.groupby("title").size()
print(ratings_by_title.head(5), end="\n\n\n")

print("6.- Peliculas con mas de 250 calificaciones:")
active_titles = ratings_by_title.index[ratings_by_title >= 250]
print(active_titles, end="\n\n\n")

print("7.- Promedio de calificaciones de cada pelicula por genero, de peliculas con mas de 250 calificaciones")
mean_ratings = mean_ratings.loc[active_titles]
print(mean_ratings.head(5), end="\n\n\n")

print("8.- Promedio de calificaciones de cada pelicula por genero, de peliculas con mas de 250 calificaciones, de mayor a menor segun las mujeres")
top_female_ratings = mean_ratings.sort_values("F", ascending=False)
print(top_female_ratings.head(5), end="\n\n\n")

print("9.- Diferencia de opiniones entre mujeres y hombres")
mean_ratings["diff"] = mean_ratings["M"] - mean_ratings["F"] #Anadir columna
print(mean_ratings.head(5), end="\n\n\n")

print("10.- Peliculas preferidas por mas mujeres que hombres")
sorted_by_diff = mean_ratings.sort_values("diff") #Agrupar parecidos
print(sorted_by_diff.head(5), end="\n\n\n")

print("11.- Peliculas preferidas por mas hombres que mujeres")
print(sorted_by_diff[::-1].head(), end="\n\n\n")
