/***************************************************
Programa: Natural.pl
Funcion: Implementacion de numeros naturales con los
         postulados de Peano

    1) 0 es un numero natural
    2) Si n es un numero natural, s(n) tambien lo es
    3) 0 no es sucesor de ningun natural
    4) Si n y m son naturales y s(n) = s(m), entonces n=m
    5) Si 0 pertenece a A, y dado un natural n su sucesor
    tambien pertenece a A, entonces todos los naturales 
    pertenecen a A

    Nombre: Arellano Ochoa Daniel Ignacio
    No. de control: 19141118
***************************************************/

/*Indica si un sucesor es natural s(s(0)) es natural*/
natural(0):- !.
natural(s(X)) :- natural(X).

/*(1,X) X=s(0), regresa X que es la representacion con s() del numero natural*/
representa(0,0) :- !.
representa(N,s(X)) :- 
    N1 is N-1,
    representa(N1,X).

/*Contrario de representa, (s(0),X) X=1, regresa el valor de la representacion s() */
corresponde(0,0) :-!.
corresponde(s(X),N):-
    corresponde(X,N1),
    N is N1+1.

/* suma(X,Y,Z) Z=Y+X */
suma(0,X,X):-!.
suma(s(X), Y, s(Z)):- 
    suma(X,Y,Z).

/* multiplica(X,Y,Z) Z=Y*X */
multiplica(0,_,0):-!.
multiplica(s(X), Y, Z):-
    multiplica(X,Y,W),
    suma(Y,W,Z).

% factorial, potencia, ackermann

/* factorial(X,Y) Y=X! */
factorial(0,s(0)):- !.
factorial(s(X),F) :-
	factorial(X,T),
	multiplica(s(X),T,F).

/* potencia(X,Y,Z)  Z=X^Y */
potencia(0,_,0) :- !.
potencia(_,0,s(0)) :- !.
potencia(s(X),s(Y),Z) :-
	potencia(s(X),Y,T),
	multiplica(s(X),T,Z).

/* acker(M,N,Z)  Z=A(M,N) */
acker(0,s(N),s(s(N))):-!.
acker(s(M),0,Z):- !, acker(M,s(0),Z).
acker(s(M),s(N),Z):- !, acker(s(M),N,Z2), acker(M,Z2,Z).
