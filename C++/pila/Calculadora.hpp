#ifndef Calculadora_hpp
#define Calculadora_hpp
#include <string>
#include "Nodo.hpp"
#include "Pila.hpp"

using namespace std;

class Calculadora
{
    private:
        Pila* pilaOperadores;
        Pila* pilaNumeros;
    public:
        Calculadora(Pila*, Pila*);
        string pasarApostfija(string);
        double resolver(string);
        bool validadJerarquia(Nodo*);
        
};
#endif /* Calculadora_hpp*/