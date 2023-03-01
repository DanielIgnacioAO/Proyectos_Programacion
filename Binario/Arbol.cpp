#include "Arbol.hpp"
#include "Nodo.hpp"
#include "Archivo.hpp"
#include <iostream>
using namespace std;

Arbol::Arbol(){this->raiz=NULL;}//constructor, iniciliza la raiz

//(nodo padre, nuevo archivo)inserta un archivo dentro del arbol, acomodandolo segun su nombre
bool Arbol::insertar(Nodo* &n, Archivo* a){
    if(n==NULL){
        n=new Nodo(a);
        enlazarTam(n, this->raiz);
        enlazarFec(n, this->raiz);
        cout<<"Creaccion con exito"<<endl;
        return 1;
    }else{
        if(n->dato->getNombre()>a->getNombre())
        {
           return insertar(n->IzqNombre, a);
        }else{
           return insertar(n->DerNombre, a);
        }
    }
}


//(nombre del archivo a borrar, nodo padre)borrar un archivo segun su nombre
bool Arbol::borrar(string eliminar, Nodo*& n){

    if(n==NULL){
        cout<<"No existe"<<endl;
        return 0;
    }else{
        if(n->dato->getNombre()==eliminar ){
            Nodo* aux = n;//auxiliar 
            
            desenlazarTam(n,this->raiz);
            desenlazarFec(n, this->raiz);

            if(aux->IzqNombre==NULL){
               n=aux->DerNombre; 
            }else if(aux->DerNombre==NULL){
                n=aux->IzqNombre;
            }else{
                aux=reemplazar(aux);
            }
            aux=NULL;
            cout<<"Eliminacion correcta por NOMBRE...Eliminacion COMPLETA"<<endl;
            
                
            return 1;
        }else{
            if(eliminar > n->dato->getNombre() )
            {
                return borrar(eliminar, n->DerNombre);
            }else if(eliminar < n->dato->getNombre()){
                return borrar(eliminar, n->IzqNombre);
            }
        }
    }
}

//(nodo que sera eliminado)realiza el reemplazo de los nodos, 
//al eliminar un nodo que tiene hijos a la derecha y a la izquierda 
//modo: El mayor de los menores
Nodo* Arbol::reemplazar(Nodo* n){
    Nodo* aux1= n->IzqNombre;//nodo auxiliar 1, para recorrer el arbol
    Nodo* aux2=n;//nodo auxiliar 2, para recorrer el arbol
    while (aux1->DerNombre !=NULL){
        aux2=aux1;
        aux1=aux1->DerNombre;
    }
    n->dato=aux1->dato;

    if(aux2==n){
        aux2->IzqNombre=aux1->IzqNombre;
        return aux1;
    }else{
        aux2->DerNombre=aux1->IzqNombre;
        return aux1;
    }
}

//(nodo a enlazar, raiz/nodo padre)enlaza los nodos segun su tamano (acomoda los nodos segun el tamano)
bool Arbol::enlazarTam(Nodo* & analizar, Nodo*& nodoPrincipal){

    if(analizar==this->raiz){
        return 1;
    }else{
        if(analizar->dato->getTamano()>=nodoPrincipal->dato->getTamano()){
            if(nodoPrincipal->DerTamano==NULL){
                nodoPrincipal->DerTamano=analizar;
                return 1;
            }else{
                return enlazarTam(analizar, nodoPrincipal->DerTamano);
            }
        }else{
            if(nodoPrincipal->IzqTamano==NULL){
                nodoPrincipal->IzqTamano=analizar;
                return 1;
            }else{
                return enlazarTam(analizar, nodoPrincipal->IzqTamano);
            }
        }
    }
    
}

//(nodo a enlazar, raiz/nodo padre)enlaza los nodos segun la fecha (acomoda los nodo segun la fecha 
bool Arbol::enlazarFec(Nodo*& analizar, Nodo*& nodoPrincipal){
    if(analizar==this->raiz){
        return 1;
    }else{
        if(analizar->dato->getFecha()>=nodoPrincipal->dato->getFecha()){
            if(nodoPrincipal->DerFecha==NULL){
                nodoPrincipal->DerFecha=analizar;
                return 1;
            }else{
                return enlazarFec(analizar, nodoPrincipal->DerFecha);
            }
        }else{
            if (nodoPrincipal->IzqFecha==NULL){
                nodoPrincipal->IzqFecha=analizar;
                return 1;
            }else{
                return enlazarFec(analizar, nodoPrincipal->IzqFecha);
            }
            
        }
    }
}

