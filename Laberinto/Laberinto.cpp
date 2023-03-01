/*Nombre: Arellano Ochoa Daniel Ignacio
Programa que permite solucionar un laberinto
*/
#include <string>
#include <iostream>


using namespace std; 
//structura para generar una matriz de 30x30 con el laberinto
struct Laberinto{
    //M muro, E entrada, S salida, ' ' camino
    char laberinto[30][30]={
        'M','M','M','M','M','M','M','M','M','M','M','M','M','M','M','M','M','M','M','M','M','M','M','M','M','M','M','M','M','M',
        'E',' ',' ',' ',' ','M','M','M','M','M','M','M',' ','M','M','M','M','M',' ','M','M','M','M','M','M','M',' ','M','M','M',
        'M','M','M','M',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','M',
        'M','M',' ','M',' ','M','M','M',' ','M','M','M','M',' ','M','M','M','M','M','M',' ','M','M','M','M','M','M','M',' ','M',
        'M','M',' ','M',' ',' ','M','M',' ','M','M','M','M',' ','M','M',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','M',
        'M','M',' ','M','M',' ',' ','M',' ',' ',' ','M','M',' ',' ','M',' ','M','M','M','M','M',' ','M','M','M',' ','M',' ','M',
        'M','M',' ','M','M','M',' ','M','M','M',' ','M',' ','M',' ','M',' ','M',' ',' ',' ','M',' ','M','M','M',' ','M',' ','M',
        'M','M',' ','M','M','M',' ','M','M','M',' ','M',' ',' ',' ','M',' ','M',' ','M',' ',' ',' ',' ',' ','M',' ','M',' ','M',
        'M','M',' ','M','M','M',' ',' ',' ',' ',' ','M','M','M','M',' ',' ','M','M','M',' ','M','M','M',' ','M',' ','M',' ','M',
        'M',' ',' ',' ',' ','M',' ','M','M','M',' ',' ',' ','M','M','M',' ',' ',' ',' ',' ',' ',' ','M',' ','M',' ','M',' ','M',
        'M',' ','M','M',' ','M',' ','M','M','M','M','M','M','M','M','M','M','M','M','M',' ','M','M','M',' ','M',' ','M',' ','M',
        'M',' ','M','M',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','M',' ','M',' ',' ',' ',' ',' ','M',' ','M',' ','M',
        'M',' ','M','M',' ','M','M','M','M','M','M','M','M',' ','M','M',' ','M',' ','M','M','M','M','M','M','M',' ','M',' ','M',
        'M',' ','M','M','M','M','M','M','M','M',' ','M','M',' ','M','M',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','M',' ','M',
        'M',' ',' ',' ',' ',' ',' ',' ',' ','M',' ',' ','M',' ','M','M',' ','M','M','M','M','M','M','M','M','M','M','M',' ','M',
        'M','M','M','M',' ','M','M','M',' ','M',' ','M','M',' ','M','M',' ','M',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','M',
        'M',' ',' ','M',' ','M','M','M',' ','M',' ','M','M',' ','M','M',' ','M',' ','M',' ','M','M','M','M','M','M','M',' ','M',
        'M',' ','M','M',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','M','M',' ',' ',' ','M',' ','M',' ',' ',' ',' ',' ','M',' ','M',
        'M',' ',' ',' ',' ','M','M','M','M','M','M','M','M','M','M','M',' ','M',' ','M',' ','M',' ','M','M','M',' ','M',' ','M',
        'M',' ','M','M',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','M',' ','M',' ','M',
        'M',' ','M','M',' ','M','M','M','M',' ','M',' ','M','M','M','M',' ','M','M','M',' ','M',' ','M',' ','M',' ','M',' ','M',
        'M',' ','M','M',' ','M','M','M','M',' ','M',' ','M',' ',' ',' ',' ','M',' ','M',' ','M',' ',' ',' ','M',' ','M',' ','M',
        'M',' ','M','M',' ','M','M',' ','M',' ','M','M','M','M','M','M',' ','M',' ','M',' ','M','M','M','M','M',' ','M',' ','M',
        'M','M','M','M',' ','M','M',' ',' ',' ',' ',' ',' ',' ','M','M',' ','M',' ','M',' ',' ',' ',' ',' ',' ',' ','M',' ','M',
        'M','M',' ',' ',' ',' ',' ',' ','M','M','M','M','M',' ','M','M',' ','M',' ','M','M','M','M','M','M','M',' ','M',' ','M',
        'M','M','M',' ','M','M','M',' ','M','M',' ',' ',' ',' ','M','M',' ',' ',' ',' ',' ',' ',' ',' ',' ','M',' ','M',' ','M',
        'M',' ',' ',' ','M','M','M',' ','M','M','M','M','M','M','M','M',' ','M','M','M',' ','M','M','M',' ','M',' ',' ',' ','M',
        'M','M','M',' ','M','M',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','M','M','M',' ','M','M','M',' ','M','M','M','M','M',
        'M','M','M',' ',' ','M','M','M','M','M','M',' ','M','M','M','M',' ','M','M','M',' ',' ',' ','M',' ',' ',' ',' ',' ','S',
        'M','M','M','M','M','M','M','M','M','M','M','M','M','M','M','M','M','M','M','M','M','M','M','M','M','M','M','M','M','M',    
    
    };

}lab;

