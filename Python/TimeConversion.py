#!/bin/python3

import math
import os
import random
import re
import sys
import datetime

#
# Complete the 'timeConversion' function below.
#
# The function is expected to return a STRING.
# The function accepts STRING s as parameter.
#


def timeConversion(s):
    newhora = s.split(':')
    amPm = newhora[2]
    hora = newhora[0]
    print(newhora[2].count("A"))
    segundos = newhora[2]
    print(segundos.replace('AM',''))

    militarAM = ['00','01','02','03','04','05','06','07','08','09','10','11']
    militarPM = ['12','13','14','15','16','17','18','19','20','21','22','23']

    if amPm.count('A') == 1:
        newhora[2] = newhora[2].replace('AM','')
        if hora == '12':
            newhora[0] = militarAM[0]

    if amPm.count('P') == 1:
        newhora[2] = newhora[2].replace('PM','')
        if hora == '01':
            newhora[0] = militarPM[1]
        elif hora == '02':
            newhora[0] = militarPM[2]
        elif hora == '03':
            newhora[0] = militarPM[3]
        elif hora == '04':
            newhora[0] = militarPM[4]
        elif hora == '05':
            newhora[0] = militarPM[5]
        elif hora == '06':
            newhora[0] = militarPM[6]
        elif hora == '07':
            newhora[0] = militarPM[7]
        elif hora == '08':
            newhora[0] = militarPM[8]
        elif hora == '09':
            newhora[0] = militarPM[9]
        elif hora == '10':
            newhora[0] = militarPM[10]
        elif hora == '11':
            newhora[0] = militarPM[11]

        horafinal = ':'.join(newhora)
        
        return horafinal
    
    

if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    s = input()

    result = timeConversion(s)

    fptr.write(result + '\n')

    fptr.close()