//(nodo a desenlazar, raiz/nodo padre)desenlaza al nodo segun el tamano 
void Arbol::desenlazarTam(Nodo*& analizar, Nodo*& nodoPrincipal){
if(nodoPrincipal!=NULL){
    if(nodoPrincipal->IzqTamano==analizar){
        if(nodoPrincipal->IzqTamano->IzqTamano==NULL){
            nodoPrincipal->IzqTamano=nodoPrincipal->IzqTamano->DerTamano;
        }else if(nodoPrincipal->IzqTamano->DerTamano==NULL){
            nodoPrincipal->IzqTamano=nodoPrincipal->IzqTamano->IzqTamano;
        }else{
        
            Nodo* aux1= nodoPrincipal->IzqTamano->IzqTamano;//nodo auxiliar 1, para recorrer el arbol
            Nodo* aux2=nodoPrincipal->IzqTamano;//nodo auxiliar 2, para recorrer el arbol
            Nodo* hijoD=nodoPrincipal->IzqTamano;//nodo auxiliar 3, para guardara un valor
            while (aux1->DerTamano !=NULL){
                aux2=aux1;
                aux1=aux1->DerTamano;
            }
    
            if(aux2==nodoPrincipal->IzqTamano){
                aux1->DerTamano=hijoD->DerTamano;
                nodoPrincipal->IzqTamano=aux1;
            }else{
                aux2->DerTamano=aux1->IzqTamano;
                aux1->IzqTamano=hijoD->IzqTamano;
                aux1->DerTamano=hijoD->DerTamano;
                nodoPrincipal->IzqTamano=aux1;
            }        
        }
        cout<<"Eliminacion correcta por TAMANO...";
    }else if(nodoPrincipal->DerTamano==analizar){
        if(nodoPrincipal->DerTamano->IzqTamano==NULL){
            nodoPrincipal->DerTamano=nodoPrincipal->DerTamano->DerTamano;
        }else if(nodoPrincipal->DerTamano->DerTamano==NULL){ 
            nodoPrincipal->DerTamano=nodoPrincipal->DerTamano->IzqTamano;
        }else{
            Nodo* aux1= nodoPrincipal->DerTamano->IzqTamano;//nodo auxiliar 1, para recorrer el arbol
            Nodo* aux2=nodoPrincipal->DerTamano;//nodo auxiliar 2, para recorrer el arbol
            Nodo* hijoD=nodoPrincipal->DerTamano;//nodo auxiliar 3, para guardar un dato
            while (aux1->DerTamano !=NULL){
                aux2=aux1;
                aux1=aux1->DerTamano;
            }
        
            if(aux2==nodoPrincipal->DerTamano){
                aux1->DerTamano=hijoD->DerTamano;
                nodoPrincipal->DerTamano=aux1; 
            }else{
                aux2->DerTamano=aux1->IzqTamano;
                aux1->IzqTamano=hijoD->IzqTamano;
                aux1->DerTamano=hijoD->DerTamano;
                nodoPrincipal->DerTamano=aux1;
            }
        }   
        cout<<"Eliminacion correcta por TAMANO..."; 
    }else{
        if(analizar->dato->getTamano() >= nodoPrincipal->dato->getTamano()){
            desenlazarTam(analizar, nodoPrincipal->DerTamano);
        }else if(analizar->dato->getTamano() < nodoPrincipal->dato->getTamano()){
            desenlazarTam(analizar, nodoPrincipal->IzqTamano);
        }
    }
}    
}