//Codigo para imprimir el laberinto de 30x30
void imprimirLaberinto(Laberinto *lab){
    for (size_t i = 0; i < 30; i++)
    {
        for (size_t j = 0; j < 30; j++)
        {
            if (lab->laberinto[i][j]=='M')
                printf("%c",219);
            else if(lab->laberinto[i][j]=='x')
                printf("x");
            else
                printf(" ");
        }
        printf("\n");
    }

}
//codigo recursivo para solucionar el laberinto de 30x30
bool solucionarLaberinto(int x, int y, int primer, Laberinto *lab){
    char* aux;
    if(x<0 || x>29 || y<0 || y>29)
        return 0;
    else
    {
        aux=&lab->laberinto[x][y];
        
        if (*aux=='S')
            return true;
        else if(*aux=='E')
        {
            if(primer==1)
            {
                if(solucionarLaberinto(x+1, y, 0, lab)||solucionarLaberinto(x-1, y, 0, lab)||solucionarLaberinto(x, y+1, 0, lab)||solucionarLaberinto(x, y-1, 0, lab))
                    return true;
            }
            else
                return false;
        }
        else if(*aux==' ')
        {
            *aux='x';
            if(solucionarLaberinto(x+1, y, 0, lab)||solucionarLaberinto(x-1, y, 0, lab)||solucionarLaberinto(x, y+1, 0, lab)||solucionarLaberinto(x, y-1, 0, lab))
                return true;
            else {
                *aux=' ';
                return false;
            }
                
        }
        else
            return false;
    }
    
}
//Codigo para encontrar la entrada 'E' del laberinto de 30x30, para despues solucionarlo
void encontrarEntrada(Laberinto *lab) {
    int entrada=0;
    int x,y,x1,y1;
    for (size_t i = 0; i < 30; i++)
    {
        for (size_t j = 0; j < 30; j++)
        {
            if(lab->laberinto[i][j]=='E'){
                x=i;
                y=j;
                entrada=1;
            }
            if(lab->laberinto[i][j]=='S'){
                x1=i;
                y1=j;
            }
        }
        
    }
    cout<<"Entrada:\nx/i= "<<x<<"\ny/j= "<<y<<endl;
    bool res=solucionarLaberinto(x, y, entrada, lab);
    if (res==true){
        imprimirLaberinto(lab);
        cout<<"Salida:\nx/i= "<<x1<<"\ny/j= "<<y1<<endl;
    }
        
    else
        cout<<"Sin solucion"<<endl;
}

//Menu de inicio del programa
int main(int argc, const char * argv[]){
    Laberinto* auxLaberinto=&lab;
    imprimirLaberinto(auxLaberinto);
    encontrarEntrada(auxLaberinto);

}
