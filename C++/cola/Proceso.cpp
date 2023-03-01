#include "Proceso.hpp"
#include <iostream>
#include <string>
//clase de proceso
using namespace std;
//constructor con los atributos de porcentaje y ant inicializados
Proceso::Proceso(){
    this->porcentaje=0;//porcentaje atendido
    this->ant=NULL;//procesos atras de este dentro de una cola
}
//metodo que regresa el porcentaje que ha sido atendido este proceso
int Proceso::getPorcentaje(){
    return this->porcentaje;
}
//metodo que refresa el proceso que se encuentra anterior a este dentro de una cola
Proceso* Proceso::getAnt(){
    return this->ant;
}
//metodo que permite modificar el proceso que se encuentra atras de este dentro de una cola
void Proceso::setAnt(Proceso* p){
    this->ant=p;
}
//metodo que permite modificar el procentaje atendido de este proceso
void Proceso::setPorcentaje(int* n){
    this->porcentaje=*n;
}