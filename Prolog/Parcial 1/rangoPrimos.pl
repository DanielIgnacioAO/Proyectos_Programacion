main:-
    write('Limite inferior: '),
    read(Inf),
    write('Limite superior: '),
    read(Sup),
    contar(Inf, Sup, N),
    write("Numero de primos: " ), write(N).

contar(Sup, Sup, N):- 
    esPrimo(Sup), !,
    contar
contar(Inf,Sup,N) :-
    esPrimo(Inf), !,
    contar(Inf + 1, Sup, N2),
    N is N2 + 1.
