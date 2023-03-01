/************************************************************************
Codigo para leer una cadena y separarla por espacios en una lista
************************************************************************/
leerCadena(Cadena):-
    get0(Caracter),
    leerResto(Caracter, Cadena).

/*Punto*/
leerResto(46,[]):-!.
/*Espacio*/
leerResto(32,Cadena):-!,
    leerCadena(Cadena).
/*Palabra*/
leerResto(Caracter,[Palabra | Palabras]):-
    leerCaracteres(Caracter, Caracteres, SigCaracter),
    name(Palabra,Caracteres),
    leerResto(SigCaracter, Palabras).

/*Leer caracteres*/
leerCaracteres(46,[],46):-!.
leerCaracteres(32,[],32):-!.
leerCaracteres(Caracter, [Caracter | Caracteres], SigCaracter):-
    get0(NuevoCaracter), 
    leerCaracteres(NuevoCaracter, Caracteres, SigCaracter).
