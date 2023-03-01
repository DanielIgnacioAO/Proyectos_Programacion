/*************************************
    Programa: Cantidad_Letras.pl
    Descripcion: Programa que escribe con letra el numero dado
    
    Nombre: Arellano Ochoa Daniel Ignacio
    No. de control: 19141118
***************************************/
main:-
    write('Numero: '), read(X),
    convertir(X,1).

convertir(0,1):-!, write('cero').
convertir(0,_):-!.
convertir(Num,P):-
    Ter is Num mod 1000,
    Res is Num // 1000,
    P2 is P + 1,
    convertir(Res,P2),
    tercia(Ter,P).

tercia(0,_):-!.
tercia(1,2):-!, write('mil ').
tercia(1,3):-!, write('un millon ').
tercia(Ter,PTer):-
    Dec is Ter mod 100,
    Cen is Ter // 100,
    letraC(Cen),
    letraD(Dec),
    letraTer(PTer).

letraC(0):-!.
letraC(1):-!, write('ciento ').
letraC(2):-!, write('doscientos ').
letraC(3):-!, write('trescientos ').
letraC(4):-!, write('cuatrocientos ').
letraC(5):-!, write('quinientos ').
letraC(6):-!, write('seiscientos ').
letraC(7):-!, write('setecientos ').
letraC(8):-!, write('ochocientos ').
letraC(9):-!, write('novecientos ').

letraD(0):-!.
letraD(1):-!, write('uno ').
letraD(2):-!, write('dos ').
letraD(3):-!, write('tres ').
letraD(4):-!, write('cuatro ').
letraD(5):-!, write('cinco ').
letraD(6):-!, write('seis ').
letraD(7):-!, write('siete ').
letraD(8):-!, write('ocho ').
letraD(9):-!, write('nueve ').
letraD(10):-!, write('diez ').
letraD(11):-!, write('once ').
letraD(12):-!, write('doce ').
letraD(13):-!, write('trece ').
letraD(14):-!, write('catorce ').
letraD(15):-!, write('quince ').
letraD(16):-!, write('dieciseis ').
letraD(17):-!, write('diecisiete ').
letraD(18):-!, write('dieciocho ').
letraD(19):-!, write('diecinueve ').
letraD(20):-!, write('veinte ').
letraD(30):-!, write('treinta ').
letraD(40):-!, write('cuarenta ').
letraD(50):-!, write('cincuenta ').
letraD(60):-!, write('sesenta ').
letraD(70):-!, write('setenta ').
letraD(80):-!, write('ochenta ').
letraD(90):-!, write('noventa ').
letraD(Num):-
    Dec is Num // 10,
    Uni is Num mod 10,
    Dec = 2, !, 
    write('veinti'), 
    letraD(Uni).
letraD(Num):-
    Dec is (Num // 10)*10,
    Uni is Num mod 10,
    letraD(Dec),
    write('y '),
    letraD(Uni).

letraTer(1):-!.
letraTer(2):-!, write('mil ').
letraTer(3):-!, write('millones ').

/*
Codigo para probar el codigo de convertir
*/
prueba(0):-!.
prueba(N):-
    N2 is N - 1,
    random(0,999999999,X),
    write(X),write(': '),convertir(X,1),nl,
    prueba(N2).