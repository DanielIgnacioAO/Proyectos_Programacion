#ifndef Pila_hpp
#define Pila_hpp

#include <string>
#include "Nodo.hpp"

using namespace std;
class Pila
{
    private:
        int elementos;
        Nodo* tope;
    public:
        Pila();
        void sacarTope();
        Nodo* consultarTope();
        int getElementos();
        void insertar(Nodo*);
    
};



#endif /*Pila_hpp*/