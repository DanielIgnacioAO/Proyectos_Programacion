#ifndef Procesador_hpp
#define Procesador_hpp
#include "Proceso.hpp"

class Procesador
{
private:
    Proceso* inicio;
    Proceso* final;
    int proGenerados;
    int proAtendidos;
    int proCola;
    int proCero;

public:
    Procesador();
    
    void insertar(Proceso*);
    void sacar();
    void generarProcesos(int*);
    void atenderProcesos(int*);
    void procesar();
    void procesosColaInc();

};


#endif /*Procesador_hpp*/