#include "Nodo.hpp"
#include <iostream>
#include <string>
#include <list>

using namespace std;
//constructor, se inicializa el dato, la lista de hijos inicia con cero datos almacenados
Nodo::Nodo(string n){
    this->dato=n;
}
string Nodo::getDato(){return this->dato;};//metodo que regresa el dato
void Nodo::setDato(string n){this->dato=n;}//metodo que cambia el dato

//metodo que regresa un apuntador de la lista de los hijos del nodo
list<Nodo*>* Nodo::getHijos(){
    list<Nodo*>* auxH=&this->hijos; //apuntador que apunta a la lista de los hijos del nodo
    return auxH;
};

//metodo para agregar un nuevo hijo
void Nodo::agregarHijo(Nodo* a){
    this->hijos.push_back(a);//se agregara al final de la lista
}

//metodo que elimina un hijo de la lista de hijos
void Nodo::eliminarHijo(Nodo* objetivo){
    list<Nodo*>::iterator iterador;//iterador que ayudara a encontrar el nodo hijo para despues eliminarlo 
    iterador=this->hijos.begin();
    while (iterador != this->hijos.end()){
        if(*iterador==objetivo){
            this->hijos.erase(iterador);
            break;
        }
        iterador++;
    }
}
