#ifndef Nodo_hpp
#define Nodo_hpp
#include <iostream>
#include <string>
#include <list>
using namespace std;
class Nodo
{
private:
    string dato; //el dato que alamecena el nodo
    list<Nodo*> hijos; //lista de los hijos 
public:
    Nodo(string);//constructor
    string getDato();//metodo para devolver el dato
    void setDato(string);//metodo para cambiar el dato 
    list<Nodo*>* getHijos();//metodo que regresa un apuntador de la lista de sus hijos
    void agregarHijo(Nodo*);//metodo para agregar un hijo a la lista
    void eliminarHijo(Nodo*);//metodo para eliminar un hijo de la lista
};

#endif /* Nodo_hpp*/