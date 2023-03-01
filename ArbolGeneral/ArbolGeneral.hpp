#ifndef ArbolGeneral_hpp
#define ArbolGeneral_hpp
#include "Nodo.hpp"
#include <iostream>
#include <string>

using namespace std;
 
class ArbolGeneral
{
private:
    Nodo* raiz;//nodo principal del arbol (raiz del arbol)
public:
    ArbolGeneral();//cosntructor
    Nodo* getRaiz();//Regresa la raiz
    void setRaiz(Nodo*);//(nueva raiz)Cambia la raiz
    void renombrarNodo(string, string);//(nombre actual, nombre nuevo)-->Renombra/cambia el dato del nodo
    void agregarNodo(string, string);//(hijo, padre)-->Agrega un nodo hijo a un nodo padre

    void elimnarNodo(string, string);//(nodo a eliminar, nuevo padre)-->Elimina un nodo, pasando sus hijos a otro nodo
    void eliminarNodo(string);//(nodo a eliminar) -->Elimina un nodo con todo y sus hijos
    void trasladarHijo(string, string);//(hijo a trasladar, nuevo padre)-->Traslada un solo hijo a otro nodo
    void trasladarHijos(string, string);//(padre actual, padre nuevo)-->Traslada todos los hijos de un nodo a otro

    void mostrar(Nodo*, int);//(raiz, nivel)-->Imprime al árbol, a partir del nodo raiz, el nivel es para visualizar mejor el arbol
    Nodo* buscar(string, Nodo*);//(objetivo a buscar, raiz)-->Busca un nodo desde la raiz
    Nodo* buscarPadre(string, Nodo*);//(hijo, raiz)-->Busca el nodo padre del hijo

};

#endif /*ArbolGeneral_hpp*/