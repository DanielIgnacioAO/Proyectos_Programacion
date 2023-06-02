n = int(input("Dame un numero: "))
suma=0
s=1
b=1

for i in range(n):
    print(str(i+1) + '**3 = ', end=' ')
    for j in range(b):
        print(' +' + str(s), end=' ')
        suma = suma + s
        s= s+2
    print('= ' + str(suma))
    b=b+1
    suma =0
        
