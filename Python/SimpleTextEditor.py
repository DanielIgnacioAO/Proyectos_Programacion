q = int(input())
s = ""
ops=[]
for i in range(q):
    op = input()
    ops.append(op)

ultimate = []
for op in ops:
    if op[0] == '1':
        op,w = op.split(' ')
        ultimate.append(s)
        s = s + w
    elif op[0] == '2':
        op,k = op.split(' ')
        k = int(k)
        ultimate.append(s)
        s = s[:-k]
    elif op[0] == '3':
        op,k = op.split(' ')
        k = int(k)
        print(s[k-1])
    elif op[0] == '4':
        s = ultimate.pop()