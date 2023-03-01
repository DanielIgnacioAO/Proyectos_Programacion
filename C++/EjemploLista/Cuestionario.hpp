#ifndef Cuestionario_hpp
#define Cuestionario_hpp
#include <string>
#include <iostream>
#include <list>
#include "Pregunta.hpp"
using namespace std;
 
class Cuestionario
{
    private:
        int categorias;
        int preguntas;
        list<Pregunta*>* listaCategoria;
        list<Pregunta*>* listaPuntaje;
    public:
        Cuestionario();
        
        void insertar(Pregunta*);
        void llenarListaPuntaje(Pregunta*);
        
        int compararLugar(Pregunta* , Pregunta*);
        string limpiador(string*);
        void contadorCategorias(Pregunta*);

        void llenarCuestionario();
        void listarPreguntas();
        void listarCategorias();
        void cantidadCategoriasPreguntas();
        void listarCuestionarioPuntacion();
};

#endif /*Cuestionario_hpp*/