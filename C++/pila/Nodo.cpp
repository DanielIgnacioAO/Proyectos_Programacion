#include "Nodo.hpp"
#include <iostream>
#include <string>
//clase nodo que seran almacenados a una pila sin importar el dato que representen
using namespace std;
//contructor de un nodo de caracter, con valores inicializados 
Nodo::Nodo(char valor){
    this->dato=valor;//caracter inicializado con su parametro
    this->siguiente=NULL;//nodo que se encuentra adelante o arriba de este dentro de la pila
    this->num=0;//al ser un nodo de caracter no es necesario darle un valor al numero
}
//constructor de un nodo de numeros reales, con valores inicializados
Nodo::Nodo(double numero){
    this->num=numero;//numero unicializado con su parametro
    this->siguiente=NULL;//nodo que se encuentra encima o adelante de este dentro de una pila
    this->dato=0;//al ser un nodo de numero no es necesario darle un valor al caracter
}
//metodo que regresa el nodo siguiente de este dentro de una pila
Nodo* Nodo::getSiguiente(){
    return this->siguiente;
}
//metodo que regresa un caracter del nodo
char Nodo::getDato(){
    return this->dato;
}
//metodo que regresa el numero de un nodo
double Nodo::getNum(){
    return this->num;
}
//metodo que permite modificar el nodo adelante o encima de este dentro de una pila
void Nodo::setSiguiente(Nodo* n){
    this->siguiente=n;
}
