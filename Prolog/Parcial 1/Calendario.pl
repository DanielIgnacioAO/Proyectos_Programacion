
main :-
    write('Bienvenido, que calendario desea? '), read(A), nl,
    diaInicial(A,D),
    impM(1,D,A).

impM(Mes,D,A):-
    impTitulo(Mes, D),
    (Mes=12)->
        imprimirSemanas(D,1,31),
        true
    ;(Mes=1 ; Mes=3 ; Mes=5; Mes=7 ; Mes=8 ; Mes=10)->
        imprimirSemanas(D,1,31),
        Mes2 is Mes+1,
        D2 is (D+31) mod 7,
        impM(Mes2,D2,A)
    ;(Mes=4 ; Mes=6 ; Mes=9 ; Mes=11)->
        imprimirSemanas(D,1,30),
        Mes2 is Mes+1,
        D2 is (D+30) mod 7,
        impM(Mes2,D2,A)
    ;(esBisiesto(A))->
        imprimirSemanas(D,1,29),
        Mes2 is Mes+1,
        D2 is (D+29) mod 7,
        impM(Mes2,D2,A)
    ;
        imprimirSemanas(D,1,28),
        Mes2 is Mes+1,
        D2 is (D+28) mod 7,
        impM(Mes2,D2,A).


impTitulo(Mes, Dinicio):-
    nombreMes2(Mes,X),
    write(X),nl,
    write(' D  L Ma Mi  J  V  S'), nl,
    imprimirEspacios(Dinicio).

imprimirEspacios(Dinicio) :-
    (Dinicio \= 0) -> 
        write('   '),
        Dinicio2 is Dinicio-1,
        imprimirEspacios(Dinicio2)
    ;true.

imprimirSemanas(Dact, Fcon, Lim):-
    (Lim > 0, Dact = 6) ->
        imprimirDia(Fcon), nl,
        Lim2 is Lim-1,
        Fcon2 is Fcon+1,
        imprimirSemanas(0,Fcon2,Lim2)
    ;(Lim > 0, Dact \= 6)->
        imprimirDia(Fcon),write(' '),
        Lim2 is Lim-1,
        Fcon2 is Fcon+1,
        Dact2 is Dact+1,
        imprimirSemanas(Dact2,Fcon2,Lim2)
    ;nl,nl,true.

imprimirDia(Fcon):-
    (Fcon>9)->
        write(Fcon)
    ;
        write(' '),write(Fcon),true.

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

esBisiesto(A) :-
    R is A mod 400, R=0, !.
esBisiesto(A) :-
    R is A mod 4, R = 0, !,
    R1 is A mod 100, R1\=0.

nombreMes2(M,X) :-
    nombreMes3(M, ['Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'], X).

nombreMes3(1,[X | _],X) :- !.
nombreMes3(M,[_ | Resto],X) :- 
    M1 is M-1, nombreMes3(M1, Resto, X).