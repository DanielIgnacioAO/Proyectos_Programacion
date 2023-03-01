/*Nombre: Arellano Ochoa Daniel Ignacio
Programa que permite realizar la funcion basica de una calculadora (evaluar una expresion aritmetica)
*/
#include <string>
#include <iostream>
#include <stdlib.h>
#include <ctime>
#include <math.h>
#include "Calculadora.hpp"
using namespace std; 


//Menu de inicio del programa
int main(int argc, const char * argv[]){
    Pila *pila1=new Pila();//pila creada para la calculadora
    Pila *pila2=new Pila();//pila creada para la calculadora
    Calculadora* casio=new Calculadora(pila1, pila2);//la calculadora requiere dos pilas para su funcionamiento

    //se obtiene la expresion infija
    string expresion;
    cout<<"Escribe la expresion:"<<endl;
    getline(cin, expresion);

    //se pasa a posfija
    string pos=casio->pasarApostfija(expresion);
    cout<<"Expresion posfija: "<<pos<<endl;

    //se evalua
    double r= casio->resolver(pos);
    cout<<"El resultado es = "<<r<<endl;
}