/*************************************
    Programa: Romanos.pl
    Descripcion: Programa que genera n numeros random, escribiendolo en arabigo y en 
                romano.   
    
    Nombre: Arellano Ochoa Daniel Ignacio
    No. de control: 19141118
***************************************/
main:-
    write('Cuantos numeros desea generar? '),
    read(N),
    generar(N).

generar(0):-!.
generar(N):-
    random(1,4000,X),
    write(X),write(': '),convertir(X,1),nl,
    N2 is N - 1,
    generar(N2). 


convertir(0,_):-!.
convertir(Num, P):-
    Dig is Num mod 10,
    Res is Num // 10,
    P2 is P + 1,
    convertir(Res,P2),
    romano(Dig, P).

romano(0,_):-!.
romano(1,4):-!, write('M').
romano(2,4):-!, write('MM').
romano(3,4):-!, write('MMM').

romano(1,3):-!, write('C').
romano(2,3):-!, write('CC').
romano(3,3):-!, write('CCC').
romano(4,3):-!, write('CD').
romano(5,3):-!, write('D').
romano(6,3):-!, write('DC').
romano(7,3):-!, write('DCC').
romano(8,3):-!, write('DCCC').
romano(9,3):-!, write('CM').

romano(1,2):-!, write('X').
romano(2,2):-!, write('XX').
romano(3,2):-!, write('XXX').
romano(4,2):-!, write('XL').
romano(5,2):-!, write('L').
romano(6,2):-!, write('LX').
romano(7,2):-!, write('LXX').
romano(8,2):-!, write('LXXX').
romano(9,2):-!, write('XC').

romano(1,1):-!, write('I').
romano(2,1):-!, write('II').
romano(3,1):-!, write('III').
romano(4,1):-!, write('IV').
romano(5,1):-!, write('V').
romano(6,1):-!, write('VI').
romano(7,1):-!, write('VII').
romano(8,1):-!, write('VIII').
romano(9,1):-!, write('IX').