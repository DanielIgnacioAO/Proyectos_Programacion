/*Nombre: Arellano Ochoa Daniel Ignacio
Programa que simula el procesamiento durante 100 minutos en los cuales por cada minutos se genraran n procesos y se atenderan m procesos donde m y n son valores aletarios de 0 a 5
*/
#include <string>
#include <iostream>
#include "Procesador.hpp"
#include "Proceso.hpp"

using namespace std; 

//Menu de inicio del programa
int main(int argc, const char * argv[]){
    
    cout<<"Bienvenido al programa, se ejecutaran 100 minutos de procesamiento simulado"<<endl;
    Procesador* intel=new Procesador();
    intel->procesar();

}
