#include <iostream>
#include "Archivo.hpp"
#include <string>
 
using namespace std;
//(nombre, tamano, tipo, fecha)constructor
Archivo::Archivo(string name, int size, string type, string date){
    this->nombre=name;//se inicializan los datos del archivo con los parametos del constructor
    this->tamano=size;
    this->tipo=type;
    this->fecha=date;
}
 
string Archivo::getNombre(){return this->nombre;}//regresa el nombre
int Archivo::getTamano(){return this->tamano;}//regresa el tamano
string Archivo::getTipo(){return this->tipo;}//regresa el tipo
string Archivo::getFecha(){return this->fecha;}//regresa la fecha