#include "Procesador.hpp"
#include "Proceso.hpp"
#include <string>
#include <iostream>
#include <stdlib.h>
#include <time.h>
//clase de procesador
using namespace std;
//constructor del procesador, con datos inicializados
Procesador::Procesador(){
    this->inicio=NULL;//proceso que se encuentra al inicio de la cola
    this->final=NULL;//procesos que se encuetnra al final de la cola
    this->proGenerados=0;//procesos generados
    this->proAtendidos=0;//procesos atendido al 100%
    this->proCola=0;//procesos atendidos de 0% a 99%
    this->proCero=0;//procesos no atendido
}

//metodo para insertar un procesos dentro de la cola
void Procesador::insertar(Proceso* p){
    if(this->proCola==0){
        this->inicio=p;
        this->final=p;
    }else{
        this->final->setAnt(p);
        this->final=p;
    }
    this->proCola++;
}
//metodo para sacar el proceso que se encuetra al inicio de la cola
void Procesador::sacar(){
    this->inicio=this->inicio->getAnt();
    this->proCola--;
}
//metodo que generar N procesos, insertandolos a la cola
void Procesador::generarProcesos(int* N){
    Proceso* pro;
    for (size_t i = 0; i < *N; i++)
    {
        pro=new Proceso();
        this->insertar(pro);
        this->proGenerados++;
    }
}
//metodo que atiende M procesos, verificando si se logro atender al 100%, si es el caso contrario se volvera a formar dentro de la cola
void Procesador::atenderProcesos(int* M){
    srand(time(NULL));
    int pAux=0;
    Proceso* proAux;
    for (size_t i = 0; i < *M; i++)
    {
        if(this->proCola>0){
            proAux=this->inicio;
            this->sacar();
            pAux=rand()%100 + 1;
            pAux= pAux + proAux->getPorcentaje();
            proAux->setPorcentaje(&pAux);
        
        
            if(proAux->getPorcentaje()<100){
                this->insertar(proAux);
            }else{
                this->proAtendidos++;
            }
        
        }
       
        
    }
}
//metodo que generar y ateiende N y M procesos respectivamente, durante 100 ciclos (100 minutos simulados), dando informacion al final
void Procesador::procesar(){
    srand(time(NULL));
    int M=0;//proceso a atender
    int N=0;//procesos a generar
    
    for (size_t i = 0; i < 100; i++)
    {
        //cout<<"minuto"<<i<<endl;
        M= rand()%6;
        N= rand()%6;
        //cout<<"M= "<<M<<" N= "<<N<<endl;
        this->generarProcesos(&N);
        if(M>this->proCola){
            M=this->proCola;
            this->atenderProcesos(&M);
        }else{
            this->atenderProcesos(&M);
        }
    }
    cout<<"Se generaron: "<<this->proGenerados<<" procesos"<<endl;
    cout<<"Se atendieron al 100%: "<<this->proAtendidos<<" procesos"<<endl;
    cout<<"En la cola hay: "<<this->proCola<<" procesos"<<endl;
    cout<<"Lista de procesos incompletos:"<<endl;
    this->procesosColaInc();
    

}
//metodo que cuenta los procesos que quedaron sin atender y enumero e imprime los procesos que fueron atendidos pero no al 100%
void Procesador::procesosColaInc(){
    Proceso* auxPro;
    int i=1;
    int aux= this->proCola;
    while (aux>0)
    {
        auxPro=this->inicio;
        this->sacar();
        if(auxPro->getPorcentaje()>0){
            cout<<"Proceso "<<i<<" Porcentaje: "<<auxPro->getPorcentaje()<<endl;
            i++;
        }else{
            this->proCero++;
        }
        this->insertar(auxPro);
        aux--;
    }
    cout<<"Procesos con 0%: "<<this->proCero<<endl;
    
}