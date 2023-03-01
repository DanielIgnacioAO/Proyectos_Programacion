#ifndef Nodo_hpp
#define Nodo_hpp
#include <iostream>
#include "Archivo.hpp"
using namespace std; 

class Nodo
{
private:
    Archivo* dato;//dato que almacenara el nodo

    Nodo* IzqNombre;//nodo hijo izquierdo segun el nombre
    Nodo* DerNombre;//nodo hijo derecho segun el nombre
    
    Nodo* IzqTamano;//nodo hijo izquierdo segun el tamano
    Nodo* DerTamano;//nodo hijo derecho segun el tamano 
    
    Nodo* IzqFecha;//nodo hijo izquierdo segun la fecha
    Nodo* DerFecha;//nodo hijo derecho segun la fecha
public:

    friend class Arbol;//clase amiga

    Nodo(Archivo*);//(dato para almacenar)constructor
    Archivo* getdato();//regresa el dato almacenado

    Nodo* getIzqNombre();//regresa el nodo hijo izquierdo segun el nombre
    Nodo* getDerNombre();//regresa el nodo hijo derecho segun el nombre
    void setIzqNombre(Nodo*);//(nuevo nodo)cambia el nodo hijo izquierdo segun el nombre
    void setDerNombre(Nodo*);//(nuevo nodo)cambia el nodo hijo derecho segun el nombre 
    
    Nodo* getIzqTamano();//regresa el nodo hijo izquierdo segun el tamano
    Nodo* getDerTamano();//regre el nodo hijo derecho segun el tamano
    void setIzqTamano(Nodo*);//(nuevo nodo)cambia el nodo hijo izquierdo segun el tamano 
    void setDerTamano(Nodo*);//(nuevo nodo) cambia el nodo hijo derecho segun el tamano
    
    Nodo* getIzqFecha();//regresa el nodo hijo izquierdo segun la fecha 
    Nodo* getDerFecha();//regresa el nodo hijo derecho segun la fecha
    void setIzqFecha(Nodo*);//(nuevo nodo)cambia el nodo hijo izquierdo segun la fecha
    void setDerFecha(Nodo*);//(nuevo nodo)cambia el nodo hijo derecho segun la fecha
};
#endif /*Nodo_hpp*/