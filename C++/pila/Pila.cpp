#include "Pila.hpp"
#include "Nodo.hpp"
#include <iostream>
#include <string>
 //clase pila que que almecenara nodos, y ayudaran a la clase calculadroa a almacenar datos sea el caso
using namespace std;
//constructor inicializando atributos
Pila::Pila(){
    this->elementos=0;//cantidad de nodos que almacena
    this->tope=NULL;//nodo que se encuentra en el top
}
//metodo que permite sacar de la pila
void Pila::sacarTope(){
    this->elementos--;
    this->tope=this->tope->getSiguiente();
}
//metodo que permite consultar el tope de la pila
Nodo* Pila::consultarTope(){
    return this->tope;
}
//metodo que permite consultar el total de nodos que hay dentro
int Pila::getElementos(){
    return this->elementos;
}
//metodo que permite insertar un nuevo nodo a la pila
void Pila::insertar(Nodo* n){
    this->elementos++;
    n->setSiguiente(this->tope);
    this->tope=n;
}