/*
    Programa: rangoPrimos.c
    Funcion Determian la cantidad de numeros primos en un rango de dos numeros,
            ademas de calcular el tiempo que tarda en hacerlo.
    
    Nombre: Arellano Ochoa Daniel Ignacio
    No. de control: 19141118 
*/
#include <stdio.h>
#include <time.h>
int main(int argc, char const *argv[])
{ 
    clock_t start_t, end_t;
    int inf,sup,cont = 0, primos = 0;
    printf("Limite inferior: ");
    scanf("%d",&inf);
    printf("Limite superior: ");
    scanf("%d",&sup);
    
    start_t = clock();
    for (int i =  inf; i < (sup + 1) ; i++)
    {
        for (int j = 1; j < (i + 1); j++)
        {
            if(i%j == 0)
            {
                cont++;
                if(cont > 2)
                    break; 
            }   
        }
        if(cont == 2)
            primos++;
        cont = 0;    
    }
    end_t = clock();
    double total_t = (double)((end_t - start_t) / CLOCKS_PER_SEC);

    printf("Numero de primos: %i \n",primos);
    printf("Tiempo de ejecucion: %d \n",total_t);

    system("pause"); 
    return 0;
} 
