#ifndef Pregunta_hpp
#define Pregunta_hpp
#include <string>
#include <iostream> 

using namespace std;
class Pregunta
{
    private:
        string descripcion;
        string categoria;
        int valor;
        //Pregunta* ant;
        //Pregunta* des;
    public:
        Pregunta(string, string, int);
        string getDescripcion();
        string getCategoria();
        int getValor();
        //Pregunta* getAnt();
        //Pregunta* getDes();
        //void setAnt(Pregunta*);
        //void setDes(Pregunta*);

        
};
#endif /*Pregunta_hpp*/