//(nodo a desenlazar, raiz/nodo padre)desenlaza al nodo segun la fecha
void Arbol::desenlazarFec(Nodo*& analizar,Nodo*& nodoPrincipal){
if(nodoPrincipal!=NULL){
    if(nodoPrincipal->IzqFecha==analizar){
        if(nodoPrincipal->IzqFecha->IzqFecha==NULL){
            nodoPrincipal->IzqFecha=nodoPrincipal->IzqFecha->DerFecha;
        }else if(nodoPrincipal->IzqFecha->DerFecha==NULL){
            nodoPrincipal->IzqFecha=nodoPrincipal->IzqFecha->IzqFecha;
        }else{
            Nodo* aux1= nodoPrincipal->IzqFecha->IzqFecha;//nodo auxiliar 1, para recorrer el arbol
            Nodo* aux2=nodoPrincipal->IzqFecha;//nodo auxiliar 2, para recorrer el arbol
            Nodo* hijoD=nodoPrincipal->IzqFecha;//nodo auxiliar 3, para guardar un dato
            while (aux1->DerFecha !=NULL){
                aux2=aux1;
                aux1=aux1->DerFecha;
            }
    
            if(aux2==nodoPrincipal->IzqFecha){
                aux1->DerFecha=hijoD->DerFecha;
                nodoPrincipal->IzqFecha=aux1;
            }else{
                aux2->DerFecha=aux1->IzqFecha;
                aux1->IzqFecha=hijoD->IzqFecha;
                aux1->DerFecha=hijoD->DerFecha;
                nodoPrincipal->IzqFecha=aux1;
            }    
            
        }
        cout<<"Eliminacion correcta por FECHA...";
    }else if(nodoPrincipal->DerFecha==analizar){
        if(nodoPrincipal->DerFecha->IzqFecha==NULL){
            nodoPrincipal->DerFecha=nodoPrincipal->DerFecha->DerFecha;
        }else if(nodoPrincipal->DerFecha->DerFecha==NULL){ 
            nodoPrincipal->DerFecha=nodoPrincipal->DerFecha->IzqFecha;
        }else{
            Nodo* aux1= nodoPrincipal->DerFecha->IzqFecha;//nodo auxiliar 1, para recorrer el arbol
            Nodo* aux2=nodoPrincipal->DerFecha;//nodo auxiliar 2, para recorrer el arbol
            Nodo* hijoD=nodoPrincipal->DerFecha;//nodo auxiliar 3, para guardar un dato
    
            while (aux1->DerFecha !=NULL){
                aux2=aux1;
                aux1=aux1->DerFecha;
            }
        
            if(aux2==nodoPrincipal->DerFecha){
                aux1->DerFecha=hijoD->DerFecha;
                nodoPrincipal->DerFecha=aux1;
            
            }else{
                aux2->DerFecha=aux1->IzqFecha;
                aux1->IzqFecha=hijoD->IzqFecha;
                aux1->DerFecha=hijoD->DerFecha;
                nodoPrincipal->DerFecha=aux1;
            }
            
        }
        cout<<"Eliminacion correcta por FECHA...";
    }else{
        if(analizar->dato->getFecha() >= nodoPrincipal->dato->getFecha()){
            desenlazarFec(analizar, nodoPrincipal->DerFecha);
        }else if(analizar->dato->getFecha() < nodoPrincipal->dato->getFecha()){
            desenlazarFec(analizar, nodoPrincipal->IzqFecha);
        }
    }
}
}

//(nombre del archivo a buscar, raiz/nodo padre)busca el archivo segun el nombre
Archivo* Arbol::buscarArchivoNombre(string buscar, Nodo*& n){
    cout<<"BUSCANDO...";
    if(n==NULL){
        cout<<"EL ARCHIVO NO EXISTE"<<endl;
        return NULL;
    }else{
        if(n->dato->getNombre()==buscar ){
            cout<<"ENCONTRADO...NOMBRE: "<<n->dato->getNombre()<<" TAMANO: "<<n->dato->getTamano()<<" TIPO: "<<n->dato->getTipo()<<" FECHA:"<<n->dato->getFecha()<<endl;
            return n->dato;
        }else{
            if(buscar >= n->dato->getNombre() )
            {
                return buscarArchivoNombre(buscar, n->DerNombre);
            }else{
                return buscarArchivoNombre(buscar, n->IzqNombre);
            }
        }
    }
}   

