:- use_module(library(lists)).

main:-
    write('Escribe las claves publicas, para finalizar captura "0": '), nl,
    leerClavesPublicas(ListaClavesPublicas),nl,
    write('Se generaron las siguientes claves: '), nl,
    procesarClaves(ListaClavesPublicas).

procesarClaves([Publica|Resto]):-
    length(Resto, Z),
    (Z > 0)->
        clave(Publica, Privada, 2),
        tranformarListaNumero(Privada, PrivadaNumero),
        compactar(Privada, M, X, N, Y),
        write('Clave publica: '), write(Publica), nl,
        write('     Clave privada: '), write(PrivadaNumero), nl,
        write('     Clave compacta: '), write(M), write(X), write(N), write(Y), nl, nl,
        procesarClaves(Resto)
    ;
    clave(Publica, Privada, 2),
        tranformarListaNumero(Privada, PrivadaNumero),
        compactar(Privada, M, X, N, Y),
        write('Clave publica: '), write(Publica), nl,
        write('     Clave privada: '), write(PrivadaNumero), nl,
        write('     Clave compacta: '), write(M), write(X), write(N), write(Y), nl, nl.

leerClavesPublicas(ListaClavesPublicas):-
    read(ClavePublica),
    (ClavePublica \= 0 )->
        leerClavesPublicas(ListaClavesPublicas2),
        agregar(ClavePublica, ListaClavesPublicas2, ListaNueva),
        ListaClavesPublicas = ListaNueva
    ;ListaClavesPublicas = [].
        

tranformarListaNumero([Numero | Resto], Resultado):-
    length(Resto, X),
    (X>0)->
        Valor is 10**X,
        ValorFinal is Valor*Numero,
        tranformarListaNumero(Resto, Resultado2),
        Resultado is Resultado2+ValorFinal
    ;Resultado is Numero.

compactar(Numero, M, X, N, Y):-
    length(Numero,TamTotal),
    nth0(0, Numero, X),
    delete(Numero, X, Numero2),
    
    length(Numero2, N),
    nth0(0, Numero2, Y),
    delete(Numero2, Y, Numero3),

    M is TamTotal-N,
    Numero3=[].

clave(X,Y,Contador):-
    Multiplo is Contador*X,
    listarNumero(Multiplo, ListaMultiploArr),
    reverse(ListaMultiploArr, ListaMult),
    (bipartita(ListaMult)) ->
        Y = ListaMult
    ;Contador2 is Contador+1, clave(X, Y2, Contador2), Y = Y2.
        
bipartita(Numero) :- 
    list_to_set(Numero, ListaDigitos),
    length(ListaDigitos, 2),
    nth0(0, Numero, X),
    eliminarSeguidos(Numero,X,Numero2),
    nth0(0,Numero2,Y),
    delete(Numero2, Y, Numero3),
    Numero3=[].

eliminarSeguidos([X|Resto], Y,ListaNueva):-
    (Y = X)->
        eliminarSeguidos(Resto, Y, ListaNueva2),
        ListaNueva = ListaNueva2
    ; ListaNueva = [X|Resto].

listarNumero(X,ListaMultiplo):-
    (X > 0) ->
        Digito is X mod 10,
        X2 is X // 10,
        listarNumero(X2, ListaMultiplo2),
        agregar(Digito, ListaMultiplo2, Lnueva),
        ListaMultiplo = Lnueva
    ; ListaMultiplo = [].

agregar(X, L, Lnueva):- 
    append([X], L, Lnueva).










































