#ifndef Archivo_hpp
#define Archivo_hpp
#include <iostream>
 
using namespace std;
class Archivo
{
private:
    string nombre;//nombre del archivo
    int tamano;//tamano del archivo
    string tipo;//tipo del archivo
    string fecha;//fecha de creacion del archivo
    
public:
    Archivo(string, int, string, string);//(nombre, tamano, tipo, fecha)constructor

    string getNombre();//regresa el nombre
    int getTamano();//regresa el tamano
    string getTipo();//regresa el tipo
    string getFecha();//regresa la fecha
};


#endif /*Archivo_hpp*/