//(nombre del archivo a buscar, raiz/nodo padre)busca el archivo segun el tamano
Archivo* Arbol::buscarArchivoTamano(int buscar, Nodo*& n){
    cout<<"BUSCANDO...";
    if(n==NULL){
        cout<<"EL ARCHIVO NO EXISTE"<<endl;
        return NULL;
    }else{
        if(n->dato->getTamano()==buscar){
            cout<<"ENCONTRADO...NOMBRE: "<<n->dato->getNombre()<<" TAMANO: "<<n->dato->getTamano()<<" TIPO: "<<n->dato->getTipo()<<" FECHA:"<<n->dato->getFecha()<<endl;
            return n->dato;
        }else{
            if(buscar >= n->dato->getTamano()){
                return buscarArchivoTamano(buscar, n->DerTamano);
            }else{
                return buscarArchivoTamano(buscar, n->IzqTamano);
            }
        }
    }
}

//(nombre del archivo a buscar, raiz/nodo padre)busca el archivo segun la fecha
Archivo* Arbol::buscarArchivoFecha(string buscar, Nodo*& n){
    cout<<"BUSCANDO...";
    if(n==NULL){
        cout<<"EL ARCHIVO NO EXISTE"<<endl;
        return NULL;
    }else{
        if(n->dato->getFecha()==buscar){
            cout<<"ENCONTRADO...NOMBRE: "<<n->dato->getNombre()<<" TAMANO: "<<n->dato->getTamano()<<" TIPO: "<<n->dato->getTipo()<<" FECHA:"<<n->dato->getFecha()<<endl;
            return n->dato;
        }else{
            if(buscar >= n->dato->getFecha()){
                return buscarArchivoFecha(buscar, n->DerFecha);
            }else{
                return buscarArchivoFecha(buscar, n->IzqFecha);
            }
        }
    }
}

//(raiz/nodo padre)imprime en inOrden segun el nombre
void Arbol::inOrdenN(Nodo* a){
    if(a!=NULL){
        if(a==this->raiz){
            cout<<"==================================================================================================="<<endl;
            cout<<"Recorrido inOrden por nombre:"<<endl;
        }
        inOrdenN(a->IzqNombre);
        cout<<"NOMBRE: "<<a->dato->getNombre()<<" TAMANO: "<<a->dato->getTamano()<<" TIPO: "<<a->dato->getTipo()<<" FECHA:"<<a->dato->getFecha()<<endl;
        inOrdenN(a->DerNombre);
        if(a==this->raiz){
            cout<<"==================================================================================================="<<endl;
        }
    }
}

//(raiz/nodo padre)imprime en preOrden segun el nombre
void Arbol::preOrdenN(Nodo* a){
    if(a!=NULL){
        if(a==this->raiz){
            cout<<"==================================================================================================="<<endl;
            cout<<"Recorrido preOrden por nombre:"<<endl;
        }
        cout<<"NOMBRE: "<<a->dato->getNombre()<<" TAMANO: "<<a->dato->getTamano()<<" TIPO: "<<a->dato->getTipo()<<" FECHA:"<<a->dato->getFecha()<<endl;
        preOrdenN(a->IzqNombre);
        preOrdenN(a->DerNombre);
        if(a==this->raiz){
            cout<<"==================================================================================================="<<endl;
        }
    }
}

//(raiz/nodo padre)imprime en postOrden segun el nombre
void Arbol::postOrdenN(Nodo* a){
    if(a!=NULL){
        if(a==this->raiz){
            cout<<"==================================================================================================="<<endl;
            cout<<"Recorrido postOrden por nombre:"<<endl;
        }
        postOrdenN(a->IzqNombre);
        postOrdenN(a->DerNombre);
        cout<<"NOMBRE: "<<a->dato->getNombre()<<" TAMANO: "<<a->dato->getTamano()<<" TIPO: "<<a->dato->getTipo()<<" FECHA:"<<a->dato->getFecha()<<endl;
        if(a==this->raiz){
            cout<<"==================================================================================================="<<endl;
        }
    }
}

