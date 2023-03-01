/**************
Programa: area.pl
Funcion: Calculo de integrales definidas
--------------------------------------
Ejercicio: Elaborar un progrma en Prolog
           para imprimir la tabla de la
           distribucion normal estandar
**************/

main:-
    write('Limite inferior: '),read(A),
    write('Limite superior: '),read(B),
    N is 1000,
    Base is (B - A) / N,
    suma(A,Base,0,N,Area),
    write('Area = '), format('~4f',Area), nl.

f(X,Y) :-
    Y is exp(-X*X/2) / sqrt(2*pi).

suma(_,_,N,N,0) :- !.
suma(A,Base,I,N,Area):-
    I1 is I+1,
    suma(A,Base,I1,N,Area1),
    X1 is A + I*Base, X2 is X1 + Base,
    f(X1,Y1), f(X2,Y2), Y is (Y1 + Y2) / 2,
    Area is Base*Y + Area1.