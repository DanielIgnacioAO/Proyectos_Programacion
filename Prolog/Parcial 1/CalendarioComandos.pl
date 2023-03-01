
esBisiesto(A) :-
    R is A mod 400, R=0, !.
esBisiesto(A) :-
    R is A mod 4, R = 0, !,
    R1 is A mod 100, R1\=0.

nombreMes(1,enero) :- !.
nombreMes(2,febrero) :- !.
nombreMes(12,diciembre) :- !.

nombreMes2(M,X) :-
    nombreMes3(M, [enero,febrero,marzo,abr,mayo,junio,julio,agosto,septiembre,octubre,noviembre,diciembre], X).

nombreMes3(1,[X | _],X) :- !.
nombreMes3(M,[_ | Resto],X) :- 
    M1 is M-1, nombreMes3(M1, Resto, X).

diaInicial(A,D) :-
    primerDia(A,D,2022,6).

primerDia(A,D,A,D) :- !.
primerDia(A,D,Aact,Dact) :-
    A > Aact, !,
    Aact1 is Aact+1, ajusteBis(Aact,X),
    Dact1 is (Dact+1+X) mod 7,
    primerDia(A,D,Aact1, Dact1).
primerDia(A,D,Aact,Dact) :-
    A < Aact, !,
    Aact1 is Aact-1, ajusteBis(Aact1,X),
    Dact1 is (Dact-1-X) mod 7,
    primerDia(A,D,Aact1, Dact1).

ajusteBis(A,1) :- 
    esBisiesto(A), !.
ajusteBis(_,0).
    
