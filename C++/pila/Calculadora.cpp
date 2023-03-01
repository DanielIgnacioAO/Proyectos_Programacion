#include "Calculadora.hpp"
#include "Pila.hpp"
#include "Nodo.hpp"
#include <string>
#include <iostream>
#include <stdlib.h>
#include <math.h>
//clase de calculadora que realizara los procesos basicos de una calculadora
using namespace std;
//constructor con parametros de dos pilas, las cuales serviran para realizar las funciones de la calculadora
Calculadora::Calculadora(Pila* pila1, Pila* pila2){

    this->pilaNumeros=pila1;//pila de numeros que ayudara a la evaluacion de las expresion posfijas
    this->pilaOperadores=pila2;//pila de caracteres que ayudadra a realizar la trnaformacion a posfija
}
//Metodo que permitira pasar de una expresion infija (parametro) a una posfija, utilizando la pila de caracteres que se creo en el constructor de la calculadora
string Calculadora::pasarApostfija(string infija){
    char* aux;//el caractere auxiliar que ira tomando el valor de cada caracter de la expresion infija para poder analizarla
    string posfija="";//expresion posfija incializada en blanco 
    Nodo* nodo;

    for (size_t i = 0; i < infija.length(); i++)
    {
        *aux=infija.at(i);
        if(*aux>=48 && *aux<=57){//identifica si es un numero si es el caso la pasa a la expresion posfija
            posfija=posfija + *aux;
        }else if(*aux=='(' || *aux=='+' || *aux=='-' || *aux=='*' || *aux=='/' || *aux=='^'){//en caso de ser un operador o parentesis izquierdo se iran almacenando en la pila segun sea el caso
            
            nodo =new Nodo(*aux);
            bool con=true;
            do//todo el codigo dentro del do-while, se puede colocar en una funcion recursiva, pero creo que sera mas comprensible el codigo si se deja de manera iterativa
            {
                if(this->pilaOperadores->getElementos()==0){//caso base-->en caso de estar vacia la pila se intrducira el operador  
                    this->pilaOperadores->insertar(nodo);
                    con=false;
                }else if(*aux=='('){//caso base-->en caso de ser parentesis izquierdo ocurrira lo mismo de introducirlo dentro de la pila sin evaluar su jerarquia
                    this->pilaOperadores->insertar(nodo);
                    con=false;
                }else{//caso base-->en caso contrario de los dos anteriores, el operador sera evaluado segun su jerarquia
                    if(this->validadJerarquia(nodo)){//si su jerarquia es mayor que la del operador que se encuentra en la cima de la pila, este sera insertado en la pila tomando lugar como el top
                        this->pilaOperadores->insertar(nodo);
                        con=false;
                    }else{//caso recursivo-->en caso de tener una menor o igual jerarquia al top, el top sera sacado de la pila e introducido a la expresion posfija y se volvera a repetir la comparacion de jerarqui con el nuevo top
                        posfija=posfija + this->pilaOperadores->consultarTope()->getDato();
                        this->pilaOperadores->sacarTope();
                    }
                }    
            } while (con);
        }else if(*aux==')'){//en caso de ser un parentesis derecho todos los operador dentro de la pila seran sacados uno a uno y colocados en la expresion posfija hasta que se encuentre un parentesis izquierdo el cual en vez de ser colocado a la expresion sera slo eliminado de la pila
            bool con2=true;
            do
            {
                posfija=posfija + this->pilaOperadores->consultarTope()->getDato();
                this->pilaOperadores->sacarTope();
                if(this->pilaOperadores->consultarTope()->getDato()=='('){
                    this->pilaOperadores->sacarTope();
                    con2=false;
                }else{
                    con2=true;
                }
            } while (con2);
        }
    }
    while (this->pilaOperadores->getElementos()>0)//finalmente, todos los operadores restantes dentro de la pila seran sacados y colocados en la expresion posfija
    {
        posfija=posfija + this->pilaOperadores->consultarTope()->getDato();
        this->pilaOperadores->sacarTope();
    }
    
    return posfija;//se regresa la expresion posfija
}
//metodo que resuelve la operacion resiviendo como parametro una expresion posfija
double Calculadora::resolver(string expresion){
    char aux;//caracter auxiliar que ira tomando los valores de cada caracter dentro de la expresion
    double resultado;
    Nodo* nodo;
    Nodo* nodoR;
    for (size_t i = 0; i < expresion.length(); i++)
    {
        aux=expresion.at(i);
        if(aux>=48 && aux<=57){//en caso de ser un numero se colocara dentro de la pila de numeros
            double z=aux-48;
            nodo=new Nodo(z); 
            this->pilaNumeros->insertar(nodo);
        }else{//en caso de ser un operador, se secaran los dos valores del top de la pila
            double b=this->pilaNumeros->consultarTope()->getNum();//b es el top
            this->pilaNumeros->sacarTope();//b es sacado, por lo tanto el numero debajo de la pila sera el nuevo top, representado como 'a'
            double a=this->pilaNumeros->consultarTope()->getNum();//a es el nuevo top
            this->pilaNumeros->sacarTope();//a es sacado por lo tanto el valor de bajo tomara el nuevo top
            double c=0;
            switch (aux)//segun sea el caso se realizara la operacion y almeceanra el resultado en c, de manera "c= a & b"
            {
                case '+':
                {
                    c=a+b;
                }
                break;
                case '-':
                {
                    c=a-b;
                }
                break;
                case '*':
                {
                    c=a*b;
                }
                break;
                case '/':
                {
                    c=a/b;
                }
                break;
                case '^':
                {
                    c=pow(a,b);
                }
                break;
            
            }
            nodoR = new Nodo(c);
            this->pilaNumeros->insertar(nodoR);//el resultado sera almacenado en la pila
        }

    }
    resultado=this->pilaNumeros->consultarTope()->getNum();//Al final solamente debera quedar un numero dentro de la pila, el cual es el resultado de la expresion
    this->pilaNumeros->sacarTope();

    return resultado;
    

}
//regresa true si el dato almacenado en el nodo nuevo (parametro) tiene mayor prioridad que el del tope en caso contrario regresara un false
bool Calculadora::validadJerarquia(Nodo* nuevo){
    int aux;//se dan valores numericos segun sea la importnacia en la jerarquia de operaciones 
    if(nuevo->getDato()=='(')
        aux=0;
    else if(nuevo->getDato()=='+' || nuevo->getDato()=='-')
        aux=1;
    else if(nuevo->getDato()=='*' || nuevo->getDato()=='/')
        aux=2;
    else if(nuevo->getDato()=='^')
        aux=3;

    int auxT;//se da valor numericos al operador del top
    if(this->pilaOperadores->consultarTope()->getDato()=='(')
        auxT=0;
    else if(this->pilaOperadores->consultarTope()->getDato()=='+' || this->pilaOperadores->consultarTope()->getDato()=='-')
        auxT=1;
    else if(this->pilaOperadores->consultarTope()->getDato()=='*' || this->pilaOperadores->consultarTope()->getDato()=='/')
        auxT=2;
    else if(this->pilaOperadores->consultarTope()->getDato()=='^')
        auxT=3;
    
    if(aux>auxT)//se compran ambas si es mayor la del parametro regresara un true
        return true;
    else
        return false;
}

