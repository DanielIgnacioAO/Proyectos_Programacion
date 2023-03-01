#include "Pregunta.hpp"
#include "Cuestionario.hpp"
#include <iostream>
#include <string>
#include <list>
using namespace std;
//clase que tiene la funcion tanto de un cuestionario para ser llenado y listar las preguntas o dar informacion de este
//pero a la vez tiene funciones como una lista dinamica de preguntas
Cuestionario::Cuestionario(){
    this->categorias=0;//total de categorias diferentes 
    this->preguntas=0;//total de preguntas
    this->listaCategoria=new list<Pregunta*>();//list que almacena las preguntas acomodadas alfabeticamente de la A a la Z segun su categoria y a la vez por su valor numerico de puntaje de mayor a menor
    this->listaPuntaje=new list<Pregunta*>();//list que almacena las preguntas acomodads segun su valor de puntaje de mayor a menor
}

//metodo que permite inserta un nodo de pregunta a ambas lists del cuestioanrio, acomodando el nodo segun le corresponda
//este metodo acomoda segun la caegoria y valor numerico
void Cuestionario::insertar(Pregunta* nuevo){
    this->preguntas++;
    this->contadorCategorias(nuevo);//se llama otro metodo que maneja el conteo de categorias
     
    if(this->listaCategoria->size()==0){//caseo de estar vacia la list
        this->listaCategoria->push_front(nuevo);        
    }else if(this->compararLugar(nuevo, this->listaCategoria->front())==1 ){//caso de insertar al inicio
        this->listaCategoria->push_front(nuevo);
    }else if(this->compararLugar(nuevo, this->listaCategoria->back())==-1 || this->compararLugar(nuevo, this->listaCategoria->back())==0 ){//caso de insertar al final
        this->listaCategoria->push_back(nuevo);
    }else{//caso de insertar entre dos nodos
        list<Pregunta*>::iterator auxIte;//iterador que nos permita recorrer la list
        auxIte=this->listaCategoria->begin();//desde el comienzo
        bool condicionAux=true;
        Pregunta* auxPregunta;
        while (condicionAux)
        {
            auxPregunta=*auxIte;
            
            if(auxIte == this->listaCategoria->end()){
                condicionAux=false;
            }

            if(this->compararLugar(nuevo, auxPregunta)==1){
                this->listaCategoria->insert(auxIte, nuevo);
                condicionAux=false;
            }else
            {
                auxIte++;
            }
        }
    }
    this->llenarListaPuntaje(nuevo);//se llama otro metodo para insertar en la lista de puntaje
}

//metodo que permite insertar un nodo en la lista acomodado segun su valor numerico
void Cuestionario::llenarListaPuntaje(Pregunta* nuevo){

   if(this->listaPuntaje->size()==0){//en caso de estar vacia la list
       this->listaPuntaje->push_front(nuevo);
   }else if(nuevo->getValor()>this->listaPuntaje->front()->getValor()){//en caso de insertar al inicio
       this->listaPuntaje->push_front(nuevo);
   }else if(nuevo->getValor()<=this->listaPuntaje->back()->getValor()){//en caso de insertar al final
       this->listaPuntaje->push_back(nuevo);
   }else{
       list<Pregunta*>::iterator auxIte;//iterador que permitira recorrer la list
        auxIte=this->listaPuntaje->begin();
        bool condicionAux=true;
        Pregunta* auxPregunta;
        while (condicionAux)
        {
            auxPregunta=*auxIte;
            
            if(auxIte == this->listaPuntaje->end()){
                condicionAux=false;
            }

            if(nuevo->getValor()>auxPregunta->getValor()){
                this->listaPuntaje->insert(auxIte, nuevo);
                condicionAux=false;
            }else
            {
                auxIte++;
            }
        }

   }
        
}

//metodo que a partir de dos nodos de pregunta indica si n1 va antes o despues o es igual a n2
//regresa -1 si va antes o enfrente
//regresa 1 si va despues o atras
//regresa 0 si es equivalente
//se compara primero el orden alfabetico de A a Z de la categoria y si son iguales se compara su valor de puntaje de mayor a menor
int Cuestionario::compararLugar(Pregunta* n1, Pregunta* n2){
    int auxV1;//numeros enteros que guardaran el valor de puntaje de cada nodo de pregunta
    int auxV2;
    string a1=n1->getCategoria();//strings que guardaran la categoria de los nodos 
    string a2=n2->getCategoria();
    string auxS1=this->limpiador(&a1);//se limpian (eliminan las mayusculas)
    string auxS2=this->limpiador(&a2);
    
    if(auxS1<auxS2){
        return 1;
    }else if(auxS1==auxS2){
        auxV1=n1->getValor();
        auxV2=n2->getValor();
        if(auxV1<auxV2){
            return -1;
        }else if(auxV1==auxV2){
            return 0;
        }else{
            return 1;
        }
    }else{
        return -1;
    }
}

//metodo que regresa un string sin mayusculas de esta manera la categoria "Historia" es lo mismo a "historia"
string Cuestionario::limpiador(string* palabra){
    char aux;//auxiliar que tomara cada dato del strign para pasarlo a minuscula si es mayuscula 
    string limpio="";//string vacio que tomara el valor del parametro pero todo en minusculas
    for (size_t i = 0; i < palabra->length(); i++)
    {   
        aux=palabra->at(i);
        if(aux<91 && aux>64){
            aux=aux+32;
            limpio=limpio+aux;
        }else if(aux<123 && aux>96){
            limpio=limpio+aux;
        }
        
    }
    return limpio;
}

