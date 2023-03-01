#ifndef Proceso_hpp
#define Proceso_hpp

using namespace std;
class Proceso
{
private:
    int porcentaje;
    Proceso* ant;
public:
    Proceso();
    int getPorcentaje();
    Proceso* getAnt();
    void setPorcentaje(int*);
    void setAnt(Proceso*);

};


#endif /*Proceso_hpp*/