/*Nombre: Arellano Ochoa Daniel Ignacio
Implemente en C++ utilizando clases, un árbol binario de búsqueda, de archivos con la siguiente información:
•	Nombre del Archivo
•	Tamaño
•	Tipo de Archivo
•	Fecha de Inclusión
Deberá implementar:
•	Creación del Árbol (agregar Nodos)
•	Recorridos en Árbol 
    o  	Pre orden
    o	InOrden
    o	PostOrden
•	Búsquedas de algún archivo por:
    o	Nombre
    o	Tamaño
    o	Fecha

*/
#include "Archivo.hpp"
#include "Arbol.hpp"
#include "Nodo.hpp"
#include <iostream>
#include <string>

using namespace std;


//Menu de inicio del programa
int main(int argc, const char * argv[]){
    //se crea el arbol
    Arbol* carpeta = new Arbol();


    //se crean los archivos 
    Archivo* arc1 = new Archivo("archivo B",100, "imagen", "2000/01/01");
    Archivo* arc2 = new Archivo("archivo A",300, "video", "2000/01/02");
    Archivo* arc3 = new Archivo("archivo D",500, "texto", "2000/02/01");
    Archivo* arc4 = new Archivo("archivo C",400, "cpp", "2001/01/01");
    Archivo* arc5 = new Archivo("archivo E",200, "cpp", "2002/01/01");


    //se insertan los archivos al arbol
    carpeta->insertar(carpeta->raiz, arc1);
    carpeta->insertar(carpeta->raiz, arc2);
    carpeta->insertar(carpeta->raiz, arc3);
    carpeta->insertar(carpeta->raiz, arc4);
    carpeta->insertar(carpeta->raiz, arc5);

    //se imprime segun el nombre
    //se imprime en inOrden 
    carpeta->inOrdenN(carpeta->raiz);
    
    //se imprime en postOrden
    carpeta->postOrdenN(carpeta->raiz);
    
    //se imprime en preOrden
    carpeta->preOrdenN(carpeta->raiz);
    

    //se imprime segun el tamano
    //se imprime en inOrden
    carpeta->inOrdenTam(carpeta->raiz);
    
    //se imprime en postOrden
    carpeta->postOrdenTam(carpeta->raiz);
    
    //se imprime en preOrden
    carpeta->preOrdenTam(carpeta->raiz);
    

    //se imprime segun la fecha
    //se imprime en inOrden
    carpeta->inOrdenFec(carpeta->raiz);
    
    //se imprime en postOrden
    carpeta->postOrdenFec(carpeta->raiz);
    
    //se imprime en preOrden
    carpeta->preOrdenFec(carpeta->raiz);
    



    //se borra un archivo 
    carpeta->borrar("archivo D", carpeta->raiz);
    
    //se imprime para verificar el borrado, en las 3 relaciones(nombre, tamano, fecha)
    carpeta->inOrdenN(carpeta->raiz);
    
    carpeta->inOrdenTam(carpeta->raiz);
    
    carpeta->inOrdenFec(carpeta->raiz);
    
    
    //se busca segun su nombre
    carpeta->buscarArchivoNombre("archivo E", carpeta->raiz);
    
    //se busca segun su tamaño
    carpeta->buscarArchivoTamano(400, carpeta->raiz);
    
    //se buca segun su fecha
    carpeta->buscarArchivoFecha("2000/01/01", carpeta->raiz);
    
    //se busca el archivo que se borro
    carpeta->buscarArchivoNombre("archivo D", carpeta->raiz);
    cout<<"FIN"<<endl;    
}

