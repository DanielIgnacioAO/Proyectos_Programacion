#include "Nodo.hpp"
#include <iostream>
#include "Archivo.hpp"
using namespace std;
//(dato para almacenar)constructor
Nodo::Nodo(Archivo* info){//se inicializan los datos
    this->dato=info;
    this->DerNombre=NULL;
    this->IzqNombre=NULL;
    this->DerTamano=NULL;
    this->IzqTamano=NULL;
    this->DerFecha=NULL;
    this->IzqFecha=NULL;
}

Archivo* Nodo::getdato(){return this->dato;}//regresa el dato almacenado

Nodo* Nodo::getDerNombre(){return this->DerNombre;}//regresa el nodo hijo derecho segun el nombre
Nodo* Nodo::getIzqNombre(){return this->IzqNombre;}//regresa el nodo hijo izquierdo segun el nombre
void Nodo::setDerNombre(Nodo* n){this->DerNombre=n;}//(nuevo nodo)cambia el nodo hijo derecho segun el nombre
void Nodo::setIzqNombre(Nodo*n){this->IzqNombre=n;}//(nuevo nodo)cambia el nodo hijo izquierdo segun el nombre

Nodo* Nodo::getDerTamano(){return this->DerTamano;}//regresa el nodo hijo derecho segun el tamano
Nodo* Nodo::getIzqTamano(){return this->IzqTamano;}//regre el nodo hijo izquierdo segun el tamano
void Nodo::setDerTamano(Nodo*n){this->DerTamano=n;}//(nuevo nodo)cambia el nodo hijo derecho segun el tamano 
void Nodo::setIzqTamano(Nodo*n){this->IzqTamano=n;}//(nuevo nodo) cambia el nodo hijo izquierdo segun el tamano

Nodo* Nodo::getDerFecha(){return this->DerFecha;}//regresa el nodo hijo derecho segun la fecha 
Nodo* Nodo::getIzqFecha(){return this->IzqFecha;}//regresa el nodo hijo izquierdo segun la fecha
void Nodo::setDerFecha(Nodo*n){this->DerFecha=n;}//(nuevo nodo)cambia el nodo hijo derecho segun la fecha
void Nodo::setIzqFecha(Nodo*n){this->IzqFecha=n;}//(nuevo nodo)cambia el nodo hijo izquierdo segun la fecha
