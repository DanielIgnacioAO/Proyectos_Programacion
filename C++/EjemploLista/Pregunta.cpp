#include "Pregunta.hpp"
#include <string>
#include <iostream> 
using namespace std;
//clase que sirve para almacenar la pregunta asi como su categoria y valor de puntaje, a la vez funciona como nodo 
Pregunta::Pregunta(string pre, string cat, int pun){
    this->descripcion=pre;//descripcion es la pregunta que se almacenara
    this->categoria=cat;//categoria de la pregunta
    this->valor=pun;//valor de puntaje de la pregunta solo se aceptan numeros enteros
}
//metodo que regresa la categoria de la pregunta
string Pregunta::getCategoria(){
    return this->categoria;
}
//metodo que regresa la descripcion de la pregunta (regresa la pregunta almacenada)
string Pregunta::getDescripcion(){
    return this->descripcion;
}
//metodo que regresa el valor de puntaje
int Pregunta::getValor(){
    return this->valor;
}
