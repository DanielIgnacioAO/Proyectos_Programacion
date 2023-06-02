n,m = input().split(' ')
n = int(n)
m = int(m)

n_numbers = input().split(' ')

for i in range(len(n_numbers)):
    n_numbers[i] = int(n_numbers[i])

for i in range(m):
    j,s = input().split(' ')
    j = int(j)
    s = int(s)
    r = n_numbers[j]
    while(r < s):
        j = j + 1
        r = r + n_numbers[j]
    print(j)