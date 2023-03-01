/*************************
Programa: Ack.pl
Funcion: Funcion de Ackerman

A(m,n) = n+1                si m = 0
A(m,n) = A(m-1,1)           si m > 0 y n = 0
A(m,n) = A(m-1,A(m,n-1))    si m > 0 y n > 0
*************************/

ack(0,N,X):-
    !,
    X is N + 1.
ack(M,0,X):-
    !,
    M1 is M - 1,
    ack(M1,1,X).
ack(M,N,X):-
    M1 is M - 1,
    N1 is N - 1,
    ack(M,N1,X1),
    ack(M1,X1,X).
