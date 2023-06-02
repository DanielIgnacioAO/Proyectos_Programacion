#!/bin/python3

import math
import os
import random
import re
import sys

#
# Complete the 'truckTour' function below.
#
# The function is expected to return an INTEGER.
# The function accepts 2D_INTEGER_ARRAY petrolpumps as parameter.
#

def truckTour(petrolpumps):
    cam = 0
    for case in range(len(petrolpumps)):
        estaciones=[]
        k = 1
        for i in range(len(petrolpumps)):
            j = case + i
            if(j >= len(petrolpumps)): j = j - len(petrolpumps)
            cam = cam + petrolpumps[j][0] - petrolpumps[j][1]
            if(cam < 0):break
            k = k +1
        if(k == len(petrolpumps)):return case
    return -1

if __name__ == '__main__':
    #fptr = open(os.environ['OUTPUT_PATH'], 'w')

    n = int(input().strip())

    petrolpumps = []

    for _ in range(n):
        petrolpumps.append(list(map(int, input().rstrip().split())))

    result = truckTour(petrolpumps)
    print(result)
    
    #fptr.write(str(result) + '\n')

    #fptr.close()
