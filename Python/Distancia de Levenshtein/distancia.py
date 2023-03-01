'''
   Programa: distancia.py
    Funcion: A partir de dos palabras calcula la distancia de Levenshtein

    Nombre: Arellano Ochoa Daniel Ignacio
    No. de control: 19141118
'''
def distance(str1, str2):
  d=dict()
  for i in range(len(str1)+1):
     d[i]=dict()
     d[i][0]=i
  for i in range(len(str2)+1):
     d[0][i] = i
  for i in range(1, len(str1)+1):
     for j in range(1, len(str2)+1):
        d[i][j] = min(d[i][j-1]+1, d[i-1][j]+1, d[i-1][j-1]+(not str1[i-1] == str2[j-1]))
  return d[len(str1)][len(str2)]

print('Distancia de Levenshtein \n ')
pal1 = input('Dame una palabra: ')
pal2 = input('Dame una segunda palabra: ')
dis = distance(pal1, pal2)
print('Distancias entre \"',pal1,'\" y \"',pal2,'\": ',dis)