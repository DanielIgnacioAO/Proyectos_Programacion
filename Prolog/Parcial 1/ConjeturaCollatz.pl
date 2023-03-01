% Conjetura 3n+1

main :-
    write('N: '), read(N),
    longitud(N,X),
    write('La longitud de la sucesion es: '),
    write(X), nl.

longitud(1,1) :- !, write(1), nl.
longitud(N,X) :-
    N1 is N mod 2, N1 = 0, !,
    write(N), write(' '),
    N2 is N div 2,
    longitud(N2,X2),
    X is X2+1.
longitud(N,X) :-
    write(N), write(' '),
    N1 is 3*N+1,
    longitud(N1,X1),
    X is X1+1.
