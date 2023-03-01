/*
Nombre: Arellano Ochoa Daniel Ignacio
Problema: Lista de preguntas
Implemente un progrma utilizando estructuras lineales dinamicas que permitan controlar una lista de preguntas.
Cada pregunta deberá tener una descripcion, una categoria y valor en puntos, la lista debera estar ordenada por
categorias y por puntuacion, independientemente del orden como se fueron incorporando las preguntas
Al finalizar la captura de preguntas, el programa debera proporcionar:
    Listar por categoria las preguntas capturadas
    Listar solo las categorias sin repetir (nombres diferentes de categorias)
    La cantidad de categorias y preguntas existentes 
    Las preguntas de mayor a menor puntuacion

    He de mensionar que las categorias al ser capturas no consideran las mayusculas por lo tanto si se escribre
    "Historia" en categoria de la primer pregunta captura y despues en otra pregunta se captura como categoria
    "historia" ambas seran de la misma categoria
*/ 
#include <string>
#include <iostream>
#include <list>
#include "Pregunta.hpp"
#include "Cuestionario.hpp"

using namespace std; 

//Menu de inicio del programa
int main(int argc, const char * argv[]){
    Cuestionario* examen=new Cuestionario();//se crea el objeto de cuestionario con el identificador de examen 
    examen->llenarCuestionario();
    examen->listarPreguntas();
    examen->listarCategorias();
    examen->cantidadCategoriasPreguntas();
    examen->listarCuestionarioPuntacion();
    cout<<"Fin del programa"<<endl;
}
