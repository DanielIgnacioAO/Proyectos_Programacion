/*************************************
    Programa: Polinomio.pl
    Descripcion: Programa que verifica que un polinomio este bien escrito
    
    Nombre: Arellano Ochoa Daniel Ignacio
    No. de control: 19141118
***************************************/
main:-
    write('Escribe un polinomio entre comillas en el formato CxP +/- ... Cx +/- C: '),read(X),
    validar(X).
validar(X):-
    string_chars(X,Lista),
    validar2(Lista).
validar2(Lista):-
    numero(Lista,[X2|Resto2]),
    atom_codes(X2,Y),Y == [120], !,
    numero(Resto2,Resto3), 
    signo(Resto3).
validar2(Lista):-
    numero(Lista,Resto2), 
    signo(Resto2).

numero([X|Resto],Resto2):-
    atom_codes(X,Y), Y >=48, Y=<57, !,
    numero(Resto,Resto2).
numero(X,Resto2):-Resto2 = X.

signo([]):-!,write('Bien escrito').
signo([X | Resto]):-
    atom_codes(X,Y), Y==[43], !,
    validar2(Resto).
signo([X|Resto]):-
    atom_codes(X,Y), Y==[45], !,
    validar2(Resto).