//metodo que ayuda a tener control del numero de categorias del cuestionario
void Cuestionario::contadorCategorias(Pregunta* nuevo){
    string categoria=nuevo->getCategoria();//auxiliar que tomara el valor de la categoria del nodo parametro
    string categoriaAux="";//auxiliar que tomara el valor de una categoria

    bool condicion=true;//auxiliar que cambiara a false en caso de haber encontrado en la list la misma categoria que el parametro

    list<Pregunta*>::iterator auxIte;//iterador que nos ayude a recorrer la list
    auxIte=this->listaCategoria->begin();

    Pregunta* auxPregunta;
    while (auxIte != this->listaCategoria->end())
    {
        auxPregunta=*auxIte;

        categoriaAux=auxPregunta->getCategoria();
        if(this->limpiador(&categoria)==this->limpiador(&categoriaAux)){
            condicion=false;
            break;
        }
        auxIte++;
        
    }
    if(condicion){
        this->categorias++;
    }
}

//metodo que permite llenar el cuestionario 
void Cuestionario::llenarCuestionario(){
    string cat, des;//auxiliares que tomaran valores del usuario para crear la pregunta
    int puntaje;
    Pregunta* nuevo;//pregunta que sera creada mas adelante
    int condicion;//numero de preguntas que se quieren colocar

    cout<<"Cuantas preguntas desea colocar?"<<endl;
    cin>>condicion;
    cin.ignore();
    
    for (size_t i = 0; i < condicion; i++)
    {
        cout<<"Pregunta "<<i+1<<endl;
        cout<<"Escribe la categoria de la pregunta"<<endl;
        getline(cin, cat);
        cout<<"Escribe la pregunta"<<endl;
        getline(cin, des);
        cout<<"Escribe el valor de la pregunta"<<endl;
        cin>>puntaje;
        cin.ignore();
        
        nuevo = new Pregunta(des, cat, puntaje);
        this->insertar(nuevo);
        cout<<endl;
    } 
    cout<<"Cuestionario terminado"<<endl;
    cout<<endl;
    cout<<endl;

}

//metodo que lista todas las preguntas de la siguiente manera:
//categoria: 1:
//pregunta 1:----- Puntuacion:---
//pregunta 2:------Puntacion:---
//categoria: 2
//pregunta 3:----Puntuacion:---
void Cuestionario::listarPreguntas(){
    string categoria="";//auxiliares que tomaran el valor de las categorias 
    string categoriaAux="";

    list<Pregunta*>::iterator auxIte;//iterador que nos ayudara a recorrer la list
    auxIte=this->listaCategoria->begin();

    Pregunta* auxPregunta;//auxliar de un nodo pregunta
    int i=1;//contador de preguntas
    cout<<"Lista de preguntas del cuestionario:"<<endl;
    while (auxIte != this->listaCategoria->end())
    {
        auxPregunta=*auxIte;

        categoriaAux=auxPregunta->getCategoria();
        if(this->limpiador(&categoria)!=this->limpiador(&categoriaAux)){
            categoria=auxPregunta->getCategoria();
            cout<<"\nCategoria: "<<categoria<<endl;
        }

        cout<<"Pregunta "<<i<<": "<<auxPregunta->getDescripcion()<<" Puntuacion: "<<auxPregunta->getValor()<<endl;
        auxIte++;
        i++;
    }
    cout<<endl;
    cout<<endl;
    
}

//metodo que lista las categorias sin repetir 
void Cuestionario::listarCategorias(){
    string categoria="";//auxiliares que tomaran el valor de categorias
    string categoriaAux="";

    list<Pregunta*>::iterator auxIte;//iterador para recorrer la list
    auxIte=this->listaCategoria->begin();
    
    Pregunta* auxPregunta;//auxiliar de nod de pregunta
    int i=1;      //contador de categorias
    cout<<"Lista de categorias del cuestionario:"<<endl;  
    while (auxIte != this->listaCategoria->end())
    {
        auxPregunta=*auxIte;

        categoriaAux=auxPregunta->getCategoria();
        if(this->limpiador(&categoria)!=this->limpiador(&categoriaAux)){
            categoria=auxPregunta->getCategoria();
            cout<<"Categoria "<<i<<": "<<categoria<<endl;
            i++;
        }
        auxIte++;
    }
    cout<<endl;
    cout<<endl;
}

//metodo que imprime el total de preguntas y total de categorias
void Cuestionario::cantidadCategoriasPreguntas(){
    cout<<"Cantidad total de preguntas: "<<this->preguntas<<endl;
    cout<<"Canridad total de categorias: "<<this->categorias<<endl;
    cout<<endl;
    cout<<endl;
}

//metodo que lista las preguntas por su puntuacion de mayor a menor (no se considera su categoria)
void Cuestionario::listarCuestionarioPuntacion(){
    list<Pregunta*>::iterator auxIte;//iterador para recorrer la list
    auxIte=this->listaPuntaje->begin();
    
    Pregunta* auxPregunta;//auxiliar de pregunta
    int i=1;      //contador de pregunta
    cout<<"Lista de preguntas del cuestionario por puntaje:"<<endl;  
    while (auxIte != this->listaPuntaje->end())
    {
        auxPregunta=*auxIte;
        cout<<"Puntaje: "<<auxPregunta->getValor()<<" Pregunta "<<i<<": "<<auxPregunta->getDescripcion()<<endl;
        i++;
        auxIte++;
    }
}