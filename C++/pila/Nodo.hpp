#ifndef Nodo_hpp
#define Nodo_hpp

#include <string>

using namespace std;

class Nodo
{
    private:
        Nodo* siguiente;
        char dato;
        double num;
        
    public:
        Nodo(char);
        Nodo(double);
        Nodo* getSiguiente();
        char getDato();
        double getNum();
        void setSiguiente(Nodo*);
    
};


#endif /*Nodo_hpp*/