#ifndef Arbol_hpp
#define Arbol_hpp
#include <iostream>
#include "Archivo.hpp"
#include "Nodo.hpp"
using namespace std;
class Arbol
{
private:
    
public:
    Nodo* raiz; //raiz del arbol 
    Arbol();//constructor

    bool insertar(Nodo*& , Archivo*);//(nodo padre, nuevo archivo)inserta un archivo dentro del arbol, acomodandolo segun su nombre
    bool borrar(string, Nodo*&);//(nombre del archivo a borrar, nodo padre)borrar un archivo segun su nombre
    Nodo* reemplazar(Nodo*);//(nodo que sera eliminado)realiza el reemplazo de los nodos, al eliminar un nodo que tiene hijos a la derecha y a la izquierda 
    bool enlazarTam(Nodo*&, Nodo*&);//(nodo a enlazar, raiz/nodo padre)enlaza los nodos segun su tamano (acomoda los nodos segun el tamano)
    bool enlazarFec(Nodo*&, Nodo*&);//(nodo a enlazar, raiz/nodo padre)enlaza los nodos segun la fecha (acomoda los nodo segun la fecha 
    void desenlazarTam(Nodo*&, Nodo*&);//(nodo a desenlazar, raiz/nodo padre)desenlaza al nodo segun el tamano 
    void desenlazarFec(Nodo*&, Nodo*&);//(nodo a desenlazar, raiz/nodo padre)desenlaza al nodo segun la fecha

    Archivo* buscarArchivoNombre(string, Nodo*&);//(nombre del archivo a buscar, raiz/nodo padre)busca el archivo segun el nombre
    Archivo* buscarArchivoTamano(int, Nodo*&);//(tamano del archivo a buscar, raiz/nodo padre)busca el archivo segun el tamano
    Archivo* buscarArchivoFecha(string, Nodo*&);//(fecha del archivo a buscar, raiz/nodo padre)busca el archivo segun la fecha
    
    void inOrdenN(Nodo*);//(raiz/nodo padre)imprime en inOrden segun el nombre
    void preOrdenN(Nodo*);//(raiz/nodo padre)imprime en preOrden segun el nombre
    void postOrdenN(Nodo*);//(raiz/nodo padre)imprime en postOrden segun el nombre

    void inOrdenTam(Nodo*);//(raiz/nodo padre)imprime en inOrden segun el tamano
    void preOrdenTam(Nodo*);//(raiz/nodo padre)imprime en preOrden segun el tamano
    void postOrdenTam(Nodo*);//(raiz/nodo padre)imprime en postOrden segun el tamano

    void inOrdenFec(Nodo*);//(raiz/nodo padre)imprime en inOrden segun la fecha
    void preOrdenFec(Nodo*);//(raiz/nodo padre)imprime en preOrden segun la fecha
    void postOrdenFec(Nodo*);//(raiz/nodo padre)imprime en postOrden segun la fecha


};


#endif /* Arbol_hpp*/