//(raiz/nodo padre)imprime en inOrden segun el tamano
void Arbol::inOrdenTam(Nodo* a){
    if(a!=NULL){
        if(a==this->raiz){
            cout<<"==================================================================================================="<<endl;
            cout<<"Recorrido inOrden por tamano:"<<endl;
        }
        inOrdenTam(a->IzqTamano);
        cout<<"TAMANO: "<<a->dato->getTamano()<<" NOMBRE: "<<a->dato->getNombre()<<" TIPO: "<<a->dato->getTipo()<<" FECHA:"<<a->dato->getFecha()<<endl;
        inOrdenTam(a->DerTamano);
        if(a==this->raiz){
            cout<<"==================================================================================================="<<endl;
        }
    }
}

//(raiz/nodo padre)imprime en preOrden segun el tamano
void Arbol::preOrdenTam(Nodo* a){
    if(a !=NULL){
        if(a==this->raiz){
            cout<<"==================================================================================================="<<endl;
            cout<<"Recorrido preOrden por tamano:"<<endl;
        }
        cout<<"TAMANO: "<<a->dato->getTamano()<<" NOMBRE: "<<a->dato->getNombre()<<" TIPO: "<<a->dato->getTipo()<<" FECHA:"<<a->dato->getFecha()<<endl;
        preOrdenTam(a->IzqTamano);
        preOrdenTam(a->DerTamano);
        if(a==this->raiz){
            cout<<"==================================================================================================="<<endl;
        }
    }
}

//(raiz/nodo padre)imprime en postOrden segun el tamano
void Arbol::postOrdenTam(Nodo* a){
    if(a!=NULL){
        if(a==this->raiz){
            cout<<"==================================================================================================="<<endl;
            cout<<"Recorrido postOrden por tamano:"<<endl;
        }
        postOrdenTam(a->IzqTamano);
        postOrdenTam(a->DerTamano);
        cout<<"TAMANO: "<<a->dato->getTamano()<<" NOMBRE: "<<a->dato->getNombre()<<" TIPO: "<<a->dato->getTipo()<<" FECHA:"<<a->dato->getFecha()<<endl;
        if(a==this->raiz){
            cout<<"==================================================================================================="<<endl;
        }
    }
}

//(raiz/nodo padre)imprime en inOrden segun la fecha
void Arbol::inOrdenFec(Nodo* a){
    if(a!=NULL){
        if(a==this->raiz){
            cout<<"==================================================================================================="<<endl;
            cout<<"Recorrido inOrden por fecha:"<<endl;
        }
        inOrdenFec(a->IzqFecha);
        cout<<"FECHA:"<<a->dato->getFecha()<<" NOMBRE: "<<a->dato->getNombre()<<" TAMANO: "<<a->dato->getTamano()<<" TIPO: "<<a->dato->getTipo()<<endl;
        inOrdenFec(a->DerFecha);
        if(a==this->raiz){
            cout<<"==================================================================================================="<<endl;
        }
    }
}

//(raiz/nodo padre)imprime en preOrden segun la fecha
void Arbol::preOrdenFec(Nodo* a){
    if(a!=NULL){
        if(a==this->raiz){
            cout<<"==================================================================================================="<<endl;
            cout<<"Recorrido preOrden por fecha:"<<endl;
        }
        cout<<"FECHA:"<<a->dato->getFecha()<<" NOMBRE: "<<a->dato->getNombre()<<" TAMANO: "<<a->dato->getTamano()<<" TIPO: "<<a->dato->getTipo()<<endl;
        preOrdenFec(a->IzqFecha);
        preOrdenFec(a->DerFecha);
        if(a==this->raiz){
            cout<<"==================================================================================================="<<endl;
        }
    }
}

//(raiz/nodo padre)imprime en postOrden segun la fecha
void Arbol::postOrdenFec(Nodo* a){
    if(a!=NULL){
        if(a==this->raiz){
            cout<<"==================================================================================================="<<endl;
            cout<<"Recorrido postOrden por fecha:"<<endl;
        }
        postOrdenFec(a->IzqFecha);
        postOrdenFec(a->DerFecha);
        cout<<"FECHA:"<<a->dato->getFecha()<<" NOMBRE: "<<a->dato->getNombre()<<" TAMANO: "<<a->dato->getTamano()<<" TIPO: "<<a->dato->getTipo()<<endl;
        if(a==this->raiz){
            cout<<"==================================================================================================="<<endl;
        }
    }
}