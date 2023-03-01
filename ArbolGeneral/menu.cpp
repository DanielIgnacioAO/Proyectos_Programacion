/*Nombre: Arellano Ochoa Daniel Ignacio
Implementacion de un arbol general, incluyendo las bajas
Se tomo el ejemplo de como se jerarquiza una universidad
*/
#include <string>
#include <iostream>
#include "Nodo.hpp"
#include "ArbolGeneral.hpp"
using namespace std; 

//Menu de inicio del programa
int main(int argc, const char * argv[]){
    
   ArbolGeneral* arbol=new ArbolGeneral();
    //nivel 0
    arbol->agregarNodo("Universidad", "Universidad");
    //nivel 1 
    arbol->agregarNodo("Software", "Universidad");
    arbol->agregarNodo("Industrial", "Universidad");
    arbol->agregarNodo("Gestion", "Universidad");
    arbol->agregarNodo("Arquitectura", "Universidad");
    //nivel 2
    arbol->agregarNodo("Algebra", "Software");
    arbol->agregarNodo("Estructura", "Software");
    arbol->agregarNodo("Calculo", "Industrial");
    arbol->agregarNodo("Fisica", "Industrial");
    //nivel 3
    arbol->agregarNodo("GRUPO A","Algebra");
    arbol->agregarNodo("GRUPO B","Algebra");
    arbol->agregarNodo("GRUPO C","Fisica");

    arbol->mostrar(arbol->getRaiz(), 1);
   
    //cambios: renombrar
    arbol->renombrarNodo("Software","Sistemas");//renombra software
    arbol->renombrarNodo("Universidad", "ITQ");//renombra Universisdad
    arbol->renombrarNodo("Gestion", "Electricidad");//renombre gestion
    
    arbol->mostrar(arbol->getRaiz(), 1);

    //cambios: traslados 
    arbol->trasladarHijo("Algebra", "Electricidad");//el nodo algebra pasara a ingeneria en electricidad
    arbol->trasladarHijos("Industrial", "Sistemas");//todos los hijos de industrial pasaran a sistemas
    
    arbol->mostrar(arbol->getRaiz(), 1);

    //cambios: eliminacion
    arbol->eliminarNodo("Estructura");//eliminacion de un nodo sin hijos sin traslado
    arbol->eliminarNodo("Algebra");//eliminacion de un nodo con hijos sin traslado
    arbol->elimnarNodo("Arquitectura","Industrial");//eliminacion de un nodo sin hijos con traslado
    arbol->elimnarNodo("Sistemas","Industrial");//eliminacion de un nodo con hijos con traslado
    
    arbol->mostrar(arbol->getRaiz(), 1);

    cout<<"FIN"<<endl;

}
