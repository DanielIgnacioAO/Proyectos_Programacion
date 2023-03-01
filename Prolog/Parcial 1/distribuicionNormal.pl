/**************
    Programa: distribuicionNormal.pl
    Descripcion: Calculo de tabla de distribuicion normal estandar
--------------------------------------
    Ejercicio: Elaborar un progrma en Prolog
            para imprimir la tabla de la
            distribucion normal estandar

    Nombre: Arellano Ochoa Daniel Ignacio
    No. de control: 19141118
**************/

main:-
    tablaEncabezado.

tablaEncabezado:-
    write('Tabla de distribuicion normal estandar: '), nl,
    write('   z    |  0.00  |  0.01  |  0.02  |  0.03  |  0.04  |  0.05  |  0.06  |  0.07  |  0.08  |  0.09  '),
    tabla(-10, 10).

tabla(350, 10):- !.
tabla(Zf, 10):-
    Zf2 is Zf + 10,
    Zc2 is 0,
    nl, write('-------------------------------------------------------------------------------------------------'),
    Aux is Zf2/100,
    nl, imprimirNum(Aux,8,'~1f'),
    tabla(Zf2,Zc2).
tabla(Zf,Zc):-
    Z is (Zf + Zc) / 100,
    N is 1000,
    Base is Z / N,
    suma(0,Base,0,N,Area),
    write('|'), imprimirNum(Area, 8, '~4f'),
    Zc2 is Zc+1,
    tabla(Zf,Zc2).

f(X,Y) :-
    Y is exp(-X*X/2) / sqrt(2*pi).

suma(_,_,N,N,0.5) :- !.
suma(A,Base,I,N,Area):-
    I1 is I+1,
    suma(A,Base,I1,N,Area1),
    X1 is A + I*Base, X2 is X1 + Base,
    f(X1,Y1), f(X2,Y2), Y is (Y1 + Y2) / 2,
    Area is Base*Y + Area1.

imprimirNum(Num,Tam, Formato):-
    format(string(String),Formato,Num),
    string_length(String,X),
    TamE is Tam-X,
    centrar(TamE, String).
imprimirEsp(0):- !.
imprimirEsp(Espa):-
    write(' '),
    Espa2 is Espa-1,
    imprimirEsp(Espa2).
centrar(Espa,String):-
    A is Espa mod 2, A = 0, !,
    B is Espa/2,
    imprimirEsp(B),write(String),imprimirEsp(B).
centrar(Espa,String):-
    E is Espa-1,
    A is E/2,
    B is A+1,
    imprimirEsp(A),write(String),imprimirEsp(B).