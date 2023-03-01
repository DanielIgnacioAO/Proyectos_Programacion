numero = int(input('N= '))
particiones = [1] + [0] *numero
for i in range(1,numero+1):
    for j in range(i, numero+1):
        particiones[j] +=particiones[j-i]
    print(particiones)
print(particiones[numero])