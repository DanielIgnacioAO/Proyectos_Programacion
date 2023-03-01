main :-
    write('\e[2j'),
    write('Lista de enteros no negativos: '),
    read(Lista),
    write('Ancho: '), read(Ancho),
    write('Alto: '),read(Alto),

    write('Histograma Horizontal: '),nl,
    barrasEscala(Lista,Ancho,Alto),
    write('Histograma Vertical: '),nl,
    histoVertical(Lista,Ancho,Alto).

/****************
Codigo para histograma vertical
***************/
histoVertical(Lista,Ancho,Alto):-
    max_member(Max,Lista),
    nivelesBarra(Lista,Ancho,Alto,Max).

nivelesBarra(_,_,_,0):- !.
nivelesBarra(Lista,Ancho,Alto, Max):-
    iterarNivel(Lista, Ancho, Alto, Max),
    Max2 is Max-1,
    nivelesBarra(Lista,Ancho,Alto,Max2).

iterarNivel(_, _, 0, _):- !.
iterarNivel(Lista, Ancho, N, Nivel):-
    nivel(Lista,Ancho,Nivel),
    N2 is N-1,
    iterarNivel(Lista,Ancho,N2,Nivel).

nivel([],_,_):- !, nl.
nivel([X | Resto], Ancho, Nivel):-
    (X >= Nivel)->
        nivelBarra(Ancho,'*'),
        nivel(Resto, Ancho, Nivel)
    ;nivelBarra(Ancho,' '), nivel(Resto, Ancho,Nivel).


nivelBarra(0,_):- !, write(' ').
nivelBarra(N,Caracter):-
    write(Caracter),
    N1 is N-1,
    nivelBarra(N1,Caracter).

/****************
Codigo para histograma Horizontal
***************/
barras([]) :- !.
barras([X | Resto]) :-
    barra(X), barras(Resto).

barra(0) :- !, nl.
barra(N) :-
    write('*'),
    N1 is N-1,
    barra(N1).

barrasEscala([],_,_) :- !.
barrasEscala([X | Resto], Ancho, Alto) :-
    X1 is X*Alto,
    iteraBarra(X1, Ancho),
    barrasEscala(Resto,Ancho,Ancho).

iteraBarra(_,0):- !.
iteraBarra(X,Ancho) :-
    barra(X),
    Ancho1 is Ancho-1,
    iteraBarra(X, Ancho1).